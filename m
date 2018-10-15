Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5734B1F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeJOHpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50580 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbeJOHpE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 985E661B82;
        Mon, 15 Oct 2018 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561740;
        bh=lk3zoBfcaMgdtZKQJfSk16mesbk7eXWLsgQNgRVDvjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=KUf+sF752uSRyqywTiHdQ7tBGKp+iVGeiOFsBYdwdnmzAk0twwgj7VQ0Ggghl285M
         UIw3eHCnacatNkzq1MRsvw7oh4JtxpIDk4XbtVLfh30w2LRtBsG2NyZMZiK3VhteFu
         GTOIy3is1Bcncr6NoBlbc3Wxkllns3hiH71xm4F1LLr9nx2JxvlXZRweOdZFvEs0Dm
         VAm1QYmXVc79wJvgUEoLI/wqXLpKzPubbYs89Mpq28uVTNuD0DsKsAzwpUtO7Vim+m
         mNCEsfk+815aysF9MaCYPia5+HR8MrJPZWv9FHn3Vd4NOE6YFovnPDUux0LEZYCRVh
         2Eyd/LCgddmy//ic5sZN33+dMVAmjQ3pG+08uUCbJqbEK2FGiw4EARlq8XpAl3m146
         CrzB6/b60FSPtCcUZJYH7rH8gsirhI4uuUkGeaS6ZnlMLsZHJL+cwztwNmxcRM/9Di
         hqgYSFLIYRa8/WxzJbsEaESVimqZp1ixkODMcqYojj1XpVrEC7j
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 08/15] refs/packed-backend: express constants using the_hash_algo
Date:   Mon, 15 Oct 2018 00:01:55 +0000
Message-Id: <20181015000202.951965-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015000202.951965-1-sandals@crustytoothpaste.net>
References: <20181015000202.951965-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch uses of GIT_SHA1_HEXSZ to use the_hash_algo so that they are
appropriate for the any given hash length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/packed-backend.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 74e2996e93..c01c7f5901 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -274,8 +274,8 @@ struct snapshot_record {
 static int cmp_packed_ref_records(const void *v1, const void *v2)
 {
 	const struct snapshot_record *e1 = v1, *e2 = v2;
-	const char *r1 = e1->start + GIT_SHA1_HEXSZ + 1;
-	const char *r2 = e2->start + GIT_SHA1_HEXSZ + 1;
+	const char *r1 = e1->start + the_hash_algo->hexsz + 1;
+	const char *r2 = e2->start + the_hash_algo->hexsz + 1;
 
 	while (1) {
 		if (*r1 == '\n')
@@ -297,7 +297,7 @@ static int cmp_packed_ref_records(const void *v1, const void *v2)
  */
 static int cmp_record_to_refname(const char *rec, const char *refname)
 {
-	const char *r1 = rec + GIT_SHA1_HEXSZ + 1;
+	const char *r1 = rec + the_hash_algo->hexsz + 1;
 	const char *r2 = refname;
 
 	while (1) {
@@ -344,7 +344,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 		if (!eol)
 			/* The safety check should prevent this. */
 			BUG("unterminated line found in packed-refs");
-		if (eol - pos < GIT_SHA1_HEXSZ + 2)
+		if (eol - pos < the_hash_algo->hexsz + 2)
 			die_invalid_line(snapshot->refs->path,
 					 pos, eof - pos);
 		eol++;
@@ -456,7 +456,7 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 		return;
 
 	last_line = find_start_of_record(start, eof - 1);
-	if (*(eof - 1) != '\n' || eof - last_line < GIT_SHA1_HEXSZ + 2)
+	if (*(eof - 1) != '\n' || eof - last_line < the_hash_algo->hexsz + 2)
 		die_invalid_line(snapshot->refs->path,
 				 last_line, eof - last_line);
 }
@@ -796,7 +796,7 @@ static int next_record(struct packed_ref_iterator *iter)
 
 	iter->base.flags = REF_ISPACKED;
 
-	if (iter->eof - p < GIT_SHA1_HEXSZ + 2 ||
+	if (iter->eof - p < the_hash_algo->hexsz + 2 ||
 	    parse_oid_hex(p, &iter->oid, &p) ||
 	    !isspace(*p++))
 		die_invalid_line(iter->snapshot->refs->path,
@@ -826,7 +826,7 @@ static int next_record(struct packed_ref_iterator *iter)
 
 	if (iter->pos < iter->eof && *iter->pos == '^') {
 		p = iter->pos + 1;
-		if (iter->eof - p < GIT_SHA1_HEXSZ + 1 ||
+		if (iter->eof - p < the_hash_algo->hexsz + 1 ||
 		    parse_oid_hex(p, &iter->peeled, &p) ||
 		    *p++ != '\n')
 			die_invalid_line(iter->snapshot->refs->path,
