Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3983320450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbdKBGxM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:53:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:57079 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdKBGxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:53:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id b85so3876108pfj.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zX2pW3vPXOc0hV55ULBI3aJh2bVo9VeaaFGfiFOzoEw=;
        b=p+lLKkj8qmpDlAWrOJwIM1z/95pFVRvmZs1wUGbC1z2fme6LCJL1EPV0LfqAFugM6I
         4hSMezJbN31opPjsIf3kECUruOqu1xkUREKe+7URhTFMvWLAvxl+Ho7keR6bhnKHjpaj
         pg/RsrwWGMJkK4LLHg03yFr1o8aq1Gzl6fgWvQ5AskyOWlKfEhpYfmpxq/uGCM7PP5VN
         ILiCkrq9HDURWzVINxavc1CeutuFz5pzeZwe2vc2ngphi+zyI3lCRYgo2PBhVlJy3uwb
         H6EXFvtjx/MH4BP2xupV4GMTHTLlNfXwRSiPi0J/bcdBPqXVZ7DUAnBJQl6kd+oTI38B
         X1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zX2pW3vPXOc0hV55ULBI3aJh2bVo9VeaaFGfiFOzoEw=;
        b=bWoHuamaLVqa9DaxRTzCK6HjWXLCjLYdQbKBajcu24fxsIIxFBFcZjIwnP5AoAIdq+
         kWNHKl2DvuqMD6B3IMpnVCtqaaxIIsFNk4qvhbpvZwnV9S75+KasUFNI2ynn2X7f8f2Q
         CWkzPGngSEwPrP19dsKWKcR3qgrebgQS7/GfesUBFO4XrNuojz3ljzsFSHuAeFASV7F8
         kThtZdN2Rzczf5B42y+0aiFcekw48WpOwFgR/gZEHgfg/c52xxHFiIZh6PieOxL7Dc3u
         PoWkByRW8tuHCmZH1TNwIYXMbvVXZ65gsA3wkEIiV44N06P/+yCcZbyDghuFs1VPpkuF
         FRhg==
X-Gm-Message-State: AMCzsaXIlFVagIs0O42EJ6XaSTKQUEmWnkRw6k2uocHPu4Cf+cT0un17
        JCUBOYwz41ksXm80UIfIlS0dpoFCdQY=
X-Google-Smtp-Source: ABhQp+TIQeIj/TJid4FmqOQQxxJrmzsC5QJDps/eCh6qVHhvO+tD2Gk0yMoXq3lbmHGZxq8cXdvsdA==
X-Received: by 10.101.92.202 with SMTP id b10mr2582217pgt.164.1509605588983;
        Wed, 01 Nov 2017 23:53:08 -0700 (PDT)
Received: from localhost.localdomain ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id p4sm3879871pga.58.2017.11.01.23.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:53:08 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for branchname validation
Date:   Thu,  2 Nov 2017 12:22:41 +0530
Message-Id: <20171102065242.25299-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
References: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
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

Only the logic has been added but no caller has been made to use it, yet.
So, no functional changes.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 branch.c           | 62 +++++++++++++++++++++++++++++++-----------------------
 branch.h           | 60 ++++++++++++++++++++++++++++++++++++++++++----------
 builtin/branch.c   |  4 ++--
 builtin/checkout.c |  5 +++--
 4 files changed, 90 insertions(+), 41 deletions(-)

