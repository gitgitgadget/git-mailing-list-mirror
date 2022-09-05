Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCE9ECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbiIEI2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiIEI1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CB286C0
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k9so10323516wri.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M06hmaJjVFoIHa4CgpSLYL9DP+HC4p3tXHjVZQm0gyE=;
        b=jx9MKkT80A2xGqaymV83pavJ0DZwuMcjv/TYQr1eiMX7XEFwULE+LhA0dPMhPKKYV5
         M9KvMVN9AENL+WUtF/Id8Xvt1B3uQMkDqe0MS8cXbppRBn3UNGDRzdt2+r7Pc8fyCQGy
         4xzdPGfUUOvd0v2pverUFkRed7a6I6TDaGTy1vUwAsGG+J7x5ztcaZckvNt8FK/YMLx3
         dSXBBS99/54dS7FKner0gRX1PjeX4EB5YuN+VFwvYfCIqzDq7mrsNT07LFqCwV5vZSM+
         zdbeVxLlqs7fdE5RDay8ccldm/8r9dP69GPwWoq9RJpxUmGPcwq2smCngeRyApQ1J1hD
         Qz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M06hmaJjVFoIHa4CgpSLYL9DP+HC4p3tXHjVZQm0gyE=;
        b=j6THjB+xUk6ONx6By6PrFnbNFMMC24wQfbHbooT1Em9zk/wsaXgphMM1yQ18O7hLJY
         coQ1/M9urw38SCwS1/U6lwQATXqQBL+t27ZFVNngeGpQctsIjzYRuE9M71fpIkm01qh2
         LdCwrAD2lPi+61BV9SeI9fZysmW+9brtu+MOb6XSsVzragfLki9uYqQc1z/Z4L+LzV88
         7T70CvTjlgWSb/4j06lhs+HPrb5i9+HRRzT9PUzjiD6esSCQ3JgeWnxSH8/XbX+sCT5Q
         YCegJOOSxs/S4jcItLLzump4StsGk4bjm6AW1oAH5fA2H5Qsa1qbo84fKnltDEAi/w2M
         glag==
X-Gm-Message-State: ACgBeo31a9AVpO9eIHNRdzN1ifNCpRQ1KlaJThY8iTrcEc3IL/HFIkxf
        3ugKZAd3fC9yQZEj+Wi/qkWEKko/UP8wQw==
X-Google-Smtp-Source: AA6agR6YS8d1Ir3pAJjjw1QZG4EqKAY5d3toLZZ1mt/wX5ft8msAoiF7GfI/u+bGD2w+WNo74SfWrg==
X-Received: by 2002:a05:6000:696:b0:226:f89d:55b2 with SMTP id bo22-20020a056000069600b00226f89d55b2mr10524366wrb.133.1662366431390;
        Mon, 05 Sep 2022 01:27:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/34] doc txt & -h consistency: add missing options and labels
Date:   Mon,  5 Sep 2022 10:26:31 +0200
Message-Id: <patch-20.34-f6ecf6a38af-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various issues of SYNOPSIS and -h output syntax where:

 * Options such as --force were missing entirely
 * ...or the short option, such as -f

 * We said "opts" or "options", but could instead enumerate
   the (small) set of supported options

 * argument labels were missing entirely (ls-remote)

 * How we referred to an argument was inconsistent between the two,
   e.g. <pack> v.s. <pack>.idx.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-pack.txt          |  3 ++-
 Documentation/git-sparse-checkout.txt    |  2 +-
 Documentation/git-update-server-info.txt |  8 +++++++-
 Documentation/git-verify-commit.txt      |  2 +-
 Documentation/git-verify-tag.txt         |  2 +-
 builtin/credential-cache--daemon.c       |  2 +-
 builtin/describe.c                       |  5 +++--
 builtin/diff-index.c                     |  2 +-
 builtin/help.c                           |  2 +-
 builtin/ls-remote.c                      |  2 +-
 builtin/pack-refs.c                      |  2 +-
 builtin/revert.c                         |  9 +++++----
 builtin/send-pack.c                      |  1 +
 builtin/sparse-checkout.c                |  2 +-
 builtin/symbolic-ref.c                   |  5 +++--
 builtin/tag.c                            | 10 ++++++----
 builtin/update-server-info.c             |  2 +-
 builtin/upload-pack.c                    |  3 ++-
 builtin/verify-pack.c                    |  2 +-
 help.c                                   |  2 +-
 20 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index be41f119740..047713e3a81 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,7 +9,8 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+'git send-pack' [--mirror] [--dry-run] [--force]
