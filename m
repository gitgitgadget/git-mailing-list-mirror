Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECB02022D
	for <e@80x24.org>; Fri,  4 Nov 2016 15:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935225AbcKDPT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 11:19:56 -0400
Received: from mail.zhinst.com ([212.126.164.98]:32806 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754005AbcKDPTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 11:19:55 -0400
Received: from ziws08.zhinst.com ([10.42.0.7])
        by mail.zhinst.com (Kerio Connect 9.1.1) with ESMTP;
        Fri, 4 Nov 2016 16:19:49 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] branch: remove unused parameter to create_branch()
Date:   Fri,  4 Nov 2016 16:19:49 +0100
Message-Id: <20161104151949.13384-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name parameter to create_branch() has been unused since commit
55c4a673070f ("Prevent force-updating of the current branch"). Remove
the parameter and adjust the callers accordingly. Also remove the
parameter from the function's documentation comment.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 branch.c           |  3 +--
 branch.h           | 15 +++++++--------
 builtin/branch.c   |  4 ++--
 builtin/checkout.c |  2 +-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index a5a8dcbd0ed9..0d459b3cfe50 100644
--- a/branch.c
+++ b/branch.c
@@ -228,8 +228,7 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(const char *head,
-		   const char *name, const char *start_name,
+void create_branch(const char *name, const char *start_name,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
diff --git a/branch.h b/branch.h
index b2f964933270..8e63d1b6f964 100644
--- a/branch.h
+++ b/branch.h
@@ -4,15 +4,14 @@
 /* Functions for acting on the information about branches. */
 
 /*
- * Creates a new branch, where head is the branch currently checked
- * out, name is the new branch name, start_name is the name of the
- * existing branch that the new branch should start from, force
- * enables overwriting an existing (non-head) branch, reflog creates a
- * reflog for the branch, and track causes the new branch to be
- * configured to merge the remote branch that start_name is a tracking
- * branch for (if any).
+ * Creates a new branch, where name is the new branch name, start_name
+ * is the name of the existing branch that the new branch should start
+ * from, force enables overwriting an existing (non-head) branch, reflog
+ * creates a reflog for the branch, and track causes the new branch to
+ * be configured to merge the remote branch that start_name is a
+ * tracking branch for (if any).
  */
-void create_branch(const char *head, const char *name, const char *start_name,
+void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
 		   int clobber_head, int quiet, enum branch_track track);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index d5d93a8c03fe..60cc5c8e8da0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -807,7 +807,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -853,7 +853,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 
 		branch_existed = ref_exists(branch->refname);
-		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
 		/*
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b2a5b31d423..512492aad909 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -630,7 +630,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch, new->name,
+			create_branch(opts->new_branch, new->name,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->new_branch_force ? 1 : 0,
-- 
2.9.0


