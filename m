Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A9FC20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbdFTH46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33081 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdFTH4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so21272247wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9lgZzpGC07SrTsfKnzLQHV/hk1i+l3Qz+BJ536c8CM=;
        b=JyB7c91POD0Bx2jwinMD9v/+e3lt9ubTwqyFmCP2O9aZdDM7d/I7AbR/XiTFvIu+aP
         qLywwHiiOCjzjPl0jfh1Cvxl5VP/KJpIOtDzrtstSP8gCtxvG8HRosNmi1lZzEY3EDEX
         xjLD79BLOHQXKrJIVTPggjPFMLvs3fnNK2h+XOZHpOxvKkoQN5j8WQJx9t1EWldX+j+T
         9VFyHXRAALa4ffqdaSup1aILUk52JuNrtQNJs4PZEAkbHKm0UbdhUerpKfIq89J5gcgN
         X3kzZtv1M2luuv2RggHvIt3SR5CAIsV7g8CqX+WfpsJFUtg0MdXP1yrkiPJW27wY/5Ig
         116A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A9lgZzpGC07SrTsfKnzLQHV/hk1i+l3Qz+BJ536c8CM=;
        b=tb5XJHB6i7ujEnqAlB9dhyx5Ju8Rhk2rwk6Qn0kOSjz/ofABIVaNBclhKEyO1CF/aU
         SUoB4LjMozj4PMwDhGFNLfErRiqlqv/UmMsrFNMZSttpbujuju0Lfc+nEl+11mK9xmRO
         nisXkgAHKXRv1EYtyaPyEoNQ6zfMEIeuj3J4E8/fLf6scIZECBx8Z5qtZqG21MQu+QCL
         JSmIa58PWRoIMWXkxSSMC2k94xWmFn8jnzrLPBH9wIBDSnTbmPrKNz4haZv5fCxZCEvL
         GUf9NtWkPoIXY+se/DdA1rlYjhbWpGlRWIpt0xkWgZjUesL3lH/ceWk3NNzWn5KjnwyC
         5ocg==
X-Gm-Message-State: AKS2vOy3jy4sqGyL2omJC/L4jYzaED0tqyYIgYCBIPnRgXKLGDa/nsBF
        0fRsTSthFCQ30ITQ
X-Received: by 10.28.11.145 with SMTP id 139mr1823720wml.11.1497945407376;
        Tue, 20 Jun 2017 00:56:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:42 -0700 (PDT)
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
Subject: [RFC/PATCH v4 42/49] odb-helper: advertise 'have' capability
Date:   Tue, 20 Jun 2017 09:55:16 +0200
Message-Id: <20170620075523.26961-43-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index e21113c0b8..2cd1f25e83 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -67,7 +67,7 @@ static int start_read_object_fn(struct subprocess_entry *subprocess)
 	if (err)
 		goto done;
 
-	err = packet_writel(process->in, "capability=get", NULL);
+	err = packet_writel(process->in, "capability=get", "capability=have", NULL);
 	if (err)
 		goto done;
 
-- 
2.13.1.565.gbfcd7a9048

