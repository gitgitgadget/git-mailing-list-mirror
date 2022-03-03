Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D9C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiCCW0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiCCW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:07 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469DE3EB8D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:25:21 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id iv12so3814416qvb.6
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 14:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3uJK/E15n0HogjcN3ZBLc9dVwkKid1m0r26202lh2I0=;
        b=w3RvjuD7N34AVjW2iGgdkA85fZN743cVU+xJtrjIFtpsM+3/wPZLMD7XyXTlCk+WOP
         hHgOCD6VEE4xCEilPs/jBfq1Ba0gWeVRBJwptTUbVH1qBaHv+Z6dmwRGyTIL9Vn3J0iS
         pRG0kkUNEd4giobFgQGLzHqSu6RP6WbMX1jYvVdf/Zp9fmws2r81Zb9Jlw8gn20klwP6
         7LOuKa/L6gwtm6+LVfaJJs3wPlrbAdXUvW6dlt8KgZxaOzS1o9qpa92TIo3/bcblmf6H
         rmpGXXq/FzKQY8gkxf6bKuA02CmWr97XqaXbT39Frqqa+ObTZbc91zEilVxUXwTckzN1
         MUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3uJK/E15n0HogjcN3ZBLc9dVwkKid1m0r26202lh2I0=;
        b=naxEIwIWviywbiQHpDmdm1KJWV7YgBxuIokv6JpIFloM9s61tUGV39V7wdJOwgx0jw
         H9ltrOlWLSEmoVENycH+5gwjpQtUsUX8pY34Q7ndgavESNcznrjCCitOll891azUXTTi
         ZQ4I1sT1PvLK9yiJVQ4GF+TeIVDTXuQmFMzcPE1lAYZasRGOxi98j95TsMVqOmgfYZ3w
         x6XjH7UPsQgfByHbMwY8EzYiiz/PfNxGF7ZvvloTwZAubMTJNgyBbLhm64cLHYbKkndR
         E2vIUAwUAaQcKk5g4hQlXXYHwRErg3AFELj26lDkMhJLF4v/FYA1VHL38PVzewRl+TYu
         65Eg==
X-Gm-Message-State: AOAM533JPMU0P5NaPcfb9iOMb544gUQOnGvWk1jg8l+rKmU32aQDmurJ
        SQjupLSHQ/J/U+booQ0runu+x4fGZVyYSqgq
X-Google-Smtp-Source: ABdhPJwNDieYNBG3eBOzPkYoC6t69hHAAsZy32GqiT57jG6TPvLa2nENY+VIUA1a7wMRMUwjgrrwNg==
X-Received: by 2002:ad4:5889:0:b0:42d:f4f5:937d with SMTP id dz9-20020ad45889000000b0042df4f5937dmr25201498qvb.39.1646346320223;
        Thu, 03 Mar 2022 14:25:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d186-20020a379bc3000000b006490a4e507esm1691524qke.70.2022.03.03.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:25:19 -0800 (PST)
Date:   Thu, 3 Mar 2022 17:25:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, derrickstolee@github.com,
        avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 2/2] builtin/remote.c: show progress when renaming remote
 references
Message-ID: <d5b0a4b71027619123b7284611692d3a9c128518.1646346287.git.me@ttaylorr.com>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <cover.1646346286.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646346286.git.me@ttaylorr.com>
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
 Documentation/git-remote.txt |  2 +-
 builtin/remote.c             | 30 +++++++++++++++++++++++++-----
 t/t5505-remote.sh            |  4 +++-
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 2bebc32566..cde9614e36 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git remote' [-v | --verbose]
 'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
-'git remote rename' <old> <new>
+'git remote rename' [--[no-]progress] <old> <new>
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
diff --git a/builtin/remote.c b/builtin/remote.c
index 824fb8099c..950e7958d5 100644
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
+	N_("git remote rename [--[no-]progress] <old> <new>"),
 	N_("git remote remove <name>"),
 	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
@@ -36,7 +37,7 @@ static const char * const builtin_remote_add_usage[] = {
 };
 
 static const char * const builtin_remote_rename_usage[] = {
-	N_("git remote rename <old> <new>"),
+	N_("git remote rename [--[no-]progress] <old> <new>"),
 	NULL
 };
 
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
 
@@ -674,7 +678,9 @@ static void handle_push_default(const char* old_name, const char* new_name)
 
 static int mv(int argc, const char **argv)
 {
+	int show_progress = isatty(2);
 	struct option options[] = {
+		OPT_BOOL(0, "progress", &show_progress, N_("force progress reporting")),
 		OPT_END()
 	};
 	struct remote *oldremote, *newremote;
@@ -682,7 +688,8 @@ static int mv(int argc, const char **argv)
 		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_DUP;
 	struct rename_info rename;
-	int i, refspec_updated = 0;
+	int i, refs_renamed_nr = 0, refspec_updated = 0;
+	struct progress *progress = NULL;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_remote_rename_usage, 0);
@@ -693,6 +700,7 @@ static int mv(int argc, const char **argv)
 	rename.old_name = argv[0];
 	rename.new_name = argv[1];
 	rename.remote_branches = &remote_branches;
+	rename.symrefs_nr = 0;
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1)) {
@@ -767,6 +775,14 @@ static int mv(int argc, const char **argv)
 	 * the new symrefs.
 	 */
 	for_each_ref(read_remote_branches, &rename);
+	if (show_progress) {
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
@@ -776,6 +792,7 @@ static int mv(int argc, const char **argv)
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
+		display_progress(progress, ++refs_renamed_nr);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -791,6 +808,7 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
+		display_progress(progress, ++refs_renamed_nr);
 	}
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
@@ -810,7 +828,9 @@ static int mv(int argc, const char **argv)
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
+		display_progress(progress, ++refs_renamed_nr);
 	}
+	stop_progress(&progress);
 	string_list_clear(&remote_branches, 1);
 
 	handle_push_default(rename.old_name, rename.new_name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9ab315424c..c90cf47acd 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -753,7 +753,9 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git config branch.main.pushRemote origin &&
-		git remote rename origin upstream &&
+		GIT_TRACE2_EVENT=$(pwd)/trace \
+			git remote rename --progress origin upstream &&
+		test_region progress "Renaming remote references" trace &&
 		grep "pushRemote" .git/config &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
-- 
2.35.1.73.gccc5557600
