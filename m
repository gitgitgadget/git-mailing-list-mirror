Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD6D1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 15:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeCJPy7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 10:54:59 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36539 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 10:54:58 -0500
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so6906306plf.3
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WiLg4ywYp8Pj6O/crt+y/m1ZupqZq5VwF6qe7ehDYts=;
        b=jPlOgP9TW302PFCEXcEureIVtBlZEQtjFq+kLbKjUDnFNiR8KBacYN44D4tYHlSwPh
         HlRepfdBaaidsQQ+5rRcWd3ud1fgW6404WuD7Yeo2m3YyBiXm4SIWQ4xjPt/z6jS3NO+
         8rL0yTbq+enMVnwy5tE4M+M0422Dr5ACvnZEm3pWnTQl/xem63L+2Wh4pfZcHq6Q6BQw
         IxO+Td8v+IZdCLPs1FDNysW42609rd+VCY0eXLnV/ZQYVdC7wrHBtml8NEKWLrPKv4ZX
         tD8nJ0MwJ4HAu1ftamyWyg7Q5Es4rUKQkEOunJGzvpWr02sVWWQ0loTfsRpMAwYlFuRt
         iGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WiLg4ywYp8Pj6O/crt+y/m1ZupqZq5VwF6qe7ehDYts=;
        b=XThT1W5ZOVNMQPY2j/+RgrmfOrj8Rqv2ng0bocsltqtySBLDv+PVtblG5VZqRsY7aH
         9r1ohFOBkWCv60zVZZ/okG6EbZgRtXdK2/Y1cmjd3lbnVvruZbDEMYjCvmpTksVCucXK
         8w9XALIHzT715e9FFoJNdiBzSHJ0iyuNcJOETHALgDfs2RiWrmZ5LVqZJuwE07AIQcgx
         ZXXHpSZ8PcvyDPGWly64EwVqMEkkSsM5n1V1lU7Z3E+fMFp01D1smGuDW+cPckkoFfgC
         ldIm8chTlhWigWt2WGDQzJJmF9MjQCOROI+a2ZzLJmEZeyzriBy4L5NIBvB9FjTHGE/3
         De+g==
X-Gm-Message-State: AElRT7HZF1/o9OOekVBSoJvxWNVWjorF8HskKWo7zUAm9+hl1/NEB3hq
        IihbFkbsnZaTwgfGFRQIYF7e5/qm
X-Google-Smtp-Source: AG47ELvJHpehcY8OipO2rSiJcMSjDIMcjLZZDOSvlf6DlUJcFeOHcFtBMQrMerl+eiUq5l05G8ZqJw==
X-Received: by 2002:a17:902:12d:: with SMTP id 42-v6mr2429679plb.141.1520697297379;
        Sat, 10 Mar 2018 07:54:57 -0800 (PST)
Received: from localhost.localdomain ([117.209.148.118])
        by smtp.gmail.com with ESMTPSA id j25sm7795956pgn.92.2018.03.10.07.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 07:54:56 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/3] branch: introduce dont_fail parameter for branchname validation
Date:   Sat, 10 Mar 2018 21:24:14 +0530
Message-Id: <20180310155416.21802-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f13
In-Reply-To: <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This parameter allows the branchname validation functions to
optionally return a flag specifying the reason for failure, when
requested. This allows the caller to know why it was about to die.
This allows more useful error messages to be given to the user when
trying to rename a branch.

The flags are specified in the form of an enum and values for success
flags have been assigned explicitly to clearly express that certain
callers rely on those values and they cannot be arbitrary.

Only the logic has been added but no caller has been made to use
it, yet. So, no functional changes.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 branch.c           | 59 ++++++++++++++++++++++++--------------------
 branch.h           | 61 +++++++++++++++++++++++++++++++++++++---------
 builtin/branch.c   |  4 +--
 builtin/checkout.c |  5 ++--
 4 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/branch.c b/branch.c
