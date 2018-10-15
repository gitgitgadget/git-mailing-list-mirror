Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633211F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeJOHpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:45:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbeJOHpA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 03:45:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DDEF161B79;
        Mon, 15 Oct 2018 00:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539561733;
        bh=n4v8FhjlnL5JLIBi738520meHZ+42FjmztlUmUqFXZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jiO/SuJ2G9xQvAkOjEOMMb05CqJTiQ5ofYGwir21FDV3s6gcqt+Iw4DeBOz0Zg7Je
         nTiphKaLIVlwv+UqYzylvITQzwAe6U6WnBqz6G4DZt//mnEg5w1/zbNjjbaV8HgVkL
         cWuNnX/raCMXoUzhX0KUjyPybiffx4E5kXQ4id3QiVBjHoSvoIVC+d0u4NIRbLbKYe
         B0zps4IR2nANtBtgQL+TYrsLy7girYfWKh0W6bvTXQOE7ow30axv1WNt/XlX9WpGix
         g5RviAysH5dqnCm1vdhsBmjRSm3t5RUQ7pwTlchHTqKjtK2JdnV5zGt8uMypiz4gr3
         JnIWtN3vuVspSHMymB+rgihu/jWz7CUJtremLz6diLOhdLNtNW4TMavKfE4zZYu0Q3
         rXxnKXTCCrTkHOJdmJgK+5mvMrHIQo8GRRniC0/pK93qP9t212Xo7f1P/Uhw5ZdSs0
         61gXfk7XxJz2P05sJVSN/zWy7H/zISNw/A5Vlkk1oTvF0yqpKl/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 03/15] builtin/repack: replace hard-coded constants
Date:   Mon, 15 Oct 2018 00:01:50 +0000
Message-Id: <20181015000202.951965-4-sandals@crustytoothpaste.net>
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

Note that while the error messages here are not translated, the end user
should never see them.  We invoke git pack-objects shortly before both
invocations, so we can be fairly certain that the data we're receiving
is in fact valid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/repack.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c6a7943d5c..0223f2880c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -235,8 +235,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		char *promisor_name;
 		int fd;
-		if (line.len != 40)
-			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		if (line.len != the_hash_algo->hexsz)
+			die("repack: Expecting full hex object ID lines only from pack-objects.");
 		string_list_append(names, line.buf);
 
 		/*
@@ -407,8 +407,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
-		if (line.len != 40)
-			die("repack: Expecting 40 character sha1 lines only from pack-objects.");
+		if (line.len != the_hash_algo->hexsz)
+			die("repack: Expecting full hex object ID lines only from pack-objects.");
 		string_list_append(&names, line.buf);
 	}
 	fclose(out);
@@ -535,14 +535,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	reprepare_packed_git(the_repository);
 
 	if (delete_redundant) {
+		const int hexsz = the_hash_algo->hexsz;
 		int opts = 0;
 		string_list_sort(&names);
 		for_each_string_list_item(item, &existing_packs) {
 			char *sha1;
 			size_t len = strlen(item->string);
-			if (len < 40)
+			if (len < hexsz)
 				continue;
-			sha1 = item->string + len - 40;
+			sha1 = item->string + len - hexsz;
 			if (!string_list_has_string(&names, sha1))
 				remove_redundant_pack(packdir, item->string);
 		}
