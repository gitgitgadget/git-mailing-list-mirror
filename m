Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C66C47423
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA2521D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eelj0oiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgJADq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730555AbgJADq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CFEC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so1288404wmh.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aKfttKZqWWeMvcMBTaMWxfS3Jrs++sz9EJ06YfrFm4E=;
        b=Eelj0oiKzgWDmII2cEIY2f7WBMjsjqj01ZeQmA11SjE+CV+ocvpzzMqguYsuodF51k
         SInZ3a5Ei+CE5FVG1xI3GmIOmpwDAztZz3nmKiGfKFM9ej2Y58/RMuXZwwWUc6QgC28M
         yz37LHl4R3/+OiX1qjX/fEZjtipl3YiEbzjNq0WHKoVWg8bh3uuzAAjsPi8s+XUzi+/J
         pgDJl7smruMTOjX0QCboeW/0DKBi51LTvWFSP3Y9H3ZwUchxEql7W+HvuC+pR4bET6QJ
         h7vZLHHumq/RT1TLooXeV/RHFMeZAshOCfEPp6RoM7acRlpi4WcGF/EHc4SuPtF+TfcZ
         qBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aKfttKZqWWeMvcMBTaMWxfS3Jrs++sz9EJ06YfrFm4E=;
        b=GTflyWtDlsYEdUw0waBmFvuLv5ryxK3fo9YzSKwQ9H43FYkD2ATKO4MaPGSpdp811n
         ykGvKhuP6+0k1ULRlz9cVteBQjn4/rQab65SMr9x77LFdSlvJUoVDzouj4X9pcVrEeNh
         l8r4VPOLG3PvGROMnbY79Owy93PuRKM7Dgqw2Y38A0cMIsQ6bNKuuOC5fKb8BxEaA+zU
         vvsn2tl7E2wfRv9jFiWciVZpo7uFivwhnkthsNxaxP3XN4c7S0RYuAZzgB2rpeCAAm4x
         EFJKK3pZH97wsKsDVAbXan2oBhIKViOFXkpqi+m4pzC70kEF76EpNYLYS/A9KgJbYB1g
         ZY5g==
X-Gm-Message-State: AOAM533CptF/BgcW/rEgYb5hJMr7UeUl6itkoZiTwNG54l5k4/yLFI7e
        tJmpXr0IjW43+vfi4d74sT755k57pLk=
X-Google-Smtp-Source: ABdhPJwSMer0b9efgoUKRQYLmPfBmZNMu0mcEzhIG4eL+QxacxpGarDRho+SIquXBswk0j4ysVwoDA==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr6272270wmc.151.1601523984298;
        Wed, 30 Sep 2020 20:46:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm1127332wmi.18.2020.09.30.20.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:23 -0700 (PDT)
Message-Id: <da8212e500a5876d5427a3be3ea60e5a03a9b9ae.1601523977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
        <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:16 +0000
Subject: [PATCH v3 7/7] clone: allow configurable default for `-o`/`--origin`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

While the default remote name of "origin" can be changed at clone-time
with `git clone`'s `--origin` option, it was previously not possible
to specify a default value for the name of that remote.  Add support for
a new `clone.defaultRemoteName` config, with the newly-created remote
name resolved in priority order:

1. (Highest priority) A remote name passed directly to `git clone -o`
2. A `clone.defaultRemoteName=new_name` in config `git clone -c`
3. A `clone.defaultRemoteName` value set in `/path/to/template/config`,
   where `--template=/path/to/template` is provided
4. A `clone.defaultRemoteName` value set in a non-template config file
5. The default value of `origin`

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Andrei Rybak <rybak.a.v@gmail.com>
Signed-off-by: Sean Barag <sean@barag.org>
---
 Documentation/config.txt       |  2 ++
 Documentation/config/clone.txt |  5 +++++
 Documentation/git-clone.txt    |  5 +++--
 builtin/clone.c                | 26 +++++++++++++++++++-------
 t/t5606-clone-options.sh       | 22 ++++++++++++++++++++++
 5 files changed, 51 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/clone.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf706b950e..025ca4df11 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -334,6 +334,8 @@ include::config/checkout.txt[]
 
 include::config/clean.txt[]
 
+include::config/clone.txt[]
+
 include::config/color.txt[]
 
 include::config/column.txt[]
diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
new file mode 100644
index 0000000000..20755d413a
--- /dev/null
+++ b/Documentation/config/clone.txt
@@ -0,0 +1,5 @@
+clone.defaultRemoteName::
+	The name of the remote to create when cloning a repository.  Defaults to
+	`origin`, and can be overridden by passing the `--origin` command-line
+	option to linkgit:git-clone[1].
+
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 097e6a86c5..876aedcd47 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -183,8 +183,9 @@ objects from the source repository into a pack in the cloned repository.
 
 -o <name>::
 --origin <name>::
-	Instead of using the remote name `origin` to keep track
-	of the upstream repository, use `<name>`.
+	Instead of using the remote name `origin` to keep track of the upstream
+	repository, use `<name>`.  Overrides `clone.defaultRemoteName` from the
+	config.
 
 -b <name>::
 --branch <name>::
diff --git a/builtin/clone.c b/builtin/clone.c
index 6bcdfa4cd6..a0841923cf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,7 +53,7 @@ static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
-static char *remote_name = "origin";
+static char *remote_name = NULL;
 static char *option_branch = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
@@ -854,6 +854,10 @@ static int checkout(int submodule_progress)
 
 static int git_clone_config(const char *k, const char *v, void *cb)
 {
+	if (!strcmp(k, "clone.defaultremotename")) {
+		free(remote_name);
+		remote_name = xstrdup(v);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -1009,12 +1013,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (option_origin)
-		remote_name = option_origin;
-
-	if (!valid_remote_name(remote_name))
-		die(_("'%s' is not a valid remote name"), remote_name);
-
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
@@ -1157,6 +1155,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 */
 	git_config(git_clone_config, NULL);
 
+	/*
+	 * apply the remote name provided by --origin only after this second
+	 * call to git_config, to ensure it overrides all config-based values.
+	 */
+	if (option_origin != NULL)
+		remote_name = xstrdup(option_origin);
+
+	if (remote_name == NULL)
+		remote_name = xstrdup("origin");
+
+	if (!valid_remote_name(remote_name))
+		die(_("'%s' is not a valid remote name"), remote_name);
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
@@ -1356,6 +1367,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout(submodule_progress);
 
+	free(remote_name);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 0422b24258..5e201e7d85 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,6 +19,13 @@ test_expect_success 'clone -o' '
 
 '
 
+test_expect_success 'rejects invalid -o/--origin' '
+
+	test_must_fail git clone -o "bad...name" parent clone-bad-name 2>err &&
+	test_i18ngrep "'\''bad...name'\'' is not a valid remote name" err
+
+'
+
 test_expect_success 'disallows --bare with --origin' '
 
 	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
@@ -63,6 +70,21 @@ test_expect_success 'prefers -c config over --template config' '
 
 '
 
+test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
+
+	test_config_global clone.defaultRemoteName from_config &&
+	git clone parent clone-config-origin &&
+	git -C clone-config-origin rev-parse --verify refs/remotes/from_config/master
+
+'
+
+test_expect_success 'prefers --origin over -c config' '
+
+	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&
+	git -C clone-o-and-inline-config rev-parse --verify refs/remotes/from_option/master
+
+'
+
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-- 
gitgitgadget
