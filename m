Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F1C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbiAFRMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiAFRMn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:12:43 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612EC061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 09:12:42 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c15so2536587qtc.4
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1CIA7Op/Zm5JQHLtKk1xqD/8yijcfGAa4Fp1HW1XhrY=;
        b=2gxU7OSgED1b0mcUSKjxzFWUmM3LVKsSeDVWKKBpNM7+3WFUCVPIMImA0PvXUs7MuY
         nEFhV7AdoJ8q7gxgTowBXfKhRwsQ+TqWFdG8kVc/75dUgLgGyVXSUaPtUbBKmkqVLSSV
         N4ly1jCpff+h03S7y8LYUFlQTW6B6lXF6fzpEucd2sTGLnJiMMnw6XJWwo9GFF6gYera
         L9x3qhT4uto3/4u8aCU2rZOJxXodmImjUrdC9U7RwkZPtTVO3ftMM33V4AAdfLm6YY1f
         7rrXGKhm/r0tVhjRqRNOrRYxeafNlMUb/rB7cbysEB1cqpWYinwpgUhFfqo6E4y6K0Sr
         Sh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1CIA7Op/Zm5JQHLtKk1xqD/8yijcfGAa4Fp1HW1XhrY=;
        b=jGu/yeC7pJbEpKAH3NHpDXy4VtImM+rSKnOtthZpmB5mzlu0D6RhAryN4YNslQqq5g
         V/88BHYbPsHU2kc007G1XtLSEljE16QDOqnddT7J//RcTr3qnaw66S7WRp1W2D5yqanB
         tZOrnU+lNgfQZWg8w1m/d91uM1H3+Oy2TaWUvlr5tu/dqRMXsQkONtYh9tntFd2JNcRE
         KaQNO9WO873wGzs1jZnBsJqlMP0a6/cmk+oGGQrFliz5/T+FsffGixneGph4C6Uxxyf5
         eoNs65xjpRYLkLAj/laIloInDX/zIin6t5TbfOWAjuvj0PON8SwL+oDWhuvcMx3DPqS5
         V5tQ==
X-Gm-Message-State: AOAM530G8on5T/6SxN70+tJbkRZWCwmyJvNvhttAvuXA1xiEiPELqdRu
        KsQcdCcEQ4znoYe74pj7LnmF9KtrV3/PFA==
X-Google-Smtp-Source: ABdhPJxPYwhpx461Z7vaSlqfVwQQ8pp+bL4Ykby92FYLGSy8xamFpO6GY321RRBqgS+5gSfaw/FG6A==
X-Received: by 2002:ac8:5d8e:: with SMTP id d14mr53055053qtx.214.1641489161968;
        Thu, 06 Jan 2022 09:12:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i11sm1866737qko.116.2022.01.06.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:12:41 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:12:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com,
        phillip.wood123@gmail.com, Tilman Vogel <tilman.vogel@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin/pull.c: teach run_merge() to honor
 rebase.autostash config
Message-ID: <YdcjCKTrK+W/FCw1@nand.local>
References: <20220106150226.77458-1-johncai86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220106150226.77458-1-johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 06, 2022 at 10:02:26AM -0500, John Cai wrote:
> On a git pull --rebase, if fast forward is possible we run merge.
> However, merge will not honor rebase.autostash if it is configured. This
> has the unfortunate result of
>
> $ git config rebase.autostash true
> $ git pull --rebase
>
> to ignore the rebase.autostash value.
>
> Allow run_merge() to honor rebase.autostash by passing in
> config_autostash if --autostash or --no-autostash flags are not
> explicitly set.
>
> Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
> Co-authored-by: "Junio C Hamano" <gitster@pobox.com>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>
> Notes:
>     Fix a bug that prevents git pull --rebase from honoring the rebase.autostash
>     config value.
>
>     Changes since V2:
>     - fixed Junio's email in trailer
>
>     Changes since V1:
>     - used simpler fix as proposed by Junio
>     - removed redundant test cases
>
>  builtin/pull.c          |  9 ++++++++-
>  t/t5521-pull-options.sh | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 100cbf9fb8..8423e420ee 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			die(_("cannot rebase with locally recorded submodule modifications"));
>
>  		if (can_ff) {
> -			/* we can fast-forward this without invoking rebase */
> +			/*
> +			* We can fast-forward without invoking
> +			* rebase, by calling run_merge().  But we
> +			* have to allow rebase.autostash=true to kick
> +			* in.
> +			*/
> +			if (opt_autostash < 0)
> +				opt_autostash = config_autostash;

This looks OK, and prefers the value of autostash given over options
over the configured one. But it may be a little clearer to construct it
that way explicitly (see the conditional "if (opt_rebase)" inside of
cmd_pull()).

>  			opt_ff = "--ff-only";
>  			ret = run_merge();
>  		} else {
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 66cfcb09c5..66fac99d2b 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -252,4 +252,16 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
>  	test_must_fail git -C dst pull --no-ff --no-verify --verify
>  '
>
> +test_expect_success 'git pull --rebase --autostash succeeds on ff' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src "initial" file "content" &&

A handful of these arguments do not need extra quotes. It would be fine
to instead write:

    test_commit -C src initial file content &&

but if you don't care about the commit message being "content", you can
shorten this to just:

    test_commit -C src content file &&

since test_commit defaults all of its arguments to the value of
"<message>".

> +	git clone src dst &&
> +	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&

Same note here, but I think the `--printf` is unnecessary. Running
`echo` with "\n" characters in its argument is fine, so this could be
shortened to:

    test_commit -C src blah file "more\ncontent"

Unfortunately using `--append` isn't an option here, since the "content"
anchor needs to be at the end of the file in order to apply the stash
without conflict.

Thanks,
Taylor
