Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C67C43141
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D7206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3b0QIli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUWUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:34 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44015 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUWUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:33 -0500
Received: by mail-wr1-f51.google.com with SMTP id n1so6308748wra.10
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jN9AdLNvViEOBxV6KrBx7VuvMursJPNapfugey/ZdMc=;
        b=n3b0QIli8NWPi+ITywR2MmXQuIiJ1ebtzMP32u0vps5oSuXKwW1VB0vYmbOamDgCN1
         g8c8S6CRywQJsD34qMw/VG6VC1hdDuX0GiiwGRrbfRB9J1eb6d0kiry2KX2mGldClfvk
         JSISrj/Pa/l82l2IU5aUWwwP82GxniRMbGhGP2HkWYam47+WWkhH/jWB7UvQIFvfkKTW
         jU1aluCe2qKmVZlnm49DTTe88MTMeel5Mj4lIRbwSxqbKiLy+2M3s7jxld00giRKQWa5
         qG97p3A982PjBxKJjGIBDDA4p8BwZmP91Z9z9uSarOQonRUnLBsyoZV+SlBdj1235DfO
         b9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jN9AdLNvViEOBxV6KrBx7VuvMursJPNapfugey/ZdMc=;
        b=NKB2XdvXRNNAR6172w8tpdNmBoR7/mi34oM2e/GTxdB2L2JXvO/ew+qpdzixWCkDiT
         uDKnprARRgvxI5x6fCinrskQyMTalFFadnnFrlkOhobGQy4Ot9ZSlaCKLvw9Os91RPRk
         9nYW1C3xyW0t0Q2UePogsq9fH/HKr+UkdJ1gwIlInRCw3J7Gcik3zrka3/WN9tr0s0Oz
         SHVuOCpJJCLmaCfgPb6ggBvsFA1vb8fjKA1vmS715Pj8OpY5auwfHGHk3rr7aMOHw303
         EEgPBeRFLaueT+J21o+8O3uk7GJo84nT3qIu9ItdGIszI9wcDT7psPFFKHt1JJFkl+Us
         obxQ==
X-Gm-Message-State: APjAAAVSRhQyIJOL7fWZx1MESuamTAcn+WrLBEKKVwEucrWbEMSCbtqx
        gmGnziA+Dsv5wBe+oXNds7cebZJJ
X-Google-Smtp-Source: APXvYqyH9ZvWLzzEu03DCIrc1vZ/kw7Okf5iEZgVE7grQ3zuXhXuG1e2j+USlR8VEIpyd1u+Okitwg==
X-Received: by 2002:adf:f80b:: with SMTP id s11mr6444340wrp.12.1574374831917;
        Thu, 21 Nov 2019 14:20:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g184sm1276505wma.8.2019.11.21.14.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:31 -0800 (PST)
Message-Id: <d0b212c9df86915e89bf6d101c84e8e137e3252a.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:22 +0000
Subject: [PATCH 07/11] t3600-rm.sh: disable fsmonitor when deleting populated
 submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3600-rm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66282a720e..64269bd89d 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -355,6 +355,7 @@ test_expect_success 'rm succeeds when given a directory with a trailing /' '
 '
 
 test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
+	GIT_TEST_FSMONITOR="" &&
 	git reset --hard &&
 	git submodule update &&
 	git -C submod checkout HEAD^ &&
-- 
gitgitgadget

