Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CBFC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4765D207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ate95XjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfLQMBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfLQMBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so5542495pgl.11
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bzgvR1Sl23sJ8AQ1hoVe/cwMobweUGRefCQpNp62K1I=;
        b=ate95XjI2Y8Mntjh4vgdxEVW0HsxxnoYacNmMcr3EGGCc86IPEECtoLNo2J0lFFXp/
         lIYwJrf+IVN5L638vTGqGbEz+Ujvg1SnONrzGuraRv5lmqLdbubU7kvuCskAR/EOjKet
         LcXyQEh4/wBDSieJILFcOc4iblR6XljNR49LKUTQ2ZLHoKy+ACY7iFDh4dAKwcGxDNun
         BFC7maLNqVLRxeFe8LV5fBJ2w22LJZV2F33NpIA99ZfWfRZs8xMHnaQBujberzZsUl/S
         6osLXSxvvEu8O9fbNHRWNeWI5bJptcyvafqAtsjYSIEEzq4UqCKXDV/DKiBBOiQ/70DS
         hTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzgvR1Sl23sJ8AQ1hoVe/cwMobweUGRefCQpNp62K1I=;
        b=aASUsuCpb29myJuCkRlRD7t8lvNhdyh0DpvJW0BAf8KmiOo2OBpF15APMpF2PZUmm8
         y+TM16Y2wG1OwPiP2bxihD55f8B4Seqme8ccAI7nLCdgp0qVxsp7x845KGx4Dw5oTkmN
         lr13GyZCenOA6k3JghG+1AXgBEQa9B5IUMuVT71In0Eyx5NRlYcmanxqHLTUXGh9UB+i
         fBgc8jSgXrqlKVyTYpFbSf9wjTW/MwyaD8LGXsXhJXkY5bVyrWP9RH/qeSZdbnaZRXPy
         CzDTIQbMTFeRvUDzYDXHNNwKW85rNG+nQ9U9LvogvuEjProWgPBt2fEGSSvzV/JIbzLc
         WbvQ==
X-Gm-Message-State: APjAAAVLOYG7YRKr12GLtQccXPXF7NvUnTukVU9g9dZLILXKfQzO5qnE
        S76DGEZgi6kYJ+srugBfvdIMLC1d
X-Google-Smtp-Source: APXvYqwHTlFeNmnep8LvrWi0L6LjWTBMhB//tVV02oDcmOb1xeyAO/iwQeFino1wOC7Dm+K3tQx13g==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr21506368pfi.94.1576584106052;
        Tue, 17 Dec 2019 04:01:46 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 04/15] t0003: use named parameters in attr_check()
Date:   Tue, 17 Dec 2019 04:01:29 -0800
Message-Id: <f1acb2a0dfb39a4ff047d721edde821e9e296e72.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had named the parameters in attr_check() but $2 was being used
instead of $expect. Make all variable accesses in attr_check() use named
variables instead of numbered arguments for clarity.

While we're at it, add variable assignments to the &&-chain. These
aren't ever expected to fail but for stylistic purposes, include them
anyway for stylistic purposes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0003-attributes.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 71e63d8b50..c47d4cfbcd 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -5,19 +5,20 @@ test_description=gitattributes
 . ./test-lib.sh
 
 attr_check () {
-	path="$1" expect="$2"
+	path="$1" &&
+	expect="$2" &&
+	git_opts="$3" &&
 
-	git $3 check-attr test -- "$path" >actual 2>err &&
-	echo "$path: test: $2" >expect &&
+	git $git_opts check-attr test -- "$path" >actual 2>err &&
+	echo "$path: test: $expect" >expect &&
 	test_cmp expect actual &&
 	test_line_count = 0 err
 }
 
 attr_check_quote () {
-
-	path="$1"
-	quoted_path="$2"
-	expect="$3"
+	path="$1" &&
+	quoted_path="$2" &&
+	expect="$3" &&
 
 	git check-attr test -- "$path" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
-- 
2.24.0.627.geba02921db

