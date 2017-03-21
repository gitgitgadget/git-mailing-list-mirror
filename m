Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE472095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757455AbdCUW50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:57:26 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33100 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757076AbdCUW5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:57:25 -0400
Received: by mail-pg0-f49.google.com with SMTP id n190so100148690pga.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=geyJyKYuWpBNTztbo1s2ag0W2Nbhipfe0rFswVRbS64=;
        b=vllWyOBtkUNNOBfLDuXGxrH/3aT+R5zwhkiyqmUin+u1XfO8ZFHXeODV/SJZd9i89e
         7rtyE/PRVJwm3hUoLyDekXBEzGbex+Rsv6c1sif0yDl386+blkrUktBdrbnjXX3zIo20
         cg7656RXRHMBXHA09Z+LpVS8STQt1Duskel0A8uvR+IEqFsVmPk3KVMterFosCFFzUCx
         TYdfQ11rAqvJF1wNsl80mtCgDFL4djqIoJnVakfxfcBD6eun5nk4qjODwzmdj6tu+Wrh
         R6pjXD+t/zgbibAvLY0n2XOnQEe9NvqvFS5SkTwo0THWJb0a9AU4Bg3JiaXCVOyrtlK4
         OYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=geyJyKYuWpBNTztbo1s2ag0W2Nbhipfe0rFswVRbS64=;
        b=PFjV8B7GVOoW3PWzrx0KcTMhkTz4iNDrmEfwB5zMguu23xvkB67eUHCEtPUJw9yn3g
         YgxLvu3VBGuBkZd0Rv9Pa5164dXQ5n8iskCdWuSVSRcABIY3/iglKaae4VxpXpxuz7P7
         uHwB2WoJQ/IF05p62wglblNAQczmO8+hpkFcsF5BWXu5612SYROCwX/MwUCaFHgUVGy9
         ItFj5JA+RncDKIL6ZvHMYTQ3A/y9ynz+EuLAPnOrlNnCsyeIaxRiaFtxTZ/kReC8gxJF
         lDy+mwSfRWyB/3EtPoqjSP4xBWF6H2Ls3IthQMDweCEUZG5pWkvrIgbSUCj60T8/osJR
         O16A==
X-Gm-Message-State: AFeK/H0vU6UhP6PiokDDtq+rokYnrM7mIShQFHkRW8+MD/97YQKCv9m5g2nAhh2PzsZKKYE1
X-Received: by 10.99.45.133 with SMTP id t127mr40413248pgt.224.1490137043476;
        Tue, 21 Mar 2017 15:57:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b114:ae16:71df:23b2])
        by smtp.gmail.com with ESMTPSA id q4sm23426027pgc.63.2017.03.21.15.57.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 15:57:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2] builtin/describe: introduce --broken flag
Date:   Tue, 21 Mar 2017 15:57:18 -0700
Message-Id: <20170321225718.18633-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.385.gd4d53dfa89.dirty
In-Reply-To: <CAGZ79kYfrKRbs40UH73VCgMsJgFyh1aG5ZrYMj3O_wGdu6rSUA@mail.gmail.com>
References: <CAGZ79kYfrKRbs40UH73VCgMsJgFyh1aG5ZrYMj3O_wGdu6rSUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-describe tells you the version number you're at, or errors out, e.g.
when you run it outside of a repository, which may happen when downloading
a tar ball instead of using git to obtain the source code.

To keep this property of only erroring out, when not in a repository,
severe (submodule) errors must be downgraded to reporting them gently
instead of having git-describe error out completely.

To achieve that a flag '--broken' is introduced, which is in the same
vein as '--dirty' but uses an actual child process to check for dirtiness.
When that child dies unexpectedly, we'll append '-broken' instead of
'-dirty'.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-describe.txt | 11 +++++++---
 builtin/describe.c             | 47 ++++++++++++++++++++++++++++++++++--------
 t/t6120-describe.sh            | 20 ++++++++++++++++++
 3 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 8755f3af7b..26f19d3b07 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -30,9 +30,14 @@ OPTIONS
 	Commit-ish object names to describe.  Defaults to HEAD if omitted.
 
 --dirty[=<mark>]::
