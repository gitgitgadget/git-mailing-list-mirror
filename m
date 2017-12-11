Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24A01F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbdLKONz (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:13:55 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:35381 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbdLKONr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:47 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq2eBive; Mon, 11 Dec 2017 14:13:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001626;
        bh=r3H1qVDGXyktW0/2jBTJ8cojM4TnG2oTvPNUArQjSF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=KvH2yeG9eVE3gG9mI/J9xSzaxmfzT4jtvCZ2zPmXGjPGnZAmgp1UnFbDdEK4eUB7v
         u1RxcWR1QtG4MiMsBEotO2Ro6TSjH5czzlfJWpPzgnVTfOuZWkIE0082RMXj3w6DZG
         99UsPwFb/92iG6uw92TOldJAVp67SygCOzqjHvYA=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=YgUoppyUvfUiwa9g-6kA:9
 a=LsZgiExTRIM4etDD:21 a=YqjHFiUZr1EcQFKv:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 3/9] Add a function to update HEAD after creating a commit
Date:   Mon, 11 Dec 2017 14:13:24 +0000
Message-Id: <20171211141330.23566-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCkKLf5C3ntqVQLKaiaaPnge9xOtiNC0A3Rc+uZSswgLb1nitE4vjAV9PWOOZm6qDN+jz3qeqMP0N+mRKw1ykVYuzzhTf0kvNOP49itQyt6Z+xo/DnBX
 hg31ZpUKL1qxz5vNca2jtey2CTUe2+k+Szo5qyytFPrpA0bgwYqzzCoY0e8fVT81UaWA9wqTB3V8kceeSYS8mUptc81u6x0maZ5WxwS56WubXVtblGY+CbXp
 fwqhUMtbpoPJ/MJ7ADhVsoc/4Fa1qFnbaUqmKRDtXmD7ND1z4CvqjsKCPCMtRxn4T3iWYXrE8tg9OW2f2JjJ2HlofSp3te2dE7UIzcYX6p/68bc3vpQ0f+c7
 ILGdFbLo7H2iVJe9md293c3c8s8wpScTPdUzPM7htqywo3mU0YA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add update_head_with_reflog() based on the code that updates HEAD
after committing in builtin/commit.c that can be called by 'git
commit' and other commands.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - updated commit message to reflect the change in function name
     - style fixes
    
    changes since v1:
     - rename update_head() to update_head_with_reflog()

 builtin/commit.c | 20 ++------------------
 sequencer.c      | 39 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h      |  4 ++++
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2175dac8036c465a73c4c782f061e85ae6d1a629..340cc2988ebdb92ef222b677ee12c94fa53aa1ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1610,13 +1610,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
-	char *nl;
 	struct object_id oid;
 	struct commit_list *parents = NULL;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
-	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -1739,25 +1737,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	nl = strchr(sb.buf, '\n');
-	if (nl)
-		strbuf_setlen(&sb, nl + 1 - sb.buf);
-	else
-		strbuf_addch(&sb, '\n');
-	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
-	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
-
-	transaction = ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", &oid,
-				   current_head
-				   ? &current_head->object.oid : &null_oid,
-				   0, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
+				    &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
 
 	unlink(git_path_cherry_pick_head());
 	unlink(git_path_revert_head());
diff --git a/sequencer.c b/sequencer.c
index 168da5093e71f50a4d70af7288cf761110e69e87..5fe6ef3512566622f0423a09cbffe1adf1e65957 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,10 +1,10 @@
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
-#include "sequencer.h"
 #include "dir.h"
 #include "object.h"
 #include "commit.h"
+#include "sequencer.h"
 #include "tag.h"
 #include "run-command.h"
 #include "exec_cmd.h"
@@ -753,6 +753,43 @@ int template_untouched(const struct strbuf *sb, const char *template_file,
 	return rest_is_empty(sb, start - sb->buf);
 }
 
+int update_head_with_reflog(const struct commit *old_head,
+			    const struct object_id *new_head,
+			    const char *action, const struct strbuf *msg,
+			    struct strbuf *err)
+{
+	struct ref_transaction *transaction;
+	struct strbuf sb = STRBUF_INIT;
+	const char *nl;
+	int ret = 0;
+
+	if (action) {
+		strbuf_addstr(&sb, action);
+		strbuf_addstr(&sb, ": ");
+	}
+
+	nl = strchr(msg->buf, '\n');
+	if (nl) {
+		strbuf_add(&sb, msg->buf, nl + 1 - msg->buf);
+	} else {
+		strbuf_addbuf(&sb, msg);
+		strbuf_addch(&sb, '\n');
+	}
+
+	transaction = ref_transaction_begin(err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", new_head,
+				   old_head ? &old_head->object.oid : &null_oid,
+				   0, sb.buf, err) ||
+	    ref_transaction_commit(transaction, err)) {
+		ret = -1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&sb);
+
+	return ret;
+}
+
 static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
diff --git a/sequencer.h b/sequencer.h
index 2040773c7b6fd3966d5a1a14f410ea8ff53843c8..3757a7aecb5a7795d7b9b45964f3328ee852e14b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -68,4 +68,8 @@ int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
 		       enum commit_msg_cleanup_mode cleanup_mode);
+int update_head_with_reflog(const struct commit *old_head,
+			    const struct object_id *new_head,
+			    const char *action, const struct strbuf *msg,
+			    struct strbuf *err);
 #endif
-- 
2.15.1

