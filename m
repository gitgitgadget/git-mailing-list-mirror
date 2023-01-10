Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE5C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjAJFoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjAJFoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958804102B
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk9so25815995ejc.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Efz/Kl6udRu6r4tsUusWym+eZrf9qMOq86M+gpdcp3w=;
        b=j2pmUa+gJhrFmog3qVCh3WQ5WpdEPK3IowHSUKCxiW5r0DNsJFFPdOn9c2ywRvWdCM
         4GdbjU6Ln1u+ykWzNQ20CeSfxCXK5GTTXTfITg3/vSlrDr8JcK8f9SNPfGU/SVKKpPQ3
         lsmGAOySVAYc0A9HeDbWLP06yT03Sbc9AE+U8Jq+E0/6wdpkt+O/qg62HdTgXtVrKa8c
         u7bhVfyExpJtKipq80xUoUM8GQvC0cJjkE7QSLRu8/c9G8bbzeqJblQQfpVDkov4ciKY
         2lx2dBoyiJEZ49ZEYVI9VQsH18LGcXf0lEBROfNxFpLDrazrJxWTO2Nwy4Kqm3DEm68T
         fNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Efz/Kl6udRu6r4tsUusWym+eZrf9qMOq86M+gpdcp3w=;
        b=kqXlhLQSeupZi072Eu4hQ/H892Rul4fxhCb0cw06vNIl4hBivaVHLDBlTZa1vtI7cY
         51xJlPPQn6yJgQvmMBKtCw2di3a4lCzWG5DQ3Bb0Zbrg5F8sEybhPrO2Fmi9w6PxJL+r
         I42DO53iT6QVqtbZ0Hxq6twRfowU6b4FvoQPu3HDy+JeNmgyb+tOVmGn8rt+vOb1z+Ua
         j+0nMUkWTPo+9SbXM9pzx/YpNJId2Sn4d3HwUblyjKjF2sBIMf0BHUGS12P/7pm/B8E+
         rIYv+wqzBmh7uk8oStWnxyCptAO2QUfVbwIjmkEVT8ZAw/Q8xjObcaOi7igylWJRL3xE
         BIwQ==
X-Gm-Message-State: AFqh2kpcNhf18EYhsfdU3q6UxfXct4C+QxDgo+rMryuNbBnZgXWjnTOA
        JNlkHL72dLo4VMp/jVJtYud3G53Xzk0dFg==
X-Google-Smtp-Source: AMrXdXvj4WpZCEDJPieJ/Lw4gT650vWKPKdKZqzSVpzRymRgpAFCeqgQAcrpH5ey6GaqD4xPBfbORA==
X-Received: by 2002:a17:906:c192:b0:7c1:6fe:f4a2 with SMTP id g18-20020a170906c19200b007c106fef4a2mr58847734ejz.45.1673329441563;
        Mon, 09 Jan 2023 21:44:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/19] show-branch: free() allocated "head" before return
Date:   Tue, 10 Jan 2023 06:43:32 +0100
Message-Id: <patch-v3-12.19-e44e74dcc58-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop leaking the "head" variable, which we've been leaking since it
was originally added in [1], and in its current form since [2]

1. ed378ec7e85 (Make ref resolution saner, 2006-09-11)
2. d9e557a320b (show-branch: store resolved head in heap buffer,
   2017-02-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index c013abaf942..358ac3e519a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -956,5 +956,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (shown_merge_point && --extra < 0)
 			break;
 	}
+	free(head);
 	return 0;
 }
-- 
2.39.0.1195.gabc92c078c4

