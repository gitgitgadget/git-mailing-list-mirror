Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1256F1F45F
	for <e@80x24.org>; Thu,  9 May 2019 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIKKw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 06:10:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIKKv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 06:10:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so975532pgb.3
        for <git@vger.kernel.org>; Thu, 09 May 2019 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/nY+vlGwvNAAR4EUzy4yU4bO93HCB+tRyYacQUc7uo=;
        b=EQjcaZ8fUrHSAm+d02D1ldx9PtFAI0/GtwSxqt1q8wDwGgcqeXL7Kr23mKg1Y+UYau
         TH9NFN8oxwqX29pS5NEj3pKGv25jXfqYRpFQMq5nT9NbmMc4MII9HNIUfQdZh3EU18Pi
         oeOu9neLaHl30GdKoW0xrfSXbYirpEvCpEdmRlP57bYS6/Jf+ZA0C+huUnBoLkc7fSun
         DnFYzeeVvAa/GQ4GImuVDAnEWWkwDnAhxXAdZ0npTPu3a66AwBaUZyAD9zOO7Gvf+Ef+
         WfJSslGMRhMctuhomXpGlfHa+YFZjhquR6EyfHJJ5LYGBR1aoy6DCBvACo/btcaI7eSg
         uwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/nY+vlGwvNAAR4EUzy4yU4bO93HCB+tRyYacQUc7uo=;
        b=UyJ177h8J99NMZMZniOliWuiKhnWPZ+PZPICGiuDkGuZZ+2MDmicYSmFquEEX0Lc2c
         yEq3gkAtZJUm0LwzOVbf/BqjObuLgIhc0hQMqG2xFSFNUM/qsOEzHwdrsjoef9DyYyXc
         rMQ9OLvhE4iUEyZqNI4CBlewUCN7JzTDToJJfpagELE0XYzAFgxkLgBuUsQ4YM7EaQNw
         htNWHz3Y99VJE8SVtyv7WOISwL0fSib/3yW+5iFPadQnf3DHoI4CRAZXX03caWgaLCKu
         0ocXz74b1xapP68tGxJfRXxzNsfL3neVyYb/yWntArj1gsgMLGtd60AvZzJPw9W0FroY
         8PfQ==
X-Gm-Message-State: APjAAAXNiaK0eZSgxDsnPpvTUoHc4fLnASL7h8HKl0siwg9cvQxo4O3N
        aQeVxUwLMvTssFqSTic+ffY=
X-Google-Smtp-Source: APXvYqwI76E6I2+Iaww7GqhjDmr1KMJxEiAMvoQTwB0zT3OPKjWrWVBW8Kj1aol4/WDgoSwg5JGOAg==
X-Received: by 2002:a63:530d:: with SMTP id h13mr4132858pgb.77.1557396650976;
        Thu, 09 May 2019 03:10:50 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id q20sm900405pgq.66.2019.05.09.03.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 03:10:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 09 May 2019 17:10:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: [PATCH v2 1/2] merge: remove drop_save() in favor of remove_merge_branch_state()
Date:   Thu,  9 May 2019 17:10:27 +0700
Message-Id: <20190509101028.24656-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190509101028.24656-1-pclouds@gmail.com>
References: <20190501131152.314-1-pclouds@gmail.com>
 <20190509101028.24656-1-pclouds@gmail.com>
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
2.21.0.1141.gd54ac2cb17