-	Describe the working tree.
-	It means describe HEAD and appends <mark> (`-dirty` by
-	default) if the working tree is dirty.
+--broken[=<mark>]::
+	Describe the state of the working tree.  When the working
+	tree matches HEAD, the output is the same as "git describe
+	HEAD".  If the working tree has local modification "-dirty"
+	is appended to it.  If a repository is corrupt and Git
+	cannot determine if there is local modification, Git will
+	error out, unless `--broken' is given, which appends
+	the suffix "-broken" instead.
 
 --all::
 	Instead of using only the annotated tags, use any ref
diff --git a/builtin/describe.c b/builtin/describe.c
index 76c18059bf..45adbf67d5 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include "run-command.h"
 
 #define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -31,7 +32,7 @@ static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
-static const char *dirty;
+static const char *suffix, *dirty, *broken;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -292,8 +293,8 @@ static void describe(const char *arg, int last_one)
 		display_name(n);
 		if (longformat)
 			show_suffix(0, n->tag ? &n->tag->tagged->oid : &oid);
-		if (dirty)
-			printf("%s", dirty);
+		if (suffix)
+			printf("%s", suffix);
 		printf("\n");
 		return;
 	}
@@ -369,8 +370,8 @@ static void describe(const char *arg, int last_one)
 		struct object_id *oid = &cmit->object.oid;
 		if (always) {
 			printf("%s", find_unique_abbrev(oid->hash, abbrev));
-			if (dirty)
-				printf("%s", dirty);
+			if (suffix)
+				printf("%s", suffix);
 			printf("\n");
 			return;
 		}
@@ -413,8 +414,8 @@ static void describe(const char *arg, int last_one)
 	display_name(all_matches[0].name);
 	if (abbrev)
 		show_suffix(all_matches[0].depth, &cmit->object.oid);
-	if (dirty)
-		printf("%s", dirty);
+	if (suffix)
+		printf("%s", suffix);
 	printf("\n");
 
 	if (!last_one)
@@ -445,6 +446,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+		{OPTION_STRING, 0, "broken",  &broken, N_("mark"),
+			N_("append <mark> on broken working tree (default: \"-broken\")"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "-broken"},
 		OPT_END(),
 	};
 
@@ -493,7 +497,28 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("No names found, cannot describe anything."));
 
 	if (argc == 0) {
-		if (dirty) {
+		if (broken) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			argv_array_pushv(&cp.args, diff_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+
+			if (!dirty)
+				dirty = "-dirty";
+
+			switch (run_command(&cp)) {
+			case 0:
+				suffix = NULL;
+				break;
+			case 1:
+				suffix = dirty;
+				break;
+			default:
+				/* diff-index aborted abnormally */
+				suffix = broken;
+			}
+		} else if (dirty) {
 			static struct lock_file index_lock;
 			int fd;
 
@@ -506,11 +531,15 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
 					    diff_index_args, prefix))
-				dirty = NULL;
+				suffix = NULL;
+			else
+				suffix = dirty;
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
 		die(_("--dirty is incompatible with commit-ishes"));
+	} else if (broken) {
+		die(_("--broken is incompatible with commit-ishes"));
 	} else {
 		while (argc-- > 0)
 			describe(*argv++, argc == 0);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 167491fd5b..16952e44fc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -233,4 +233,24 @@ test_expect_success 'describe --contains and --no-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup and absorb a submodule' '
+	test_create_repo sub1 &&
+	test_commit -C sub1 initial &&
+	git submodule add ./sub1 &&
+	git submodule absorbgitdirs &&
+	git commit -a -m "add submodule" &&
+	git describe --dirty >expect &&
+	git describe --broken >out &&
+	test_cmp expect out
+'
+
+test_expect_success 'describe chokes on severly broken submodules' '
+	mv .git/modules/sub1/ .git/modules/sub_moved &&
+	test_must_fail git describe --dirty
+'
+test_expect_success 'describe ignoring a borken submodule' '
+	git describe --broken >out &&
+	grep broken out
+'
+
 test_done
-- 
2.12.1.385.gd4d53dfa89.dirty

