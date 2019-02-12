Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68551F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBLBXZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34260 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbfBLBXY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 579C960E52;
        Tue, 12 Feb 2019 01:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934602;
        bh=OWpABVvwG3CC3PnX6hGwinD43iXSki/R5NxyAxbG6zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=V94OFbMoe4x8hSu+7kEEYzOIYY7WLibNBQBR6U8TFwAadCQhD++goyPnhFu84khrB
         KbTu0ADkLtBuel3qqmWEiEq9NUzIBqOSovjM0lSSUYIpUQAX5nAttM+Dhx9Y7I2YFz
         sCoV640Wss5RKVC6o73pf3zeyxKvJ2bJ2qL4HD6YIcf3iPHDMqOVsdbptKeqZts9wm
         aJJKBzjJFMo4jjq+IeHmO0XttFEvOu+bmy8Q8Vj1S9SYBxd3lIQWb5zraW3eXY7FCU
         RJSnozABfBPh8JWsVOfiaz/TEa1H2S4BF0bBQebbRkn5MtoT0fhezivNWZZbTVzt7k
         782XH5eXs31LXOWhKJEtlL2/v7NrKGxCiYf8HCqRsaOx+l8SjNxo/0ymcHbNuXQBnl
         ES+TFNiLf5M+zuVXkB2cZcBzbfG03fD9mPfRQ2/RF7t9Mjy1o+S+EYkc6M5eil/6Lu
         nzb8wCHnVFNdOqjnLAZn+QLIRdvDyHoAihAZY8G2ShhM5clKhTT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 09/31] notes: replace sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:34 +0000
Message-Id: <20190212012256.1005924-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the uses of sha1_to_hex in this function with hash_to_hex to
allow the use of SHA-256 as well.  Rename some variables since this code
is no longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index 96647f1d2d..a9a3ddd6d7 100644
--- a/notes.c
+++ b/notes.c
@@ -532,19 +532,19 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 /* hex oid + one slash between each pair + NUL */
 #define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
 
-static void construct_path_with_fanout(const unsigned char *sha1,
+static void construct_path_with_fanout(const unsigned char *hash,
 		unsigned char fanout, char *path)
 {
 	unsigned int i = 0, j = 0;
-	const char *hex_sha1 = sha1_to_hex(sha1);
+	const char *hex_hash = hash_to_hex(hash);
 	assert(fanout < the_hash_algo->rawsz);
 	while (fanout) {
-		path[i++] = hex_sha1[j++];
-		path[i++] = hex_sha1[j++];
+		path[i++] = hex_hash[j++];
+		path[i++] = hex_hash[j++];
 		path[i++] = '/';
 		fanout--;
 	}
-	xsnprintf(path + i, FANOUT_PATH_MAX - i, "%s", hex_sha1 + j);
+	xsnprintf(path + i, FANOUT_PATH_MAX - i, "%s", hex_hash + j);
 }
 
 static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
@@ -1167,7 +1167,7 @@ void prune_notes(struct notes_tree *t, int flags)
 
 	while (l) {
 		if (flags & NOTES_PRUNE_VERBOSE)
-			printf("%s\n", sha1_to_hex(l->sha1));
+			printf("%s\n", hash_to_hex(l->sha1));
 		if (!(flags & NOTES_PRUNE_DRYRUN))
 			remove_note(t, l->sha1);
 		l = l->next;
