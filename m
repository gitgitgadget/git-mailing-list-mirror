Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46883C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3SLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiI3SKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57711EF02E
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n10so7989642wrw.12
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RqPsxYNLoHC/f8bVtAvF03OrswHANxvf09+OWUVW4/g=;
        b=WrBLlDPRuGN+qGZ+uWAivPlY7t0ebDEabC9zjjRnHxtlJ3D27QA4ZXmG1h021HlzPJ
         3G7RaJ+djPyvrWsHP0n0hMxJAe9Wcj0dIz+D02VT/QOGqmi1VejS5PDqPANe7bujAvvB
         NWZeXVjC5McHXG74u4Zo2n2oI/Hxf6a95L7+6hU9GvqiTE8xsk0nYM5dzU3u41jQMSND
         R5RBK52nWJIxkFPtLQOStaWvkMJONedSptiJenC7ehEw519DgooH6GMZFetbI0Yecf9u
         Zn7A+lSUkOtIyztw3pvdXwGyd53BB+gwFaoU9Qe3oMHjsEwG2JYe5cuR99B7cWhu8n4M
         tfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RqPsxYNLoHC/f8bVtAvF03OrswHANxvf09+OWUVW4/g=;
        b=bjVTDVQUq6Ak8M/mYgAj2UV4LhhLtQaDHdMuhvTYx+2yAOQaSKtuCDJfK68OX3lxkz
         hebSkL1BNPfV0UzQMWWer14iEtHFubjudp9SP2hvd0EF6cC/N98bjOtYz1wGxNWTbMcR
         dW7gNttvSZ4r2QyMD7uii/laRPZk4pr+6PnBGA6Uz2cqcTpHBObuwtasxtbEGudNkvFf
         /LNgGMOsADyQ0wyjAqVi6ePewtv7urwgfWMjOwtc6QugNgZPF0uG868gFri22nrugMV8
         9wH9plhguWrRRPznrxKRUOV2o+lbHHSXcoBazDTxe250aPQMBCJ+uTCjVznpB30v06VJ
         At1w==
X-Gm-Message-State: ACrzQf0S8/zu81AXd4BbXdpIndvzFCeHDyRGc3gf1KnJhEw3b4odfIj7
        mek7V1xmbdzWYZPD8LadE5V981LWaYx0fw==
X-Google-Smtp-Source: AMsMyM4qBQcS8OjlHGga7mew9+8LAbYQFLhV35MqB2bdZoS/7mQl/Im0m2/ImzxTJj5P6P0jdwTrsQ==
X-Received: by 2002:a5d:6c6f:0:b0:22a:74af:fb7c with SMTP id r15-20020a5d6c6f000000b0022a74affb7cmr6585044wrz.634.1664561361589;
        Fri, 30 Sep 2022 11:09:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 21/36] doc txt & -h consistency: add missing options and labels
Date:   Fri, 30 Sep 2022 20:07:44 +0200
Message-Id: <patch-v3-21.36-1713227d497-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
 builtin/ls-remote.c                      |  2 +-
 builtin/pack-refs.c                      |  2 +-
 builtin/revert.c                         |  9 +++++----
 builtin/send-pack.c                      |  1 +
 builtin/symbolic-ref.c                   |  5 +++--
 builtin/tag.c                            | 10 ++++++----
 builtin/update-server-info.c             |  2 +-
 builtin/upload-pack.c                    |  3 ++-
 help.c                                   |  2 +-
 17 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index e0c71623432..595b002152f 100644
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
 		[--[no-]signed | --signed=(true|false|if-asked)]
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
index e17c4b4c69b..23e3f05fb10 100644
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
index 64962be0168..4c5d125fa0a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -20,6 +20,7 @@ static const char * const send_pack_usage[] = {
 	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
 	   "              [--receive-pack=<git-receive-pack>]\n"
 	   "              [--verbose] [--thin] [--atomic]\n"
+	   "              [--[no-]signed | --signed=(true|false|if-asked)]\n"
 	   "              [<host>:]<directory> (--all | <ref>...)"),
 	NULL,
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
index 75dece0e4f1..d428c45dc8d 100644
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
+	   "        [--create-reflog] [--sort=<key>] [--format=<format>]\n"
+	   "        [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
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
 
diff --git a/help.c b/help.c
index d04542d8261..f1e090a4428 100644
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
2.38.0.rc2.935.g6b421ae1592

