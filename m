Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD94C433F2
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0672F20768
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHlHNuq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgGQKyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgGQKyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74CAC08C5C0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so10452431wrw.12
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Y8RQWgTwF/RO1Uaus8CCVvUUfZv3gZ8SKcL2uuqtns=;
        b=uHlHNuq5vAsu/m84a6bxctyZlxFAx8kYFnoelf2ngxlgkJJPXWZ800dGLUoFFLq3o6
         uVEZmRakYd9lC559mv/SJx48wCozEXMQ/ILOSUMK7DFC6Xtm3jtnMc8qbmFi0EqqKM4F
         Wq/n4dWUg0ZBHHecWW0T0eBaWqrzPiSiubgwI1TKvRtMVoGq2CpzBqkqwxC3L/InRrI2
         cdw+cqqpeEa+JQP5O/kmT5eoP77eiTlQdXrAWwnclx/MC4hcQu901eAg5GjfhFNdJVr0
         ySSGo6dLDxwK2kMT5wcsW6W9nrpC82wxBuA3TRvIdaMUHqNyXK8de0Ha6EkgqzzCPsKc
         7org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Y8RQWgTwF/RO1Uaus8CCVvUUfZv3gZ8SKcL2uuqtns=;
        b=Bc5u9PnYdzpFvDdUbM4FEzaGqxi0rudcsATYSxhXXQextcPbMwFtbojvTtbm1AEXcq
         RO+txNulwysCeLme+FYy425Tg+0c77XB4ujlrEaXCrOU6FqlR2GnvOSbBETVpGpvU8dU
         WbnWspowyGprwG53y8Vmc4yWjohuwuVVfJynz6I/Cl89Q+DL9E73BcYYPkRVertCz3Jr
         m4eoES7Sc2iB37nFbm/tq7sZFfHLHTnUVUFK2OOGlEE0/ZcNCpYzKWA37VoMA0nzgjCP
         q8lxuzGatVQV/QY6Ok8XNimPkRONtv9Lame+idKCPyXZH9bWs3PQ736S1ivXmhlOz8Xc
         eX8Q==
X-Gm-Message-State: AOAM531tSyJDRjeVBp6RhQL0+bVdTvrEr2sjlFVy0lLuMgQBQwUGGcnN
        D/wE0w850Y+1/3Xd5ck9zNNC9QrX
X-Google-Smtp-Source: ABdhPJzWngrSeUejuAKCDRPz2llDLluj4hCbhwzPhFHGSgrqrnyAYk3sLrtnN+9/tCEjrBGvPf4/0Q==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr649881wrc.257.1594983275406;
        Fri, 17 Jul 2020 03:54:35 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:34 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Fri, 17 Jul 2020 12:53:55 +0200
Message-Id: <20200717105406.82226-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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

