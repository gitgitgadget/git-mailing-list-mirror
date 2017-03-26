Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C1720958
	for <e@80x24.org>; Sun, 26 Mar 2017 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdCZQCG (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 12:02:06 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58066 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751394AbdCZQCA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Mar 2017 12:02:00 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EC47D280B6;
        Sun, 26 Mar 2017 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490544115;
        bh=OCllgegdouh7FKaCVzlsSX0nCekoNSXMCnNJ5OfZMc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrS0bMdQdRaufEpuX4jNH+0H2St2WoLkcBltgdN48z+9TXgBIb4i99uLPd2BTUdbu
         Ip+MlqaLGyzdF0f0r0it21wnVcVhbBMy7dHboE/kBQSP2z42b9z6do7PoOtxtiZ5Yp
         NMlhIC/dkaYQjxDjqUP+uJLjzlZO4kOrPPBpkOGEJozt9OYuY0TGp5m70NvDYxqiqf
         ZHWQ1oL1y6gV/TqMUbZF3fiFrjfyeSBJrcHGJLCj4xNmAHv67aQLfrCIlPIuTvS20M
         iC1oKkVEWIPBCynUBNrNVXccJaQNnQZOEG5ly5n9hF6dEiQRUNth3wjCCLdLQGT3G2
         rc3oi7FQn4/vJCOpiq5fpp8M8bTjMXwasTq13h2dqalw31GWR/vBF9M4bzAoCUQ48W
         FCrbVf/nSNOfDVe/6BU43o/jo/7mTF0t3meOEKFSFRTOZ2sVvUZZk6gH8iSZOHNaZJ
         tJfYGAbJT1xFlX48BGgYJ1IdmC07FGAOWzyJ3NVS4bjjYQvhc6V
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/21] parse-options-cb: convert sha1_array_append caller to struct object_id
Date:   Sun, 26 Mar 2017 16:01:31 +0000
Message-Id: <20170326160143.769630-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170326160143.769630-1-sandals@crustytoothpaste.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 parse-options-cb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index b7d8f7dcb2..40ece4d8c2 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -96,7 +96,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 
 int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	if (unset) {
 		sha1_array_clear(opt->value);
@@ -104,9 +104,9 @@ int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 	}
 	if (!arg)
 		return -1;
-	if (get_sha1(arg, sha1))
+	if (get_oid(arg, &oid))
 		return error(_("malformed object name '%s'"), arg);
-	sha1_array_append(opt->value, sha1);
+	sha1_array_append(opt->value, oid.hash);
 	return 0;
 }
 
