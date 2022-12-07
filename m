Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46738C63705
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLGWKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLGWKd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:10:33 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8D44E41B
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:10:32 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d123so7229667iof.6
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX42Zh4D2DypDT+TXNgGCX1PrX+PTRSWqF0pmCP4S1w=;
        b=QRxMxVrdSpmvOHtaMBEaRdjPYoI8RbMxHfmp0MR1Ce0DZ4IZsWwkFZ0e88dceQN+De
         R+nSP0Uhy46W0NW8BrkDqkXuDOp9nZBAlceTGkW/My3cPhFz0/Ljy+dgODEEYPqJZHqA
         6jRTKVkXhL7wo3XJC29cCktVhjYhORQ3RWofAmbtXmok+icvYY//SyVLaJ801hMZDyyL
         eR0VJJ0vi3twQ66kSeqYt/xuEwZ+IFcxhS022qT2afZeKSwyG+6sEjvi1DfWa0Bolyv0
         8d0+hCINA4Pna9BtDnKLsTQGQ0Smuqj+FsgO+b0e4ZTcac8ww3vBLelamLiGknAv0yNw
         b8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX42Zh4D2DypDT+TXNgGCX1PrX+PTRSWqF0pmCP4S1w=;
        b=KJpnm4xEosZr1n0tmvOpuUHfDpF/i+mIGS0uYOZwYbpcS4A7zXRtPJVsN+6Hbdb/R9
         J4q3k0+dyP6GzQhQMzb5/4CwFEwi2ZVF9MKFGdZDShRk9jyh3d169ZKmjtQZVFqjNR8L
         1J7SK+vGHSclMf6LuTDs09pwSK3FXdlpCbsBj64ET+oFutTZVShQVmCUTe2R4dSk9XyJ
         iNYcI4X/46BcdkRW9cyE1ZZJMkUbH15oQM0HQbNd+o2bUWx0zKZt6340VUX1bphzDFRn
         uTohTPNJN6ifgfh8iTVj+TORMbgVRoI5lBZ9zggzm1lUducI+ewpXMqhu73kj0xjsqBu
         LzFw==
X-Gm-Message-State: ANoB5pmn0n0I5TlC8+MYbbFxKEqA+EcKTFdwWWfQLS5xDQ58/vwVO3zB
        AV1RDHjXIzWu21/cjdv3Ao9zjA==
X-Google-Smtp-Source: AA0mqf7sXZOmGVJZBNKAT/9J5He46nV8RwfdnowBa8CpkuaC9yhChURDv20UXYso9qETxP2T8qqlJQ==
X-Received: by 2002:a02:1681:0:b0:375:bdba:52b with SMTP id a123-20020a021681000000b00375bdba052bmr45536585jaa.271.1670451031737;
        Wed, 07 Dec 2022 14:10:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y101-20020a02956e000000b003758390c97esm8130139jah.83.2022.12.07.14.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:10:31 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:10:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] scalar: use verbose mode in clone
Message-ID: <Y5EPVpb511wk5Uw/@nand.local>
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 06:10:56PM +0000, ZheNing Hu via GitGitGadget wrote:
> So add `[--verbose| -v]` to scalar clone, to enable
> fetch's output.

Seems reasonable.

> @@ -84,6 +84,11 @@ cloning. If the HEAD at the remote did not point at any branch when
>  	A sparse-checkout is initialized by default. This behavior can be
>  	turned off via `--full-clone`.
>
> +-v::
> +--verbose::
> +	When scalar executes `git fetch`, `--quiet` is used by default to
> +	suppress the output of fetch, use verbose mode for cancel this.
> +

This description may be exposing a few too many implementation details
for our liking. E.g., scalar happens to use `git fetch`, but it might
not always. That is probably academic, but a more practical reason to do
some hiding here might just be that it's unnecessary detail to expose in
our documentation.

Perhaps something like:

    -v::
    --verbose::
     Enable more verbose output when cloning a repository.

Or something simple like that.

>  List
>  ~~~~
>
> diff --git a/scalar.c b/scalar.c
> index 6c52243cdf1..b1d4504d136 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -404,7 +404,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
>  static int cmd_clone(int argc, const char **argv)
>  {
>  	const char *branch = NULL;
> -	int full_clone = 0, single_branch = 0;
> +	int full_clone = 0, single_branch = 0, verbosity = 0;
>  	struct option clone_options[] = {
>  		OPT_STRING('b', "branch", &branch, N_("<branch>"),
>  			   N_("branch to checkout after clone")),
> @@ -413,6 +413,7 @@ static int cmd_clone(int argc, const char **argv)
>  		OPT_BOOL(0, "single-branch", &single_branch,
>  			 N_("only download metadata for the branch that will "
>  			    "be checked out")),
> +		OPT__VERBOSITY(&verbosity),
>  		OPT_END(),
>  	};
>  	const char * const clone_usage[] = {

Looking good.

> @@ -499,7 +500,9 @@ static int cmd_clone(int argc, const char **argv)
>  	if (set_recommended_config(0))
>  		return error(_("could not configure '%s'"), dir);
>
> -	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
> +	if ((res = run_git("fetch", "origin",
> +			   verbosity ? NULL : "--quiet",
> +			   NULL))) {

Hmmph. This and below are a little strange in that they will end up
calling:

    run_git("fetch", "origin", NULL, NULL);

when running without `--verbose`. `run_git()` will still do the right
thing and stop reading its arguments after the first NULL that it sees.
So I doubt that it's a huge deal in practice, but felt worth calling out
nonetheless.

Is there an opportunity to easily test this new code?

Thanks,
Taylor
