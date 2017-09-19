Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6432090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdISHPy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34412 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdISHPw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id u18so1475186pgo.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JYnxgfn61GVSEAkC16KHIO6eUlqNK466U+p7Y3gKUi0=;
        b=Koz5MXCtx9dMukV+S1pABOqdWI+or9PtTGirlPz6pEcYX83xDBJMIZNg3oVAwzNYCj
         OZhiE8fqgXb8zGgKabrd6ppw8eimVohp+1NBQnXw+n0fT1ruM6lZM5ZkB8lEb7zsJM8p
         1DS97XdOm33u9obfl1pGXoS4pd2WCjIi7yFb/NcJFRSMI9uXzYfOdSVFokaeqyt0jOWC
         socXniKjHr7qdbSDJ+RuFntUozJO30gHRpD5HZrfQF7CvDua/3SqF6+3sDL9IQKv0dHJ
         LnnMaFZ97J91cZoP7CbVR5e+ulsD+Aj0+hWlpMoZS1A9FmEU6P7Xla9RkglW28b500D2
         jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JYnxgfn61GVSEAkC16KHIO6eUlqNK466U+p7Y3gKUi0=;
        b=gz9HDFyh5eTJ9XZKb3WINIVoyTcwfyoGcSghAI1cjysR6SBMdRI9vMu0AiFNuDK6/M
         2IFXyaLZbYVGfx/L/Vn9m1foPZPb1VZ3FbEbkmZe/4oYvDc+X0qQwyghfVbtF0puouYZ
         bDUZamBdH781htnMtRnFPiKmrnFyKVYWHtJHdikHKSDgVbCDHv06yW3MO7kN6wovStfT
         5JXDjZCbwiHjSh+FD+KbF7tMrDPXc5KxN6ZecaY7Q4t74B7zPipC1lwjp5glBzw50dzW
         6pffXvui/VBMdMXimBg4mxSWnwtRMnbSnl/i7leL8F8wIyJrJ4VTrcaLgSZ8+gX7QcpR
         Rdlw==
X-Gm-Message-State: AHPjjUhBSGqJsQP77+h2h7eZSFHwjc0To/+saLlmTAsGCVXdYaO1BTr0
        JwoOcjaRer2KO6lphIOOWKcKa7nQOS8=
X-Google-Smtp-Source: AOwi7QD74p8eD/8TqgKN0giqqHTsdSRz6te7N1tU/5hspY+yRb+qRMkyB6vq1NsqJrRalt9f6t2GeA==
X-Received: by 10.99.186.3 with SMTP id k3mr455564pgf.149.1505805351380;
        Tue, 19 Sep 2017 00:15:51 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:50 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 3/5] branch: cleanup branch name validation
