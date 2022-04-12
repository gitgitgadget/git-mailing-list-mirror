Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B989C4321E
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbiDLKBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383822AbiDLIiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 04:38:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BDA580FA
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:02:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g18so10723268ejc.10
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YD1IVGzB6sIc0JdXKIHLejd3xH6PNCBMKGfpN7MrdZs=;
        b=KWps6XN/rpMUIIvtI2OhbHSD9MfOkMJCWKm9d4iMzOrXYbIB0uKw/+qrqr/qsLeN+b
         PINq8i474atf+qYeEhzOX6eF5e3TCFTSa1PWhMEVr0mJ2tPqY72b/tfWzbJOJkUghTHL
         epxPq3/ML31fT4EdEKh88mU+MiSXfU7SN+FWpMq6Sq2lXBfP2Xa3hlTy5NoW1zzF23Oe
         8MeRBjj2QFMjBWN/9rhqUH7z+/3Sbjwln4KkubwFbiKVg2lql0C/awxrDNianSTj1DUd
         LSjH2RmZlvK3ClEU+7iHZp+2EPuPSVNRcXzmYD5dSlZwkBmZmYG7U/GZsgu2GpK7RHIW
         9GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YD1IVGzB6sIc0JdXKIHLejd3xH6PNCBMKGfpN7MrdZs=;
        b=x21GaFObW5GZ5+bJvuFkglPMGzrerJ8WRZw2W15AlTv56TnhXnLJcNewyjX/xpM7mu
         iFWpPwDw1VrfFZAdFUrgBWzQqcVbrBTmOOFP29K71fvAoMOJLOml97jgBEjiW/DlMeuF
         mIbuPj9TND3asuA63X1Au0ja3+A/WjMjAXFZSVbzfbeQfQ+QpilQEexCHO/ZrPSNd3at
         0DCpa/3Wh0gc4Dyxo4vfXGzxs3njEfaxDMugQKzmKrxAkxoWqD6F2f3+mcfUSM8GftpR
         ybd6/xlqN8P2JdFePcjmnzkx49X/lUy1nsYini6i6R0CgXMOSYj2Big+m60vH5omz9vG
         iKEA==
X-Gm-Message-State: AOAM533ORri+6oupkromzDw1A5K1ILJvF9VS+QYefBz0ehPVERNtF0TS
        ynp/W9XYrDh23pu96antjblz/GFNpW8=
X-Google-Smtp-Source: ABdhPJyMUWE6ZeYK/uP8TqpD937zzmc9RQeUG1MC6T4gK3EELpKJn9vmhvZrpOnhw/pM4tc4NkLHcA==
X-Received: by 2002:a17:906:3a04:b0:6d0:8d78:2758 with SMTP id z4-20020a1709063a0400b006d08d782758mr34307944eje.685.1649750558177;
        Tue, 12 Apr 2022 01:02:38 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm8406856eje.17.2022.04.12.01.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:02:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neBTx-004Vc9-6o;
        Tue, 12 Apr 2022 10:02:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: fix some badly formatted i18n strings
Date:   Tue, 12 Apr 2022 09:59:59 +0200
References: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
Message-ID: <220412.86y20ahgpu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> String in submodule--helper is not correctly formatting
> placeholders. The string in git-send-email is partial.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>     V2.36 i18n fixes
>=20=20=20=20=20
>     While translating the latest version of the messages, I encountered a
>     few errors of formatting or management.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1212%2F=
jnavila%2Fv2.36_i18n_fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1212/jnavi=
la/v2.36_i18n_fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1212
>
>  builtin/submodule--helper.c | 2 +-
>  git-send-email.perl         | 7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0b8b226c8ff..2c87ef9364f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3082,7 +3082,7 @@ static int module_create_branch(int argc, const cha=
r **argv, const char *prefix)
>  		OPT_END()
>  	};
>  	const char *const usage[] =3D {
> -		N_("git submodule--helper create-branch [-f|--force] [--create-reflog]=
 [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start_oid> <start_name>"),
> +		N_("git submodule--helper create-branch [-f|--force] [--create-reflog]=
 [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),

Okey, so s/_/-/g here.

>  		NULL
>  	};
>=20=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a98460bdb96..5861e99a6eb 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -2096,10 +2096,9 @@ sub validate_patch {
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
>  		if ($hook_error) {
> -			$hook_error =3D sprintf(__("fatal: %s: rejected by %s hook\n" .
> -						 $hook_error . "\n" .
> -						 "warning: no patches were sent\n"),
> -					      $fn, $hook_name);
> +			$hook_error =3D sprintf(
> +			    __("fatal: %s: rejected by %s hook\n%s\nwarning: no patches were =
sent\n"),
> +			    $fn, $hook_name, $hook_error);

Isn't this much narrower change going to do the same thing?:
=09
	diff --git a/git-send-email.perl b/git-send-email.perl
	index a98460bdb96..5adb7593ce3 100755
	--- a/git-send-email.perl
	+++ b/git-send-email.perl
	@@ -2097,9 +2097,9 @@ sub validate_patch {
	 		}
	 		if ($hook_error) {
	 			$hook_error =3D sprintf(__("fatal: %s: rejected by %s hook\n" .
	-						 $hook_error . "\n" .
	+						 "%s\n" .
	 						 "warning: no patches were sent\n"),
	-					      $fn, $hook_name);
	+					      $fn, $hook_name, $hook_error);
	 			die $hook_error;
	 		}
	 	}
