Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8417E2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdHCJUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34974 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdHCJUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id r77so1443928wmd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f+UARGenZ4uhLtTkXswbVFOl6xsRH+qmRLvW0bKgX48=;
        b=fOs16XuTSZLc+aBmQGFT7pyN0xZhKbXvD2fLAVISif3D6zbVn3ZUBxWkR+4hyOb2b+
         51o3pkp7OjUG4c4dmM0+bwutl7PmOgiI01eqtqIHZfR66e0eWV/E7pQC4zcIXjKhXIAl
         qx8EKYnEf5JiQg2e6Z6qdHffFEbJADOuiiczBWvqdQU45LkBEpGJfgKqr+9haLYdJIue
         bIE8ocS2ijjEv5ENWdgPC4Qm55TVxl+RxesGa2/iR5Wp2MsyKQGaJZVym7yOsJSJnFeF
         MjW4hTWuZ1rQwcKW2qMK+S3Bx4T1IYbYUDzi/1f74cxEsRWV3P5kXalSH7hoMiFeWTWz
         CPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f+UARGenZ4uhLtTkXswbVFOl6xsRH+qmRLvW0bKgX48=;
        b=PiYfnf94AeAVfA0I25av7w1Y8koxpubDrsu5I8VWCckZxzXr2/TwU9zl3CDXNSF9Oe
         vkeROUHOq1GCDFlUQuhXY9FES2a6Li8d8N5+DOyPWvTot1xfThuCcHvaKzYnivzjYOja
         ZvmcdLw4MEpD34jHPCkI/2aUZNL4dDAqjrc8bdp9Qtw9SolSS2GAxUeGUty0HZtSXAJx
         E6KEXvOwyD9basdCDiXwShbeb2sv2pZR9Ech54DduOpa2n/X1hLWamMBu6qZrNd/we5n
         oQ000QW76OlkrThkIKVyASiUiyAZOFzNGRkXa4A4bWRxy23me7q89KSlnQTKbrPzB1gB
         g/Mw==
X-Gm-Message-State: AHYfb5iHMPTFNN9CuhZ7SI6am6X6Cyq/5hsAFNd+UMk2fKr64VyeWSNW
        gbHnEO54djJ87YlT
X-Received: by 10.28.26.5 with SMTP id a5mr810565wma.80.1501752005414;
        Thu, 03 Aug 2017 02:20:05 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 23/40] pack-objects: don't pack objects in external odbs
Date:   Thu,  3 Aug 2017 11:19:09 +0200
Message-Id: <20170803091926.1755-24-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Objects managed by an external ODB should not be put into
pack files. They should be transfered using other mechanism
that can be specific to the external odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f4a8441fe9..8283d15408 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -25,6 +25,7 @@
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
2.14.0.rc1.52.gf02fb0ddac.dirty

