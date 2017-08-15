Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5946F208C4
	for <e@80x24.org>; Tue, 15 Aug 2017 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbdHORga (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:36:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36932 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbdHORg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:36:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so2160709wmt.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=512/gDFMvAnlBsOiWWS22jV7sG050vKVbF89gWpEz7M=;
        b=FQK0x7AsHbvjQsnTx2fUKhR9j5KmXEkQcfJ/EHX9QeMT9IpQ7NZHlwinVw3rhd3ewY
         J/5IrGBYE1zIT/XnmrTUVQUAfIiitYkz2TCk01QZ/b9HE4LIplbkNfZAcmIqxws7O79t
         6f6H+8kpy3en68zIxdCTsenyZa75JKDAVwNQ8u7KJo3HpWyHM2XZV74YXsWuWQaCWj23
         phpPj9chn4FG/TPsuQaRlrlyzopuXpbzyCWL4vznlO9NKx+ysnDi+EmR/Zbm/LJNV/eG
         YHdpcD4UclLDNkUIDghPn+04BAzDX37oLdnhmGKLS7ygllXwxZMvpG7+OlAxWuHB6oPj
         jRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=512/gDFMvAnlBsOiWWS22jV7sG050vKVbF89gWpEz7M=;
        b=dcsW+K1KloLD18jq4Na6aLThbK77jCHgdG2G1IKsFUxdA0HkSIH4MtRsKVwVuXAgOv
         gcg29SRBFabTq/X6owDhO2vpwN1YI4CiQrAVBPIsBcSu3BB4R0cKE2AIKmEUYl7PjvA8
         iYpqyavZ1W57W/br/FTnAi/8aCnFzVz3koAnpEqwSMBVRtgfWJd3XHcnwD/me4Vku06d
         Z+7Ycki5C1rBne+/DTAqofmzQAvMCafhT2iYpQCFLHEg+WQxdNIOV77nrlTbhDY0Gwj0
         H/zZJrRLO3G0ocoPYyz1+6k95oxRSQRZStRXKwld5leCoMEiWD5hk7tUEauQzXFqZn9V
         bWhQ==
X-Gm-Message-State: AHYfb5hWfGC8m066GtvblMbvN7Tq6ZIZT1TAK1/bhZaMSBbS/9GBBl5z
        6siuaKJzmxiX9Ni8
X-Received: by 10.28.74.79 with SMTP id x76mr1624252wma.140.1502818587675;
        Tue, 15 Aug 2017 10:36:27 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x4sm9079710wrd.66.2017.08.15.10.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 10:36:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] sub-process: print the cmd when a capability is unsupported
Date:   Tue, 15 Aug 2017 19:36:11 +0200
Message-Id: <20170815173611.2267-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.187.gd6d46550f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In handshake_capabilities() we use warning() when a capability
is not supported, so the exit code of the function is 0 and no
further error is shown. This is a problem because the warning
message doesn't tell us which subprocess cmd failed.

On the contrary if we cannot write a packet from this function,
we use error() and then subprocess_start() outputs:

    initialization for subprocess '<cmd>' failed

so we can know which subprocess cmd failed.

Let's improve the warning() message, so that we can know which
subprocess cmd failed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sub-process.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 6edb97c1c6..6b133f8dce 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -158,7 +158,8 @@ static int handshake_version(struct child_process *process,
 
 static int handshake_capabilities(struct child_process *process,
 				  struct subprocess_capability *capabilities,
-				  unsigned int *supported_capabilities)
+				  unsigned int *supported_capabilities,
+				  const char *cmd)
 {
 	int i;
 	char *line;
@@ -184,8 +185,8 @@ static int handshake_capabilities(struct child_process *process,
 			if (supported_capabilities)
 				*supported_capabilities |= capabilities[i].flag;
 		} else {
-			warning("external filter requested unsupported filter capability '%s'",
-				p);
+			warning("subprocess '%s' requested unsupported capability '%s'",
+				cmd, p);
 		}
 	}
 
@@ -206,8 +207,10 @@ int subprocess_handshake(struct subprocess_entry *entry,
 
 	retval = handshake_version(process, welcome_prefix, versions,
 				   chosen_version) ||
-		 handshake_capabilities(process, capabilities,
-					supported_capabilities);
+		 handshake_capabilities(process,
+					capabilities,
+					supported_capabilities,
+					entry->cmd);
 
 	sigchain_pop(SIGPIPE);
 	return retval;
-- 
2.14.1.187.gd6d46550f4

