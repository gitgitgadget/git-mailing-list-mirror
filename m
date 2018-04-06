Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB11F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeDFXWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45223 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeDFXWN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id l27so1785417pfk.12
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1f0b74R34YwCSfCCff/+Y6JwBExiCpSLyEdgo+Tbru8=;
        b=PEgrJGpSrTLUrN6Bm+ew5pgHsGGq2lToiTL3DG0r3pVUX+t8IP335/Fr3je3ODp3l3
         +uhWUWMCOvtZ2SVC8/bpN5Ab63nrGqPCMKGOsACG/yI3VRmM0fDYynbCsG4wyGP8Yryt
         xsqFcDHrvDHKkAe27FMTDq2BWHC2s71EOpdyLhbjJ76OkixnH7gEDrzUfEDFZ4Xg0Ujl
         sgmJ+mzQe5+wqtAv2I/vejo3/102kbJHgBZFY8XtGs0225v3KLkKgaDarjrzCAQs4lX1
         riErHcnm3C1Fsi9Mib/ar9XhIS5BvOb2TIaNxRg4GktLM4HEnFK4A2WnKRMAL6q63a/K
         21dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1f0b74R34YwCSfCCff/+Y6JwBExiCpSLyEdgo+Tbru8=;
        b=J5VkTDwW4M0SU/fSkzuljXOPj7DJNmDMeRuA3X6GOy587y+tb1vC/p/KRsz6c+zW2k
         PUBn88f1asfTpnh0JdDfbgmc2FxvuEN0CefDV+0AtzkYIddJTYeZ0a1ohESOliGSm73q
         p+UzMsB6Ms7WrYVnNZ/ReYwk65bqgBkgTJlz9y/F/MNjz73tFuLC0z2C234z+OoE71fP
         IKdDJcr2AYAZsHNctH+k2xyoHRX8Dk67HKteFP53dVxCiOBXtfhpS/eFm/iElXS2YHLd
         wlaccjSc9t3zEwkhSaYbq2FoL4qBx52JjazMPgBYNRmMEOJuAMQtAqiBPEx9VQ9rTfe6
         OLqQ==
X-Gm-Message-State: AElRT7EdNzb8z7MQsSv8F7CNGuJNME+SjiPa8qbe0rS7RaIzE0G/mKNK
        /lEqftk28nT4oPMmsa7sZn2icg==
X-Google-Smtp-Source: AIpwx4/1attl3RIUZdITVDoFevaolDdjBo2shZ04VXrmjhwIs99I085wbhqK/rrn2Jx/w0ZnvulABg==
X-Received: by 10.101.87.136 with SMTP id b8mr18744599pgr.282.1523056932909;
        Fri, 06 Apr 2018 16:22:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v1sm5640055pfg.144.2018.04.06.16.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/19] replace-object: allow register_replace_object to handle arbitrary repositories
Date:   Fri,  6 Apr 2018 16:21:33 -0700
Message-Id: <20180406232136.253950-17-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 9272c7acbf..b3bfd21541 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -19,32 +19,31 @@ static int replace_object_pos(struct repository *r, const unsigned char *sha1)
 			replace_sha1_access);
 }
 
-#define register_replace_object(r, rp, i) \
-	register_replace_object_##r(rp, i)
-static int register_replace_object_the_repository(struct replace_object *replace,
-						  int ignore_dups)
+static int register_replace_object(struct repository *r,
+				   struct replace_object *replace,
+				   int ignore_dups)
 {
-	int pos = replace_object_pos(the_repository, replace->original);
+	int pos = replace_object_pos(r, replace->original);
 
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(replace);
 		else {
-			free( the_repository->objects->replacements.items[pos]);
-			 the_repository->objects->replacements.items[pos] = replace;
+			free(r->objects->replacements.items[pos]);
+			r->objects->replacements.items[pos] = replace;
 		}
 		return 1;
 	}
 	pos = -pos - 1;
-	ALLOC_GROW( the_repository->objects->replacements.items,
-		    the_repository->objects->replacements.nr + 1,
-		    the_repository->objects->replacements.alloc);
-	 the_repository->objects->replacements.nr++;
-	if (pos <  the_repository->objects->replacements.nr)
-		MOVE_ARRAY( the_repository->objects->replacements.items + pos + 1,
-			    the_repository->objects->replacements.items + pos,
-			    the_repository->objects->replacements.nr - pos - 1);
-	 the_repository->objects->replacements.items[pos] = replace;
+	ALLOC_GROW(r->objects->replacements.items,
+		   r->objects->replacements.nr + 1,
+		   r->objects->replacements.alloc);
+	r->objects->replacements.nr++;
+	if (pos < r->objects->replacements.nr)
+		MOVE_ARRAY(r->objects->replacements.items + pos + 1,
+			   r->objects->replacements.items + pos,
+			   r->objects->replacements.nr - pos - 1);
+	r->objects->replacements.items[pos] = replace;
 	return 0;
 }
 
-- 
2.17.0.484.g0c8726318c-goog

