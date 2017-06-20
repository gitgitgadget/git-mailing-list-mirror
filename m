Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472AF20D11
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbdFTH4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33690 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdFTH4I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so21268489wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7ZF1/2Q+eyhT6nzN8mFHt/kUEmJdEg1uXRN4nwnCUU=;
        b=S45p66DMGAR/YMceliHzbajYRj04NBoGnYDHXxoA/tckkPNEhJCnjd+zWiEUjXU97w
         jxvavTpDj/4Px4HCrDs+BqwujHOjzyuqHjfjCpQ78ITYSBs4ngayBY6TMJSJP9rzYcLJ
         qQ1IMmbo4AAAR8tPo364KDa9ptzZLM8/+6pGd4BZt4jzh7zpIHrgnJbh+JAJELCQbGvB
         v/wRLp60Iy2/OVwtnWbI7pUX84+FalTH8goekyKkwPVde0fvERCbMdHTj/arrsG+SHvK
         WUcOXk3Y4dzUjTN+uh9xLzlDWB8QlsIzV5oVwaBwXqyI8lynvH+kqwWm+O3pPd/poLKi
         nmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7ZF1/2Q+eyhT6nzN8mFHt/kUEmJdEg1uXRN4nwnCUU=;
        b=Zd5nU5oqEF3uorOKCgrA6LZumRe49B/2/pqsjbM+Wl5x8IzUpo6ychjY3HzO/ZfxtY
         wroUYcWt9NE0T55v2Y++C0f1rlVctws6WCmvvlTy86FoZadL/G1qJSQ3rv3kp4BPFE8Y
         HHP8/an0zSo38PPdMu1ewjndZhf6NaSDcT1Cp8sBQ9pIBkoLgiklRqgJ9/ZT5bC1f86Y
         i41LYNeRbvvmCyecgjDA6fewTGfhFvDWh+9j6tVLII4RfM9qd+hAqKobtJBAXLDN4nKI
         ARqQwZ/66dy9KXnYAbUp9xMEYQE9KU7a9ylfoiWbqH2Td3mkQIca8bs6nyAXe2PbHzQs
         oAWg==
X-Gm-Message-State: AKS2vOzWZwKgDSnCUEztxKKXY2+9yrNNZ7pcVqUOAJHKrEJ2OxV7CfMu
        bzV8+4CdvxBQh+wr
X-Received: by 10.28.74.218 with SMTP id n87mr1705056wmi.16.1497945366710;
        Tue, 20 Jun 2017 00:56:06 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:06 -0700 (PDT)
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
Subject: [RFC/PATCH v4 13/49] external-odb: accept only blobs for now
Date:   Tue, 20 Jun 2017 09:54:47 +0200
Message-Id: <20170620075523.26961-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 893937a7d4..6d4fdd0bc1 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -133,6 +133,10 @@ int external_odb_write_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	/* For now accept only blobs */
+	if (strcmp(type, "blob"))
+		return 1;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
-- 
2.13.1.565.gbfcd7a9048

