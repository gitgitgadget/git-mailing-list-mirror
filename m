Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E2C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJDNZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJDNYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4F50705
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so12578255wro.7
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb9e17NA31TR6zPKdKFTst6PKU+fNvG4CJSSRbxshMg=;
        b=KfsHS3r8k6tzGZHW1OVX9mIm5F82ATrqHuZiL6pXbJGnm0IIBdtZVctAK3Hh9kpkmf
         0kRq+fgHvNFmK3zdS3Po/VaW+cKlBFZIflQzFHiA2lUMD4o7XAtDYpvv+/Hfm4rNAu0N
         LkEq9vt82U5SrPG+ow3yzLYMLH5KCXPDVTKo7O1JrZIXc1QqWKVKrYsJD7t2BW79FHC4
         R1DCkwqIlBXo7k64kjl1Q6yDAp9p/oUNLesUxzYxDa+1VbUOmJhOJrWmGNJeDzDmpnPw
         kbG5ujcR/0ciEvCUAJcIXA0Y1DqfuWIudpjv3ksmW+chJzXGSnphSgabkym1CFGoqRmS
         yD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb9e17NA31TR6zPKdKFTst6PKU+fNvG4CJSSRbxshMg=;
        b=ZizD2n70rdQbTI1VtES+GNVBTWEz8kEKBxcM9S8FU78IPGfKCPRZapn83iJyEH2gJf
         mwAXAaOAamz62lfRYSAyzPV0+ndwOUFT5Px7joTe6Z1Tz7DACj8wrtTxBrldfxyEJ0OT
         tcw/nTh6u+qD28ZICMNob4xR92Jx9EYqYCQwz2fON2Nr+Jutb7oqezq736z8PLzS9/sV
         FArERv8xDY+OSBKB4qBeFyMU2HFg8e6Zoiw5kmfT6zET1pbwo9a+RGBwrqDLqk2XcPyE
         fkrjCPDm5sTs1hOe2UdgIRpHCh9A2fdUELHvVMVrT+KvzUnQ0q/PanAbLLz3UuI6XBPD
         fyrg==
X-Gm-Message-State: ACrzQf12zthwbP5SbNbxDwJKVMCC8yLAy/Fuxq8lDHAMeR5hgz828m1y
        NxnO9VUCZfbGbyMBKfFa9pJwbi+ZByE2kw==
X-Google-Smtp-Source: AMsMyM4hDPxId3XzuWVFpJ4XaAdRrYdiGn7pIayrDZghPkb1M8/SEP/BJG+FYUYrIiwBBIGRbUrB7w==
X-Received: by 2002:a05:6000:1c18:b0:22b:13e3:19d3 with SMTP id ba24-20020a0560001c1800b0022b13e319d3mr16663999wrb.699.1664889855198;
        Tue, 04 Oct 2022 06:24:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:14 -0700 (PDT)
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
Subject: [PATCH v4 19/34] doc txt & -h consistency: add missing options and labels
Date:   Tue,  4 Oct 2022 15:23:33 +0200
Message-Id: <patch-v4-19.34-fb95d7a9f86-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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

 * Options that were missing entirely (ls-remote's --sort=<key>)

   As we can specify "--sort" multiple times (it's backed by a
   string-list" it should really be "[(--sort=<key>)...]", which is
   what "git for-each-ref" lists it as, but let's leave that issue for
   a subsequent cleanup, and stop at making these consistent. Other
   "ref-filter.h" users share the same issue, e.g. "git-branch.txt".

 * For "verify-tag" and "verify-commit" we were missing the "--raw"
   option.

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
 builtin/verify-commit.c                  |  2 +-
 builtin/verify-tag.c                     |  2 +-
 help.c                                   |  2 +-
 19 files changed, 40 insertions(+), 26 deletions(-)

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
index 969bb2e15f1..17e429dbd09 100644
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
+	update the info files from scratch.
+
 OUTPUT
 ------
 
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 92097f6673d..aee4c40eac4 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -8,7 +8,7 @@ git-verify-commit - Check the GPG signature of commits
 SYNOPSIS
 --------
 [verse]
-'git verify-commit' <commit>...
+'git verify-commit' [-v | --verbose] [--raw] <commit>...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0b8075dad96..81d50ecc4c6 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' [--format=<format>] <tag>...
+'git verify-tag' [-v | --verbose] [--format=<format>] [--raw] <tag>...
 
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
 
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 40c69a0bedd..3ebad32b0f1 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -16,7 +16,7 @@
 #include "gpg-interface.h"
 
 static const char * const verify_commit_usage[] = {
-		N_("git verify-commit [-v | --verbose] <commit>..."),
+		N_("git verify-commit [-v | --verbose] [--raw] <commit>..."),
 		NULL
 };
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06ba..217566952d8 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -15,7 +15,7 @@
 #include "ref-filter.h"
 
 static const char * const verify_tag_usage[] = {
-		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
+		N_("git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>..."),
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

