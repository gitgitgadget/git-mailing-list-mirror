Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D84C433F5
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiDJLYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbiDJLYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:24:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA866AC1
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s28so3133374wrb.5
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DO44CQDzRsfM2/xk90FEsKo9GiQndjOLjbaSEWfRXlM=;
        b=ckFWH9O9WMP6xHmKmBgPlpq/Z96bOcQyeY67Yhr1v/WN4KbDsFRA1me2IJ6K4skEYK
         AEUfyNFEKOjXaNkcwKcDw+RoG0v9botZpi0lRQgZSM4b28defOwScQUjYe0oLsb3GdzI
         GQFt1hbvaEJJQp4QW2/n2UEjxZliOTbveU02mGBmDVKmyg9QK9L+sKRGRZSZ2RVgddNF
         0kUKHXFT3/Tn8oSqrH+MkeYJj9h/AaZAuFM2AMBL23c4+sRRYHQEitAmuwXj8nXaYnTT
         ff3sOVW1xTHKa/F2xdb8oMFv7FlVY0nDUIMPqAZQZyETr1Waj/TfVGSnekJMFpRlIh+k
         OLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DO44CQDzRsfM2/xk90FEsKo9GiQndjOLjbaSEWfRXlM=;
        b=UqvseUFlofMYsztqmSNDkG1nmV1CKhBQcTEiOjQXj360vNIptBBIhr6jEa67Es9ejo
         ansRokQJYl0Ee7161XL9j165bj2cSihLIBJVqnlHEX1nSFY76IcNVrtB8X9fOTTwsGZi
         RPL47PspwCvWIw2bqqy4cb/naYe9w8o3PvNA5FNcCgJHqnrzc67VDKevfoZ8+DrWBmpz
         Si+4CcUMrhExFW3Cm5Wn468v9Lo6QJRaM6bKC7iJZ0VTxAOZcCNqMfvbv6gbjpnbEPcF
         Thm5Jcl5rIeFpYP3+INCZ1Fq1buHMkD4KsK8mui46gUKVAB1abL2Bw3EVcAQncnLDra6
         sUVA==
X-Gm-Message-State: AOAM5327OvjRY8wV3qRbAwTwNALFQUR+3SXyxhNmYdkg+Xt6/6biZ5h4
        W7cHxvLZ5l809ZiTy1ZFvzYInZJFM+8=
X-Google-Smtp-Source: ABdhPJzd0yIkJZDhyOBml8yCFgm/9k8+ii7J79H6fCn3TkeQC1FCz/p2kOzMkp0ifsmlsQ/5OO5vUw==
X-Received: by 2002:adf:efc6:0:b0:207:9d86:780a with SMTP id i6-20020adfefc6000000b002079d86780amr5584670wrp.686.1649589726408;
        Sun, 10 Apr 2022 04:22:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:22:06 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 6/6] test-dir-iterator: handle EACCES errno by dir-iterator
Date:   Sun, 10 Apr 2022 14:18:52 +0300
Message-Id: <20220410111852.2097418-7-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Handle EACCES errno returned by dir_iterator_begin() by printing the
"EACCES" string instead of printing "ESOMETHINGELSE".

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/helper/test-dir-iterator.c | 8 +++++---
 t/t0066-dir-iterator.sh      | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
index c92616bd69..fd07429f90 100644
--- a/t/helper/test-dir-iterator.c
+++ b/t/helper/test-dir-iterator.c
@@ -7,9 +7,11 @@
 static const char *error_name(int error_number)
 {
 	switch (error_number) {
-	case ENOENT: return "ENOENT";
-	case ENOTDIR: return "ENOTDIR";
-	default: return "ESOMETHINGELSE";
+		case ENOENT: return "ENOENT";
+		case ENOTDIR: return "ENOTDIR";
+		case EACCES: return "EACCES";
+
+		default: return "ESOMETHINGELSE";
 	}
 }
 
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 974bb13092..4bf6456735 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -861,7 +861,7 @@ test_expect_success POSIXPERM,SANITY \
 
 
 	cat >expected-no-permissions-out <<-EOF &&
-	dir_iterator_begin failure: ESOMETHINGELSE
+	dir_iterator_begin failure: EACCES
 	EOF
 
 	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&
-- 
2.35.1

