Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD2C4BA2D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B041024650
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 00:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdrZSCzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgB0AOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 19:14:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56187 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgB0AOa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 19:14:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so1444868wmj.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 16:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ggWSSSOrZj8rN/Gx9O/HDN8AwTSnklbBsJqCZKL7GxM=;
        b=hdrZSCzGiuhHWUg9lC1QAj7/ujCUhIWLurR6C1jYQG49Q/81QW6zANZIFTcDPjIBA5
         iqCNCfWDZ3bKUE+Z/Ix+8G2CzBPxFrZIP2yClVDIkGxL24PLuOk7rLm+IIYLITJ1NegU
         XT0PpZJLNQ0vBpyslKVt9jOJnY2P4SkVyOUOcbSEEtqK9vyOSb+M/2QrmKp9fhAIBysO
         YAlCAXQHODb8X8g8ppr4mDatjZTRQO2Pv+wIj6rqJhVP8feGBo/wfJb9RI0BhRRW727O
         G3IzGGdPWVzu58QH36dJxGeGNtCBl33ztq0pc5aukq/0M+UqS6C+35eOHypFbF2ML9jx
         B6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ggWSSSOrZj8rN/Gx9O/HDN8AwTSnklbBsJqCZKL7GxM=;
        b=UFezL+XkQgLqmFLKKg6WwtMRkqVkoHVjMO3W/8oFZTZ2AaOXjwcmo5RfTmWfPXKrzQ
         PGJktScuXeKB7at6h/TVSeQYIlGwOposQPsHmE2kqwxF/z4AFyYbTB4qD529qJ1/nKje
         KJmsUTs+PpvTIvRIuHkwL4T9d6y6BZKCvFzR4wh7fNaBV6+2vvUHSGygdRnAeVlIcB4d
         90wD/p6cppnIAkGeVxf4V6rwQQrdEXJR8pegI18tCq1gVbsVkm9F3lVJ1Vg98gnqQJiR
         BXWKtIBwxylC6HpwpepydFVRycrafsbVOhPM93aJmjItxJ6MOzIsL7eMR/1vA2S9YYab
         ZfxQ==
X-Gm-Message-State: APjAAAXu+7uP68MbjKpvzXNabmgYDyk7XiecmorbOKLh+lWGGQA8CRnY
        UOegXXylCixqPhUrioD2Qv8YGtF0
X-Google-Smtp-Source: APXvYqzpKPl6L4q7MkyqGHxz2FFYMiU8lKtVmP0NmaXtMRCB+mLIpvdBe0MW6Ta6eZHd/9UcTQB8Zw==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr1450766wmc.65.1582762468043;
        Wed, 26 Feb 2020 16:14:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm5374122wrw.61.2020.02.26.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 16:14:27 -0800 (PST)
Message-Id: <9e02a22dd00895304051519abfa34ecbf80f9ea0.1582762465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 00:14:22 +0000
Subject: [PATCH 3/5] t3035: prefer test_must_fail to bash negation for git
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3035-merge-sparse.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3035-merge-sparse.sh b/t/t3035-merge-sparse.sh
index c4b4a94324a..74562e12356 100755
--- a/t/t3035-merge-sparse.sh
+++ b/t/t3035-merge-sparse.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 	git config core.sparseCheckout true &&
 	echo "/checked-out" >.git/info/sparse-checkout &&
 	git reset --hard &&
-	! git merge theirs
+	test_must_fail git merge theirs
 '
 
 test_expect_success 'reset --hard works after the conflict' '
@@ -42,7 +42,7 @@ test_expect_success 'is reset properly' '
 '
 
 test_expect_success 'setup: conflict back' '
-	! git merge theirs
+	test_must_fail git merge theirs
 '
 
 test_expect_success 'Merge abort works after the conflict' '
-- 
gitgitgadget

