Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFEC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CD0619A8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 03:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCWDVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 23:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCWDVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 23:21:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4104C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 20:21:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v3so10320893pgq.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjWEqFXfrwee3HFInK1aehy/3RUK4+8PQs6OQGsmynI=;
        b=fsIDsRRMS52/DxcQjRhjw5bKkapkVzbDUSfxcLYxI9RaaaTff/tJC5uu3OnGi8lSj7
         TypQByYeWr+WWhevwYKUyD3R/qz09aRSbqk/WHX2OiQ+uSmHZBlP+0ML3a9Z2o/8FvFV
         B3Rv5WFHpJ9XmhE5rSBAvhjJIu4iOJoTaV4aPIrc0UOjdUsvR3fHh0ziRG0z/jxMU2UL
         KieNc+gATmX5bgPd++L/0UyzXNb9Gxq9Fm3I4CqmqLEOHEvr6FIGDBu8WaTgnWk8DiJp
         Ili1CpQX10dlce+r9QDmsrv3RapbHbcPYwGD8R6wCQx6YfWAPKC8Y1LlOoviOJ5aqbY8
         ppQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjWEqFXfrwee3HFInK1aehy/3RUK4+8PQs6OQGsmynI=;
        b=AMOYjS9oJjG4NDERN0ECQ2/2aWAyprnBOfUyJuqhw6oezucslZwW8VEcwh3p6xhrKH
         Lc6bxWyOLoTY8SItCi3qKJJB7Ydco1G49El4bJ+g442bHMvQyiD7Gbvfl7yYZ+A0vDoM
         DxvOj0LLZUBs0XOz80A0fMOQp19pThPWDsAtPCYfURYD43lKRw7238fats+I5xmdcAc2
         H1pUCXM8HWfk9Bjk2cvk0y/Y5ODQM547wl/+T/pRcPskORqVnfcpEm47RbxqbSImEq1d
         zFpcQIw2pEN8hXCQCB/i67xTgokeQchvdTs75A+G4QL7Q7hEPQo/Q/r9Gohw6AKiOKUY
         FvJw==
X-Gm-Message-State: AOAM533eJXg76A5kqu3Tr1mp1y/uNpEvwNcioeJpG8IVdkWh3hmJL9y+
        OiI6i4FEX8N0IQBo/S04W7Y=
X-Google-Smtp-Source: ABdhPJwxrRUfxFlKwTjU50ECwQtaAub9UrXAiacI8LI3g27Q0WDa37/SWlkWN2+2GD+JvDurboewHg==
X-Received: by 2002:a63:1149:: with SMTP id 9mr2142509pgr.169.1616469681408;
        Mon, 22 Mar 2021 20:21:21 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.84])
        by smtp.gmail.com with ESMTPSA id g5sm15602026pfb.77.2021.03.22.20.21.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Mar 2021 20:21:20 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH] pack-objects: fix comment of reused_chunk.difference
Date:   Tue, 23 Mar 2021 11:20:50 +0800
Message-Id: <20210323032050.97700-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

As record_reused_object(offset, offset - hashfile_total(out)) said,
reused_chunk.difference should be the offset of original packfile minus
the offset of the generated packfile. But the comment presented an opposite way.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5617c01b5a..0c45bdc011 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -810,8 +810,8 @@ static struct reused_chunk {
 	/* The offset of the first object of this chunk in the original
 	 * packfile. */
 	off_t original;
-	/* The offset of the first object of this chunk in the generated
-	 * packfile minus "original". */
+	/* The difference for "original" minus the offset of the first object of
+	 * this chunk in the generated packfile. */
 	off_t difference;
 } *reused_chunks;
 static int reused_chunks_nr;
-- 
2.24.1

