Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E6FC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC27A206F2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH7EQ7T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgIDNKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbgIDNJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB19C06125E
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e11so7505631wme.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3BP+V47fkAW0XOrc+qRv9CzrUpLDeEi54vnAws/gvxo=;
        b=dH7EQ7T3oKMV0XpqZk15i594C1y0PLV9CVboYr+w6Ph3OTRDcZhrAnBf1lb13lXcB4
         xCgFXqIHK817S5FIAQ2qEXPswU59u0lD3bH/0CbQrZOiUgNrH0APCkafs6d2Taaxz4TE
         Ux57dTrwTOC32JaPABgBaAocYiSJCTdn6uAenZ6ZPqrGPMMzvEl6xiJgYE2PxdSUZ4ZX
         m8EWGRzsN8ToQXbp25EwmLsI6yxS7GjjKdh2tTL8Vz2fTnpTkXJUnos+GA59eZb+3sWg
         kS2N1GY4SwMyNCo/CROFMyh/+IGkb9SWeYAHp0hExy1vSRuJ08MzrE3EgEU9xviJO0Mu
         3BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3BP+V47fkAW0XOrc+qRv9CzrUpLDeEi54vnAws/gvxo=;
        b=dRhcL6H9eLCBk+a5XgG51YTnhSpn/p6VQG9U77Ubz4Ke6wonPD9Q73/Sng9UeMJKOF
         wIKrOwkJ/aUsQMfJduRPTgUBc2ODEt5Z/YHy0YD/TX3Nnv7oKwrk7lccq4enL2+LQuf+
         4XjgkFh5A93eFgdO8pPfZiNwiVwwXylFPxPcf20NGMwm9GiRrPjGyaxA2qRpbbe/J3rV
         NQuPwaF+0h4FM7MFLEkAdQx69LpaUosfl28wdpSEaAOC1LKMju4ViVG23e9JdUiKGLB6
         kvIhlAaAh6iwDsAEnOaQYj3Wi9e9T5G0N7CIO8V3qFxxVrG1K5m9mdfmuQliw86zS1g6
         O7kg==
X-Gm-Message-State: AOAM532cZZ9encSZrtdiTWULlELKEaQ75Yn4a/KqEE1YG5FioIJtQpHi
        9gypsFd9/p/ny6Hh0WblWgzcmlmzqmk=
X-Google-Smtp-Source: ABdhPJz32dUViI2x8fjIpdGKtD0C//gMHMmhpbv0Bc/ByaZx/kaDIpMMMNtDhm8s31B6V592opwl2w==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr7215881wmg.182.1599224966690;
        Fri, 04 Sep 2020 06:09:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm11654596wrt.38.2020.09.04.06.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:26 -0700 (PDT)
Message-Id: <2d6414d89ba447d6b2ad652f56038eb24004f408.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:15 +0000
Subject: [PATCH v4 11/11] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
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
index 8c4edf19ba..c3bcdc1167 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -927,10 +927,12 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
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
