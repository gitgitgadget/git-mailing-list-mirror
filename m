Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A5EC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiCCAJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiCCAJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:09:26 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B1CFB97
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:08:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i1so2751382ila.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H483xgpq9qbNEL1THMTygHeR95erO/3HdJBTOFBSoew=;
        b=IUampiot8LKQuw1zclR5Nr1sCmWwsR9a3gP8vv/UEHvbkbvqChUDNRg5epFIle8XUs
         zje3zDQgQGaz94wD4UGhDzd70X3UUFfGvkiFpCINn95AMjz6uICO2iY6/P2ykbmICRQB
         2ZNBnMD+i9NjAd45gjfCz5sp9CSW3wvrtrFX/nQ3+w3U1pXbMbfVG1Bw5zCcylbNT18N
         5K3AJvHdWJ90kR8gr9oL2LFBlEV4JdPEF5Y0R8XhfV5wgPQTrCP8uAi/47p7QJutwNT5
         4yYKkfbPA9ox8e8u2G1oBbdhdZyZmT8O4qB6UsFDgWKcsXQyPjiNNJZxY06Mj7DAORlE
         pPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H483xgpq9qbNEL1THMTygHeR95erO/3HdJBTOFBSoew=;
        b=Ayk2VPUBaRwTILrahkD9x6skexxy+Eg2MxqY6wysMKHkygyCt7MKXpMr2c9dAq5VvP
         Cdcsa6b5ymfk94gyt9fyRMpD01rPS5F6PFsbhS73wtYCkmWZ9bxRof0D+w/KCYxWDaDd
         4C6r1D7u2nXLb2me91p/+SP/CL7AciIXKgpBN9aP87UbPZ4kDOI3zSGBnN+xdrv/M1GX
         c1cWAyF8r867dWx+e4UlwsRfYh6VBa0BnUdEAy6iSEOHdX/uwfaRLBPzI7dGPEjeMBMo
         U6CiI+T0K/DPnph+RxYhejjDFt20vTn+q8RM5NYMvjjX//BWrk4UArqKPpM3nZyeX/j7
         6aXw==
X-Gm-Message-State: AOAM533xAnMG9QsIuecyjv7pkXp5ipVe9pF6IXxP/b0h0HV53ynihTBO
        fBPwK9MX73I8Jkaud+80krPE+oCFdcLSMZdl
X-Google-Smtp-Source: ABdhPJyF3sQrpp0fa9qJTZAhc4wly7YJXlBb7yU/Z4lj2aIa6wjKzOdzQfWVADBCU5sDOGsCNFYhLQ==
X-Received: by 2002:a6b:d60a:0:b0:63a:be64:c652 with SMTP id w10-20020a6bd60a000000b0063abe64c652mr24934255ioa.27.1646262013281;
        Wed, 02 Mar 2022 15:00:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02152e00b002bee249710csm254947ilu.15.2022.03.02.15.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:00:12 -0800 (PST)
Date:   Wed, 2 Mar 2022 18:00:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, derrickstolee@github.com,
        avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <dc63ec91ab24eb24a276de074138745fa061eba1.1646261969.git.me@ttaylorr.com>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
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
A small reroll which renames the variable used to keep track of our
progress from "j" to "refs_renamed_nr" for clarity.

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
index 6f27ddc47b..00668af5c9 100644
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
+	int i, refs_renamed_nr = 0, refspec_updated = 0;
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
+		display_progress(progress, ++refs_renamed_nr);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -788,6 +803,7 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
+		display_progress(progress, ++refs_renamed_nr);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -807,7 +823,9 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
+		display_progress(progress, ++refs_renamed_nr);
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
