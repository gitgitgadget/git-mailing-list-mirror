Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80FC433E2
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D425206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esKeZhb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgGANff (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgGANfe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AAAC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so23820942wrw.12
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Y8RQWgTwF/RO1Uaus8CCVvUUfZv3gZ8SKcL2uuqtns=;
        b=esKeZhb7f+g7EHislyx8Bp4WAoCyU72uteB2IbeSuNHjz03ntyQylnKtBIKONOdM0i
         BVTz+AGDze8CrcxYuJ8bkLBncTm7V2qHFMnAvcOctPxRr+RfrIEl4BSc3IZHA8r6t2dr
         rrllwqYVTjxovOeeaHWgCeLf5Tj9MltBLoSm/aqkwU7agcQ41+WO/HBtgMcsd4bU5iaj
         DcR2h/yeQlHDY52S8H0oPnaOHtva/K2X4YV1CTXo3/Mf0ZeqlYTK7mXIb8DPx25P34M8
         eWfCyNhGynDWfCqMRVLq2gDqniCZ/GlAV+hudq12a6TmdIlMBVDFBQjHXEDBKXzPDdaK
         UmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Y8RQWgTwF/RO1Uaus8CCVvUUfZv3gZ8SKcL2uuqtns=;
        b=CgmTtaBWI+RYDpkW/+ZTeKtVpia4VNHh9PUAUSl16CxqK/M0v1lnwv5VyJVE6JVkrM
         kUD4AfUMhG0am6k1AHJu80Edo+OGtLfbYk4ZEjMEu31pJ/ruOGxA26qgqqHTGYGANljp
         2mhGKpg+IJprRG89s7gFWuKGdY+Z+YYOTlKip4FaqFdfIfW22u3xicW0CGjOhYLt3gfS
         9CDWi0tZRNmHUeDjclNfhWIbl6bk7aZQH+i9No551Xh00a3pF+pim+RHi7AnXu3xKNyP
         bHypPVbD+fiCyoxeXzJCBOaO7f6Lyb5obRHrQ7CMcn3WJa/Gcq9esXUXQv3yOJnH5WC+
         gz7g==
X-Gm-Message-State: AOAM531apJvtbw48OztpgSAZGnEZGOLXYga4GgmH1PpKWBPtVpb7CBXJ
        fNho82FFSCGwzUbOv9MR04KUqdEOMqE=
X-Google-Smtp-Source: ABdhPJwlDkkmzM3dO+cfJyHnqpRtF5GA4alN7k27dRJkQ12BW09Z9zStipfdLrbz9rxU2eHLxYFB+A==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr26920630wro.151.1593610532318;
        Wed, 01 Jul 2020 06:35:32 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:31 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Wed,  1 Jul 2020 15:34:53 +0200
Message-Id: <20200701133504.18360-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following 'enum bisect_error' vocabulary, return variable 'res' is
always non-positive.
Let's use '-res' instead of 'abs(res)' to make the code clearer.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c452d3f6b7..0466b07a43 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -727,5 +727,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
-- 
2.25.0

