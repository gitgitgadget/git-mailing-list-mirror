Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4152090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdISHP4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35228 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdISHPy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so1589918pga.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGRx9+qEdXeYDiJ1INHmma/sGdfrcl8njqsL41NTKdU=;
        b=JpHAg7bUbTE3Q7o5+TVNExNGxvmFrAMYgySkptA7N5xjsYZBrDryrVZ/LTZuDMyf1r
         Ha9glUZOHSoC8St4N53jtCh9W/G2O4BMkFcFmvYoO29FNKCjt/9cgEvfyBeTnj9yOxRs
         4JpA04QIXyvsaGyUzQFm65vdBIB/cd3cK3H4NPF6rTTTSls0WvZZZHGJpRjrERSTPFYG
         AlczOtQzOObLeLz4PT7sUlavu0QTe4ZEjD8xPr336mYTm3Iv9gUlzzAKO2/ves/bO+r5
         2j95Q+OTO9/QQfM9OqzsAl0CDGIWlurPlI1jn8llmjQwiF7KbE9vUcerX0HX1iEpYGDM
         vV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGRx9+qEdXeYDiJ1INHmma/sGdfrcl8njqsL41NTKdU=;
        b=T9nF+vH16jcUU0UE8RdZFpJFMPwCGDpn5n1zEDdJ0obt3N3vcY5HESe0O/+f+krKvb
         O8qTuasibX0F1SwVRVLLfF2PzgSJJ3SGjkSq+ubBHahyCD5h4V2DeSMtQEJ/XeFtNQXd
         2rB0/q2FddHnEA3T1bLPJFS6fPIkLC1OJMaAyqyF4SfB69k2rWYa+nUwjfOyRnnFfzot
         BxvZeqBy3usfpVmCTGg2hWzSqGWDgJbuQyGr5UjfplFR0V6cc05vbRQAJRPqVITOrmSq
         lWOkPgCJOWAo6NIvXRpgusAEuKSAgdeo2xSuoNSLoy2EO6pndV224ROMzDbLBQCMQVyx
         wLVQ==
X-Gm-Message-State: AHPjjUjQ8ArS6F8Hb4BrEoWlZRY6GIay8L7/XwOP0v39pQiVsNleWAL7
        aX7dvQWv8pnbYbgGWHY/rNpFAk0vcfA=
X-Google-Smtp-Source: AOwi7QB8JPeoVMo4GnVaOH+WgcBAT9p+7Z3xwa8/PhENvGIL/X+Ofpin4W4Jh7uV1/QmnwO8Lo1LkQ==
X-Received: by 10.101.90.138 with SMTP id c10mr455967pgt.350.1505805353550;
        Tue, 19 Sep 2017 00:15:53 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:53 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 4/5] branch: introduce dont_fail parameter for update validation
Date:   Tue, 19 Sep 2017 12:45:24 +0530
Message-Id: <20170919071525.9404-5-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This parameter allows the branch update validation function to
optionally return a flag specifying the reason for failure, when
requested. This allows the caller to know why it was about to die.
This allows more useful error messages to be given to the user when
trying to rename a branch.

The flags are specified in the form of an enum and values for success
flags have been assigned explicitly to clearly express that certain
callers rely those values and they cannot be arbitrary.

Only the logic has been added but no caller has been made to use it, yet.
So, no functional changes.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           | 34 +++++++++++++++++++++++-----------
 branch.h           | 23 +++++++++++++++++++++--
 builtin/branch.c   |  2 +-
 builtin/checkout.c |  2 +-
 4 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 2020dedf6..9dda336a0 100644
--- a/branch.c
+++ b/branch.c
@@ -178,28 +178,40 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-int validate_branch_update(const char *name, struct strbuf *ref,
-			   int could_exist, int clobber_head)
+int validate_branch_update(const char *name, struct strbuf *ref, int could_exist,
+			   int clobber_head, unsigned dont_fail)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name."), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		if (dont_fail)
+			return INVALID_BRANCH_NAME;
+		else
+			die(_("'%s' is not a valid branch name."), name);
+	}
 
 	if (!ref_exists(ref->buf))
-		return 0;
+		return VALID_BRANCH_NAME;
 
-	if (!could_exist)
-		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
+	if (!could_exist) {
+		if (dont_fail)
+			return BRANCH_EXISTS;
+		else
+			die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
+	}
 
 	if (!clobber_head) {
 		const char *head;
 		struct object_id oid;
 
 		head = resolve_ref_unsafe("HEAD", 0, oid.hash, NULL);
-		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-			die(_("Cannot force update the current branch."));
+		if (!is_bare_repository() && head && !strcmp(head, ref->buf)) {
+			if (dont_fail)
+				return CANNOT_FORCE_UPDATE_CURRENT_BRANCH;
+			else
+				die(_("Cannot force update the current branch."));
+		}
 	}
 
-	return 1;
+	return FORCE_UPDATING_BRANCH;
 }
 
 /*
@@ -268,7 +280,7 @@ void create_branch(const char *name, const char *start_name,
 		validate_existing_branch(name, &ref);
 		dont_change_ref = 1;
 	} else {
-		forcing = validate_branch_update(name, &ref, force, clobber_head);
+		forcing = validate_branch_update(name, &ref, force, clobber_head, 0);
 	}
 
 	real_ref = NULL;
diff --git a/branch.h b/branch.h
index 6ada7af59..c6a8a75bb 100644
--- a/branch.h
+++ b/branch.h
@@ -27,6 +27,16 @@ void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
 		   int clobber_head, int quiet, enum branch_track track);
 
+enum branch_validation_result {
+	/* Flags that say it's NOT OK to update */
+	BRANCH_EXISTS = -3,
+	CANNOT_FORCE_UPDATE_CURRENT_BRANCH,
+	INVALID_BRANCH_NAME,
+	/* Flags that say it's OK to update */
+	VALID_BRANCH_NAME = 0,
+	FORCE_UPDATING_BRANCH = 1
+};
+
 /*
  * Validates whether the branch with the given name may be updated (created, renamed etc.,)
  * with respect to the given conditions. It returns the interpreted ref in ref.
@@ -36,10 +46,19 @@ void create_branch(const char *name, const char *start_name,
  * if 'could_exist' is true, clobber_head indicates whether the branch could be the
  * current branch else it has no effect.
  *
- * A non-zero return value indicates that a branch already exists and can be force updated.
+ * The return values have the following meaning,
+ *
+ *   - If dont_fail is 0, the function dies in case of failure and returns flags of
+ *     'validate_result' that specify it is OK to update the branch. The positive
+ *     non-zero flag implies that the branch can be force updated.
+ *
+ *   - If dont_fail is 1, the function doesn't die in case of failure but returns flags
+ *     of 'validate_result' that specify the reason for failure. The behaviour in case of
+ *     success is same as above.
  *
  */
-int validate_branch_update(const char *name, struct strbuf *ref, int could_exist, int clobber_head);
+int validate_branch_update(const char *name, struct strbuf *ref, int could_exist,
+			   int clobber_head, unsigned dont_fail);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 27ddcad97..205c12a11 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -483,7 +483,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_branch_update(newname, &newref, force, clobber_head_ok);
+	validate_branch_update(newname, &newref, force, clobber_head_ok, 0);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e870ab4b..c7e11c352 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1284,7 +1284,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		int force = opts.new_branch_force != NULL;
 
 		opts.branch_exists = validate_branch_update(opts.new_branch, &buf,
-							    force, force);
+							    force, force, 0);
 
 		strbuf_release(&buf);
 	}
-- 
2.14.1.868.g66c78774b