+		[--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
 		[--[no-]signed|--signed=(true|false|if-asked)]
 		[<host>:]<directory> (--all | <ref>...)
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 872436d7426..68392d2a56e 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout' <subcommand> [<options>]
+'git sparse-checkout' (init | list | set | add | reapply | disable) [<options>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 969bb2e15f1..4e6bf44427f 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
 SYNOPSIS
 --------
 [verse]
-'git update-server-info'
+'git update-server-info' [-f | --force]
 
 DESCRIPTION
 -----------
@@ -19,6 +19,12 @@ $GIT_OBJECT_DIRECTORY/info directories to help clients discover
 what references and packs the server has.  This command
 generates such auxiliary files.
 
+OPTIONS
+-------
+-f::
+--force::
+	Allow adding otherwise ignored files.
+
 OUTPUT
 ------
 
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 92097f6673d..96d10cfdffe 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -8,7 +8,7 @@ git-verify-commit - Check the GPG signature of commits
 SYNOPSIS
 --------
 [verse]
-'git verify-commit' <commit>...
+'git verify-commit' [-v | --verbose] <commit>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0b8075dad96..a454df2711e 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' [--format=<format>] <tag>...
+'git verify-tag' [-v | --verbose] [--format=<format>] <tag>...
 
 DESCRIPTION
 -----------
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index ca672a6a619..d4eb0097d24 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -267,7 +267,7 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	const char *socket_path;
 	int ignore_sighup = 0;
 	static const char *usage[] = {
-		"git-credential-cache--daemon [opts] <socket-path>",
+		"git-credential-cache--daemon [--debug] <socket-path>",
 		NULL
 	};
 	int debug = 0;
diff --git a/builtin/describe.c b/builtin/describe.c
index a76f1a1a7a7..98fb8afc3fa 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -23,8 +23,9 @@
 define_commit_slab(commit_names, struct commit_name *);
 
 static const char * const describe_usage[] = {
-	N_("git describe [<options>] [<commit-ish>...]"),
-	N_("git describe [<options>] --dirty"),
+	N_("git describe [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]"),
+	N_("git describe [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]"),
+	N_("git describe <blob>"),
 	NULL
 };
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index e667cf52e7d..aea139b9d8f 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -9,7 +9,7 @@
 #include "submodule.h"
 
 static const char diff_cache_usage[] =
-"git diff-index [-m] [--cached] "
+"git diff-index [-m] [--cached] [--merge-base] "
 "[<common-diff-options>] <tree-ish> [<path>...]"
 "\n"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/builtin/help.c b/builtin/help.c
index 09ac4289f13..36e3f4116e9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -88,7 +88,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
+	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index df44e5cc0d1..5d5ac038716 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -7,7 +7,7 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-	   "              [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]\n"
 	   "              [--symref] [<repository> [<refs>...]]"),
 	NULL
 };
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index cfbd5c36c76..27c2ca06acb 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -5,7 +5,7 @@
 #include "repository.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [<options>]"),
+	N_("git pack-refs [--all] [--no-prune]"),
 	NULL
 };
 
diff --git a/builtin/revert.c b/builtin/revert.c
index ee2a0807f01..ee32c714a76 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -21,14 +21,15 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [<options>] <commit-ish>..."),
-	N_("git revert <subcommand>"),
+	N_("git revert [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>..."),
+	N_("git revert (--continue | --skip | --abort | --quit)"),
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	N_("git cherry-pick [<options>] <commit-ish>..."),
-	N_("git cherry-pick <subcommand>"),
+	N_("git cherry-pick [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]\n"
+	   "                [-S[<keyid>]] <commit>..."),
+	N_("git cherry-pick (--continue | --skip | --abort | --quit)"),
 	NULL
 };
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 64962be0168..dd9d2c4acc4 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -20,6 +20,7 @@ static const char * const send_pack_usage[] = {
 	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
 	   "              [--receive-pack=<git-receive-pack>]\n"
 	   "              [--verbose] [--thin] [--atomic]\n"
+	   "              [--[no-]signed|--signed=(true|false|if-asked)]\n"
 	   "              [<host>:]<directory> (--all | <ref>...)"),
 	NULL,
 };
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index aac0f708e42..58a22503f04 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,7 +20,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
 	NULL
 };
 
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 1b0f10225f0..50b6df78df0 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -5,8 +5,9 @@
 #include "parse-options.h"
 
 static const char * const git_symbolic_ref_usage[] = {
-	N_("git symbolic-ref [<options>] <name> [<ref>]"),
-	N_("git symbolic-ref -d [-q] <name>"),
+	N_("git symbolic-ref [-m <reason>] <name> <ref>"),
+	N_("git symbolic-ref [-q] [--short] <name>"),
+	N_("git symbolic-ref --delete [-q] <name>"),
 	NULL
 };
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 75dece0e4f1..f665b90692a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,11 +23,13 @@
 #include "date.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-	   "        <tagname> [<head>]"),
+	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+	   "        <tagname> [<commit> | <object>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
-	   "        [--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
+	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
+	   "        [--points-at <object>] [--column[=<options>] | --no-column]\n"
+	   "[--create-reflog] [--sort=<key>] [--format=<format>]\n"
+	   "[--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 880fffec587..d2239c9ef4d 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
 
 static const char * const update_server_info_usage[] = {
-	"git update-server-info [--force]",
+	"git update-server-info [-f | --force]",
 	NULL
 };
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 125af53885f..25b69da2bf2 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -8,7 +8,8 @@
 #include "serve.h"
 
 static const char * const upload_pack_usage[] = {
-	N_("git upload-pack [<options>] <dir>"),
+	N_("git-upload-pack [--[no-]strict] [--timeout=<n>] [--stateless-rpc]\n"
+	   "                [--advertise-refs] <directory>"),
 	NULL
 };
 
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 05c52135946..27d6f75fd8a 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -56,7 +56,7 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
 	NULL
 };
 
diff --git a/help.c b/help.c
index 991e33f8a6e..0dd5b980220 100644
--- a/help.c
+++ b/help.c
@@ -757,7 +757,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int build_options = 0;
 	const char * const usage[] = {
-		N_("git version [<options>]"),
+		N_("git version [--build-options]"),
 		NULL
 	};
 	struct option options[] = {
-- 
2.37.3.1425.g73df845bcb2

