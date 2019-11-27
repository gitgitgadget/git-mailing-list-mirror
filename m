Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909CBC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6423620661
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXqhGArL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK0T4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:56:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45102 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0T4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:56:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so11617329pfn.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eRn63DcFnoPvu7TR3FJvpy+wrj+0K6IwJAG/Q1PokYk=;
        b=mXqhGArLsN4u+unKAy2WslxSKs1vUwPRRe0bKx818ss7du8SLI5zUt4p6zggXZDSRS
         lp6Msw0IvdfOPrgaN4AStrP5u+v9R9Z8LWhidRvGyRUbV3QF1lPLfEjVEoBGGDrPUME+
         V+QEGazwkUSJ8ZF8MMTnhiwIT69mxAa45vRlg/ucowcY6X/BL37ACYuBiJq4gokS43oo
         CQdsGBPIlzkRwkJ0kJy6BJi3ioy17XjZ9QVBFz9weVIUoruw4NgIEDPoddgziMFh7kJM
         QunFwfvCzsVI8IVWXu2a+bOBThgUy7aQ2LaVppDsDGqitM9kdl3xTvL3uedn93uWxnu/
         YJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eRn63DcFnoPvu7TR3FJvpy+wrj+0K6IwJAG/Q1PokYk=;
        b=HsnoYAn5H80SaP7MUJS6CvdBMBVbOeOsUP56IjF43mfjFAWysbLYML2SSHg+LcnhFE
         cOC7GtzH/8Y2nsPTgLvzoQzHJddEeFmTEUmZudgcz7FwbZ3sA9kLSRe/H/t8ZyXRj5a/
         tMut47cPAgwjOYRYy8viUpw8/Y3JkwVPfpUjuf/xgXlcTJajAkP+PnXSkeTUfHWUK1Va
         AcaCtJe1pd1x8X/NUZEkjcQR7x9Wl5MuiiaTp5ulIRG72FZWJhqMD7tEGTQv86L4+bBs
         39yBpQF3uTzu5rX47KJ9A0IjaemwurNc0SbSY/r7F37S8hRQQe5gICMn5ZjK5sotjB+C
         zrEg==
X-Gm-Message-State: APjAAAW9/dEpKnXnubiKPtvPrQIk++PEvlleMv8MaGEx/0UcyIuCvIai
        CwgCDkuuJ/JJgBG+YjyKQrhWaSpu
X-Google-Smtp-Source: APXvYqxv4CxjTloTrrdciJacOZT9a8nZBQ6VqcJ20YFHz7i7B9j8K7viCciR+5QVCHA5CqO/Tv41VA==
X-Received: by 2002:a63:d20f:: with SMTP id a15mr7265025pgg.268.1574884577297;
        Wed, 27 Nov 2019 11:56:17 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id l9sm4153119pgh.34.2019.11.27.11.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:56:16 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:56:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/5] format-patch: teach --no-base
Message-ID: <20191127195615.GA7413@generichostname>
References: <cover.1574820308.git.liu.denton@gmail.com>
 <cover.1574878089.git.liu.denton@gmail.com>
 <f7e5325cc0a7c29b62abe361e188c7cf9c59a9ca.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e5325cc0a7c29b62abe361e188c7cf9c59a9ca.1574878089.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 10:13:46AM -0800, Denton Liu wrote:
> If `format.useAutoBase = true`, there was no way to override this from
> the command-line. Teach format-patch the `--no-base` option which
> overrides `format.useAutoBase`.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-format-patch.txt |  5 +++--
>  builtin/log.c                      | 24 +++++++++++++++++++++---
>  t/t4014-format-patch.sh            |  6 ++++++
>  3 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 00bdf9b125..0d4f8951bb 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -333,11 +333,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>    Output an all-zero hash in each patch's From header instead
>    of the hash of the commit.
>  
> ---base=<commit>::
> +--[no-]base[=<commit>]::
>  	Record the base tree information to identify the state the
>  	patch series applies to.  See the BASE TREE INFORMATION section
>  	below for details. If <commit> is "auto", a base commit is
> -	automatically chosen.
> +	automatically chosen. The `--no-base` option overrides a
> +	`format.useAutoBase` configuration.
>  
>  --root::
>  	Treat the revision argument as a <revision range>, even if it
> diff --git a/builtin/log.c b/builtin/log.c
> index 9c44682f61..c017df4056 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1388,6 +1388,23 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +static int base_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	char **base_commit = opt->value;
> +
> +	free(*base_commit);
> +
> +	if (unset) {
> +		base_auto = 0;
> +		*base_commit = NULL;
> +	} else if (arg) {
> +		*base_commit = xstrdup(arg);
> +	} else {
> +		BUG("arg is NULL");
> +	}
> +	return 0;
> +}
> +
>  struct base_tree_info {
>  	struct object_id base_commit;
>  	int nr_patch_id, alloc_patch_id;
> @@ -1676,10 +1693,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			    PARSE_OPT_OPTARG, thread_callback },
>  		OPT_STRING(0, "signature", &signature, N_("signature"),
>  			    N_("add a signature")),
> -		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
> -			   N_("add prerequisite tree info to the patch series")),
> +		{ OPTION_CALLBACK, 0, "base", &base_commit, N_("base-commit"),
> +			   N_("add prerequisite tree info to the patch series"),
> +			   0, base_callback },
>  		OPT_FILENAME(0, "signature-file", &signature_file,
> -				N_("add a signature from a file")),
> +			N_("add a signature from a file")),

Oops, this is reindentation is a spurious change and should be dropped.

>  		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
>  		OPT_BOOL(0, "progress", &show_progress,
>  			 N_("show progress while generating patches")),
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index c7cc643adf..a5b6302a1c 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1958,6 +1958,12 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'format-patch --no-base overrides format.useAutoBase' '
> +	test_config format.useAutoBase true &&
> +	git format-patch --stdout --no-base -1 >patch &&
> +	! grep "^base-commit:" patch
> +'
> +
>  test_expect_success 'format-patch --base with --attach' '
>  	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
>  	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
> -- 
> 2.24.0.504.g3cd56eb17d
> 
