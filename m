Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E081F461
	for <e@80x24.org>; Sat, 18 May 2019 11:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfERLa5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:30:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47046 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERLa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:30:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so4940534pfm.13
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2S66HgaOErjrrvIYJD+/RtviQdvMbzQlV1URKA0ElbU=;
        b=AEybOszj9VB23BEIzKy7KziWP6n+V4CV0p6SbBDhk76UjxVKljk2BhVHq//e6MJK1w
         ZxMezCYm1kmI+HnkSE5Zz16ZvKYUim8r6OylhohKjhfm7lD4SdxAo6RfkAPOHAnW0pTd
         RIousuhHDBEGWrn/pLLgO2DYw0FnSuJszqfT4A3ovzN7lE801BvI7U9PFW7m5hpYHPne
         adPUVdmsjIRldVqnVzO7gfWCd7i8lkLpvHNxPc+SQeIi4gidrSYATXcmo/9/kJUbvkc4
         7azemT4rHsF2XzUAGm7UTXQVLM7Cpacvss4MhJHty3JnV5NISIZwul3X6GUlzHvJK3Ir
         rrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2S66HgaOErjrrvIYJD+/RtviQdvMbzQlV1URKA0ElbU=;
        b=tU+ysf1Ckt7jm4zd8PrNadGKX9t5D6hgOq+NGNpdf3NPpIPDybDeQvngvagigC+dFO
         YDvkCqlI7ZHmYZVb/xss1MGNtvtN5tuqOvg1ktp4C31dcV8HOCWuEfmLLRgETXLGXeQj
         59WobkzqXAgapBxsRO2boG7tB671mL+gVGH/FFxysac9qHwWkaL1oPPeXwINNJpwFQGt
         OP9eOmlYsV989okMzEi8lzaD9o6SXvGRi52RocFwlTLfWSw9kANFKDDYI+wQHdg0lrBg
         ByAAfasOPaDt7CkngID+ixv+EKkXvJHvSoFFHiN1xSi8NRksVazPnUunbQifYEPyxSUr
         0LiA==
X-Gm-Message-State: APjAAAXgPqYppohdIgCvDg0YkFiGWLECGoXXWpNydaUMeqFZcXXGdvAp
        jDIWBX/pgFBC6KnV3j/jMBA=
X-Google-Smtp-Source: APXvYqzPMcfKrvdxl27N2zKzL6XmUnSSljXwiqPP/RnkBdMUF5aJuVOaxOm104Ug8o40bCFBUJE1Cg==
X-Received: by 2002:a63:2d6:: with SMTP id 205mr61949071pgc.114.1558179056581;
        Sat, 18 May 2019 04:30:56 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id v64sm14968440pfv.106.2019.05.18.04.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 04:30:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 May 2019 18:30:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v4 1/2] merge: remove drop_save() in favor of remove_merge_branch_state()
Date:   Sat, 18 May 2019 18:30:42 +0700
Message-Id: <20190518113043.18389-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190518113043.18389-1-pclouds@gmail.com>
References: <20190514091322.12427-1-pclouds@gmail.com>
 <20190518113043.18389-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both remove_branch_state() and drop_save() delete almost the same set of
files about the current merge state. The only difference is MERGE_RR but
it should also be cleaned up after a successful merge, which is what
drop_save() is for.

Make a new function that deletes all merge-related state files and use
it instead of drop_save(). This function will also be used in the next
patch that introduces --quit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c        | 11 ++++++++---
 branch.h        |  6 ++++++
 builtin/merge.c | 17 +++++------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 28b81a7e02..1db0601a11 100644
--- a/branch.c
+++ b/branch.c
@@ -337,15 +337,20 @@ void create_branch(struct repository *r,
 	free(real_ref);
 }
 
-void remove_branch_state(struct repository *r)
+void remove_merge_branch_state(struct repository *r)
 {
-	unlink(git_path_cherry_pick_head(r));
-	unlink(git_path_revert_head(r));
 	unlink(git_path_merge_head(r));
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
+}
+
+void remove_branch_state(struct repository *r)
+{
+	unlink(git_path_cherry_pick_head(r));
+	unlink(git_path_revert_head(r));
 	unlink(git_path_squash_msg(r));
+	remove_merge_branch_state(r);
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 29c1afa4d0..c90ba9d7bf 100644
--- a/branch.h
+++ b/branch.h
@@ -60,6 +60,12 @@ extern int validate_branchname(const char *name, struct strbuf *ref);
  */
 extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
+/*
+ * Remove information about the merge state on the current
+ * branch. (E.g., MERGE_HEAD)
+ */
+void remove_merge_branch_state(struct repository *r);
+
 /*
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
diff --git a/builtin/merge.c b/builtin/merge.c
index e47d77baee..e9663f027a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -37,6 +37,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "branch.h"
 #include "commit-reach.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
@@ -279,14 +280,6 @@ static struct option builtin_merge_options[] = {
 	OPT_END()
 };
 
-/* Cleans up metadata that is uninteresting after a succeeded merge. */
-static void drop_save(void)
-{
-	unlink(git_path_merge_head(the_repository));
-	unlink(git_path_merge_msg(the_repository));
-	unlink(git_path_merge_mode(the_repository));
-}
-
 static int save_state(struct object_id *stash)
 {
 	int len;
@@ -380,7 +373,7 @@ static void finish_up_to_date(const char *msg)
 {
 	if (verbosity >= 0)
 		printf("%s%s\n", squash ? _(" (nothing to squash)") : "", msg);
-	drop_save();
+	remove_merge_branch_state(the_repository);
 }
 
 static void squash_message(struct commit *commit, struct commit_list *remoteheads)
@@ -858,7 +851,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, &result_commit, "In-index merge");
-	drop_save();
+	remove_merge_branch_state(the_repository);
 	return 0;
 }
 
@@ -885,7 +878,7 @@ static int finish_automerge(struct commit *head,
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, &result_commit, buf.buf);
 	strbuf_release(&buf);
-	drop_save();
+	remove_merge_branch_state(the_repository);
 	return 0;
 }
 
@@ -1463,7 +1456,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 
 		finish(head_commit, remoteheads, &commit->object.oid, msg.buf);
-		drop_save();
+		remove_merge_branch_state(the_repository);
 		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
-- 
2.22.0.rc0.322.g2b0371e29a

