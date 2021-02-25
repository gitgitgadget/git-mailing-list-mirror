Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A06C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE2D64F03
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhBYKVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhBYKTA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:19:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D935C0611C1
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:17:25 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o22so4813026pjs.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=WICIQBZKLJg6NCnY6gpJzJLKyWs6NYvTBJL5j9ILc0qfsi5PZA1Up+jxxXDx478W4j
         /3aH6IlpbUDwOtfBe/inMcEI302oXXtgOnoHh4y3Z0MZUrMCD1iSUuRcP3jGRzlyovjX
         MLbnghMzE/qlrZM8Ej7XkIYl+xJVwnwCkRe8Xle0p2ezHVoVejXqAeoPkzXDluSIfiqk
         wVsk4phMUVt9Rgc0CKnRueXb+Uai8oYtruBy/Gmr0XdkqM1xEV9LvfsE33QplnRivEBJ
         VFX0UhQRRmCTr9jeHBHfhteAHpr4v1QFsdEpNKlT4o83blURo+MGJLL9iv+ak5jHG6y4
         occw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqyQqnN/r9Yp2nVabx5VAmks8N5fv9M2AVAwzn2f2LI=;
        b=nSJYmt8Nhu+33wFG4QOxM62/6wT1Zoe9GHCQjpW1Ja8JYxb3X/MsrlG628YkqWjtbu
         hfomD/vRB2JGEVyBclvsbBfUjuGFDuL8FdWm5KknPzPie4A299AM2YFOPpBxh6NzLFk8
         ajPs15GP0fgtKoJdzeiHQ0FNB7UnIcLjuEH8BneO601IvIA3WNN0f/AE4WAanAnXOnmQ
         I80SVPxjIoPHKpw9sg/+L3npf8LMe5rkyzZ2wz5sCRiZ6XBvhrU4P2X1xXGoWjDmrvW7
         V9KS+Bz4BHnDPUV0VIa6eNjoTxWE/VLBVax6JfoaWZu8HW2SzMUeMsj+2OX7zv2igfYm
         AoFw==
X-Gm-Message-State: AOAM531uAH4h0iBSvqRKdbNzfo5UwbngnMZSETex57whsE2h9oYs7v0r
        Gs1K9XkACkwgRbm0SzXQEL2bmX38WC9eew==
X-Google-Smtp-Source: ABdhPJxw1m363eKk70qn4aXlQxedfRoPZ9MgQkmN4QzARQKkeMPVLHJHwLE6SCqQ5cm42tH3iuuDLQ==
X-Received: by 2002:a17:90a:bd05:: with SMTP id y5mr2662010pjr.6.1614248244741;
        Thu, 25 Feb 2021 02:17:24 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:17:24 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/6] t3437: use --fixup with options to create amend! commit
Date:   Thu, 25 Feb 2021 15:39:02 +0530
Message-Id: <20210225100855.25530-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We taught `git commit --fixup` to create "amend!" commit. Let's also
update the tests and use it to setup the rebase tests.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index a5a20354e3..d0bdc7ed02 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -72,40 +72,16 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	git tag B1 &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	EOF
+	FAKE_COMMIT_AMEND="edited 1" git commit --fixup=reword:B &&
 	test_tick &&
-	git commit --allow-empty -F - <<-EOF &&
-	amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	EOF
+	FAKE_COMMIT_AMEND="edited 2" git commit --fixup=reword:HEAD &&
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	git tag B2 &&
 	echo B3 >B &&
 	test_tick &&
-	git commit -a -F - <<-EOF &&
-	amend! amend! amend! B
-	$EMPTY
-	B
-	$EMPTY
-	edited 1
-	$EMPTY
-	edited 2
-	$EMPTY
-	edited 3
-	EOF
+	FAKE_COMMIT_AMEND="edited 3" git commit -a --fixup=amend:HEAD^ &&
 	git tag B3 &&
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
-- 
2.29.0.rc1

