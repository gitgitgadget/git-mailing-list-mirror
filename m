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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACECC2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99249221EB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKaa/2ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIXMeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgIXMeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:34:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A1C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:33:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so3669095wrn.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+JmQMk+e2m4npZedAl84xsb23PB90uGmu0PhUZk5L0=;
        b=CKaa/2ZJfhRZygsBiKGSd3rPHOwtzaEiSUd1Hfsd2Vy8oatopa+Wc787DZ6vSZWNJp
         zLK/A0y46cW37LuMeLtfOG6KeMgPL+YoMhSSWBt6Vo9+L3qVzVsm7dbn/2r9VX5E85Hn
         mvWqWphXROtpYHw9qkLJL3plikM2XM3bGAAvUhAIA/9g74E9K7g07+LDv2kYFWP97kpX
         ZiqEUT8x9TxYf1yZ31WtHWfLXvJSTBXqJWyJnT84DTxEqYP6xaimXxFW2QrJUvlnSZJF
         YmKySzBm8HSYzMppJzEN603dxIKEZ7mw7X6gfMDpUvuMQTCp+Wnx+cvhvFvjyLEVPWL7
         oKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+JmQMk+e2m4npZedAl84xsb23PB90uGmu0PhUZk5L0=;
        b=Ho5duHz4ZMmV/SZkm7M39+55by2wnciDi3ZJgPFQGETmKv8ixsaNh+vwAZNakom0fn
         ktVUKvq/9cyvK8Mqr4fMUBlDcoRVnZhWObzSOAQR4g6r6Pr5aVOrhpzkmOlpbhrhY6m7
         U6LQUCm8sBtdCFdmOk7fIWbmZCexa28b4UMAZktP1417i3TFDp05NsVoXBgcPql4IGE9
         xxbN5j8OxGEzOsRM6Q0LLVU5xlURncx21u9d4pNz5S+wbSGVi9cMRpqn5WfyQkCSK2qI
         FB1uW+UKCBpneI/Jm3GYONIiDPVRBNa2F7aZkY9TRCjq4RUI7m/hKSmkGgzKFlUeX7yf
         q4gg==
X-Gm-Message-State: AOAM532V4Rc7biWz86+AIrCrSnGau2OMlnmFa2H+rX4guEgh+mhKlbvk
        hxMyDApQkYKlRR9CC5h6wYLdLFSOfoU=
X-Google-Smtp-Source: ABdhPJzVZ2uSV1rbX1iDGIyW2zi8WMiKKGQn+fWGXJ3D3c83GgvBoIQLfZGrMFrFKfYY1+htlyNKJw==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr4600657wrv.195.1600950838232;
        Thu, 24 Sep 2020 05:33:58 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id i83sm3485457wma.22.2020.09.24.05.33.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 05:33:57 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v9 1/6] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Thu, 24 Sep 2020 14:33:35 +0200
Message-Id: <20200924123340.52632-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200924123340.52632-1-mirucam@gmail.com>
References: <20200924123340.52632-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, if an invalid or no
subcommand is passed there is a BUG.

BUG() out instead of returning an error.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7dcc1b5188..23a9f00035 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -720,7 +720,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

