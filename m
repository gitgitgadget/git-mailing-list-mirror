Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27EC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C662082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9kXxbhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK0TxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38781 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TxT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id f7so10551499pjw.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dxh2jaW1UxAziQYQjHScRCLmQiudoN4gja7P1jegEhY=;
        b=H9kXxbheIjylpxQKrx0g7wpmQ7z9gbWH95Lp7rIhNqBLmkOl+V6FeDj+YfVxZCxNZ5
         KRYToU9RYE93ZPVy0fbjmOFv9OZbH2vhPL/uT0pcS5gsbGLFTxJXfifkM4m022Lufm1L
         3GK99VZ3xsUpSfNxOwT3x/yK2lbkFRh38tF1D/s+OCwaiOyh3pyTWRuDaBnWbG2Ykltw
         aZStoqvmCx8G+Bfv5inCg6T3cBfOqgjjvBCEWAhF53ARPhaIfehONBwddh5nPGTK/2ci
         a32mjTNn3bt9eUs4V8+Ghnx3SVRoSi5xM3iN+qaLCrLkQVFfgHM5l7h02SjHqks84Ina
         Cemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dxh2jaW1UxAziQYQjHScRCLmQiudoN4gja7P1jegEhY=;
        b=EmHw3Znl2kzTWnsxVXSrIf0VD0fMuVynh/VTinQIPlofxywBFV1tUgMDj3s2O4pMbm
         DdPFADc1FIE9rQCFAR2C3fFPJjLY1R3ox/A2jNUUmtFROSw1h2HuLlzCSVVw9raWyDjf
         eC2iXLsYMx41qdX1K06eMzkS4p4dUZ3ZH9DvlaE+mO+dKdq/ViJAG0HZHh0xMwaHG4iM
         gbdC7ubKItBQZNCk3AkUGP3s1Q4yRbnbMB6HfoGcPqrIDcz6ZYhVkpOqtvQjMFH649iT
         HXTZrtHEHj2X6/IxRBgxuErPIYhH7412R4jSo7AKOT0Z8gobPo6yls2ioMF69npts6qI
         jPNw==
X-Gm-Message-State: APjAAAUYius9T4kWoGg+3OROOjrU/eCMoPvzG/nwvH4ANkoIh+qA7NlY
        jyoO8VL95BmDPgGpS39lHxqaYX52
X-Google-Smtp-Source: APXvYqxnHwFpulAWHpboIvraajbotzZTZKCECvvfKIFfJmMwYZezckfLitc4EaII7zMWfVx8wGlxvQ==
X-Received: by 2002:a17:90a:34c7:: with SMTP id m7mr7966262pjf.103.1574884398042;
        Wed, 27 Nov 2019 11:53:18 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id x4sm7293833pgg.61.2019.11.27.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 06/26] t3600: use test_line_count() where possible
Message-ID: <d541a8d4d4b8fc224fe1967ce5717d70c0f2b55f.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have a helper function that can test the number of lines in a
file that gives better debugging information on failure, use
test_line_count() to test the number of lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 8c8cca5bfb..f6e659b7e9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -113,9 +113,10 @@ test_expect_success '"rm" command printed' '
 	echo frotz >test-file &&
 	git add test-file &&
 	git commit -m "add file for rm test" &&
-	git rm test-file >rm-output &&
-	test $(grep "^rm " rm-output | wc -l) = 1 &&
-	rm -f test-file rm-output &&
+	git rm test-file >rm-output.raw &&
+	grep "^rm " rm-output.raw >rm-output &&
+	test_line_count = 1 rm-output &&
+	rm -f test-file rm-output.raw rm-output &&
 	git commit -m "remove file from rm test"
 '
 
-- 
2.24.0.504.g3cd56eb17d

