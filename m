Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244831F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfBLBXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727200AbfBLBXf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:35 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CED6B60E58;
        Tue, 12 Feb 2019 01:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934614;
        bh=bmlpTh1QMtR816yG8bEjpctnZspsdFW0f7T20uzxib0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mpgHnfXpp9SywvBb3HbxnjX+40AX1bnuu3tX4CX5DkG1NPUXnwrssJ8VOBx1YXN8c
         WV2L0i1dA+6aPhi1tXY2F0qbKedG8KZ+pFeqy6OPqOY3kjknF0dgGDFp8RSHsFsjhR
         7x9zIHFIlx5VTb/aslsJEuw6jOrSAD/lPMoV1jb7S7P+5AWcuxx6Qjew6CngGoJlEB
         dTcmWntarLL9CtAI29ZtG1MqLErt8RFrb+S5aPuBsfzyAm53e/K7yF1Cw7qBzoWZra
         GPqSc60S6NjYOgQQ3gRWy2JXC6QcNnqvuuxM4mXD2TSQ3RxNC97Ld5cR8JNFqLZ04J
         j+8E/XWFBjzEnk45c3hftJuKGI+rlRqsiCNzACXhXLK5i3C5d3EzhQjUe6Il+/uqyB
         GkiACgJqx0QFf87lkNghAKalWSkqIbuJBa6SpmsOMiAuOmQKlrEJju7Dq6qZBjDsAw
         D5LEccaGe/RHnHRwlBaz0kPVtCp85kRdvaXy47No9mTV0zh53f0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 19/31] http-walker: replace sha1_to_hex
Date:   Tue, 12 Feb 2019 01:22:44 +0000
Message-Id: <20190212012256.1005924-20-sandals@crustytoothpaste.net>
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

Since sha1_to_hex is limited to SHA-1, replace the uses of it in this
file with hasH_to_hex.  Rename several variables accordingly to reflect
that they are no longer limited to SHA-1.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-walker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 8063896cf6..e11670eee2 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -434,9 +434,9 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (walker->get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->hash));
+			hash_to_hex(target->hash));
 		fprintf(stderr, " which contains %s\n",
-			sha1_to_hex(sha1));
+			hash_to_hex(sha1));
 	}
 
 	preq = new_http_pack_request(target, repo->base);
@@ -473,9 +473,9 @@ static void abort_object_request(struct object_request *obj_req)
 	release_object_request(obj_req);
 }
 
-static int fetch_object(struct walker *walker, unsigned char *sha1)
+static int fetch_object(struct walker *walker, unsigned char *hash)
 {
-	char *hex = sha1_to_hex(sha1);
+	char *hex = hash_to_hex(hash);
 	int ret = 0;
 	struct object_request *obj_req = NULL;
 	struct http_object_request *req;
@@ -483,7 +483,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 
 	list_for_each(pos, head) {
 		obj_req = list_entry(pos, struct object_request, node);
-		if (hasheq(obj_req->oid.hash, sha1))
+		if (hasheq(obj_req->oid.hash, hash))
 			break;
 	}
 	if (obj_req == NULL)
@@ -557,20 +557,20 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	return ret;
 }
 
-static int fetch(struct walker *walker, unsigned char *sha1)
+static int fetch(struct walker *walker, unsigned char *hash)
 {
 	struct walker_data *data = walker->data;
 	struct alt_base *altbase = data->alt;
 
-	if (!fetch_object(walker, sha1))
+	if (!fetch_object(walker, hash))
 		return 0;
 	while (altbase) {
-		if (!http_fetch_pack(walker, altbase, sha1))
+		if (!http_fetch_pack(walker, altbase, hash))
 			return 0;
 		fetch_alternates(walker, data->alt->base);
 		altbase = altbase->next;
 	}
-	return error("Unable to find %s under %s", sha1_to_hex(sha1),
+	return error("Unable to find %s under %s", hash_to_hex(hash),
 		     data->alt->base);
 }
 
