Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1B01F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeFGOEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42489 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeFGOEH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id y31-v6so9912353qty.9
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FoTlA5+nG855OsbVt0V+NZO7T8lLlc6slBWzyjCGFSc=;
        b=n3C6+gp+tWu5li+S74LuO8b/EYvlmzx8lYO/fLN8rlK7AfOqIxcVY/qDeB2k67VsGg
         FpGfQ7eT/wVrIwBcUe+tt9HROo5+tr7FRc2XNi9NZ5HG+4vObd0yR2L4V6NBJWvdSVSR
         41kmwK0s++eSDh1/6BN18SSV/gmp/Wb3XrPLLfWqXda41JL1pECqJB89tt1+GVrrhJ14
         FblbMk89BX92HQ+XTqQtJXxxb5aRy1VMehLnMgY3eCiklPoXqtHG4w2nP25i7Xm0IOxp
         Xh7nICZUN/tfNX6EuUBMp9l0DaYlp7bm7kJTMHBiEbi6aBqfSoyH1lFKrxwhBte2sOUF
         QA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FoTlA5+nG855OsbVt0V+NZO7T8lLlc6slBWzyjCGFSc=;
        b=cw8pwVXU8lY+fkF1puyGmbniHpKYplkvyrIUjCvkSsZuxPExsztC4DZpbCp8Q81F9U
         NTjZrFAl2ZVKKROH2/4M85ebgoI94a7XI3d/disY/P34pzjD4kX2LYdUSnZHqvSeGfbA
         gwhymHjtNfEBbT14BSVGDSowzuvbveOuB70kk0sB+5pzbCHFXhBrqZmGvEKmB0LzlVsD
         2/QiSYERg2xeN/Sh3zWHwfBduEc5KZtHP32YnEXHsyVpOEjWamaGS6lPqvrfDiybt1TK
         Wmfe1ayHJ31Lez4Jbvh2S4CrCnqYpbKUZjMuANS5IGLDVjzR7lZtnheMn5rLdsJmo2rX
         uCYg==
X-Gm-Message-State: APt69E0BxlmoQXhiKhoT8aPsNKJ48lEPsX3AJ5apqabJrN+bP+yI3E3h
        cQEYP+3iIyxgD+J9aYNZ+59Izb/O
X-Google-Smtp-Source: ADUXVKJu8GNl0QDXEA3RdPGabQi8E66RBT/gHamU1vncK15YdeEPPmakQ2NNAIJE/V93qIIoKVvkgQ==
X-Received: by 2002:a0c:99df:: with SMTP id y31-v6mr1754680qve.156.1528380247028;
        Thu, 07 Jun 2018 07:04:07 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 20/23] midx: use midx in approximate_object_count
Date:   Thu,  7 Jun 2018 10:03:35 -0400
Message-Id: <20180607140338.32440-21-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 packfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 638e113972..059b2aa097 100644
--- a/packfile.c
+++ b/packfile.c
@@ -819,11 +819,14 @@ unsigned long approximate_object_count(void)
 {
 	if (!the_repository->objects->approximate_object_count_valid) {
 		unsigned long count;
+		struct midxed_git *m;
 		struct packed_git *p;
 
 		prepare_packed_git(the_repository);
 		count = 0;
-		for (p = the_repository->objects->packed_git; p; p = p->next) {
+		for (m = get_midxed_git(the_repository); m; m = m->next)
+			count += m->num_objects;
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (open_pack_index(p))
 				continue;
 			count += p->num_objects;
-- 
2.18.0.rc1

