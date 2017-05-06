Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80389207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbdEFWN1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:13:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37748 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754704AbdEFWL5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CB2D6280DE;
        Sat,  6 May 2017 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108679;
        bh=T0KFfNOV35koJu/4NyOCqgziz0NkyiVkWSMg3HrpI5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlyBQrSYY2Xj1vPnMW+sOnAE4BA6dDnhLN5YPkisKoVRVTJQ6JAb7QPOtrxEdz84p
         YTyPZMbYlAbSdyz2KfsSDWDsriYvrZ7DT2uJKIviQK0mhZx8aKiNp791Ua11uSAX5Z
         pJJMjPdMUQj9vRkCVvlCNHS0twmizMtxf/9IHEYRQvlmdFAua1cWSNYKzb6xUvs9Nm
         2eXwhJkqrZsHP8tqOYxpZh0OUqHGEDPGytmLQ7DpXBNb1l2wmGF2vRitS8OestgriQ
         yykeUU6NclgSZXhMLGSbyTYVEAuR7n7eKfJNzxeekO4dpcaORBhlLPlI2iMIEUgtxD
         NPhsbUuDQM63udWnJua0mxLPZ85TV3sypIjkFcZBV1RZSN/d/d2AlIh2q4Y0k1pj7t
         0/+/1VtVhKKLWr0aywdCNTPq56dHX8ssUK/+rpClyWowu1aooSTCp+DEiNHJg5hWZ8
         sO/csYHZrLqrU3w7zHXs7lsjmIQJs6F8WsC5uT1XMDhRBZgsqX7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 51/53] sequencer: convert do_recursive_merge to struct object_id
Date:   Sat,  6 May 2017 22:10:36 +0000
Message-Id: <20170506221038.296722-52-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
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
index dcc56a2b6..adcc0a953 100644
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
