Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835C0C43460
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 03:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5049361408
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 03:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhD1D37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 23:29:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61133 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhD1D36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 23:29:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E75D4C85C4;
        Tue, 27 Apr 2021 23:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=enxLS52j9i1Hhi9xZYgLNBTLVach0Pwxp4xZZB
        teFrw=; b=tFH44kYaN+uPERYb7kZwi8KXDt/xD7AK2Fq9D955XfoU4GdB9Gqrz3
        dm5uUCZTw9oO6IH+XT+ezp8s1xdKcBBcvyLO/sm17mIiGy3ui3OAeJC8T9m6Jxwd
        8HNd+H9ql2ws9OswLWv9jRroT5QegIlFWjoZsXcVi8L0Ct1KyXEfc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD5B5C85C3;
        Tue, 27 Apr 2021 23:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6938CC85C2;
        Tue, 27 Apr 2021 23:29:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 2/3] fast-export: rename --signed-tags='warn' to
 'warn-verbatim'
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
        <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210423164118.693197-3-lukeshu@lukeshu.com>
Date:   Wed, 28 Apr 2021 12:29:12 +0900
In-Reply-To: <20210423164118.693197-3-lukeshu@lukeshu.com> (Luke Shumaker's
        message of "Fri, 23 Apr 2021 10:41:17 -0600")
Message-ID: <xmqqpmyfccjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E73D6E4C-A7D1-11EB-A6DA-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> ---signed-tags=(verbatim|warn|warn-strip|strip|abort)::
> +--signed-tags=(verbatim|warn-verbatim|warn-strip|strip|abort)::
>  	Specify how to handle signed tags.  Since any transformation
>  	after the export can change the tag names (which can also happen
>  	when excluding revisions) the signatures will not match.
> @@ -36,8 +36,10 @@ When asking to 'abort' (which is the default), this program will die
>  when encountering a signed tag.  With 'strip', the tags will silently
>  be made unsigned, with 'warn-strip' they will be made unsigned but a
>  warning will be displayed, with 'verbatim', they will be silently
> -exported and with 'warn', they will be exported, but you will see a
> -warning.
> +exported and with 'warn-verbatim', they will be exported, but you will
> +see a warning.
> ++
> +`warn` is a deprecated synonym of `warn-verbatim`.

Two minor points

 - Is it obvious to everybody what is the implication of using
   "verbatim" (which in turn would bring the readers to realize why
   it often deserves a warning)?  If not, would it make sense to
   explain why "verbatim" may (may not) be a good idea in different
   situations?

 - I am not sure a deprecated synonym deserves a separate paragraph.

   ... silently exported, and with 'warn-verbatim' (or `warn`, a
   deprecated synonym), they will be exported with a warning.

   may be less irritating to the eyes, perhaps?

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 85a76e0ef8..d121dd2ee6 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -55,7 +55,7 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
>  		signed_tag_mode = SIGNED_TAG_ABORT;
>  	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
>  		signed_tag_mode = VERBATIM;
> -	else if (!strcmp(arg, "warn"))
> +	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
>  		signed_tag_mode = WARN;
>  	else if (!strcmp(arg, "warn-strip"))
>  		signed_tag_mode = WARN_STRIP;

It would be preferrable to do s/WARN/WARN_VERBATIM/ at this step, as
the plan is to deprecate "warn", even if you are going to redo the
enums in later steps.  May want to consider doing so as a clean-up
iff this topic need rerolling for other reasons.

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 409b48e244..892737439b 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -253,6 +253,24 @@ test_expect_success 'signed-tags=verbatim' '
>  
>  '
>  
> +test_expect_success 'signed-tags=warn-verbatim' '
> +
> +	git fast-export --signed-tags=warn-verbatim sign-your-name >output 2>err &&
> +	grep PGP output &&
> +	test -s err

I didn't look at the surrounding existing tests, but in general
"test -s err" is not a good ingredient in any test.  The feature you
happen to care about today may not stay to be be the only thing that
writes to the standard error stream.

