Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8474DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiCAWVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiCAWVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:21:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BD7087E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:20:35 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 185so14160225qkh.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 14:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0d4GA7zloNI+Bu0KXPH8elePOKdhFuwLBPW17tvfVyw=;
        b=NNgxR9xj4rMyLBkYm3zF7Dvr1Og4flPDjhs08uZlwOQ2KLUqWDG9r7n2QTOlQvYLCA
         U/+KIE6320g5cyUqC5+N1dAhp23mIsIn0FG7x78QTUdWhWgO6qJFAWl0jM3uRMwWZd2V
         XTrR1UZ0odixMBJdSOgPyPdM5Rgw72Zf0ZYkFtpq6Y9FOKp5UkHIBe0P0Oo05sKQTC4A
         BcqUZ0LBChMe8FjmLGZaa2uMx8YPtXXiKHZqYg0/7vUUIjEUI/TMykPyxKpBnmZAmBh5
         xAaMgrmmEVUX6sdBkJBylUuk7k8WIiwEEZBbPrnWADVV922fM8W+0opMxjA1fvOaxYoS
         yl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0d4GA7zloNI+Bu0KXPH8elePOKdhFuwLBPW17tvfVyw=;
        b=SbWUU8zZ/ONrQcjSb0GDGayz9Wh6Mujkhs1ZYwJvGhrUAtPVNJjLo33QdVCwDFKTge
         zjBPjbsHjs8kzwEGGDP25Gpj2q1+vs5114BNLN7eBdKXrPK1GRIDdqJlEb4JkVLdsZdn
         ynMpwCvZjBgo7dUJk/UWp5lxlVstqk8B6R1b6hBgrbxaYniUVxCrE1pewn9qdVAJo15w
         YqQlow3frf6LiZISSrCy1EJ5xoEWLXx7zt+mfC8DQk6NJOALIZ1Rl4Q6sAXpnerYBknd
         1ylnahMbIVUK3sMK6qVRE4TPuPBTM5EDMgq5kaZibBvXYXtx0dkg2Vm3bf7w0T7/4yHy
         j+HA==
X-Gm-Message-State: AOAM533r3TB4vsi6Bjsk6kZBjavTudXhh6/aH6yGzvfuQjvKtLRdcip0
        76krquYJBgb4VNYV/FUA2jyHh/guTtxLo55/
X-Google-Smtp-Source: ABdhPJy+9j/AdNOM89oi7HCHhmc2QD/C52/lB8yrDuea/4zo059Fl1vCZc7ZotjWBfXMpDG0CBCk5Q==
X-Received: by 2002:a37:c44d:0:b0:60d:d761:516a with SMTP id h13-20020a37c44d000000b0060dd761516amr15046150qkm.273.1646173234422;
        Tue, 01 Mar 2022 14:20:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 192-20020a3704c9000000b00648d50e398asm7389770qke.109.2022.03.01.14.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:20:34 -0800 (PST)
Date:   Tue, 1 Mar 2022 17:20:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When renaming a remote, Git needs to rename all remote tracking
references to the remote's new name (e.g., renaming
"refs/remotes/old/foo" to "refs/remotes/new/foo" when renaming a remote
from "old" to "new").

This can be somewhat slow when there are many references to rename,
since each rename is done in a separate call to rename_ref() as opposed
to grouping all renames together into the same transaction. It would be
nice to execute all renames as a single transaction, but there is a
snag: the reference transaction backend doesn't support renames during a
transaction (only individually, via rename_ref()).

The reasons there are described in more detail in [1], but the main
problem is that in order to preserve the existing reflog, it must be
moved while holding both locks (i.e., on "oldname" and "newname"), and
the ref transaction code doesn't support inserting arbitrary actions
into the middle of a transaction like that.

As an aside, adding support for this to the ref transaction code is
less straightforward than inserting both a ref_update() and ref_delete()
call into the same transaction. rename_ref()'s special handling to
detect D/F conflicts would need to be rewritten for the transaction code
if we wanted to proactively catch D/F conflicts when renaming a
reference during a transaction. The reftable backend could support this
much more readily because of its lack of D/F conflicts.

