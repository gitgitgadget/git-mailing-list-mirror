Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7397921847
	for <e@80x24.org>; Wed,  2 May 2018 00:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeEBA1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:27:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37842 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753504AbeEBA05 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 53CF9609A2;
        Wed,  2 May 2018 00:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220816;
        bh=PH/8/IdUjdA0S3YaPjbU9cRy94U1DG9eG5oarZsEKHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=I0urfOdl9peM+RGigk1rD8CrkPE/MfuLsEq6ZqsRQZe6KheSQsrfySJPGC5UpMcVh
         zOLi840ioxJX2y9dV1V0nHxdnixz4qq4nPGX6zlhEJwMRoEqiIZT3ApTh1MmYsf8wG
         M5zVApQK1tXmDY7zd30zFz2/+s3flPxEkp2eraR51p4STuH+/WNFLQIS+NmRXS6S30
         FOyO8MrxeAfKjiCpvbL7tIh3mpXb/jB3njVf78M3UbZEY2rimzuwkFkR88byGP83Qc
         c8XICWOvFOvPo4J6lTQeyhMyTzK+ywGNIhHkGQma3Um+89saDpHcjmiFzwotA2B0dL
         KmqAb1SW0sMXvSb4WECuXkYAhwo9/wKHaWu8iNIfGO/fMGYirKbLtL/uOl5t7nkmeb
         Q6fI95dVeWehkckhTsaxXfUe+K9/s2ESFyYQJvFV/bNjLxBdQJ8UsuiBjzRJm7tAtY
         SVA9v7UDsy8vzGJq5F+iNnh4dSndBXoGuEIa78cfH5/FCEZnBoo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 34/42] builtin/reset: convert use of EMPTY_TREE_SHA1_BIN
Date:   Wed,  2 May 2018 00:26:02 +0000
Message-Id: <20180502002610.915892-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the last use of EMPTY_TREE_SHA1_BIN to use a direct copy from
the_hash_algo->empty_tree to avoid a dependency on a given hash
algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 7f1c3f02a3..a862c70fab 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -314,7 +314,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
-		hashcpy(oid.hash, EMPTY_TREE_SHA1_BIN);
+		oidcpy(&oid, the_hash_algo->empty_tree);
 	} else if (!pathspec.nr) {
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
