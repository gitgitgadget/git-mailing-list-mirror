Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A001F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJUQWn (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38849 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeJUQWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id k11-v6so2250292lja.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PTXgwmf50dR0T1hGKYe2V3JU1ghg5hrwVyFbGIubYA=;
        b=aGgiTExn2Gm5wj59/FsZGr/GtqXNeLfz4ZjVVeorQ3XSMC+H69RQkvpVzHeEh6xAZt
         0JvqrRfefdHRBiBfWNu3LfuB6JXnFD/mCoMIrXfeimFSrmbfPPTF9ldGowNb7SWFTKZt
         yjQgS7PNStGIA6PoTUqsxDs26VGTlew4+2qv1ISMJHCSNLz/I24e1Ui2fVoOIOAT6DMZ
         9TE7IqjHqvXVAVmbmL5M842XXavt6cpoQwEXSYbIMYVU/wJZXVTyM++0vuzSVwEf8Q15
         p4RDd7tLe2Yu5ZVrfNPZHy2zlVogNilJXAU2vvoesRAGFTanT7Bvg0XP+f9T2IhWFbwr
         T+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PTXgwmf50dR0T1hGKYe2V3JU1ghg5hrwVyFbGIubYA=;
        b=KvNacLMAUthtqVq1jZsrC7bnVT537jTJACnbb9VRczIhrvhMov8KPCrCtT6+FCv29/
         MuIWUkAnrk1mAqojAARLwvuepd6HzGYOaMcTmGe+yyDon7O/By5I/yTMNMJHkBtNNoRN
         l+eU8MG8kvFkhxk1/XZKy1Y/OoVvVZXvCXhfjM6bl1I6IE1Jze0bdWQiV454Dl88nXJu
         ibcT+qTHe9M8wR5fHZ2/Mcc7BitkfObySSuy/Tq7eVo463gSRDJFnVzhDI13dQ2Dp8Mo
         foyQrxQ9d/eJYTYVbnvYifJkPkHpYk0YHcSz1xaYB2a5pdiCGgKZN4NQY/fGS1LM1hUa
         zkQA==
X-Gm-Message-State: AGRZ1gIUENRUN9yXctKkII4DeICQl2eZV+HiO7H/i7o/3V9xjqWfu/qG
        rLnS87Ha5JaVU+vfcCGOVdeeGCTQ
X-Google-Smtp-Source: AJdET5fCJ2k5oSnCLG/1RoZFccm3Q2vgg92KkbhpKn5x+grXuKtASL/BG/dEdeOG0EX2OzmNRMhUuA==
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr2377869ljd.94.1540109350142;
        Sun, 21 Oct 2018 01:09:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
Date:   Sun, 21 Oct 2018 10:08:54 +0200
Message-Id: <20181021080859.3203-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the problems with multiple worktree is accessing per-worktree
refs of one worktree from another worktree. This was sort of solved by
multiple ref store, where the code can open the ref store of another
worktree and has access to the ref space of that worktree.

The problem with this is reporting. "HEAD" in another ref space is
also called "HEAD" like in the current ref space. In order to
differentiate them, all the code must somehow carry the ref store
around and print something like "HEAD from this ref store".

But that is not feasible (or possible with a _lot_ of work). With the
current design, we pass a reference around as a string (so called
"refname"). Extending this design to pass a string _and_ a ref store
is a nightmare, especially when handling extended SHA-1 syntax.

So we do it another way. Instead of entering a separate ref space, we
make refs from other worktrees available in the current ref space. So
"HEAD" is always HEAD of the current worktree, but then we can have
"worktrees/blah/HEAD" to denote HEAD from a worktree named
"blah". This syntax coincidentally matches the underlying directory
structure which makes implementation a bit easier.

The main worktree has to be treated specially because well... it's
special from the beginning. So HEAD from the main worktree is
acccessible via the name "main-worktree/HEAD" instead of
"worktrees/main/HEAD" because "main" could be just another secondary
worktree.

This patch also makes it possible to specify refs from one worktree in
another one, e.g.

    git log worktrees/foo/HEAD

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt | 15 ++++++++++-
 refs.c                         | 21 ++++++++++++++++
 refs.h                         |  8 +++---
 refs/files-backend.c           | 28 +++++++++++++++++++++
 t/t1415-worktree-refs.sh       | 46 ++++++++++++++++++++++++++++++++++
 worktree.c                     | 30 ++++++++++++++++++++++
 worktree.h                     |  9 +++++++
 7 files changed, 153 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a50fbf8094..9117e4fb50 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -208,7 +208,8 @@ REFS
 ----
 In multiple working trees, some refs may be shared between all working
 trees, some refs are local. One example is HEAD is different for all
-working trees. This section is about the sharing rules.
+working trees. This section is about the sharing rules and how to access
+refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
 with "refs/" are shared. Pseudo refs are ones like HEAD which are
@@ -216,6 +217,18 @@ directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
 exception to this: refs inside refs/bisect and refs/worktree is not
 shared.
 
+Refs that are per working tree can still be accessed from another
+working tree via two special paths, main-worktree and worktrees. The
+former gives access to per-worktree refs of the main working tree,
+while the latter to all linked working trees.
+
+For example, main-worktree/HEAD or main-worktree/refs/bisect/good
+resolve to the same value as the main working tree's HEAD and
+refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
+worktrees/bar/refs/bisect/bad are the same as
+GIT_COMMON_DIR/worktrees/foo/HEAD and
+GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
+
 To access refs, it's best not to look inside GIT_DIR directly. Instead
 use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
 which will handle refs correctly.
diff --git a/refs.c b/refs.c
index 67daf0918e..17e4307f31 100644
--- a/refs.c
+++ b/refs.c
@@ -641,12 +641,33 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+static int is_main_pseudoref_syntax(const char *refname)
+{
+	return skip_prefix(refname, "main-worktree/", &refname) &&
+		*refname &&
+		is_pseudoref_syntax(refname);
+}
+
+static int is_other_pseudoref_syntax(const char *refname)
+{
+	if (!skip_prefix(refname, "worktrees/", &refname))
+		return 0;
+	refname = strchr(refname, '/');
+	if (!refname || !refname[1])
+		return 0;
+	return is_pseudoref_syntax(refname + 1);
+}
+
 enum ref_type ref_type(const char *refname)
 {
 	if (is_per_worktree_ref(refname))
 		return REF_TYPE_PER_WORKTREE;
 	if (is_pseudoref_syntax(refname))
 		return REF_TYPE_PSEUDOREF;
+	if (is_main_pseudoref_syntax(refname))
+		return REF_TYPE_MAIN_PSEUDOREF;
+	if (is_other_pseudoref_syntax(refname))
+		return REF_TYPE_OTHER_PSEUDOREF;
 	return REF_TYPE_NORMAL;
 }
 
diff --git a/refs.h b/refs.h
index 6cc0397679..308fa1f03b 100644
--- a/refs.h
+++ b/refs.h
@@ -714,9 +714,11 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
 int ref_is_hidden(const char *, const char *);
 
 enum ref_type {
-	REF_TYPE_PER_WORKTREE,
-	REF_TYPE_PSEUDOREF,
-	REF_TYPE_NORMAL,
+	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
+	REF_TYPE_PSEUDOREF,	  /* refs outside refs/ in current worktree */
+	REF_TYPE_MAIN_PSEUDOREF,  /* pseudo refs from the main worktree     */
+	REF_TYPE_OTHER_PSEUDOREF, /* pseudo refs from other worktrees       */
+	REF_TYPE_NORMAL,	  /* normal/shared refs inside refs/        */
 };
 
 enum ref_type ref_type(const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2dd77f9485..9183875dad 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -10,6 +10,7 @@
 #include "../object.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
+#include "worktree.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
@@ -149,6 +150,25 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
+static void files_reflog_path_other_worktrees(struct files_ref_store *refs,
+					      struct strbuf *sb,
+					      const char *refname)
+{
+	const char *real_ref;
+	const char *worktree_name;
+	int length;
+
+	if (parse_worktree_ref(refname, &worktree_name, &length, &real_ref))
+		BUG("refname %s is not a other-worktree ref", refname);
+
+	if (worktree_name)
+		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
+			    length, worktree_name, real_ref);
+	else
+		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir,
+			    real_ref);
+}
+
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -158,6 +178,9 @@ static void files_reflog_path(struct files_ref_store *refs,
 	case REF_TYPE_PSEUDOREF:
 		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
 		break;
+	case REF_TYPE_OTHER_PSEUDOREF:
+	case REF_TYPE_MAIN_PSEUDOREF:
+		return files_reflog_path_other_worktrees(refs, sb, refname);
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
 		break;
@@ -176,6 +199,11 @@ static void files_ref_path(struct files_ref_store *refs,
 	case REF_TYPE_PSEUDOREF:
 		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
 		break;
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (!skip_prefix(refname, "main-worktree/", &refname))
+			BUG("ref %s is not a main pseudoref", refname);
+		/* fallthrough */
+	case REF_TYPE_OTHER_PSEUDOREF:
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
 		break;
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 16c91bef57..b664e51250 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -30,4 +30,50 @@ test_expect_success 'refs/worktree are per-worktree' '
 	( cd wt2 && test_cmp_rev worktree/foo wt2 )
 '
 
+test_expect_success 'resolve main-worktree/HEAD' '
+	test_cmp_rev main-worktree/HEAD initial &&
+	( cd wt1 && test_cmp_rev main-worktree/HEAD initial ) &&
+	( cd wt2 && test_cmp_rev main-worktree/HEAD initial )
+'
+
+test_expect_success 'ambiguous main-worktree/HEAD' '
+	mkdir -p .git/refs/heads/main-worktree &&
+	test_when_finished rm -f .git/refs/heads/main-worktree/HEAD &&
+	cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&
+	git rev-parse main-worktree/HEAD 2>warn &&
+	grep "main-worktree/HEAD.*ambiguous" warn
+'
+
+test_expect_success 'resolve worktrees/xx/HEAD' '
+	test_cmp_rev worktrees/wt1/HEAD wt1 &&
+	( cd wt1 && test_cmp_rev worktrees/wt1/HEAD wt1 ) &&
+	( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
+'
+
+test_expect_success 'ambiguous worktrees/xx/HEAD' '
+	mkdir -p .git/refs/heads/worktrees/wt1 &&
+	test_when_finished rm -f .git/refs/heads/worktrees/wt1/HEAD &&
+	cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
+	git rev-parse worktrees/wt1/HEAD 2>warn &&
+	grep "worktrees/wt1/HEAD.*ambiguous" warn
+'
+
+test_expect_success 'reflog of main-worktree/HEAD' '
+	git reflog HEAD | sed "s/HEAD/main-worktree\/HEAD/" >expected &&
+	git reflog main-worktree/HEAD >actual &&
+	test_cmp expected actual &&
+	git -C wt1 reflog main-worktree/HEAD >actual.wt1 &&
+	test_cmp expected actual.wt1
+'
+
+test_expect_success 'reflog of worktrees/xx/HEAD' '
+	git -C wt2 reflog HEAD | sed "s/HEAD/worktrees\/wt2\/HEAD/" >expected &&
+	git reflog worktrees/wt2/HEAD >actual &&
+	test_cmp expected actual &&
+	git -C wt1 reflog worktrees/wt2/HEAD >actual.wt1 &&
+	test_cmp expected actual.wt1 &&
+	git -C wt2 reflog worktrees/wt2/HEAD >actual.wt2 &&
+	test_cmp expected actual.wt2
+'
+
 test_done
diff --git a/worktree.c b/worktree.c
index b0d0b5426d..4193496f2a 100644
--- a/worktree.c
+++ b/worktree.c
@@ -487,6 +487,36 @@ int submodule_uses_worktrees(const char *path)
 	return ret;
 }
 
+int parse_worktree_ref(const char *worktree_ref, const char **name,
+		       int *name_length, const char **ref)
+{
+	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
+		if (!*worktree_ref)
+			return -1;
+		if (name)
+			*name = NULL;
+		if (name_length)
+			*name_length = 0;
+		if (ref)
+			*ref = worktree_ref;
+		return 0;
+	}
+	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
+		const char *slash = strchr(worktree_ref, '/');
+
+		if (!slash || slash == worktree_ref || !slash[1])
+			return -1;
+		if (name)
+			*name = worktree_ref;
+		if (name_length)
+			*name_length = slash - worktree_ref;
+		if (ref)
+			*ref = slash + 1;
+		return 0;
+	}
+	return -1;
+}
+
 int other_head_refs(each_ref_fn fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
diff --git a/worktree.h b/worktree.h
index df3fc30f73..440bb219dd 100644
--- a/worktree.h
+++ b/worktree.h
@@ -108,4 +108,13 @@ extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Parse a worktree ref (i.e. with prefix main-worktree/ or
+ * worktrees/) and return the position of the worktree's name and
+ * length (or NULL and zero if it's main worktree), and ref.
+ *
+ * All name, name_length and ref arguments could be NULL.
+ */
+int parse_worktree_ref(const char *worktree_ref, const char **name,
+		       int *name_length, const char **ref);
 #endif
-- 
2.19.1.647.g708186aaf9