Date:   Tue, 19 Sep 2017 12:45:23 +0530
Message-Id: <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function that validates a new branch name was clumsy because,

  1. It did more than just validating the branch name

  2. Despite it's name, it is more often than not used to validate
     existing branch names through the 'force' and 'attr_only'
     parameters (whose names by the way weren't communicative).

  3. The 'attr_only' parameter should have been "true" only when
     callers like to update some attribute of the branch and "false"
     when they were updating where the branch points to. It was misused
     by callers by setting it to "true" (to skip tests) even though they
     were force updating where the current branch was pointing to!

     This is an example of spoiling code clarity by making the caller
     rely on how the function is implemented thus making it hard to
     modify/maintain.

This makes it unclear what the function does at all and would confuse
the people who would ever want to it for the first time.

So, refactor it into a function that validates whether the branch could
be updated. This doesn't bear the uncommunicative 'new'. Further replace
the 'force' parameter with a 'could_exist' parameter which specifies
whether the given branch name could exist or not (it's just a better name
for 'force'). Also replace  the 'attr_only' with 'clobber_head' which is
a more communicative way of seeing "If the branch could exist, it's OK if
it is the current branch".

Separate the validation of an existing branch into another function.
This (at last!) addresses the NEEDSWORK that was added in fa7993767
(branch --set-upstream: regression fix, 2011-09-16)

This refactor has only one functional change. It enforces strictly that
an existing branch should be updated only with the 'force' switch. So,
it's no more possible to do,

        $ git branch -m master master

(which doesn't seem that useful). This strongly enforces the following
statement of the 'git branch' documentation,

        "If <newbranch> exists, -M must be used to force the
         rename to happen."

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c           | 41 ++++++++++++++++++++++++++++++-----------
 branch.h           | 20 ++++++++------------
 builtin/branch.c   |  2 +-
 builtin/checkout.c |  4 ++--
 t/t3200-branch.sh  |  4 ++++
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index 703ded69c..2020dedf6 100644
--- a/branch.c
+++ b/branch.c
@@ -178,18 +178,19 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	return 0;
 }
 
-int validate_new_branchname(const char *name, struct strbuf *ref,
-			    int force, int attr_only)
+int validate_branch_update(const char *name, struct strbuf *ref,
+			   int could_exist, int clobber_head)
 {
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
 	if (!ref_exists(ref->buf))
 		return 0;
-	else if (!force && !attr_only)
+
+	if (!could_exist)
 		die(_("A branch named '%s' already exists."), ref->buf + strlen("refs/heads/"));
 
-	if (!attr_only) {
+	if (!clobber_head) {
 		const char *head;
 		struct object_id oid;
 
@@ -197,9 +198,29 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
+
 	return 1;
 }
 
+/*
+ * Validates whether the branch with the given name exists, returning the
+ * interpreted ref in ref.
+ *
+ * This method is invoked if the caller merely wants to know if it is OK
+ * to change some attribute for the named branch (e.g. tracking upstream).
+ *
+ */
+static void validate_existing_branch(const char *name, struct strbuf *ref)
+{
+	if (strbuf_check_branch_ref(ref, name))
+		die(_("'%s' is not a valid branch name."), name);
+
+	if (ref_exists(ref->buf))
+		return;
+	else
+		die(_("branch '%s' doesn't exist"), name);
+}
+
 static int check_tracking_branch(struct remote *remote, void *cb_data)
 {
 	char *tracking_branch = cb_data;
@@ -243,13 +264,11 @@ void create_branch(const char *name, const char *start_name,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if (validate_new_branchname(name, &ref, force,
-				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head)) {
-		if (!force)
-			dont_change_ref = 1;
-		else
-			forcing = 1;
+	if (track == BRANCH_TRACK_OVERRIDE) {
+		validate_existing_branch(name, &ref);
+		dont_change_ref = 1;
+	} else {
+		forcing = validate_branch_update(name, &ref, force, clobber_head);
 	}
 
 	real_ref = NULL;
diff --git a/branch.h b/branch.h
index 33b7f5d88..b4bfff84a 100644
--- a/branch.h
+++ b/branch.h
@@ -28,22 +28,18 @@ void create_branch(const char *name, const char *start_name,
 		   int clobber_head, int quiet, enum branch_track track);
 
 /*
- * Validates that the requested branch may be created, returning the
- * interpreted ref in ref, force indicates whether (non-head) branches
- * may be overwritten. A non-zero return value indicates that the force
- * parameter was non-zero and the branch already exists.
+ * Validates whether the branch with the given name may be updated (created, renamed etc.,)
+ * with respect to the given conditions. It returns the interpreted ref in ref.
  *
- * Contrary to all of the above, when attr_only is 1, the caller is
- * not interested in verifying if it is Ok to update the named
- * branch to point at a potentially different commit. It is merely
- * asking if it is OK to change some attribute for the named branch
- * (e.g. tracking upstream).
+ * could_exist indicates whether the branch could exist or not.
  *
- * NEEDSWORK: This needs to be split into two separate functions in the
- * longer run for sanity.
+ * if 'could_exist' is true, clobber_head indicates whether the branch could be the
+ * current branch; else it has no effect.
+ *
+ * A non-zero return value indicates that a branch already exists and can be force updated.
  *
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force, int attr_only);
+int validate_branch_update(const char *name, struct strbuf *ref, int could_exist, int clobber_head);
 
 /*
  * Remove information about the state of working on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 355f9ef5d..27ddcad97 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -483,7 +483,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	 */
 	clobber_head_ok = !strcmp(oldname, newname);
 
-	validate_new_branchname(newname, &newref, force, clobber_head_ok);
+	validate_branch_update(newname, &newref, force, clobber_head_ok);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 76859da9d..2e870ab4b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1283,8 +1283,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 		int force = opts.new_branch_force != NULL;
 
-		opts.branch_exists = validate_new_branchname(opts.new_branch, &buf,
-							     force, force);
+		opts.branch_exists = validate_branch_update(opts.new_branch, &buf,
+							    force, force);
 
 		strbuf_release(&buf);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d97164997..ec85cd959 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -137,6 +137,10 @@ test_expect_success 'git branch -m -f o/q o/p should work when o/p exists' '
 	git branch -m -f o/q o/p
 '
 
+test_expect_success 'git branch -m o/o o/o should fail when o/o exists' '
+	test_must_fail git branch -m o/o o/o
+'
+
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-- 
2.14.1.1006.g90ad9a07c

