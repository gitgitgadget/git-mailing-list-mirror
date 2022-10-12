Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89194C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 15:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJLPHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJLPHR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 11:07:17 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48370AA349
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:07:16 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 9104F3717;
        Wed, 12 Oct 2022 17:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665587234;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=From:Cc:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        l=2104; bh=zFSiyIbcDcXmTd7gRX3PMXjsue6Q9BMBGJs8RLMFNXU=;
        b=haFe9MGV43T3JzkbZ4lPzO4fae9b908s7jK1B1y5QC4NwDrhe7ak2MFaih1sK1Ln
        R1wV7x2RRX9FdmsvQWUBNMV/0zqy4DLIqzuF5hY75LD8Y5glGufXJJzCLD3PtyaxB6c
        SEP7i5o7yq4/f/vn6uZ/BF9Sz10V4uyHvT1yU/ftCKc6SfVbSbmdQi9KOkh+m13q4lM
        5az81URNuCRIr+BL6Szls32pQsfbgqcQQ6X6uYGI9YkE6+TvVmREoZpADGfJNLypqpG
        xtSO1kpHu48xWrw7JddTTehIZfeXtVa6OsW3CnO3NU/XBPB6n+U9AG6QOo8Y6CeIwl9
        SjeRpUnKiA==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 12 Oct 2022 17:06:46 +0200 (CEST)
From:   sndanailov@wired4ever.net
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, aaron@schrab.com,
        philipoakley@iee.email, Sotir Danailov <sndanailov@wired4ever.net>
Subject: [PATCH v3] docs: git-send-email: difference between ssl and tls smtp-encryption
Date:   Wed, 12 Oct 2022 17:06:19 +0200
Message-Id: <20221012150619.12877-1-sndanailov@wired4ever.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sotir Danailov <sndanailov@wired4ever.net>

New explanation for the difference between these values.
It's hard to understand what they do based only on the names.
New description of used default ports.

Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
---
Changes since v1: Expanded explanation, covering more terms.
Link to v1: https://public-inbox.org/git/20221010172859.13832-1-sndanailov@wired4ever.net/

Changes since v2: Added a description of what the option actually does.
Link to v2: https://public-inbox.org/git/20221011164927.1516-1-sndanailov@wired4ever.net/

 Documentation/git-send-email.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3290043053..765b2df853 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -178,9 +178,18 @@ Sending
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
-	`sendemail.smtpEncryption`.
+	Specify in what way encrypting begins for the SMTP connection.
+	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
+	(unencrypted) SMTP, which defaults to port 25.
+	Despite the names, both values will use the same newer version of TLS,
+	but for historic reasons have these names. 'ssl' refers to "implicit"
+	encryption (sometimes called SMTPS), that uses port 465 by default.
+	'tls' refers to "explicit" encryption (often known as STARTTLS),
+	that uses port 25 by default. Other ports might be used by the SMTP
+	server, which are not the default. Commonly found alternative port for
+	'tls' and unencrypted is 587. You need to check your provider's
+	documentation or your server configuration to make sure
+	for your own case. Default is the value of `sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
-- 
2.37.3

