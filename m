Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9E81F829
	for <e@80x24.org>; Mon,  1 May 2017 02:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426700AbdEACcu (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:50 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35914 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966001AbdEACbl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0E7C0280E2;
        Mon,  1 May 2017 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605817;
        bh=T4xQR93bCY0+GEYCJrIObD3bu0vON+Lsps/huFg5WNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHasE06Vxh01FO2iIhd8z3giMp1qIqDVaaAXA8YhtpMvVsLXBNF6NGmtKEDb+JC/k
         QdchOqwdCYLtWH1qYgOKe4hhOkgxfG0uzVp7P7mm2/DZjhYUcaX7sf+Qkif+H3Myjw
         RwD+RGLHwPDTWqOyl4xNSG7HT6EEtt3TAkV0oZMFadg+n7pePwx2I6p86dYUE5MiyH
         IbXnUm8taviB38P90zDb1vKye2BOu96R+yc2RE18P+lnaTFsRlmZJDzFmZ/Wb6/QiN
         NhFjQ/xDLULHjIh4zrO7QMFHN9pOkwN+dSSlNkIswexAh2Djp9XAGoI00Y2gbNN9uq
         PMikplSbxmKRXf0g5UYuhop5LKTqeZtvr0yA7EcEyNXAdOyIWlhy1jKeCIEXrb4Z6I
         mpsU52i5Zp5aib5qtx56PL0xYi5Z4GF2LtdyhJQ1+zjUlSsNfFuP3x3gjpK+cWki6E
         YKUSLgk5rw8CKtIUhqqQktyUoD3pjfkuFAJODlwj+H0OBDBfn+J
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 51/53] sequencer: convert do_recursive_merge to struct object_id
Date:   Mon,  1 May 2017 02:29:44 +0000
Message-Id: <20170501022946.258735-52-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This conversion is required to convert parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b295004af..d2963c6c5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -426,7 +426,7 @@ void append_conflicts_hint(struct strbuf *msgbuf)
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf,
+			      struct object_id *head, struct strbuf *msgbuf,
 			      struct replay_opts *opts)
 {
 	struct merge_options o;
@@ -446,7 +446,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (is_rebase_i(opts))
 		o.buffer_output = 2;
 
-	head_tree = parse_tree_indirect(head);
+	head_tree = parse_tree_indirect(head->hash);
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
@@ -1081,7 +1081,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		res = -1;
 	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head.hash, &msgbuf, opts);
+					 &head, &msgbuf, opts);
 		if (res < 0)
 			return res;
 		res |= write_message(msgbuf.buf, msgbuf.len,