diff --git a/branch.c b/branch.c
index 7c8093041..7db2e3296 100644
--- a/branch.c
+++ b/branch.c
@@ -178,41 +178,51 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-/*
- * Check if 'name' can be a valid name for a branch; die otherwise.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-int validate_branchname(const char *name, struct strbuf *ref)
+enum branch_validation_result validate_branchname(const char *name, struct strbuf *ref, unsigned dont_fail)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name."), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		if (dont_fail)
+			return INVALID_BRANCH_NAME;
+		else
+			die(_("'%s' is not a valid branch name."), name);
+	}
 
-	return ref_exists(ref->buf);
+	if(ref_exists(ref->buf))
+		return BRANCH_EXISTS;
+	else
+		return BRANCH_DOESNT_EXIST;
 }
 
-/*
- * Check if a branch 'name' can be created as a new branch; die otherwise.
- * 'force' can be used when it is OK for the named branch already exists.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+enum branch_validation_result validate_new_branchname(const char *name, struct strbuf *ref, int force, unsigned dont_fail)
 {
 	const char *head;
 
-	if (!validate_branchname(name, ref))
-		return 0;
+	if(dont_fail) {
+		enum branch_validation_result res = validate_branchname(name, ref, 1);
+		if (res == INVALID_BRANCH_NAME || res == BRANCH_DOESNT_EXIST)
+				return res;
+	} else {
+		if(validate_branchname(name, ref, 0) == BRANCH_DOESNT_EXIST)
+			return BRANCH_DOESNT_EXIST;
+	}
 
-	if (!force)
-		die(_("A branch named '%s' already exists."),
-		    ref->buf + strlen("refs/heads/"));
+	if (!force) {
+		if (dont_fail)
+			return BRANCH_EXISTS_NO_FORCE;
+		else
+			die(_("A branch named '%s' already exists."),
+				ref->buf + strlen("refs/heads/"));
+	}
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
-	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-		die(_("Cannot force update the current branch."));
+	if (!is_bare_repository() && head && !strcmp(head, ref->buf)) {
+		if (dont_fail)
+			return CANNOT_FORCE_UPDATE_CURRENT_BRANCH;
+		else
+			die(_("Cannot force update the current branch."));
+	}
 
-	return 1;
+	return BRANCH_EXISTS;
 }
 
 static int check_tracking_branch(struct remote *remote, void *cb_data)
@@ -259,8 +269,8 @@ void create_branch(const char *name, const char *start_name,
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
index 85052628b..0c178ec5a 100644
--- a/branch.h
+++ b/branch.h
@@ -27,20 +27,58 @@ void create_branch(const char *name, const char *start_name,
 		   enum branch_track track, int force, int clobber_head_ok,
 		   int reflog, int quiet);
 
-/*
- * Check if 'name' can be a valid name for a branch; die otherwise.
- * Return 1 if the named branch already exists; return 0 otherwise.
- * Fill ref with the full refname for the branch.
- */
-extern int validate_branchname(const char *name, struct strbuf *ref);
+enum branch_validation_result {
+	/* Flags that convey that validation FAILED */
+	BRANCH_EXISTS_NO_FORCE = -3,
+	CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
+	INVALID_BRANCH_NAME,
+	/* Flags that convey that validation SUCCEEDED */
+	BRANCH_DOESNT_EXIST = 0,
+	BRANCH_EXISTS = 1,
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
+ *   - If dont_fail is 0, the function dies in case of failure and returns flags of
+ *     'branch_validation_result' that indicate status of the given branch. The positive
+ *     non-zero flag implies that the branch exists.
+ *
+ *   - If dont_fail is 1, the function doesn't die in case of failure but returns flags
+ *     of 'branch_validaton_result' that specify the reason for failure. The behaviour in case of
+ *     success is same as above.
+ *
  */
-extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+extern enum branch_validation_result validate_branchname(const char *name, struct strbuf *ref, unsigned dont_fail);
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
+ *   - If dont_fail is 0, the function dies in case of failure and returns flags of
+ *     'branch_validation_result' that indicate that convey status of given branch. The positive
+ *     non-zero flag implies that the branch can be force updated.
+ *
+ *   - If dont_fail is 1, the function doesn't die in case of failure but returns flags
+ *     of 'branch_validaton_result' that specify the reason for failure. The behaviour in case of
+ *     success is same as above.
+ *
+ */
+extern enum branch_validation_result validate_new_branchname(const char *name, struct strbuf *ref, int force, unsigned dont_fail);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index df06ac968..7018e5d75 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -487,9 +487,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
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
index 5c34a9a0d..4adab3814 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1288,10 +1288,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
2.15.0.461.gf957c703b.dirty

