Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D355C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67ED461167
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhGLPGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhGLPGD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 11:06:03 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E033C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:03:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id d2so8664384qvh.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cv3FHudSHLfA6Ab6adYsmfC1sMpl+shf++aOeQpzuWo=;
        b=XzvBiPo30vV7hJAGS8kziJ6PFbmvNBdJbQjsBuTQSUI0mUYSIsyMXMMCvBNtp4RAOq
         8oLUNnOZhxw4x8stdqo3KRAOYfpBwrWL+YkGqNZwifoIWzE1ysX/OdqiU1yoOwD9gBzd
         rHAFUtU2LCl/CrR+3NiwresxsVd6cCJGTxPFzbnuUwYMHlXTqvL5VkFS33kBV/fqcpHA
         sckr86zbmP9QkxdEpJSKI3ulvG9QOXD2AvzKynbIyA+kIUw5Z91ShArHbyizE6FN2mLH
         e1sfbqBRYfDYxbeSzkyLf5BIMR3fSPTBPLvOn2xvD9S3EVbsnGJTJdygMUQjMhVb9yFT
         f6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cv3FHudSHLfA6Ab6adYsmfC1sMpl+shf++aOeQpzuWo=;
        b=QDWGkppUkrRZ+o3/TxkYSo44VlCLcGP+q5egIsw9WcFI0PggNVavYj6zjxiYIU40gS
         Xke3Fu23TPC5zgIojCenf7AMsaWLpICU+IN97C2nbKVxDAfA2jDwOxojzLheJ/WwhgPh
         yHnPvcetXUJoCK6y80KFFsFEggEoNB8M5Vvfj+KrSVfUq3JrDEAZMs3rD1miibQ3VTrD
         fkj9QPGiU1+4KpKIMOMzxWceLlnwTIQ7fKV2agZVQFzCzDE8g29MRCAcS+HrMsrpUA6+
         53Pn613418gyBP/HmO2QJ99eBGMmwW61G5jtr9MOYTSM6AMro7rB5kI75zJm4l0i+LOL
         98jw==
X-Gm-Message-State: AOAM532glGZGQreA7UPrtTi2u/Ay4qe1moTygGMQioF8bw81TtaUo0TV
        R1cDrLqWz8PtfWoF+Jc9EQI=
X-Google-Smtp-Source: ABdhPJwdbWwkf0Pp1CsMdq+OP+09lFrbVz+sl8s6RNglYsOuhhwJJWLhtqZFhsp0UbIVlQxS3pivXA==
X-Received: by 2002:a05:6214:2a81:: with SMTP id jr1mr6815112qvb.57.1626102193563;
        Mon, 12 Jul 2021 08:03:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:91f8:61a:4701:b6c? ([2600:1700:e72:80a0:91f8:61a:4701:b6c])
        by smtp.gmail.com with ESMTPSA id s6sm6539350qkc.125.2021.07.12.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:03:12 -0700 (PDT)
Subject: Re: [PATCH 1/3] doc: clarify documentation for rename/copy limits
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c25e29a9-3a15-4079-43fd-b77746927b16@gmail.com>
Date:   Mon, 12 Jul 2021 11:03:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7dc448df6ec6edb41464a4115017064cf41b2d83.1625964399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/10/2021 8:46 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
>  diff.renameLimit::
> -	The number of files to consider when performing the copy/rename
> -	detection; equivalent to the 'git diff' option `-l`. This setting
> -	has no effect if rename detection is turned off.
> +	The number of files to consider in the quadratic portion of
> +	copy/rename detection; equivalent to the 'git diff' option
> +	`-l`.  If not set, the default value is 400.  This setting has
> +	no effect if rename detection is turned off.
...
>  merge.renameLimit::
> -	The number of files to consider when performing rename detection
> -	during a merge; if not specified, defaults to the value of
> -	diff.renameLimit. This setting has no effect if rename detection
> -	is turned off.
> +	The number of files to consider in the quadratic portion of
> +	rename detection during a merge.  If not specified, defaults
> +	to the value of diff.renameLimit.  If neither
> +	merge.renameLimit nor diff.renameLimit are specified, defaults
> +	to 1000.  This setting has no effect if rename detection is
> +	turned off.
...
>  -l<num>::
> -	The `-M` and `-C` options require O(n^2) processing time where n
> -	is the number of potential rename/copy targets.  This
> -	option prevents rename/copy detection from running if
> -	the number of rename/copy targets exceeds the specified
> -	number.
> +	The `-M` and `-C` options can require O(n^2) processing time
> +	where n is the number of potential rename/copy targets.  This
> +	option prevents the quadratic portion of rename/copy detection
> +	from running if the number of rename/copy targets exceeds the
> +	specified number.  Defaults to diff.renameLimit, or if that is
> +	also unspecified, to 400.

These changes are clear to me, but I also know how a bit about how
the rename algorithm works and what "the quadratic portion" means.
I wonder if this is sufficient detail to help a user less versed in
Git's internals.

Perhaps we should instead be describing the set of "potential inexact
renames" as a more descriptive approach? Here is a possible way to
use this wording instead:

  merge.renameLimit::
      The number of potential inexact renames to consider when
      performing rename detection during a merge; if this limit
      is exceeded, then no inexact renames are computed. Renames
      where the content does not change are excluded from this
      limit. If not specified, defaults to...

Feel free to take or leave any of this example.

Thanks,
-Stolee
