Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093A91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeDWXly (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932680AbeDWXk0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1BDC76099D;
        Mon, 23 Apr 2018 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526825;
        bh=VsUX46KiJyh5qzryPMHq1G7jioKc79El1V5RRGJSFHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Fj5lZ7chgfWnKLPf8qKUpWVVt7+xNHFF7UPeaqIPeMCfIs67jSGAAfqD5c5S6Qdkb
         hCu2UXWc7iNO9PvRfbJJ7T+m1hLl+tDYnQLFv3kU2YKfEt7nj62REFRqW9/m1FcUhB
         s5Js1TOWEM6Gv7RVI7eiBoM96pwNh8E7CUkbxyATDkoyjN5e+LlJC/AyFNxBUYpjBd
         ngPymMRpR/ANPp71VYRNmXzuhjLVwNd+hbJ5j3V8yd5FjxHvzUtCqRVEN2z8CAKAYR
         1ry6fR/0TfqTuV24PIAlbtfunVdxHeHV5YqdTcyWAeX6p+IQNgiurRccFQkTSUbAnU
         TfouF/A2IGD2h28pncE+jj/WWEJN8Ubm8oOlO0NUclB2uREJhs51/G7QCEu6Z15+oG
         WnG0OIYq4ayDLs6q92cR5DA1WW4FuFKqW5FZs55PRiutlTkxAdObJET0ZDfDqsY6Kb
         yFxAFr3i3pgO7DRtfoEIkMRE7BbVjIk4tbh10Xz9qHKHsBHSU+m
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 19/41] commit: convert uses of get_sha1_hex to get_oid_hex
Date:   Mon, 23 Apr 2018 23:39:29 +0000
Message-Id: <20180423233951.276447-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index ca474a7c11..9617f85caa 100644
--- a/commit.c
+++ b/commit.c
@@ -331,7 +331,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
 		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
-	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
+	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
 	item->tree = lookup_tree(&parent);
@@ -343,7 +343,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 		struct commit *new_parent;
 
 		if (tail <= bufptr + parent_entry_len + 1 ||
-		    get_sha1_hex(bufptr + 7, parent.hash) ||
+		    get_oid_hex(bufptr + 7, &parent) ||
 		    bufptr[parent_entry_len] != '\n')
 			return error("bad parents in commit %s", oid_to_hex(&item->object.oid));
 		bufptr += parent_entry_len + 1;
