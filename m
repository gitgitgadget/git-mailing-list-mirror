Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02BAC433E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23C92086A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y05oITk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgGWR5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgGWR5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:57:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E25C0619E5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j18so5741412wmi.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zi54yqBdOqFyF97dKl9M0ENaSIb+QlkuRDDGBj/36rg=;
        b=Y05oITk0C3k+yR/SrOPvLbjo6XodmKhRt6K2a07edZ6aLkbnwIqQzJoQ3mADw2E3g0
         WcaDJGwm+nCW4EjJH3rKP+VwZWZZmG1dV2QoyImZZmHhEkwa/8QLXHpbHHqL1Ml3dlor
         qZJbCm8jWeRUQVtkU4ux/mgNo5ED5dDoHQ28+/7u8aDm6qkowYANfoPcW5ScZVoTiVhA
         J5wJm3FRrNnzZT6ESf2PssSzMt2o8R33rXw83hzj57L0E588LxqXbGtaYRslfCtziVsu
         6TYNNzKbYSHYhqw9inxthnNb1bprNv7VaF+uUbdO5JjDaLxcqwCgn6pIquQwSmSHthfQ
         Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zi54yqBdOqFyF97dKl9M0ENaSIb+QlkuRDDGBj/36rg=;
        b=J5YFLMevc/x0diiP9+tMiURcjYfzNDtxVzzyblug+Tf6cCod5lxhPogl13gJC1QuZI
         abpLUVHxS+D6NIExpx3cWUoeWqYE2ctoEA5SrjWUQy4ZGbkDf6EHlFccU2YULLLVO5PY
         SDFF3xCkVtmZbJb5EGp6ql0e7+BYfUOSXceqMbI17Z/aO81TfVAHoJuO946+WVbAswVA
         ub4hQkZtuwEjpPckSETppk65GGK/OFRnTwmt8zZy2AA7fSYz6tx9OEtxeEbeYKbgylq8
         S5mPQxgW4fAGiUAIxIxHB8UcJ7pLO7Iz+NQf7ILfr732va5st9zUNsqzzVUuVHkeD914
         CTZA==
X-Gm-Message-State: AOAM533m6C7QhIpzxU4bBHGKzq/T/WvipLGnJSOuOLEH3d6SH3TRACwY
        UPK8RG+9If9XRC3x2HpsFXaFpSJo
X-Google-Smtp-Source: ABdhPJx33QWHO95EMLmtkmx+sS5/CbNtVKHdUXEp2kcixTNZdq4UkgwZcxsfq+NsOmpzozIf3ui1dQ==
X-Received: by 2002:a1c:27c1:: with SMTP id n184mr5393934wmn.6.1595527018444;
        Thu, 23 Jul 2020 10:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm5178452wrb.59.2020.07.23.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:58 -0700 (PDT)
Message-Id: <f24db7739fc4bf3f947cb7bfd3fe19908a1b4715.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:40 +0000
Subject: [PATCH v2 18/18] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
index b040c7d31d..7d9e6c34b7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1322,7 +1322,9 @@ static int maintenance_run(void)
 		     !tasks[i]->auto_condition()))
 			continue;
 
+		trace2_region_enter("maintenance", tasks[i]->name, r);
 		result = tasks[i]->fn();
+		trace2_region_leave("maintenance", tasks[i]->name, r);
 	}
 
 	rollback_lock_file(&lk);
-- 
gitgitgadget
