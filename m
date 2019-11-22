Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C174C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420812071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dryHJAUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKVTAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43544 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so3724309pgq.10
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZX8i9H2wHYs5K6j7QxtMRQRcBYJDAdkn0cBzDzWbGKA=;
        b=dryHJAUKeyWsOKG1RdZ0QrKi9IXRrORPyK9rPuBICPfml+FYncgR6FppjAiCfjlQ9V
         2/Fw14GNIDG8izY6TXNsW/2T7HJTRSK1i/7tc153nfmiUPbqeFwBZ0Al9IGN0QKPkGBt
         C1UII12Yy0FcXZfctnz5PU8btdkboyIolYcNpKLyvBe/ucjBigo+WPc69JwH5bdJjYF9
         vZiwsgfkJflSa5yMBaGvBzh4pSXAvF6OcBT9KDN3nMLf323/EnFhul/3AjVW5uG8cuJ/
         ZGPTgFGm+XUreQw3qIRZH0LVDhLbZFnRSBsPIf6yQGpsSn/meTr1SL2NR9Ne5IMuOyjR
         29cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZX8i9H2wHYs5K6j7QxtMRQRcBYJDAdkn0cBzDzWbGKA=;
        b=LY0VUGZcYdjv5LYb+HJOmZb/9YOKnGq+5OJmYulm6wfIDaRo4sgXS1xr6F96L3QGC4
         92PjoJZ2h8Ulb1LeY4ertizzVBhUsrSfvfEkVHYdtXdJlOQeJibW+/p2A0KiFjtAImp9
         g6l30ARXtJumswsH2SiJac6Lp8uiZa+Buo+JuBTiud/wx6ct2/uVC9vHQqkhBcE58xxB
         bIotJ2pG38mzn0cVJ1PbHNmkI8gceXt1fpP4GVJF2Q7t0JWOJKC8cIHIq+ltiZPUvKJB
         MfdqSZvISlO6/qo6zWpGXa3dtoPH/kuMwgw5lhkhcso+0DaxeA9OSS9aFrClGmvdyLwY
         57pw==
X-Gm-Message-State: APjAAAU1g4SW49MFH4vmMVS9VWWmPTEg8w5ty1kGjQXNL9lZV7qH4CDa
        HyN5lsZSdfEnbZy5bXfEfx94PIaB
X-Google-Smtp-Source: APXvYqwzWR1mjqGYXCrAvwBT+fBiqp5R5tN4mmjoKALIWOiYYaX2MJk2mZL51drPP85WL0Wmhr8/nQ==
X-Received: by 2002:a63:551a:: with SMTP id j26mr9178966pgb.370.1574449216125;
        Fri, 22 Nov 2019 11:00:16 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 76sm8274766pfw.128.2019.11.22.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:15 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 13/22] t5317: use ! grep to check for no matching lines
Message-ID: <85c2f8ca2704e54c2d0e6e65822a04d21e383f6a.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several times in t5317, we would use `wc -l` to ensure that a grep
result is empty. However, grep already has a way to do that... Its
return code! Use `! grep` in the cases where we are ensuring that there
are no matching lines.

While at it, drop unnecessary invocations of 'awk' and 'sort' in each
affected test since those commands do not influence the outcome. It's
not clear why that extra work was being done in the first place, and the
code's history doesn't shed any light on the matter since these tests
were simply born this way[1], doing all the unnecessary work for no
reason, probably due to copy/paste programming...

[1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index a8bbad74e2..dc0446574b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -45,12 +45,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	git -C r1 index-pack ../filter.pack &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
@@ -149,12 +144,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -164,12 +154,7 @@ test_expect_success 'verify blob:limit=1000' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1001' '
-- 
2.24.0.497.g17aadd8971

