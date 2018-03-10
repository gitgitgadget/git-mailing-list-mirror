Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE921F404
	for <e@80x24.org>; Sat, 10 Mar 2018 15:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeCJPzG (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 10:55:06 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33431 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPzE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 10:55:04 -0500
Received: by mail-pf0-f193.google.com with SMTP id q13so2536735pff.0
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 07:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hieyJ01PledndQ/2/AXj4/AmaOX2meFqDiDPeByMk3U=;
        b=so3a4Ljtah0tpbVL7vmjjsZQSCzM9rj0JWm7EGYP+sD46H6XvRJVsoethlYuD0zRpP
         WAKWpkJeO2cdjknlxeTtTZw+u5N25sDEqdWx1IgTXRAImcEgW8EGZpnlGwxDANsNgE9u
         7kXk00jIIVo3FDOP55OSrk1ofrWRYGVOp7WWDgwInCX/SZIR0lj6SXzfPtUoH8iph09h
         leBnt8MB+InH3hoizoSjtn2ZdUjXacjPXxI9snDyANkPyfPjnneu0G+V+i0j3bhKiXoj
         wzVMn2S9Y97h+ouLmM6MopWXkuA1bYDOVKblDICJeoGSddV4wcJIlUJnBXmu7kBlVNPp
         acUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hieyJ01PledndQ/2/AXj4/AmaOX2meFqDiDPeByMk3U=;
        b=LTS2aa119Ant2X/ffUBIxFsm+Z6H+OYF2y0nviHT7pbhzrzNRt/romo/KXgABP6OR3
         wjZMNpwx+Qi90Zm852fw7YYJeDYlD287+02ndyTX6WvKU7+Mqj4/HBVhPTZ0bcG/fZGC
         cbbW+yxBlhd2YKayD9X3AQCT0jf4SUXF3G3QV8d3UhrQvs76/vy2RGl2E4inb5QJb5AX
         rXn4x4tm8lfbqNunTUD3gn/Z3vQEwWiHVLM2TCg7afAhvL8LitPFIWL6tQWOG/kmRJ4B
         ii3ZabDXF3PQpS3fo0PCy9UODY76PysV6GSVEuqYCJIbOCujr1UmPwlIOK+o9JJX1fZj
         z8vQ==
X-Gm-Message-State: AElRT7ElfyU1PYL2QLyRCvp/QgvLQLTTjgIks1GkxHiABv0PcweAUi+Z
        qVD5TPo5ZW//WtkrpKVK4JUbwUzK
X-Google-Smtp-Source: AG47ELuG8pyshkMYZh+6v1adtYNyW5VkNBJzd2m8pJWQifuw8A+5VYdyVInAb+N2y1WadgVb6xG7Ig==
X-Received: by 10.98.32.200 with SMTP id m69mr2352455pfj.82.1520697303903;
        Sat, 10 Mar 2018 07:55:03 -0800 (PST)
Received: from localhost.localdomain ([117.209.148.118])
        by smtp.gmail.com with ESMTPSA id j25sm7795956pgn.92.2018.03.10.07.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 07:55:02 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/3] builtin/branch: give more useful error messages when renaming
Date:   Sat, 10 Mar 2018 21:24:15 +0530
Message-Id: <20180310155416.21802-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f13
In-Reply-To: <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to rename an "inexistent" branch name to a branch name
that "already exists" the rename failed stating that the new branch
name exists rather than stating that the branch trying to be renamed
doesn't exist.

    $ git branch -m tset master
    fatal: A branch named 'master' already exists.

It's conventional to report that 'tset' doesn't exist rather than
reporting that 'master' exists, the same way the 'mv' command does.

    (hypothetical)
    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist.

That has the problem that the error about an existing branch is shown
only after the user corrects the error about inexistent branch.

    $ git branch -m test master
    fatal: A branch named 'master' already exists.

This isn't useful either because the user would have corrected this
error in a single go if he had been told this alongside the first
error. So, give more useful error messages by giving errors about old
branch name and new branch name at the same time. This is possible as
the branch name validation functions now return the reason they were
about to die, when requested.

    $ git branch -m tset master
    fatal: branch 'tset' doesn't exist; branch 'master' already exists

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/branch.c | 111 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 17 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5412aa78f..ab78a7f45 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -55,6 +55,13 @@ enum color_branch {
 	BRANCH_COLOR_UPSTREAM = 5
 };
 
