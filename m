Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4BD1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426687AbdEACcj (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35868 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2993916AbdEACbc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CF38E280DD;
        Mon,  1 May 2017 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605815;
        bh=ebd4sJKw4MsVATvHVsDWUPzZ9Fl9n9XLLmxJGTIlmzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TleZ/gUkRXn5sp9HQj8qxpKgplZ0SoEP69nLRnSy7985Ym/9qdH/FutsomZSYwRqP
         Mgk2oyrJifG4YgMZ8naEk4caLRqf9ddfQbv9Fdt+kvzI42gGPfPkh2x7aghYEyq1EU
         lPyiwpIJ3PInHYS+40gi8kUM8gDf/oBLAj564Y6ZCfWxFGU8flw4cod1Tfzq/IMDNy
         4ShhmwzZFUCk+/fMTNfLji1x+/R0XQE58ROVGjvC9rsqSf32273a2rwYgXayNWMNdi
         Mj2MXogRKgxwTn7P9DkJQYbQFINeikTbR3jxD9SV/uqLZJxZ8YZ4FrZTqWJrxrk+30
         VeP/78Ka+84lRMxAPaTCIgs1sqNt/sNd6gqpfgmL8bh1anniCGP5TYPy+dpzjH23JH
         Ncyr0qJ/+1BFvAAINpWcGxFU7gRjAoMSvdQxOhREuviqcHRCVsybfW42LwnFYN17hI
         jTukFc/UwcMXGwar/6MK1uMAzm62jy8+rE7Sx77naI0HZhhpy8y
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 47/53] sequencer: convert fast_forward_to to struct object_id
Date:   Mon,  1 May 2017 02:29:40 +0000
Message-Id: <20170501022946.258735-48-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast_forward_to is required for checkout_fast_fowrard, which is required
for parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fa35e03b6..68e032630 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -374,7 +374,7 @@ static void update_abort_safety_file(void)
 		write_file(git_path_abort_safety_file(), "%s", "");
 }
 
-static int fast_forward_to(const unsigned char *to, const unsigned char *from,
+static int fast_forward_to(const struct object_id *to, const struct object_id *from,
 			int unborn, struct replay_opts *opts)
 {
 	struct ref_transaction *transaction;
@@ -382,7 +382,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
-	if (checkout_fast_forward(from, to, 1))
+	if (checkout_fast_forward(from->hash, to->hash, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
@@ -390,7 +390,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
-				   to, unborn ? null_sha1 : from,
+				   to->hash, unborn ? null_sha1 : from->hash,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
@@ -935,7 +935,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 {
 	unsigned int flags = opts->edit ? EDIT_MSG : 0;
 	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
-	unsigned char head[20];
+	struct object_id head;
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
@@ -949,12 +949,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		 * that represents the "current" state for merge-recursive
 		 * to work on.
 		 */
-		if (write_cache_as_tree(head, 0, NULL))
+		if (write_cache_as_tree(head.hash, 0, NULL))
 			return error(_("your index file is unmerged."));
 	} else {
-		unborn = get_sha1("HEAD", head);
+		unborn = get_oid("HEAD", &head);
 		if (unborn)
-			hashcpy(head, EMPTY_TREE_SHA1_BIN);
+			oidcpy(&head, &empty_tree_oid);
 		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, 0))
 			return error_dirty_index(opts);
 	}
@@ -990,11 +990,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			oid_to_hex(&commit->object.oid));
 
 	if (opts->allow_ff && !is_fixup(command) &&
-	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
+	    ((parent && !oidcmp(&parent->object.oid, &head)) ||
 	     (!parent && unborn))) {
 		if (is_rebase_i(opts))
 			write_author_script(msg.message);
-		res = fast_forward_to(commit->object.oid.hash, head, unborn,
+		res = fast_forward_to(&commit->object.oid, &head, unborn,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
@@ -1081,7 +1081,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head, &msgbuf, opts);
+					 head.hash, &msgbuf, opts);
 		if (res < 0)
 			return res;
 		res |= write_message(msgbuf.buf, msgbuf.len,
@@ -1097,7 +1097,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		commit_list_insert(next, &remotes);
 		res |= try_merge_command(opts->strategy,
 					 opts->xopts_nr, (const char **)opts->xopts,
-					common, sha1_to_hex(head), remotes);
+					common, oid_to_hex(&head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
