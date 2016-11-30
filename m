Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75AC1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbcK3X1D (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:27:03 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34095 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcK3X1C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:27:02 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so24324872wjc.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EvSoTHyPrasuu4z2n+vXogMqwE6/AnQW2nsZx7PUo3A=;
        b=ou7rFgsr9U+rcNhzChx57ip7BfQwq5ygjuoTho5LQNKjkIDwPhkprFUkLWu9E7SO6t
         Cw1h/J2S2mEgv57MOwBThWumCiM/3DEq44griqEezTZFtEzUkMPab1YUdvK9v1c9Y4c4
         OAZmFZyOt8niarOMyqxFwDFlL6oOfQ6fDH3XTa6Yl7pscUpwNB46xzl3QU+YRWoQrUpy
         vyOJWpLfNBGoO5OYmv+wFRyQxtIob6y7pEEIMXAIBKA0z852GDGQ/0h8sz+92wU/OvQe
         vPIRvm8XsJ0obaoe7O9UUwngk3gFUsoiMUysiFN79g2Ti1+dYosXovYg74uVdbXeyWwh
         pGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EvSoTHyPrasuu4z2n+vXogMqwE6/AnQW2nsZx7PUo3A=;
        b=Fhz45xZSRx1a9//akuZjo6CJYJXIuKE7uePA6IItwhSPafFqVkDR4u2w/+QzGRpTMP
         qvhSeKg4rzi1o86oTZPjlfyppu+C8ZOK9k6eBDMIz3wV85zXUjTKPN2IWDwToT3+++xM
         PDAygHNqfH9ySKqhQ7GDfXwP0hgPA0ClqcJX15T6doMfSd2eetzWqXPeTrc9LfJrPMqM
         OB5W9cMxYwzGn4rmBZO3sIVTp5WuvJXWFrhqcFJGXMNkvEXsG1N08MiDpCQfv18kug6K
         HdU05aw1z8QSrYMeDGgsbRNCCXp1vsYJNJcb51eDdEYXsY69Xmui9A7v+KKrlA7+GlPs
         BJ2Q==
X-Gm-Message-State: AKaTC03r/iFlKf/EoGjFSbrfwMZm4z90FCL9ErE8OrCfFDbpWqMMeEXmHogKTd31GynoHA==
X-Received: by 10.194.173.73 with SMTP id bi9mr30002904wjc.120.1480539900158;
        Wed, 30 Nov 2016 13:05:00 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 08/16] t0400: add test for external odb write support
Date:   Wed, 30 Nov 2016 22:04:12 +0100
Message-Id: <20161130210420.15982-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 6c6da5cf4f..3c868cad4c 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -66,4 +66,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.command "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.11.0.rc2.37.geb49ca6