+enum old_branch_validation_result {
+	VALIDATION_1_FATAL_OLD_BRANCH_DOESNT_EXIST = -2,
+	VALIDATION_1_FATAL_INVALID_OLD_BRANCH_NAME = -1,
+	VALIDATION_1_PASS_OLD_BRANCH_EXISTS = 0,
+	VALIDATION_1_WARN_BAD_OLD_BRANCH_NAME = 1
+};
+
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
@@ -458,13 +465,86 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
+static void get_error_msg(struct strbuf* error_msg,
+			  const char* oldname, enum old_branch_validation_result old_branch_name_res,
+			  const char* newname, enum branch_validation_result new_branch_name_res)
+{
+	const char* connector_string = "; ";
+	unsigned append_connector = 0;
+
+	switch (old_branch_name_res) {
+	case VALIDATION_1_FATAL_INVALID_OLD_BRANCH_NAME:
+		strbuf_addf(error_msg,
+			    _("old branch name '%s' is invalid"), oldname);
+		append_connector = 1;
+		break;
+	case VALIDATION_1_FATAL_OLD_BRANCH_DOESNT_EXIST:
+		strbuf_addf(error_msg,
+			    _("branch '%s' doesn't exist"), oldname);
+		append_connector = 1;
+		break;
+
+	/* not necessary to handle nonfatal cases */
+	case VALIDATION_1_PASS_OLD_BRANCH_EXISTS:
+	case VALIDATION_1_WARN_BAD_OLD_BRANCH_NAME:
+		break;
+	}
+
+	switch (new_branch_name_res) {
+	case VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE:
+		strbuf_addf(error_msg, "%s",
+			    (append_connector) ? connector_string : "");
+		strbuf_addf(error_msg,
+			    _("branch '%s' already exists"), newname);
+		break;
+	case VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH:
+		strbuf_addf(error_msg, "%s",
+			    (append_connector) ? connector_string : "");
+		strbuf_addstr(error_msg,
+				_("cannot force update the current branch"));
+		break;
+	case VALIDATION_FATAL_INVALID_BRANCH_NAME:
+		strbuf_addf(error_msg, "%s",
+			    (append_connector) ? connector_string : "");
+		strbuf_addf(error_msg,
+			    _("new branch name '%s' is invalid"), newname);
+		break;
+
+	/* not necessary to handle nonfatal cases */
+	case VALIDATION_PASS_BRANCH_DOESNT_EXIST:
+	case VALIDATION_PASS_BRANCH_EXISTS:
+	case VALIDATION_WARN_BRANCH_EXISTS:
+		break;
+	}
+}
+
+/* Validate the old branch name and return the result */
+static enum old_branch_validation_result validate_old_branchname (const char* name, struct strbuf *oldref) {
+	int bad_ref = strbuf_check_branch_ref(oldref, name);
+	int branch_exists = ref_exists(oldref->buf);
+
+	if (bad_ref) {
+		if(branch_exists)
+			return VALIDATION_1_WARN_BAD_OLD_BRANCH_NAME;
+		else
+			return VALIDATION_1_FATAL_INVALID_OLD_BRANCH_NAME;
+	}
+
+	if (branch_exists)
+		return VALIDATION_1_PASS_OLD_BRANCH_EXISTS;
+	else
+		return VALIDATION_1_FATAL_OLD_BRANCH_DOESNT_EXIST;
+}
+
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	struct strbuf error_msg = STRBUF_INIT, empty = STRBUF_INIT;
+	enum branch_validation_result new_branch_name_res;
+	enum old_branch_validation_result old_branch_name_res;
 
 	if (!oldname) {
 		if (copy)
@@ -473,33 +553,28 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("cannot rename the current branch while not on any."));
 	}
 
-	if (strbuf_check_branch_ref(&oldref, oldname)) {
-		/*
-		 * Bad name --- this could be an attempt to rename a
-		 * ref that we used to allow to be created by accident.
-		 */
-		if (ref_exists(oldref.buf))
-			recovery = 1;
-		else
-			die(_("Invalid branch name: '%s'"), oldname);
-	}
-
+	old_branch_name_res = validate_old_branchname(oldname, &oldref);
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref, 0);
+		new_branch_name_res = validate_branchname(newname, &newref, 1);
 	else
-		validate_new_branchname(newname, &newref, force, 0);
-
-	reject_rebase_or_bisect_branch(oldref.buf);
+		new_branch_name_res = validate_new_branchname(newname, &newref, force, 1);
 
 	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
 	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
 		die("BUG: expected prefix missing for refs");
 	}
 
+	get_error_msg(&error_msg, interpreted_oldname, old_branch_name_res,
+				  interpreted_newname, new_branch_name_res);
+	if (strbuf_cmp(&error_msg, &empty))
+		die("%s", error_msg.buf);
+
+	reject_rebase_or_bisect_branch(oldref.buf);
+
 	if (copy)
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
@@ -512,7 +587,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch copy failed"));
 
-	if (recovery) {
+	if (old_branch_name_res == VALIDATION_1_WARN_BAD_OLD_BRANCH_NAME) {
 		if (copy)
 			warning(_("Created a copy of a misnamed branch '%s'"),
 				interpreted_oldname);
@@ -537,6 +612,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		die(_("Branch is copied, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
+	strbuf_release(&error_msg);
+	strbuf_release(&empty);
 }
 
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
-- 
2.16.1.291.g4437f3f13