index 2672054f0..0eeb8403e 100644
--- a/branch.c
+++ b/branch.c
@@ -178,41 +178,48 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-/*
- * Check if 'name' can be a valid name for a branch; die otherwise.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-int validate_branchname(const char *name, struct strbuf *ref)
+enum branch_validation_result validate_branchname(const char *name, struct strbuf *ref, unsigned gently)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name."), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		if (gently)
+			return VALIDATION_FATAL_INVALID_BRANCH_NAME;
+		else
+			die(_("'%s' is not a valid branch name."), name);
+	}
 
-	return ref_exists(ref->buf);
+	return ref_exists(ref->buf) ? VALIDATION_PASS_BRANCH_EXISTS : VALIDATION_PASS_BRANCH_DOESNT_EXIST;
 }
 
-/*
- * Check if a branch 'name' can be created as a new branch; die otherwise.
- * 'force' can be used when it is OK for the named branch already exists.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+enum branch_validation_result validate_new_branchname(const char *name, struct strbuf *ref, int force, unsigned gently)
 {
 	const char *head;
 
-	if (!validate_branchname(name, ref))
-		return 0;
+	if (gently) {
+		enum branch_validation_result res = validate_branchname(name, ref, 1);
+		if (res == VALIDATION_FATAL_INVALID_BRANCH_NAME || res == VALIDATION_PASS_BRANCH_DOESNT_EXIST)
+				return res;
+	} else {
+		if (validate_branchname(name, ref, 0) == VALIDATION_PASS_BRANCH_DOESNT_EXIST)
+			return VALIDATION_PASS_BRANCH_DOESNT_EXIST;
+	}
 
-	if (!force)
-		die(_("A branch named '%s' already exists."),
-		    ref->buf + strlen("refs/heads/"));
+	if (!force) {
+		if (gently)
+			return VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE;
+		else
+			die(_("A branch named '%s' already exists."),
+				ref->buf + strlen("refs/heads/"));
+	}
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die(_("Cannot force update the current branch."));
+	if (!is_bare_repository() && head && !strcmp(head, ref->buf)) {
+		if (gently)
+			return VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH;
+		else
+			die(_("Cannot force update the current branch."));
+	}
 
-	return 1;
+	return VALIDATION_WARN_BRANCH_EXISTS;
 }
 
 static int check_tracking_branch(struct remote *remote, void *cb_data)
@@ -259,8 +266,8 @@ void create_branch(const char *name, const char *start_name,
 		explicit_tracking = 1;
 
 	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
+	    ? validate_branchname(name, &ref, 0)
+	    : validate_new_branchname(name, &ref, force, 0)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index 473d0a93e..ee5f1c0e7 100644
--- a/branch.h
+++ b/branch.h
@@ -28,20 +28,59 @@ void create_branch(const char *name, const char *start_name,
 		   int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track);
 
-/*
- * Check if 'name' can be a valid name for a branch; die otherwise.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-extern int validate_branchname(const char *name, struct strbuf *ref);
+enum branch_validation_result {
+	/* Flags that convey there are fatal errors */
+	VALIDATION_FATAL_BRANCH_EXISTS_NO_FORCE = -3,
+	VALIDATION_FATAL_CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
+	VALIDATION_FATAL_INVALID_BRANCH_NAME,
+	/* Flags that convey there are no fatal errors */
+	VALIDATION_PASS_BRANCH_DOESNT_EXIST = 0,
+	VALIDATION_PASS_BRANCH_EXISTS = 1,
+	VALIDATION_WARN_BRANCH_EXISTS = 2
+};
 
 /*
- * Check if a branch 'name' can be created as a new branch; die otherwise.
- * 'force' can be used when it is OK for the named branch already exists.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
+ * Check if 'name' can be a valid name for a branch; die otherwise.
+ *
+ *   - name is the new branch name
+ *
+ *   - ref is used to return the full refname for the branch
+ *
+ * The return values have the following meaning,
+ *
+ *   - If 'gently' is 0, the function dies in case of a fatal error and returns
+ *     flags of 'branch_validation_result' that indicate nonfatal cases, otherwise.
+ *     The positive non-zero flag implies that the branch exists.
+ *
+ *   - If 'gently' is 1, the function doesn't die in case of a fatal error but returns
+ *     flags of 'branch_validaton_result' that identify the fatal error. The behaviour
+ *     in case of success is same as above.
+ *
  */
-extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+extern enum branch_validation_result validate_branchname(const char *name, struct strbuf *ref, unsigned gently);
+
+/*
+ * Check if a branch 'name' can be created as a new branch.
+ *
+ *   - name is the new branch name
+ *
+ *   - ref is used to return the full refname for the branch
+ *
+ *   - force can be used when it is OK if the named branch already exists.
+ *     the currently checkout branch; with 'shouldnt_exist', it has no effect.
+ *
+ * The return values have the following meaning,
+ *
+ *   - If 'gently' is 0, the function dies in case of a fatal error and returns
+ *     flags of 'branch_validation_result' that indicate nonfatal cases, otherwise.
+ *     The positive non-zero flag implies that the branch can be force updated.
+ *
+ *   - If 'gently' is 1, the function doesn't die in case of a fatal error but returns
+ *     flags of 'branch_validaton_result' that identify the fatal error. The behaviour
+ *     in case of success is same as above.
+ *
+ */
+extern enum branch_validation_result validate_new_branchname(const char *name, struct strbuf *ref, int force, unsigned gently);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed05..5412aa78f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -489,9 +489,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(newname, &newref, 0);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(newname, &newref, force, 0);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8f4dfb104..c16455ff0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1243,10 +1243,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts.new_branch_force)
-			opts.branch_exists = validate_branchname(opts.new_branch, &buf);
+			opts.branch_exists = validate_branchname(opts.new_branch, &buf, 0);
 		else
 			opts.branch_exists =
-				validate_new_branchname(opts.new_branch, &buf, 0);
+				validate_new_branchname(opts.new_branch, &buf, 0, 0);
+
 		strbuf_release(&buf);
 	}
 
-- 
2.16.1.291.g4437f3f13