Instead of a more complex modification to the ref transaction code,
display a progress meter when running verbosely in order to convince the
user that Git is doing work while renaming a remote.

This is mostly done as-expected, with the minor caveat that we
intentionally count symrefs renames twice, since renaming a symref takes
place over two separate calls (one to delete the old one, and another to
create the new one).

[1]: https://lore.kernel.org/git/572367B4.4050207@alum.mit.edu/

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
A small patch to improve the user experience of `git remote -v rename`
with a large number of remote tracking references, in lieu of a more
complicated changes to the reference transaction code.

 Documentation/git-remote.txt |  2 +-
 builtin/remote.c             | 26 ++++++++++++++++++++++----
 t/t5505-remote.sh            |  3 ++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2bebc32566..626f9d0afc 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
-'git remote rename' <old> <new>
+'git remote' [-v | --verbose] 'rename' <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
diff --git a/builtin/remote.c b/builtin/remote.c
index 6f27ddc47b..a18b8532e2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -12,11 +12,12 @@
 #include "object-store.h"
 #include "strvec.h"
 #include "commit-reach.h"
+#include "progress.h"

 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
 	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
-	N_("git remote rename <old> <new>"),
+	N_("git remote [-v | --verbose] rename <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
@@ -571,6 +572,7 @@ struct rename_info {
 	const char *old_name;
 	const char *new_name;
 	struct string_list *remote_branches;
+	uint32_t symrefs_nr;
 };

 static int read_remote_branches(const char *refname,
@@ -587,10 +589,12 @@ static int read_remote_branches(const char *refname,
 		item = string_list_append(rename->remote_branches, refname);
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
 					    NULL, &flag);
-		if (symref && (flag & REF_ISSYMREF))
+		if (symref && (flag & REF_ISSYMREF)) {
 			item->util = xstrdup(symref);
-		else
+			rename->symrefs_nr++;
+		} else {
 			item->util = NULL;
+		}
 	}
 	strbuf_release(&buf);

@@ -682,7 +686,8 @@ static int mv(int argc, const char **argv)
 		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_DUP;
 	struct rename_info rename;
-	int i, refspec_updated = 0;
+	int i, j = 0, refspec_updated = 0;
+	struct progress *progress = NULL;

 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
@@ -690,6 +695,7 @@ static int mv(int argc, const char **argv)
 	rename.old_name = argv[1];
 	rename.new_name = argv[2];
 	rename.remote_branches = &remote_branches;
+	rename.symrefs_nr = 0;

 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1)) {
@@ -764,6 +770,14 @@ static int mv(int argc, const char **argv)
 	 * the new symrefs.
 	 */
 	for_each_ref(read_remote_branches, &rename);
+	if (verbose) {
+		/*
+		 * Count symrefs twice, since "renaming" them is done by
+		 * deleting and recreating them in two separate passes.
+		 */
+		progress = start_progress(_("Renaming remote references"),
+					  rename.remote_branches->nr + rename.symrefs_nr);
+	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 		int flag = 0;
@@ -773,6 +787,7 @@ static int mv(int argc, const char **argv)
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
+		display_progress(progress, ++j);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -788,6 +803,7 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
+		display_progress(progress, ++j);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -807,7 +823,9 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
+		display_progress(progress, ++j);
 	}
+	stop_progress(&progress);
 	string_list_clear(&remote_branches, 1);

 	handle_push_default(rename.old_name, rename.new_name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9ab315424c..c4b76485e0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -753,8 +753,9 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git config branch.main.pushRemote origin &&
-		git remote rename origin upstream &&
+		GIT_PROGRESS_DELAY=0 git remote -v rename origin upstream 2>err &&
 		grep "pushRemote" .git/config &&
+		grep "Renaming remote references: 100% (4/4), done" err &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
 		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
--
2.35.1.73.gccc5557600
