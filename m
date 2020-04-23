Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D662C55191
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1CB208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSCMsEHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgDWHJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgDWHJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB0AC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so5494274wrs.9
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jP/bwdW/LYWRCE8uqOGcqRjd1/CiBIduGpeiCQOOgVg=;
        b=HSCMsEHY/1GCJGO1iDWjvhB2dOmsIb6hqSBxoRbmx99mX5l5acjtUq8ad9T1Ns5H43
         m0vDSpAB3GVkjAxrn27tmGdla+JvLGRHXjCcHeHqW8vmXxprHp9eRLnPwWZtXSJF+Txk
         SfnGBzZN5QROW+Fl4Jl1UKETJZreJEXbvkD3LMxBrpXPnSOxACooqIAyVwoAqLew6hnl
         AYIyxCUDUbYFKlC9zrvTaA2FI0ScPCyBfV9TtEfVpn2cI9C10TEKDkacYjsG4KulyK3a
         1gGYfuRePdvltm5fwSnM7ED0Pjrm775XlJn8smcyr5yTKa+fMB6ToKV8JJc2Qd8wSa2o
         kJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jP/bwdW/LYWRCE8uqOGcqRjd1/CiBIduGpeiCQOOgVg=;
        b=IiR9RROUolNNUhqm6vQDWtKmLt/x198lcmkJcCQIh9FAFFZvdPGJ6jj7dVkqE/Shz6
         PtPEm9eRMlwbwmV2pe6lSq3D+TSvG2PDvwXFDwghpZXbsOibKUdVWwTWZtKHz0FWyHqH
         eM/qIW+exndW5Yq50afhRm4XiecBdsgdn0IwWGp0fcpJtOZOu8puCn23ZOI3CsWu+GLF
         F+/h9kbtpvGKDRe07q99ADJq4Vsn+fvlAiFiklhGDtBzfincB0ADFwkgmwTZG5va9pRb
         BOQVghV2/NWjxRkDGKgJSu74RXu/1xmsBTgUnJYRx5ijBQIkAn20JOr2LdM0JGMsM15C
         8IVg==
X-Gm-Message-State: AGi0PuaPQ0naDeV0TvOPwhg3evXmEb6rpzxT+8Q4yIATiHi8iQ2nMYe7
        RFMQjzwhcHASRE//YVzcG4f6BJeXDqw=
X-Google-Smtp-Source: APiQypI9SGUcUboAGwwQJlH4LWfWXj9BN2VMFr0sx2lNd01hAm5iHCGh9yaYiTOwTdLfIieBZkOpXw==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr3397248wrv.77.1587625776712;
        Thu, 23 Apr 2020 00:09:36 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:36 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Thu, 23 Apr 2020 09:06:54 +0200
Message-Id: <20200423070704.39872-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
index a81a2c76ff..0fbd924aac 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -722,5 +722,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
-- 
2.25.0

