Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D8C4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F63C2080C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFB+g40c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgI1T3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgI1T3K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:29:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77BC061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v14so1217476pjd.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=dhdNlKLCfFHlI+PeZ2/haMUICEocbpycA29bCoJcyIo=;
        b=UFB+g40cBVdHN43XthDW1fIbc3RK2l2lscfSx4FTeBJ2iV1nyurxhZJCn8QzYOx5J3
         Pi5xqZTKeD1mPkRGHe3yRNernnrUxWejk4y+M6XHQbKFTMY5gw6TaQuHRMRckmnvYIAa
         S7xa1RKaTzArukU+JBOBX0xOyEbMnumBQY68IXjz6Ma3xUhRZZbLkC7KX9Lk65ZPl/35
         ZaBucFNsyl/fkDPsJExsdv6SYbz55gkTCkxMQbGgQN/KLLzAjhmhSDkYIa1wNuf8ZySf
         zVv+uoGVt0WuGyYRPjB3N9Pb4u2J1VCTqRls7cr9EdoKzShkFWGtz7zmcQFRYRqX7rx6
         AEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=dhdNlKLCfFHlI+PeZ2/haMUICEocbpycA29bCoJcyIo=;
        b=UQiZAoYAGjRv3LG72ZR8iZhKzMWzN9vTpATHsWZqLSWeuTdxGgUGLVxgwgMWrUPDfU
         +5U4qvjnvbRjly2wEyAbr6nIowFWqeJNwqwXZy2teplRfsl/AkbGB5r0TmNi3Crk2JNj
         07nHbfXTzjem0c70lYXC9DJwZIMVwV/ep0X+mNapH2s3fR783H7pnLb8F3HzrIuH7e8V
         whNh5NCzhl1tjOFfWUco9kVK8+8l/6TqlV5vdU7T2NkAUpUk1cz3KGm8EXpMESPXOhMT
         B/4qvnOyl+k4zZiIOfXFRPOiQcLYmbrRzyT8iPDujVgJI+UK2ml2+QaD1HxqzaTxu++I
         ev0g==
X-Gm-Message-State: AOAM533cc1MPEcAkEPvw3Du/N6u9xY+Bbwb6bwPfvjPzT3aJwkaB5lZL
        r0AlykntKyJRq1Z/aWCeeRrFePX4n4KlKw==
X-Google-Smtp-Source: ABdhPJzl84Q9y/iHMHInk1YVQpYO4326eEDPH+v4QNhslXpykPnLYks5cHyytRq58H8yXnR9GmE8Jw==
X-Received: by 2002:a17:90b:1905:: with SMTP id mp5mr726936pjb.70.1601321349869;
        Mon, 28 Sep 2020 12:29:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id e16sm2091034pgv.81.2020.09.28.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:29:08 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:29:03 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/9] hook: add --porcelain to list command
Message-ID: <20200928192903.GA4095761@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-5-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909004939.1942347-5-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.09.08 17:49, Emily Shaffer wrote:
> Teach 'git hook list --porcelain <hookname>', which prints simply the
> commands to be run in the order suggested by the config. This option is
> intended for use by user scripts, wrappers, or out-of-process Git
> commands which still want to execute hooks. For example, the following
> snippet might be added to git-send-email.perl to introduce a
> `pre-send-email` hook:
> 
>   sub pre_send_email {
>     open(my $fh, 'git hook list --porcelain pre-send-email |');
>     chomp(my @hooks = <$fh>);
>     close($fh);
> 
>     foreach $hook (@hooks) {
>             system $hook
>     }
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-hook.txt    | 13 +++++++++++--
>  builtin/hook.c                | 17 +++++++++++++----
>  t/t1360-config-based-hooks.sh | 12 ++++++++++++
>  3 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index e458586e96..0854035ce2 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,7 +8,7 @@ git-hook - Manage configured hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook' list <hook-name>
> +'git hook' list [--porcelain] <hook-name>
>  
>  DESCRIPTION
>  -----------
> @@ -43,11 +43,20 @@ Local config
>  COMMANDS
>  --------
>  
> -list <hook-name>::
> +list [--porcelain] <hook-name>::
>  
>  List the hooks which have been configured for <hook-name>. Hooks appear
>  in the order they should be run, and note the config scope where the relevant
>  `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
> ++
> +If `--porcelain` is specified, instead print the commands alone, separated by
> +newlines, for easy parsing by a script.
> +
> +OPTIONS
> +-------
> +--porcelain::
> +	With `list`, print the commands in the order they should be run,
> +	separated by newlines, for easy parsing by a script.

Rather than a hard-coded porcelain format, perhaps we could accept a
format string to allow callers to specify which items they want, for
greater forwards-compatibility?

Also, we may want a "-z / --null" option like in `git config` to delimit
by null bytes rather than newlines, in case any commands end up with
embedded newlines.
