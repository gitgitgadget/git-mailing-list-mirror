Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40924C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhLHVx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhLHVxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66FC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so6487229wrb.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=JtstPlWm2erKcX0Egh9guZzuJ2D70SoXGGiZtrmQAsTYy+QCJunDEpxEZ8rl0KpLpJ
         edsvHo5e3KGPpQl7tDJeWZocXfC+I6ldWwEDXd7v2u/vptjyxaZ0dSP3m+sE1/waG/34
         pp6sIoMBMcpCV1VZQq1aRolsBnqJSftVm90zV7CZsvNBLgAROXQntxhbV5H6iF7q2ZCf
         hC4L2Ha5vAvppu37RnJezjR/x0ZPXxwoBVpiUmihzBnOxmbQu9fGOB3DaoOYnchQbhrB
         enQmuAtcqoM7Q9kZQPuFiLUAl0e7SEdHttUmTmmpE0toQtCAcjVGWMUpfwjD+JgTe8CD
         hcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=ypmNBRF5a2tS1+OT6hPtay9yCGBSyOqtSLrJ3sn6HXX7MK3vAxtaBY2lDbC/j4cHRm
         ONbdBTEG1snTcfQSe+tEZzpjiUgHLhpsKZ20cL0n8S2aeYUCfunNRUqT7J9CDC8LnOJ8
         j1k4twTw5eUsJfahnqturoZ8garUoGbdk8jTJZBgdP08ulKHX/xLYRwrCS4Uaoah1foR
         dOghlN7okSYR1Z0PC7XzdoXT0HaV1lYCS0G/NCa/TXmKt7ORLYLm1ORVboyU43SN/Hx5
         ZEahLLoEP+zkBUjsoo2gE37lkbQtg8pO6sovOL2kwhizE9N1S1jF3wlvjG3ryCmsNt/V
         SSkA==
X-Gm-Message-State: AOAM532V3YuoFhyyHCTDxw2l+n/Bd0iuAKIp91Vib9OQf/ckmD5s8hA/
        5tSVr6Zs9QhdcUvqbEdFIvpXafPef2U=
X-Google-Smtp-Source: ABdhPJwsCiDpW/IX8UgskGqeIzgaT8svAoUdx4K8HogKXbGkc83+KtQ0vpGjHq/dKI+v4FwoKglQfw==
X-Received: by 2002:a5d:4704:: with SMTP id y4mr1491154wrq.85.1639000191019;
        Wed, 08 Dec 2021 13:49:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm3867637wms.17.2021.12.08.13.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:50 -0800 (PST)
Message-Id: <9063137457be97352e99538808c914339b2e93c6.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:39 +0000
Subject: [PATCH v2 04/11] reftable: check reftable_stack_auto_compact() return
 value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..d628420e63a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -814,6 +814,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget

