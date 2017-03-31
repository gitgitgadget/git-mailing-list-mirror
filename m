Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0872220969
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935081AbdCaBkM (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:12 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59226 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935057AbdCaBkK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:10 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0C598280B5;
        Fri, 31 Mar 2017 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924409;
        bh=OCllgegdouh7FKaCVzlsSX0nCekoNSXMCnNJ5OfZMc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lhtDFoBfMKIxQrF0q10czSfYkO7lypOfrTWWhxeUT0I+yOkbbf3BQTrG/X7td4pgY
         dUYthzsG+4eEn6ALUTx0jHIP6BCBFr35jFBukLr8RiT1cFncrknqx/2flCi7KRGHNl
         7Ivs3EJPBhLlI2yL/bJ12c9Le0c1xs1UmOd5/0yPV9OHPSbAVDWENr4hoXCO7lFWT7
         akzU2TGynsPK0FTRwETJgRb8+T6ZRyzM46SromX8bkZ+28c1anwox1j4a2uD9sgE4j
         rEIJLjBW/LJ4yRw5EJ0zxTcF0gr/A4Eer2F7RictAIIQ+UDVx13ZUmJELKobgK8GwO
         Fw8k9jmss3pt693WAoEBPQda2qBSJmanTxa2PkFL0Jtu/RAmatBXlW3LUxeEXqenpL
         uCHAjMVO8qpYikHOL4f7ZCknI2sAdzXQRnknt6296lSMJ5c1xOWs1QcVF5vvbKCL5I
         KhyBXR1Lmd9FHL8H9VR7AQv9lkCN/diIUaZYpGYNZEmArF5xF8L
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/20] parse-options-cb: convert sha1_array_append caller to struct object_id
Date:   Fri, 31 Mar 2017 01:39:49 +0000
Message-Id: <20170331014001.953484-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
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
 
