Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B0BC388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB81E20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQusTF9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKLWoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKLWoG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56613C0617A7
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s8so7667321wrw.10
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bqnnc6DRfudaGIlMY9/t4Ry607yj07KWLabzb+YCGvU=;
        b=oQusTF9FOvQOpW7MK2+/siWqM/NBTcSpdBuvu48oTKwpy6EeYOaLCG5ukkAK2xnnXk
         +0DlK3165/DDT19o5v6xaOsg94mP43rT1f+IM2Y1Xz/fr5XIiltOFSJGtLlXYqQ9VQ/B
         MCPhXbkZOYiVOdfqP3qqoAcr2IQdg0fPcHOl2eSLlzDFHRvf9qKpj5782OQ+W7tRKfcD
         yBWZSJV4W/2J1ot48L1XX/JUaC1nLh9a4eNiVGblnao8cWp3N/OfhMqLT25YSlS22vXf
         8K63Q5yUasdRlvaFaNt8zdDPONB+96SEfQlfulBukhsnf3SjtQ//Jfb3xs6daO/AEkwm
         yPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bqnnc6DRfudaGIlMY9/t4Ry607yj07KWLabzb+YCGvU=;
        b=fU11iX/i0AQjeuIgHa7Fw0JeQao7MafTDpnOlztm+zjIJaEbSVD0AopW58Omt3FPJf
         MmrHhgC9ovxD/WYsakeZkm+HdO7rrmdnXSRcSIUeyluTw4jb4iZ6uO+/MV1itAiYHvZS
         KCvsNKWd8mFQIg3qnjfnyNfGziNhTT/G3kwHsuMkYF7oEDc62/C83PjmFOyNk1mjbaWd
         QfFUaif/i1jQfROETpnvHMKqg9eDjJCzS/K/tEN1TRyGmMjBbqfh/1S3Yi6/dGU+2XDe
         UAHIBq8ozT64e2LxivV5AFz9uSHGLm0ylXjqUTWABWwvCiy7VMH+gHAkpeXmAwZM7bfv
         m/aA==
X-Gm-Message-State: AOAM5315CAvHnL+NFNZgwuQ6SfjKeXf8awHme7NMgPB73CynLPgSGg3Q
        eW7VgZlJSo0Q6KHv9VBidVG/mHwK65Y=
X-Google-Smtp-Source: ABdhPJw5fUuG+5McjqOB+M4aF0RqDdAZATFboaBJJ6vDGbDLUK3rbe7zZhSTWbS0Ud5e4kaBd5fPAw==
X-Received: by 2002:adf:b186:: with SMTP id q6mr2200239wra.53.1605221044977;
        Thu, 12 Nov 2020 14:44:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm15829732wmi.3.2020.11.12.14.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:04 -0800 (PST)
Message-Id: <e494152c3e72df871cbea44e1205162b2be162df.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:35 +0000
Subject: [PATCH 05/28] t3416: preemptively adjust alignment in a comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to adjust t3416 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3416-rebase-onto-threedots.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 9c2548423b..1f37adf56b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -12,7 +12,7 @@ test_description='git rebase --onto A...B'
 #
 #	    F---G topic                             G'
 #	   /                                       /
-# A---B---C---D---E master      -->       A---B---C---D---E
+# A---B---C---D---E master        -->       A---B---C---D---E
 #      \   \ /
 #	\   x
 #	 \ / \
-- 
gitgitgadget

