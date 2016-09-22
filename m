Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191821F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034346AbcIVSxz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:55 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35581 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939361AbcIVSxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:25 -0400
Received: by mail-qk0-f196.google.com with SMTP id n185so1736653qke.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EpGQ1aRB9d+rJ21jEtk5MH6rnGSko9ZJ80Ps2Nq4arQ=;
        b=LtWC7wLpe69gWOyqKR/4DILJ34oBawgwLhkRZNeaTc9N7zsUrtT1C0/2GthNZTolIU
         1YfAZ9d27JtT5406IUbkM8UHEWe+qdCL66IQKudhE+vsl3uiOdW0Mdrq7P6Xzi7tImox
         PXKAhaWwqVKbv9gXUbssKzyAc1nwGTkuIj4HjnSOJf0fLwN1j59VeAU8tY6f7r8a19if
         us4ACIDCIgvtR3KlT12THOS25WFJb3V4aY0sjY/sLqJKZ4jxrRmxmQJ96s+2P2eJ0mRf
         7DF2N9zaw3evHru1xCYgM0usa0YmGPfnkS4821/pGdd1HRW9dwVetMbea09WrebHNoqE
         Pasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EpGQ1aRB9d+rJ21jEtk5MH6rnGSko9ZJ80Ps2Nq4arQ=;
        b=GNKnDPjhDZ0IFATFDiJeYm3JCzVrX7v5McOZrJRaCcc0nZgpaxubbv5rheumxk+yGr
         +t1X7hr5sdJ6twBPvcVeWC/nPRNZrpmStcZBITX7DiRINsEJ02bfB0P6iTBqXWJ1RI2q
         Im4rMdIv6O+CQNPonSfHiWJdsi0gRMl0Mu8Asxn9zMDrQhS/QP8uTpjsNXxoEwulxQuy
         5nBviYVftWW3vUCH9yeeIM0SUN5dXd5PH3qkyHUbWumoNhsHUbZ+nEg4r+ACtxxcPSJO
         Bu//Qb0j0o6QeS1DFx/Fism5MZSon7Lt36X79fK2ztK/3x4TApnCQkXnfZJDDj0/pQV2
         uRxA==
X-Gm-Message-State: AA6/9Rk48W7WY4nc+XRKzT0y1q/bocWaZ+NjbvlyRN99civcu45a8Z8SJDKS6FAS7Uyl8acY
X-Received: by 10.55.133.67 with SMTP id h64mr3623961qkd.293.1474570404491;
        Thu, 22 Sep 2016 11:53:24 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:24 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: [PATCH 2/6] gpg-interface: add GPG_VERIFY_QUIET flag
Date:   Thu, 22 Sep 2016 14:53:13 -0400
Message-Id: <20160922185317.349-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Functions that print git object information may require that the
gpg-interface functions be silent. Add a GPG_VERIFY_QUIET to prevent
functions such as `print_signature_buffer` from printing any output and
only return whether signature verification passed or not.

Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
---
 gpg-interface.c | 3 +++
 gpg-interface.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/gpg-interface.c b/gpg-interface.c
index 8672eda..b82bc50 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -88,6 +88,9 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 
 void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 {
+	if (flags & GPG_VERIFY_QUIET)
+		return;
+
 	const char *output = flags & GPG_VERIFY_RAW ?
 		sigc->gpg_status : sigc->gpg_output;
 
diff --git a/gpg-interface.h b/gpg-interface.h
index ea68885..85dc982 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,6 +3,7 @@
 
 #define GPG_VERIFY_VERBOSE	1
 #define GPG_VERIFY_RAW		2
+#define GPG_VERIFY_QUIET	4
 
 struct signature_check {
 	char *payload;
-- 
2.10.0

