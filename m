Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E885C2D0ED
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C9F2078E
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otNkhJ5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgCZEhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33272 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgCZEhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so2278858pgo.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rk93iIFXLxxfBSCv6fjokclVhOQ1+eI0Uc28Ooz/j2M=;
        b=otNkhJ5UnQunx0A5xTeeShUZkq0yi33QZ9qVNMPUsWXlzd0j19QMOgWS0dCJL515Yp
         Qfyt4WHdr29lbH1q19RvoCdltQa1Wg5ipgYNaYleBLBISgtWHHARgAZFqqNEtCwVZVZH
         7srDdLWlf7i/0n8JxN9BGqqDWmAY8sqiN/ZjjFeBlNSPE26pWlUzOpWFm0dxLotC14dX
         o8lVQWWwsGs6U2OHtPE8g8oJfb6Mi2NdjSwAv1EEWSgN9bdltFyv5JZaKQV/PDDV86/j
         r022rnVykURTgN5GsuPWgHNz4X3qGjEJbnwShdfc5mVlKqHs1Ya/ZLfl/AAB+Qw6tXe2
         gAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rk93iIFXLxxfBSCv6fjokclVhOQ1+eI0Uc28Ooz/j2M=;
        b=anaMjC8defgFKi2umSV2qHpWVtv2BGQT9yegPZauuSePXQxV/ycUyaX8V8IOcIfdUJ
         YscrRfQvNnNw80uzNEW8vWaqGoWcgKCAkhnZ2Q2L/32T/mzksm8iDgLwdDz+oESFp/ks
         a5EsTbBN/FxyNP+gQhQPmbWjrooWyZJGcM0mnG9aFOTPj5QM3uzvKJkEb5yjq3SHPq9L
         xSaxZI7t59qrdmhm0Ksic+/UOgiUdBcf5SKUfn/kzc2WFuxP87gEc69Lfa8rO95feUw2
         sKUc5oimUtkFRhgpLA7m5xRkuTDB63MEk0W7f5ZqXR6+LTO4obtF/qhYnKq/JYcb6j0S
         jziQ==
X-Gm-Message-State: ANhLgQ2jLcUjiAcVaZd4ASKatiwsOd3vUW8FsXNhYB5voe/NXtxgiX5+
        vwQn2w+BgkyC3oxcKXCspntE8l+C
X-Google-Smtp-Source: ADFU+vs0ePbSdwRxFkm/N07CDj0kJDI3OF2ba+2op6Fj36JZe1lCJQ5I43fbq4ue57AMxECtsHedqw==
X-Received: by 2002:a63:c712:: with SMTP id n18mr6326643pgg.343.1585197472476;
        Wed, 25 Mar 2020 21:37:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 3/8] t5003: drop the subshell in test_lazy_prereq
Date:   Thu, 26 Mar 2020 11:37:33 +0700
Message-Id: <f871a7f39534c122bdcf4b8bd18971386e4fd1d0.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_lazy_prereq will be evaluated in a throw-away directory.

Drop unnecessary subshell and mkdir.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5003-archive-zip.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 106eddbd85..df1374a312 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -7,12 +7,8 @@ test_description='git archive --format=zip test'
 SUBSTFORMAT=%H%n
 
 test_lazy_prereq UNZIP_SYMLINKS '
-	(
-		mkdir unzip-symlinks &&
-		cd unzip-symlinks &&
-		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
-		test -h symlink
-	)
+	"$GIT_UNZIP" "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip &&
+	test -h symlink
 '
 
 check_zip() {
-- 
2.26.0.rc2.357.g1e1ba0441d

