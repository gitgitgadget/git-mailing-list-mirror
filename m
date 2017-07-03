Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEA5201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbdGCS4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53012 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752378AbdGCSzz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70BDA280B7;
        Mon,  3 Jul 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108148;
        bh=QRUIsMZjOxNLcaLscdqwh7hw5ELC7z7vQ+gs7+90ZHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtvXQ16mE6W8FL/mnc9KufKPHfMNgG7blmt2G0LzNoDwPpKB6o9YpTnAbCi8NV8p1
         tT7rSHRvdwJNVtjsXQ9kU1frV+QlTHgzHNF9Y7nXGXzokgwLdF0U3xhZ9V0/8qwCmx
         w9C6JF4q0sHCOKJCxpFGUT0oNvpRFykSBZCDF9E9QbntJiMgnIixSynxpZi/5qF0nP
         uE719mS6qolmndY+N8c6LSjWAUm6HZq4xREbCLs9MZe+j9peNnXgzA0/zVAaKw6JDE
         vnEP2mVvCXtlQ2BQY8VlQc9Tk711uVVjlFFuLieA2gXo3BQn0ZkMMsXqaAOBRFhwwa
         Sqb4F29EoT/GNjiAj3dIhfR3se4n7yJ1FlazSONzmHFggCmVKA/+t9q0SB83x7wsGd
         wvkXCnvnfSNYVj/W3J61PLApQgm8ec1cIUrUcPBPByXkxUDdxsaPipc6JfDjg5yN2R
         L15pDY7Dev7p0uMhycfRK9BXw098lyb6leK5xJvvLPeOUrA90vM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 10/12] Convert remaining callers of get_sha1 to get_oid.
Date:   Mon,  3 Jul 2017 18:55:31 +0000
Message-Id: <20170703185533.51530-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 4 ++--
 mailmap.c              | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 71c0c768d..1efa48fec 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -919,9 +919,9 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
  */
 static int head_has_history(void)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
-	return !get_sha1("HEAD", sha1);
+	return !get_oid("HEAD", &oid);
 }
 
 static const char *push_to_deploy(unsigned char *sha1,
diff --git a/mailmap.c b/mailmap.c
index c1a79c100..cb921b4db 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -214,17 +214,17 @@ static int read_mailmap_blob(struct string_list *map,
 			     const char *name,
 			     char **repo_abbrev)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	char *buf;
 	unsigned long size;
 	enum object_type type;
 
 	if (!name)
 		return 0;
-	if (get_sha1(name, sha1) < 0)
+	if (get_oid(name, &oid) < 0)
 		return 0;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid.hash, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB)
