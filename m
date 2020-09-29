Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A29C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617DF208D5
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM8QiwLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgI2DhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgI2DhE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FCCC0613D4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so3149973wmj.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j4ZGlSZnIOAnCAxmKzXa0rnPh2Rvq/GMG+MUDOpOZ10=;
        b=kM8QiwLI1DABMBYKX2Ene3b9fZvd0r870vuZq19qN9AYm8fTkqsgPsat5qwtM5XSlw
         dgyUPmLty96L+I9HSFj2o4onZz/LoNH2ASZJeErtg3txYxVcVURRx/GlQZLaPIBQtzfL
         goeotCVIwnmi/mYT+ox1tEjqsMzTbPbFl0//3lfOxEhVkBAllBJaQHlYEeSSOZGKYF+S
         zrXhWSzPEDFHMdMHKDfU8ii4pR/yY2U45VVaTs4pbOZ2J0kX2S2HYa4U1n0SYq6fS8tT
         RD3OgdKlN//NK7uLL9+xBf8HMx2JAi0in7iosVH0xC9XREOJEXbzXrEq/4bNmhHnlwEx
         CDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j4ZGlSZnIOAnCAxmKzXa0rnPh2Rvq/GMG+MUDOpOZ10=;
        b=bQPidyCONHHdZrZR65EObGyrj5gpHbjTZX/40AszRZR+CEhH8TxhimbMumZOFCoReX
         DwPvMKhCT52/0nweQrfhT67pbL2lbW4xY5NBkSXAXJzq2PQMUTHxkyZiz49D4PxZ0Rbw
         T+RusPCbUHp80Ud3lEA0IgWu5daR4w5RG7HK5RYQyu0p1qSS2B/vYfKZP/i/HVag5wab
         pzSY5RarRUIajXHYW3A603+WrB921vrc5PCiE41Kevd5WS2qKNcpFXl71T3dj/xFZY4h
         Ws+TgXnvs5tuBv4PckvIxbYnq6M9+m6hIIKdYP1IOTirOko6Ce66fjidUaijUwaUboTi
         TgpQ==
X-Gm-Message-State: AOAM53295ywwQItPPzHpTxhTwg+BJCFeRZechhdP0iGyN5BLnatf5x+o
        frDwImhZz3f/1sHM1QWFMWeehTGJqYk=
X-Google-Smtp-Source: ABdhPJzv2TFUYrSfmAtSuVjiwCrJinr0Y7AuYbuex1YvnYn2P55D9d2xQXE5LLJ+sjd74cQ6z5emDQ==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr2005174wmb.129.1601350622362;
        Mon, 28 Sep 2020 20:37:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm3535376wmi.9.2020.09.28.20.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:37:01 -0700 (PDT)
Message-Id: <737f91c6244220eec196c327fcea9a6548c45310.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:55 +0000
Subject: [PATCH v2 7/7] clone: allow configurable default for `-o`/`--origin`
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
 builtin/clone.c                | 27 +++++++++++++++++++--------
 t/t5606-clone-options.sh       | 22 ++++++++++++++++++++++
 5 files changed, 51 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/config/clone.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f93b6837e4..8c58c53ae7 100644
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
index 7fdd00cd95..4c821de242 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,7 +53,8 @@ static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
 static char *option_origin = NULL;
-static char *remote_name = "origin";
+static char *default_remote_name = "origin";
+static char *remote_name = NULL;
 static char *option_branch = NULL;
 static struct string_list option_not = STRING_LIST_INIT_NODUP;
 static const char *real_git_dir;
@@ -854,6 +855,11 @@ static int checkout(int submodule_progress)
 
 static int git_clone_config(const char *k, const char *v, void *cb)
 {
+	if (!strcmp(k, "clone.defaultremotename")) {
+		if (remote_name != default_remote_name)
+			free(remote_name);
+		remote_name = xstrdup(v);
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -976,6 +982,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 
 	struct strvec ref_prefixes = STRVEC_INIT;
+	remote_name = default_remote_name;
 
 	packet_trace_identity("clone");
 
@@ -1009,12 +1016,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
@@ -1153,10 +1154,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * re-read config after init_db and write_config to pick up any config
-	 * injected by --template and --config, respectively
+	 * injected by --template and --config, respectively.
 	 */
 	git_config(git_clone_config, NULL);
 
+	/*
+	 * apply the remote name provided by --origin only after this second
+	 * call to git_config, to ensure it overrides all config-based values.
+	 */
+	if (option_origin)
+		remote_name = option_origin;
+
+	if (!valid_remote_name(remote_name))
+		die(_("'%s' is not a valid remote name"), remote_name);
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
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
