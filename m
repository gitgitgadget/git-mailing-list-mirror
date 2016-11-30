Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386E11FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759301AbcK3WDH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:03:07 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35018 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759294AbcK3WDG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:03:06 -0500
Received: by mail-wj0-f195.google.com with SMTP id he10so9891289wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lt1R03pfix18FTY4Uc6AkOqWD4hff3JQQuTkMCENMaY=;
        b=Qq2GGD/9dbJsnmRTQMSUWaMC98clHTKGC6TVokjeHUjvcCJidZfpsu8M7mjmWeaA4F
         gSMDYfmmeIGlSrHVYutLP7Slte1C+7FvnNmyN1/nvIYhKE1tS3CCqJ8ntLiUIowecadP
         aKgZVO276Zc/TCqo4u0YmYb0iiVz1ShOc9vteD2tjgbwbHfv7eJpqSS0Ze7z1WKfRTfC
         AylEiBJ8DtLlGSVUQmN12F5k0tGv2mvvWoNZUe5NZ8YIT+ApcgAw0j3EzIy+0JkomBdN
         C2sL8Il+MD525LqghWXJVVpBUAcTbMgfoKzw/ucjGsH1lewZB8ru1yZnkOdoXO0QBowb
         er2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lt1R03pfix18FTY4Uc6AkOqWD4hff3JQQuTkMCENMaY=;
        b=ZrVMErxNwSWZE/kbU9xjGGe4HWthbLj8K7jovd9F0/ZyEyZQXUcxOp9r31ifCrNBAs
         Kh5dUK/M10uuBRwhw/+KdEcQlWQe1bJUxNeQ3GjNDYWvUZgXmwVWvrJwrNvO1cuRjY8v
         FzTiBREnXZXqusFv+c1gdtwNF4IjYoticyguBK7lw1UD0Z0zRQ+JXhyWaF258oDrwHmk
         pJCse9M+SzNNE4nvUn0oxV71LRbetJ7m3Xi9IIr/iW9RIxzBRH7SOPMECrvG6i8nRAqP
         fa2wyvqv5WfFd6US97XIegKOwb/fMZ4mFAkJb9d3jcVHjOZxm+XaDWDAbr4QfeOikoeI
         sAig==
X-Gm-Message-State: AKaTC00uO/ngmB770cnzSGEcYDhJVyrJCO3y3+j/5n9A5LRd07FymmtRqY7IRcKipJuTTg==
X-Received: by 10.194.191.201 with SMTP id ha9mr30137637wjc.205.1480539898315;
        Wed, 30 Nov 2016 13:04:58 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:57 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 07/16] external-odb: accept only blobs for now
Date:   Wed, 30 Nov 2016 22:04:11 +0100
Message-Id: <20161130210420.15982-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index bb70fe3298..6dd7b2548b 100644
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
2.11.0.rc2.37.geb49ca6

