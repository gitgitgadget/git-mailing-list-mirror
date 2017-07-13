Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794732027C
	for <e@80x24.org>; Thu, 13 Jul 2017 23:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbdGMXtm (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 19:49:42 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59728 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752860AbdGMXth (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jul 2017 19:49:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 53BD6280B6;
        Thu, 13 Jul 2017 23:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499989776;
        bh=HY9D2yFEzYoWKDLIJVcYodGLfH2EoURUesSxqioiCdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmoNWoCKlq6n961JkyRQ3CnyUC7U8b/IKX9KVfX+nBKbE3oKoBGEejGkcUKVgTdiY
         mKigNkHwPXKreJ5Wd7E7XkpVF9DFFTuXKBR05ttj9WKPanP3xXZBC76dWOpRWp57n7
         k3oB3u10mP5K5JAR2ieXnbZw2qgpeNEa71dSJhsthdNSGL2Nqgo+ZXx2tIePxwxeSJ
         KyqOMo/e182Bo0ZjhYn3+q5BggOhWnC9bGgAWT4XpzoHTmxGwyFtzG6DrilgM8+5K2
         k2QDD7nOf1/GMAu5Xvbr47wXFB658HtLTIc873Q1PAhsw7si7xfFe6fHxkB5abw5m7
         YRMhdmQt/BQ2oZGA7bNFwG53RpJX67TVgUom1Hz9HgXgRxB78oPtfPt5xOhICDQcLY
         UlsHiB2OUhndSfFazUCNo62ua1cqLjsMRR0R/qFPhCH50QydTpUwYuFTBTx43eVNlb
         bjtb9y/fkbX7i9Qt/zZkbN0s/X+S4DpfXO2fdY74/mK1OEVCjNy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 10/13] Convert remaining callers of get_sha1 to get_oid.
Date:   Thu, 13 Jul 2017 23:49:27 +0000
Message-Id: <20170713234930.949612-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.932.g7449e964c
In-Reply-To: <20170713234930.949612-1-sandals@crustytoothpaste.net>
References: <20170713234930.949612-1-sandals@crustytoothpaste.net>
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
index 71c0c768db..1efa48fec4 100644
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
index c1a79c100c..cb921b4db6 100644
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
