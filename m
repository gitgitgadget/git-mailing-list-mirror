Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA76A2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbcF1SUF (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36424 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbcF1ST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so7984793wme.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s0XCx2+r8UsllI3sctn0RDQo3yWrRWuTy1QXFbEJRNw=;
        b=vXVN5lpEvTGrP/grn7VSKjOoQMIaCLXVEU1wHPd6MgY8vPNWoYatlYXVFbQQT2EcYl
         FejqKP3T/tvM3Xp7ng7plJIP1Ke/ZG/GCIPF0wlPQwP29CsvTrocCcuVmmHh00I3NQGE
         8cg8SwcAhqUj1rdbtw0gAv5seKIt46RUTyBe/FpY3gelT8IPPosGEsE1xa/CvhUfbspy
         xzXFXfO+8f3mDUOkEd5CKht/DjBw0ICq2z2NAuq75/ktuP9Lab0lVuKS4CHlTuJ4w7fY
         DwOKIDSRkPavdkp7okuW6v114/Q7rN3ch9ieicbnoMkApPMtBAZph6zViMhTd6gRJ+l2
         z0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s0XCx2+r8UsllI3sctn0RDQo3yWrRWuTy1QXFbEJRNw=;
        b=E+awSEDbUh5jMXcscOqAuHmC5QFvuOPWcf4e73qHBWuVQjhLx4qptdEZBSoI6hEkXt
         SHwJGhTTcKzc/yiYFO+MVMDVRkhnmxW5lDkfoWTaPcYZms21y5N38VAC6O1j9Y2IxtKi
         qFhdZOKFLi2yPp6pn/aVkYNnJcz8eHTO4BuGW+PRQjwWfGXuJpoVmgbDcNsfDxIv2VBL
         dibvmuBEtL6OECfxlc7VAvQNQ3fQ1Ft/k1JMVWMdqqZXv4q8lJF/fJmlMsuqmEpgkt3c
         iguLNqLaGkC3mx52xLqg7wN/9QDuNL9zZzYvuZES6R/wsWVPtBqMGICdZiaWW29gTTAR
         jIOw==
X-Gm-Message-State: ALyK8tLJJSNK4pTZGlJXyR5qxK43HcS5ZwVp+vRZVG3Jazn0D+T+UCXordhaMBf5hpCqPg==
X-Received: by 10.194.82.36 with SMTP id f4mr4443165wjy.104.1467137995947;
        Tue, 28 Jun 2016 11:19:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:55 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 07/10] external-odb: accept only blobs for now
Date:	Tue, 28 Jun 2016 20:19:30 +0200
Message-Id: <20160628181933.24620-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index bb70fe3..6dd7b25 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -133,6 +133,10 @@ int external_odb_write_object(const void *buf, unsigned long len,
 {
 	struct odb_helper *o;
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
-- 
2.9.0.rc2.11.g990c140

