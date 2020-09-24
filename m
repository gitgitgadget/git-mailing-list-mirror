Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C40C4727E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D33235FD
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siGigk+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIXMeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AE8C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so3598246wrn.10
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9Y7TvxvEafAn9PpUMsqnYYW+Mm5hIL2kR7H/olF6XM=;
        b=siGigk+CpMbheTE2c2l8+THN0eZLTSpqnpJ5RcXMAf8Be7ZyGb6dNxW/n89VTHnpCU
         yeiRZcJ3Y0mbaLYr59p+atfLHo9dkLlOg+uCd3/P+0dsU2wGVUQNXGOxXRyiK44yDxAy
         QgYlo2FbNSYXmMjK5keLvBtNNvfk7TIPNhc6cjGDEkzCMscuj5o8bEmWf8m2+IcRExMq
         DWSQot3np4EcQ9xLO1GAQ3UyWGNY8NgPMXrcuLWlq5BTO9+yMUIwX0S4ASH6lyQ9KwPB
         CH0RZFDh6tgQwrvkReubMkSrX53AgwBORD59Si6Z+JISaBj98TIN3umS8QQ92h+Tse2U
         S++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9Y7TvxvEafAn9PpUMsqnYYW+Mm5hIL2kR7H/olF6XM=;
        b=KRfp4BswanDtsQF6Q5LljYCcX632aIUumw/N4P3DSvwbLpmQv362EjT2IOzWOUJLW/
         hOD+/ZBNK2ET/C3b5VJg+4jnBmM7h5iuH37v8V8cMRSVlbFTgY+aH5zlYlv2xg3DTIu6
         3iSavhR2rNES4A7I227CMP/iVLO4Yi5C1heBpuUpnvHzSnJO8sX43wmTIYBjH4fVjSQ9
         LKl7mKmPCQMFQS8+14GndCInVNUdVRdeYJ1PJWEWQz2XxK5Ini3bpba4KdlZVnxofP0Z
         5+9DtV+Hre+eHL5P1jShQbigfpYArCGSIOC+D6Vfbcc0ZPgUeaYwP0ZXgWhPVPdKEFQD
         x6dg==
X-Gm-Message-State: AOAM533VKaIY4xWM6iYAeQSnMLNOmodWazk+IjRyr696G95eAY7wPjrY
        vo8CqQOtTPTyjQj8Vrv9PcfLy4xO4Hc=
X-Google-Smtp-Source: ABdhPJxe3HsoPlIcArSNuprx4uJvR8EBjKkHrWGKMZwhV6uITFR8P38X1zybBEoleBCIVodretR3ow==
X-Received: by 2002:adf:cd05:: with SMTP id w5mr4914792wrm.62.1600950839241;
        Thu, 24 Sep 2020 05:33:59 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:33:58 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 2/6] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Thu, 24 Sep 2020 14:33:36 +0200
Message-Id: <20200924123340.52632-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com>
References: <20200924123340.52632-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following 'enum bisect_error' vocabulary, return variable 'res' is
always non-positive.
Let's use '-res' instead of 'abs(res)' to make the code clearer.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 23a9f00035..8037888ae2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -731,5 +731,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
-- 
2.25.0

