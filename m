Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CEB1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfHRUF7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbfHRUFz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F6D36077F;
        Sun, 18 Aug 2019 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158753;
        bh=7PrtDxSwYxieVOiScyuB0DhFy4WJXixaEjwM8oLJjec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cgsbZQZtXKqu9xdhrdfSer9WOdp3e+Bh9C2Dgg7AzT4CmTFFhxX5KYGrkxs1/FoDi
         MsKDqkWGEwoOMviEsTxQAl6J7ppfAVAp846mCHrJad/Y/2/cohNeltBkv6eoZ5lxfd
         +LrfDKzp7wnMkcBNoTEKCg8IhR3nMTz3jDfm4WLgJDUg1+Q+sU8MY4KrpPJ4pUdaru
         vz/B7N5aIPE1xUL8lXzALQBlPXawycxilPHKEYFiQIsYQVM+fHqZq8n1sZIZSXzsG5
         8mNoKPHuYoSCZraZ0KbBzPiDN8pZm52LgKIuRwJi9oCJgR0woradtSxbt6uS5DhCEw
         NircOOWyWBufvfPoK/3zmK4M9245PPZ34KGHdmHAsj3wdikPYp3kEUj8XQUJ++k2ZL
         GO0vdyQC0wT2wTt8wML6q4TP2S+VVxJex8pEQQPWZXx9cTnJLtM8lr5kEWxTWtZ2Jg
         fJX/ALd+drevJg1V3NM8LhUHMA4w/dagfXtSpWA6DIOJU/PAj+5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 24/26] rerere: replace sha1_to_hex
Date:   Sun, 18 Aug 2019 20:04:25 +0000
Message-Id: <20190818200427.870753-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the uses of sha1_to_hex in this function with hash_to_hex to
allow the use of SHA-256 as well.  Rename a variable since it is no
longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 rerere.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index 17abb47321..3e51fdfe58 100644
--- a/rerere.c
+++ b/rerere.c
@@ -52,7 +52,7 @@ static void free_rerere_id(struct string_list_item *item)
 
 static const char *rerere_id_hex(const struct rerere_id *id)
 {
-	return sha1_to_hex(id->collection->hash);
+	return hash_to_hex(id->collection->hash);
 }
 
 static void fit_variant(struct rerere_dir *rr_dir, int variant)
@@ -115,7 +115,7 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 static void scan_rerere_dir(struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
-	DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->hash)));
+	DIR *dir = opendir(git_path("rr-cache/%s", hash_to_hex(rr_dir->hash)));
 
 	if (!dir)
 		return;
@@ -186,9 +186,9 @@ static struct rerere_id *new_rerere_id_hex(char *hex)
 	return id;
 }
 
-static struct rerere_id *new_rerere_id(unsigned char *sha1)
+static struct rerere_id *new_rerere_id(unsigned char *hash)
 {
-	return new_rerere_id_hex(sha1_to_hex(sha1));
+	return new_rerere_id_hex(hash_to_hex(hash));
 }
 
 /*
