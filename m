Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED131F667
	for <e@80x24.org>; Wed, 16 Aug 2017 12:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdHPMks (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 08:40:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32777 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdHPMkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 08:40:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id n88so2859430wrb.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 05:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ojDVNK0H+/Srw2fKuwvgcZhuPSb2M74Je9xJwY3SGdc=;
        b=NJ8TfT4qhpuPQRXAIheW37/MNOlzZjGmUiBmvn6mF+AzHUIQprYZlmqGb6x6GTa83r
         SMUizOWjLrhHFTFDZAf4WvB6wOSCxRiALpEbCZLI3GyZKvbIwKPmcWeooCpKnjHLOmQ8
         V8Yn3YhF32MPCoFq8enL38UwUbBpKJ3IKpzKt/5/mZqmfVbgcXtzbqNRAkktz25SS/Qw
         RJllHQo6CicZr0PmIuPrCZU99v5fuhJHv/ijQEBU1zhXlQgIpks1exgSzTOrfCpNAW/s
         hAld/1Hzj/nL1Ghog6WQXXwvLfasaKKz9cAzEC0f1d6/D3DmvpYJZzCpWKj0uu8d01+1
         UVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojDVNK0H+/Srw2fKuwvgcZhuPSb2M74Je9xJwY3SGdc=;
        b=KbWl2zFefSlf1fQ3t3+CmPRZexkZiTe+SITRKYTmUinH+/F3kOQrxrLwI9eNO/d5lH
         9hUnSCwWN91Vp2mvfabOzpJMIRxkJNwCYSz6ascWtfI/6F1zU//QeLd19ShQBgjRsTXD
         m17H6e/YZbgbd0FXXCpU3OdLBWTXmWSUz2DGSqnqj6RceAMbGk9fyFhNUVRqTZmxe2yw
         ypTnnGH6Koo39xLPd+lqqMqYBkhGPQFuhA2apblcXkRwZanlK7phGIPibu+T0EQ0tX73
         bdW5OuPXxN0aEmPBbPH5URMW1HJDUXdudND49Z7UQZeNJwG09ZEcsCNpYVW7Z/UZh5ig
         4MMQ==
X-Gm-Message-State: AHYfb5jjdZGANegQoaS2c1R1DnRlQ6KVEASxaa3AMxe/jfb7ssT2LzN3
        ywvuXeMqtCgibqqv
X-Received: by 10.80.222.66 with SMTP id a2mr1892058edl.249.1502887246103;
        Wed, 16 Aug 2017 05:40:46 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id o54sm564984edo.82.2017.08.16.05.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 05:40:44 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] sub-process: print the cmd when a capability is unsupported
Date:   Wed, 16 Aug 2017 14:40:36 +0200
Message-Id: <20170816124036.25236-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.146.g7de11f915a
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

Helped-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Change since previous version:

  - Use process->argv[0] instead of adding a new parameter to
    handshake_capabilities(), thanks to Lars.

 sub-process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 6edb97c1c6..6ccfaaba99 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -184,8 +184,8 @@ static int handshake_capabilities(struct child_process *process,
 			if (supported_capabilities)
 				*supported_capabilities |= capabilities[i].flag;
 		} else {
-			warning("external filter requested unsupported filter capability '%s'",
-				p);
+			warning("subprocess '%s' requested unsupported capability '%s'",
+				process->argv[0], p);
 		}
 	}
 
-- 
2.14.1.146.g7de11f915a

