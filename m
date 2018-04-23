Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19BA1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeDWXkP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932683AbeDWXkJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D45F7609A2;
        Mon, 23 Apr 2018 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526808;
        bh=zFSo3Gze0WFLGQmSIsWmy5ajHad+OHt0ymjhXdiW7Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=AXF7/ROKzjup6v8EDfvrc/D1HtqBwxhwSw1kR4E9Qds6JoaZttnpD6aq4bWwiiqAi
         vLny7LqM6GgQ6tesMkoM3yXeHjUMOUm9FTgDqVRDIqupio89sC9WQOX2OKgpAe0Mn7
         yJCECcOQaOyKlcnaqDHU5hJVjDyBfN4vaD2PYat1RAqYhWZaiqi/1IRUzakaf4F4E0
         hEjxBDAfOI+Ih0rkZdahXRhQpdUFCcFMYbnVn9YBnMxPXlYUq7k64HKM5dqI+9EBp2
         HoLy7jMgycXnLJnFcebrEvTL+nYFakf8tRqnd5pbYMxkAaP7ldI7FhyqBKABDO7rAS
         RqxLJBatACQUxUtHLWZlqp2h/lYSzxa3H28eCk2r7R7tkFyjuPDleHrbyNwoXj2i56
         skUOXIYbCmFEITg3D52hXkKkpc8BDw7a9gvgVVyngxGWUr2zHqAnhOfi3v5XLWz7VR
         oP+3Xfl09q5TMygq4eG1XlF4sm/KFF6PI4PhX/KqWAj3kNlVIzJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/41] packfile: remove unused member from struct pack_entry
Date:   Mon, 23 Apr 2018 23:39:14 +0000
Message-Id: <20180423233951.276447-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sha1 member in struct pack_entry is unused except for one instance
in which we store a value in it.  Since nobody ever reads this value,
don't bother to compute it and remove the member from struct pack_entry.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h    | 1 -
 packfile.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index 11a989319d..dd1a9c6094 100644
--- a/cache.h
+++ b/cache.h
@@ -1572,7 +1572,6 @@ struct pack_window {
 
 struct pack_entry {
 	off_t offset;
-	unsigned char sha1[20];
 	struct packed_git *p;
 };
 
diff --git a/packfile.c b/packfile.c
index 0bc67d0e00..5c219d0229 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1833,7 +1833,6 @@ static int fill_pack_entry(const unsigned char *sha1,
 		return 0;
 	e->offset = offset;
 	e->p = p;
-	hashcpy(e->sha1, sha1);
 	return 1;
 }
 
