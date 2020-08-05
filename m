Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B853DC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947D02073E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9JV4kpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgHERxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgHERtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:49:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC58C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:49:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so4957300pjb.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2x4nvf5u7YHLs/rvuQ2DKG/frGYuFxUPbbH8Ur2AHA=;
        b=Q9JV4kpY6x7rr59uNFknHTktXpZHrdBEwVgs+pj6+tYbhXtD+8Vq1jpB/CE8Rtrq01
         yw00178LCzj72/VhQ8kxltmhrJLUabo5c0ZBaKhD4q0YRTZbiSsgXK3uzf8DMxz2br0z
         29f7LNQHVjlyR8Cvg1XCtXYSGWssp3eeqBwNaLtZi5wkBV35Wvst1QZKEiS7ndrC8eBx
         BhqWqm0u016gQVy/eJAcsY5ugtuzwf9sqtWaIXnZcXMxR1/w+AYBNWgLyGnE701FEekH
         Q836879ssjjMrVB3vY0p62ZC4x2N5wJjgTDmFASgpayL7Tlhqojx5VJ1tG3ZkOpgo4Dg
         jrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2x4nvf5u7YHLs/rvuQ2DKG/frGYuFxUPbbH8Ur2AHA=;
        b=KxoxhxyMgmvspQQFP1nucawUSOhQYSswUvGzmgGsFHQH3o2irYqKHcKa/JZhU04sFd
         5hX3UWZdCA6uDYYnLwFXQb4dfjqW+rJI/9bI06tzS76Y5X5GSfz3oQdyCilKGqQ67OT1
         w2uudGmg2EGiYoIuhR7kyW2J2RrgYQ7yfewFGDvquwT3RBAat0GG8layDJkd748lULUO
         2HC1B6jfyJPzUnSPvW55mmTeS/ypQVIBe3NIcon0E7q5RaVxInaXA6XUto6sdyZd1Jpb
         f42nTfdrwmjWnW6HXWDCBrCg5l7IeE8hFHkZGkvxujV22h2QbTOl68z7hN2QF0Y4vSSP
         Ye2Q==
X-Gm-Message-State: AOAM531SAHCfGU/JF6MI1VOX6DBRKR5s0l+SCsQElZrBRZYElP7ug5na
        TsZXdQfmu2eoyNWABIHHxL+/F7MC2PM=
X-Google-Smtp-Source: ABdhPJxfwwMkBIF1+5vLBRuEbMmCW6fEBxC03R+3/Pm+Kg/L8z5R8VFNrKIvHPZwWE9lHNf2nMLI4Q==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr4575429pjb.226.1596649789229;
        Wed, 05 Aug 2020 10:49:49 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.185])
        by smtp.gmail.com with ESMTPSA id z77sm4765150pfc.199.2020.08.05.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:49:48 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] t7401: modernize style
Date:   Wed,  5 Aug 2020 23:19:18 +0530
Message-Id: <20200805174921.16000-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in 't7401-submodule-summary.sh' were written a long time ago
and have some violations with respect to our CodingGuidelines such as
incorrect spacing in usages of the redirection operator and absence
of line feed between statements in case of the '|' (pipe) operator.
Update it to match the CodingGuidelines.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9bc841d085..4439fb7c17 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -16,12 +16,13 @@ add_file () {
 	owd=$(pwd)
 	cd "$sm"
 	for name; do
-		echo "$name" > "$name" &&
+		echo "$name" >"$name" &&
 		git add "$name" &&
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD |
+	cut -c1-7
 	cd "$owd"
 }
 commit_file () {
@@ -125,7 +126,8 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD |
+	cut -c1-7
 )
 
 test_expect_success 'modified submodule(backward)' "
-- 
2.27.0

