Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC9C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB7A2086A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeunsKqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgHFQyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgHFQut (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:50:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796FC002149
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:49:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r2so39385545wrs.8
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=behzd+8DIw6EK2CfZW2SoL/+CxmkiSwDfqrky3nrMWY=;
        b=XeunsKqzqB+yYRpBXU4nZNWUC172Ey+hTjRHIOg6ThAjESfSar/MrswD11hfv8oilB
         DunuEZ+whLK6g8JFjFrYrtNI1zpDnHCKasvkSQeaQhaMGKCOXqwUz54eehMqFVVxizGt
         389mq8ArN+zw1eSzCXWDdXr6TZh+3omir0ilCJfGd7rtXEi4xqjU57FVEzwpD18mpEsZ
         P1eP1RAs+tb+wL6GONHjb0gBvfNdNfID85/Yq9F2k4L5qfN3Zvui7d1bgXIzhjM+KMfG
         CJLT0U+3xIEAMmQvwJrHGnFfai5/sY0k7oM7vMZ65o6zUSbT8uqWo/jluXyZii83spEt
         C87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=behzd+8DIw6EK2CfZW2SoL/+CxmkiSwDfqrky3nrMWY=;
        b=kzO1Nvz48L2hzFjD7Z2HEVicXiD0J4JZhhPndX3ca4w9/wZ8aoqn42u8VqdfLtu/m7
         Ux/Wb1fMgy+gaGKwdtOf2ZB+tc4ovMf0MDlQLAuAm0AS1G++MU1nvkEqSfWWP/k6ALZH
         ophJi0S1c/3GSoYtL0fOzBb2J1DmJKaZS6vmO73daDxBFtwfKlvN/U167op4aP7o8mqq
         Mby/EW10SfJFAb7yghCWBfo9SA03lfaGbvV9vRS5oTLcPdwztjHz69+S1OIsEZWSCjQ4
         z70A5HKZtE64HAliwnaYfmbRoBGya2U1B2fg6waGoyHp3B3UH5BdtB+5R3e8eK6ShxBE
         VsyA==
X-Gm-Message-State: AOAM5330GfnCJiME7U0K3pDUkhrhY7EcIsiyVOj5YNCqXTcw3NmnWdPO
        vmlH2vcwysPRj3OUYe5UaXTe8jgK
X-Google-Smtp-Source: ABdhPJy2hTl7WgqHVlnaTXX5d8e281dHgYRLCK05Q/+SEXCEaLLviSMmx+EIM8uPL/KJ+G8M+TMqzQ==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr7952617wrr.295.1596728933210;
        Thu, 06 Aug 2020 08:48:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm6453718wmi.15.2020.08.06.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:52 -0700 (PDT)
Message-Id: <a5d19148460decaf08e0e6293e996d42ff3f2d32.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:41 +0000
Subject: [PATCH 11/11] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 20d85f6f4e..8162bca974 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -953,10 +953,12 @@ static int maintenance_run(struct maintenance_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
+		trace2_region_leave("maintenance", tasks[i].name, r);
 	}
 
 	rollback_lock_file(&lk);
-- 
gitgitgadget
