Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DE220401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdFTH40 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35136 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdFTH4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id z45so16317555wrb.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z5E9YJ14PFiTPPSA18oiTZBf9PCyHJcTQOv93OpL1bg=;
        b=M/DzYpxDr7EU0I28BXVqka/4e+ekEb1+igE/wUWYOfJNns+IfmGebN6gWTFMJ/D9ma
         84FzYPgKTht8yrYy+2YkLjT96xJpwKKR/U0QgWzsOFkxWfTmoB4gkfWKOBbjq4kVDT1e
         NdLmqBD972CjF83idS4R/4WLOdX68BofqI/03Xs10vAN/9p+liGGExMtDd1ExHmlqUZf
         Rv6Yh2z8O2KUhfyIg0ev7hhDOfzu4qcgzNdJopf1+8OFZhOTUIPKSJfyf2Rgpyx/vcuu
         XD9Qz3DwBSz5wMYUjdiP8KgfzFlyEbn78r58bCrYNOCO/vWstNqEFf/igaB6gyTzgo3v
         uVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z5E9YJ14PFiTPPSA18oiTZBf9PCyHJcTQOv93OpL1bg=;
        b=Z4ZhLO+ulaaKnbJZOyOjUt2HUHkNe+ZvfhNPnEIY7GXF0K+kVi5zgaKh5XW95d3l2x
         /rZgwa3t+cC23C5ie7MiUZQjw4GRWZJT8WsRyfIgGdJ6agZK18J5rj1l4dfxdW+FL+sY
         VXX7zz1VQGrkWaG5+IlJCzOM8lp8eL9QipvwcHoMzikz8BRuRMmtPY+2LwS85TJkXASc
         xiUo1iL0uaWu8R3pu0z+6XhnGh9bj3Sqm/byONO+QjYI7gix/cYyIY1RwJUbaQdGp0IT
         wSAbgeCHJ7zLdE8UgZ3bCBhL+VJpHQiDg13q/Uk7BOuE+kcNzOFm4DKDtXBc/gwchDj8
         1LFw==
X-Gm-Message-State: AKS2vOyvY4FchbLR4S2lYYDtN+OjKmrRaBD+hZSbXizWAwz0MR2PQhWt
        GcWSJK6tLb+byBmF
X-Received: by 10.223.151.44 with SMTP id r41mr18805201wrb.6.1497945378142;
        Tue, 20 Jun 2017 00:56:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:17 -0700 (PDT)
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
Subject: [RFC/PATCH v4 22/49] pack-objects: don't pack objects in external odbs
Date:   Tue, 20 Jun 2017 09:54:56 +0200
Message-Id: <20170620075523.26961-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Objects managed by an external ODB should not be put into
pack files.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f672225def..e423f685ff 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -24,6 +24,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "mru.h"
+#include "external-odb.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -1011,6 +1012,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
+	if (external_odb_has_object(sha1))
+		return 0;
+
 	for (entry = packed_git_mru->head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
-- 
2.13.1.565.gbfcd7a9048

