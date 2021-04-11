Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDEC43461
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5C061206
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhDKMzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhDKMzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 08:55:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61790C06138B
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 05:54:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618145685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beCi/zvvuOrFFvxVL2z99zA5Y8Tz8YSZk7yX6+QaUVA=;
        b=rZjXkrTt4b8O2XNNG7Dz8XtPR0y8zQdHuu82Z7vUCf8ti54Z8tBesSiYwhslEc4lQJlQy9
        yoPpDgbWnkfFwb2eyl092RmcuuC8RBoLOXEjQIKa03sYK4AoNdtV0YuHKA155N54VHKVIC
        yegY4553+hYDquM/y3xpS6eSB1e/JsbwDuaDJZkYKchJ7iHnTIJfAl653jW50AeLDQoIEE
        nDGwB9aXxmgSTIb4NJMM+I/D1BO2ebuPORBu0bDxm5n5tOlSXu4Ddkr3mUrP4MyrZg6F2C
        9enyDVI2HMv0VAeVimVB3qU7qqAPvY6OTjeRAApMIwAWuAztO+hHQlC1qguLnw==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2 3/3] git-send-email: rename 'tls' to 'starttls'
Date:   Sun, 11 Apr 2021 08:54:31 -0400
Message-Id: <20210411125431.28971-4-sir@cmpwn.com>
In-Reply-To: <20210411125431.28971-1-sir@cmpwn.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name 'tls' is misleading. The 'ssl' option enables a generic
"modern" encryption stack which might very well use TLS; but the 'tls'
option enables STARTTLS support, which works entirely differently.

This renames the canonical option to 'starttls', to make this
distinction more obvious, and adds 'tls' as an alias for starttls, to
avoid breaking config files.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 Documentation/git-send-email.txt |  6 ++++--
 git-send-email.perl              | 10 +++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 520b355e50..f8cea9e1f9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -168,12 +168,14 @@ Sending
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables
-	generic SSL/TLS support and is typically used on port 465.  'tls'
+	Specify the encryption to use, either 'ssl' or 'starttls'. 'ssl' enables
+	generic SSL/TLS support and is typically used on port 465.  'starttls'
 	enables in-band STARTTLS support and is typically used on port 25 or
 	587.  Use whichever option is recommended by your mail provider.  Leave
 	empty to disable encryption and use plain SMTP.  Default is the value of
 	`sendemail.smtpEncryption`.
++
+'tls' is an alias for 'starttls' for legacy reasons.
 
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
diff --git a/git-send-email.perl b/git-send-email.perl
index bda5211f0d..3f125bc2b8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -495,8 +495,12 @@ sub read_config {
 
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
-if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "tls") {
-	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls', or nothing.\n");
+if ($smtp_encryption eq "tls") {
+	# "tls" is an alias for starttls for legacy reasons
+	$smtp_encryption = "starttls";
+};
+if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "starttls") {
+	die __("Invalid smtp_encryption configuration: expected 'ssl', 'starttls', or nothing.\n");
 }
 
 # Set CC suppressions
@@ -1541,7 +1545,7 @@ sub send_message {
 						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp,
 						 Port => $smtp_server_port);
-			if ($smtp_encryption eq 'tls' && $smtp) {
+			if ($smtp_encryption eq 'starttls' && $smtp) {
 				if ($use_net_smtp_ssl) {
 					$smtp->command('STARTTLS');
 					$smtp->response();
-- 
2.31.1

