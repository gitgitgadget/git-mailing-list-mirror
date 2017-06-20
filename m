Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05A120401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbdFTH5G (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35315 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdFTH5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:57:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so16318956wrb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+Brsbr34NJanmnHcFLR50jseZLqS5kajRPiURKDwhE=;
        b=ZOAouR66zBDOLNdXQ0hIdgml5XwESE9gpYRBeHJupwejYl8IVjQ+XQGzSGByh9ivgh
         MXIcZPwEQcyK5VlKRkFVNWcYTNJYnqH7fLEfWrXAvSXss7ZwsrVgubGGkB0w6MXPqcIE
         kdp25Iar6KioNMpjAa6vrBddoH97inSv8ey1w74K2PFaJ/zHN1eLxCLXOQWJpVSFiOEk
         yWAkFx3CgwzUtW3vvM0Uve0gk8FeH4BJxBoD0xOzqWF6fRi2J3RUOrWy0VqOBZYjmWvT
         tYogsPDc0yq4zEH4R9WSqQPc7uYU1PCJnTuUArPruz2SLm89ZCRfItGrc0kpY2COLDu0
         ZTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+Brsbr34NJanmnHcFLR50jseZLqS5kajRPiURKDwhE=;
        b=aTjEZJgOS/XgAEGj6XtXyAtehCI3QPTjhPKIsxWtcN60by4sHI2nfKAyUIJxyt3tj2
         AOy/rLSqXZuWGDbbD78vLeMQr0Ft2mpKl/l2WMSYFleaFZmjYzo7+LoDmbecaYn74iPm
         dXW/acYoIBsFs0km9N3IPXW2Fnny2sUa4BYR2zotI44ed4PCmWwKU+y/UjkpyHPC95/Z
         TkZIiPClnegiNeQaHbD6eAJ4+PWB+tTcwOCW9YMKh5OGc9XSZBDi33uiDHdobljenXes
         XiA3wIv2IILe/wKVfzM17k2Cq1TbKaJRn9QA703+HkYQ1F1gkhhcSA1G+GHrlG+WRnWI
         UMoA==
X-Gm-Message-State: AKS2vOyngvqRXXeMUwy19tQsfrQdTE4NyhtscFPN+SgFSsZObCJy3NsN
        pqUUjiXyYsoIYjYN
X-Received: by 10.223.135.154 with SMTP id b26mr13267143wrb.48.1497945408521;
        Tue, 20 Jun 2017 00:56:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 43/49] odb-helper: advertise 'put' capability
Date:   Tue, 20 Jun 2017 09:55:17 +0200
Message-Id: <20170620075523.26961-44-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index 2cd1f25e83..2e5d8af526 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -67,7 +67,11 @@ static int start_read_object_fn(struct subprocess_entry *subprocess)
 	if (err)
 		goto done;
 
-	err = packet_writel(process->in, "capability=get", "capability=have", NULL);
+	err = packet_writel(process->in,
+			    "capability=get",
+			    "capability=put",
+			    "capability=have",
+			    NULL);
 	if (err)
 		goto done;
 
-- 
2.13.1.565.gbfcd7a9048

