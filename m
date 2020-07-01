Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADACC433E2
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46BD206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBjmmP0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgGANfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgGANfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE4C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so23835823wrs.11
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGmK/o5MGnE7qfNy6OlJiuoXu3XIcEOXYJElqWDicLk=;
        b=SBjmmP0vha/ZYpjmX2q+udesPCfaUSZfcjYPEuAhcVrHU1DZHMj4KghmbMYi+TCP5/
         VAd98v7GoILN7UYDUR9zie835WIpAONhniqkjJubhx4wB/DdjKRt5BADkGa8ftNEnOgJ
         cenvzj/tEuejYAo692BbQ/S1z2Xer42+W3wJ7n9CPe7bVpnYq4EPhqXjatJizzehsPD0
         XIeN2H9YQkQoW9+Ki68JUPrUoghLOvsbeKmDxA6CSRHgPba/QwXbntePcZuLSbVf6HYB
         LviT0tzOcopr/JdZJxiuhYNNtwkQ08Y9tIqMxFaK6wr19j/4MKnJ+mtrckCzu9qhFX/D
         lkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGmK/o5MGnE7qfNy6OlJiuoXu3XIcEOXYJElqWDicLk=;
        b=jkPk1gO6nWEDQOKuOwXugntkUGRblBlLjBUTdzY90jozleDcfQ76T2pn/L9a52k7FJ
         SE0NYQiAMDgN2G7fgsepuJA/DeJQ4biLO7xwxAMVw3RyetDUL5UqoKQuL/ShlT2bX9kC
         nKt3tCLHqmsBqKEXX1T/CRgzvmn54aG/5BhNVm/q4WbsFBwtAt7UTcT2XdkAvBSsVUQz
         WGNid0Jjptk8iWQ6YwVryY1qroD9OuhIXNDMPyU99tBzYyHV0VKU1gaWPaTYe9kZhHyq
         TTJ2MSetVU1K7+fTBWibn7WZiy5ClVxaQVkm2nBauo90EYCCA1OQhP7pSlqeE5OHmRdz
         ayWg==
X-Gm-Message-State: AOAM530XFrasVi7oLa5lfQ4FNK8zXLiJvJzdweqQz1JHLTupbe2uebaG
        A2UGVgjYthgYnuTZa7uPDfk7+l+O+M0=
X-Google-Smtp-Source: ABdhPJxctBAVRVUT7zP/NRxSl7090rV6+mOwRpUlizyyaScx5EzCgGP22mTpe+hVZX+Djkh4koBm2Q==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr28951795wrx.180.1593610531128;
        Wed, 01 Jul 2020 06:35:31 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:30 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 01/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Wed,  1 Jul 2020 15:34:52 +0200
Message-Id: <20200701133504.18360-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, there would be a bug
if an invalid or no subcommand was passed.return error()
should be replaced by BUG() in that case.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e..c452d3f6b7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -716,7 +716,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", (int)cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

