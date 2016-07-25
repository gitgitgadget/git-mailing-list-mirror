Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF8E203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 09:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbcGYJdZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 05:33:25 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52522 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863AbcGYJdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 05:33:14 -0400
Received: (qmail 9705 invoked from network); 25 Jul 2016 09:33:12 -0000
Received: (qmail 14752 invoked from network); 25 Jul 2016 09:33:11 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 25 Jul 2016 09:33:09 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t5510: become resilient to GETTEXT_POISON
Date:	Mon, 25 Jul 2016 09:31:08 +0000
Message-Id: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Replace gettext poison text with appropriate values to be able to cut
the right output of git fetch command for comparison.

The first gettext poison falls from the previous line into the next
because the poison does not add a newline, so we must replace it with
nothing.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t5510-fetch.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6bd4853..b261223 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -694,7 +694,10 @@ test_expect_success 'fetch aligned output' '
 	(
 		cd full-output &&
 		git -c fetch.output=full fetch origin 2>&1 | \
-			grep -e "->" | cut -c 22- >../actual
+			grep -e "->" | \
+			sed -e "/master/ s/# GETTEXT POISON #//" \
+			    -e "/tag/ s/# GETTEXT POISON #/[new tag]        /" | \
+			cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
 	master               -> origin/master
@@ -709,7 +712,10 @@ test_expect_success 'fetch compact output' '
 	(
 		cd compact &&
 		git -c fetch.output=compact fetch origin 2>&1 | \
-			grep -e "->" | cut -c 22- >../actual
+			grep -e "->" | \
+			sed -e "/master/ s/# GETTEXT POISON #//" \
+			    -e "/extraa/ s/# GETTEXT POISON #/[new tag]        /" | \
+			cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
 	master     -> origin/*
-- 
2.7.4

