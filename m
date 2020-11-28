Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D672C83022
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE25F22242
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ9nQe9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbgK1Vts (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732093AbgK1S6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 13:58:05 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DCAC094243
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so7696884wrm.13
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u0bX5HR+EKP51B3h0YCynBVuSHPIBVV8xuMlehD5dQ4=;
        b=kZ9nQe9RJOXGjYWmfW5GfGFdSeU6t1XW9dm9SV1S97aUixy9o+0kQQwnY+xE0bzXFH
         Vg+WePI2occ52CPsosaByZ6SllNAv0KePxmTjqIUoEO/1n0da2ntQuli0MZqzRvB595h
         AY9IMNlU6rO7IDg+M348OzBdeobVGUFg6E1kDbMYvtqy8SOp00HrmGsHolxO1YLnEHjU
         h4h7bXS9/tLfdQ8NeZyOaZITJb1HxnZqoQvj6+RCuCCCBZwm665G/swoUAL++va4VvP+
         ZXa1JizWC30Db/ECJXuy/Ks+hMdbyqTIiWeO+gBr9/lDYu/DCuHAsznKdhfhEac/0OZ/
         dPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u0bX5HR+EKP51B3h0YCynBVuSHPIBVV8xuMlehD5dQ4=;
        b=BLj0ORyga6DWkC3Pxjt3ziG73B7gVKB3xZMV4wWGgG54v9mC4AvRnifub9rZBQidCI
         Sxxif4QkohBvdBuTf15beIniQMkCOo0sD5S6KFKbnYQ4xZjJM7XdMcZZr8BHedizQjDv
         B0R/FrVDaYDXHeMuw4u+rhxNM/q9g8g9nMMJEn18dkolLTOwBoLhMLvgvgp7TT+/9+0p
         wqPVd4BVO5Df9iCZcWm+GB4W0CzWiTAxqo4komGk4t/wS9se/5+KiyP5IgOKJfb76Ayt
         W/Pb3d4ZG/1/qAgkCSxtJ4X91KhpY3cJkLRfZ7+5qy4TnvuNd9DrBtih/+/1OlRKXEh2
         meIw==
X-Gm-Message-State: AOAM531YY82jiDYlUiPzb2YzOmwPH21BQkTCRUrHrlCz1//ucAWuu9ef
        zYhi/sJXUdOISyruGZATj5xkCF4f+fA=
X-Google-Smtp-Source: ABdhPJwqKKf6QQomHKOFtRfN6RZNJntxgfLeTKFiT2mfHtSKsQq8I+iz5wyBDE7PKY/0IBIdwzEzpw==
X-Received: by 2002:a5d:6503:: with SMTP id x3mr15897707wru.151.1606545882516;
        Fri, 27 Nov 2020 22:44:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm18168656wrr.89.2020.11.27.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:42 -0800 (PST)
Message-Id: <58f2b0394546e8da2922adcbc38bdb6b53f2b313.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:35 +0000
Subject: [PATCH 3/6] fixup! reftable: rest of library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

0-sized arrays are actually not portable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index c35abd7301..cf2e32a25c 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -579,11 +579,11 @@ static void test_sizes_to_segments(void)
 
 static void test_sizes_to_segments_empty(void)
 {
-	uint64_t sizes[0];
+	uint64_t sizes[1];
 
 	int seglen = 0;
 	struct segment *segs =
-		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
+		sizes_to_segments(&seglen, sizes, 0);
 	EXPECT(seglen == 0);
 	reftable_free(segs);
 }
-- 
gitgitgadget

