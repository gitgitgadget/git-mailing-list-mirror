Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BFC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 14:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiB1OJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiB1OJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 09:09:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CF522CC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 06:08:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so25027669ejb.4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 06:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xa7B2BCPq5zZZ0su7DghAb/IooxjhskeSgGSvacKyRY=;
        b=j1V2Fj670f00z8arZfsXoVVPu999PUhRR9yjZQQcaRCp5J4D4/oTRyei32ttC1x8os
         7+mkHLsiBSfxVmbp2S5cb27tS1Im51/h0Gdgzk16gl9kHeNBdh3vdqhe/cWuksh/y7Xa
         LPdwnza0UYGseY5mkTZyTNUqnhCmH3VS6BpE/eYXA5+DsOMY7sAXUdWRSvGE6ty2GT2k
         Stv6CjEVPsTjVMpAhzQ0B1f3M35Nc1ThPtW//YFV/w8yyekJZ9KWM7wHXEqAkKDzDKaA
         rPXRMQd2bgoTd7NZdgF2qarTGvBHTbKRmWN3pbO9YV9B71nJREtvfcxvs/XrbfNjgJ1v
         2/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xa7B2BCPq5zZZ0su7DghAb/IooxjhskeSgGSvacKyRY=;
        b=dCMaZ9jOjQnI8LjKJRXcXXP0gdW4I1mmBlCQ0HbVtiZegM/CaFawlUNPJjqP3imGyr
         4epRY82NyhdgwufEhAWmTHMVcBHQyAgeRkbSGR1gWtquymfwKVShNyvQsAG7K0UiM9Hi
         eVeFtcGDpa6J50vjYF8NWA7Wy4ojUoj5mQr7lZ9+BY19RbGnEHhhhfhDFiTtMhd00BPY
         Aitvu6LJZ8pift2x/t/cQmEBEWtXt5vVt3aB3Spkw8Fr0d+qFgQF8NI2nRH/WJj9ODTQ
         mTiEIz5qu1JL5phuk0Dj59XCHAGQItcJ/qfQA2iJ2YmxPQwHcMNDEV3wS6mU9pZDqQhW
         YJIg==
X-Gm-Message-State: AOAM532SvvqN7+DpavuRjSZo18Wsp8GEPM3Zzb/82J9rE84crtKvsCCp
        QQ9GzVTVzYaKZydszlQ6F2NujjIGvF8=
X-Google-Smtp-Source: ABdhPJznrIX+kAWu4qig8d1DSP5LA6MgvubMamlysDnIN2+aduzKW3jgSnYR+tD/O6Sez9Yk+NO4rQ==
X-Received: by 2002:a17:906:6a8d:b0:6d1:c4c8:cb3 with SMTP id p13-20020a1709066a8d00b006d1c4c80cb3mr14898970ejr.577.1646057318058;
        Mon, 28 Feb 2022 06:08:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm4390740eji.67.2022.02.28.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:08:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOghY-001O4m-Hv;
        Mon, 28 Feb 2022 15:08:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v4] untracked-cache: support '--untracked-files=all' if
 configured
Date:   Mon, 28 Feb 2022 15:02:24 +0100
References: <pull.985.v3.git.1645960973798.gitgitgadget@gmail.com>
 <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
Message-ID: <220228.86y21v3wyj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 27 2022, Tao Klerks via GitGitGadget wrote:

> From: Tao Klerks <tao@klerks.biz>
> [...]
>     The test suite passes, but as a n00b I do have questions:
>     
>      * Is there any additional validation that could/should be done to
>        confirm that "-uall" untracked data can be cached safely?

I haven't given this any substantial review, sorry.

>        * It looks safe from following the code

Yes, at a glance it looks safe to me.

>        * It seems from discussing briefly with Elijah Newren in the thread
>          above that thare are no obvious red flags
>        * Manual testing, explicitly and implicitly through months of use,
>          yields no issues
>      * Is it OK to check the repo configuration in the body of processing?
>        It seems to be a rare pattern

Yes, it's not very common, but it's fine.

>      * Can anyone think of a way to test this change?

Well, if we set "flags" to 0 in your new helper the existing tests will
fail, so that's something at least.

> -static void new_untracked_cache(struct index_state *istate)
> +static unsigned configured_default_dir_flags(struct repository *repo)
> +{
> +	/*
> +	 * This logic is coordinated with the setting of these flags in
> +	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
> +	 * of the config setting in commit.c#git_status_config()
> +	 */
> +	char *status_untracked_files_config_value;
> +	int config_outcome = repo_config_get_string(repo,
> +						    "status.showuntrackedfiles",
> +						    &status_untracked_files_config_value);
> +	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
> +		return 0;
> +	} else {
> +		/*
> +		 * The default, if "all" is not set, is "normal" - leading us here.
> +		 * If the value is "none" then it really doesn't matter.
> +		 */
> +		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> +	}
> +}
> +
> [...]

In reviewing this I found the addition of very long lines & indentation
made this a bit harder to read. I came up with the below which should be
squashable on top, and perhaps makes this easier to read.

I.e. the one caller that needs custom flags passes them, others pass -1
now.

For throwaway "char *" variables we usually use "char *p", "char *val"
or whatever. A "status_untracked_files_config_value" is a bit much for
something function local whose body is <10 lines of code.

And if you drop the "int config_outcome" + rename the variable the
repo_config_get_string() fits on one line:

diff --git a/dir.c b/dir.c
index 57a7d42482f..22a27d7780f 100644
--- a/dir.c
+++ b/dir.c
@@ -2746,34 +2746,33 @@ static void set_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
-static unsigned configured_default_dir_flags(struct repository *repo)
+static unsigned new_untracked_cache_flags(struct index_state *istate)
 {
+	struct repository *repo = istate->repo;
+	char *val;
+
 	/*
 	 * This logic is coordinated with the setting of these flags in
 	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
 	 * of the config setting in commit.c#git_status_config()
 	 */
-	char *status_untracked_files_config_value;
-	int config_outcome = repo_config_get_string(repo,
-						    "status.showuntrackedfiles",
-						    &status_untracked_files_config_value);
-	if (!config_outcome && !strcmp(status_untracked_files_config_value, "all")) {
+	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
+	    !strcmp(val, "all"))
 		return 0;
-	} else {
-		/*
-		 * The default, if "all" is not set, is "normal" - leading us here.
-		 * If the value is "none" then it really doesn't matter.
-		 */
-		return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-	}
+
+	/*
+	 * The default, if "all" is not set, is "normal" - leading us here.
+	 * If the value is "none" then it really doesn't matter.
+	 */
+	return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 }
 
-static void new_untracked_cache(struct index_state *istate, unsigned flags)
+static void new_untracked_cache(struct index_state *istate, int flags)
 {
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	uc->dir_flags = flags;
+	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
@@ -2782,13 +2781,11 @@ static void new_untracked_cache(struct index_state *istate, unsigned flags)
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
-		new_untracked_cache(istate,
-				    configured_default_dir_flags(istate->repo));
+		new_untracked_cache(istate, -1);
 	} else {
 		if (!ident_in_untracked(istate->untracked)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate,
-					    configured_default_dir_flags(istate->repo));
+			new_untracked_cache(istate, -1);
 		}
 	}
 }
@@ -2866,7 +2863,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	 * the current effective flags don't match the configured
 	 * flags.
 	 */
-	if (dir->flags != configured_default_dir_flags(istate->repo))
+	if (dir->flags != new_untracked_cache_flags(istate))
 		return NULL;
 
 	/*
