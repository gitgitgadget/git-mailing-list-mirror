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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B67CC43215
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7ED2071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJAbgMZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKVTAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36164 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKVTAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so3472343pls.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1pN5/XV4lc31sB+ya0Ydpg88mbbD5ma7X5LmxQVduA=;
        b=pJAbgMZZ7JBTedtckxsntZRqqrFhrBT1Ckv4TiRuhX8aO+bkuD954YQgw3qiWxDcMw
         1EHJAO6uul7fyXzAMiPwztEfV2BPCnbdo9W3O8Q6PEyOkPxhP/6jLc11ZZwqU9Di/tfs
         ZCyUR1g2Bu8jkWX1URVc94csjC+cNuPoBDRtURDbPodfSpNBF/SOLxU7UBXcfoDl3r3J
         DQW4eqSgRCMMuqj4ISY8wVBKXAWG+dIrR61HUHuLYvwY2Ud5H4RzJ/q9tg1wVsYo0zZT
         KYOqpqt/6Q+OWrpeI2cWk14xavYEMUcmS/nQCMg0wfW7Wqj14rBbceqd72jzBZoPdyOB
         NDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1pN5/XV4lc31sB+ya0Ydpg88mbbD5ma7X5LmxQVduA=;
        b=ieymTzrqUwzU3908JzZNfBO5gPJWxjSpddLUqJwDh5Ddjyf1a+MeUpQ58XrrEN+hlL
         CUPafXZCWhQjMYoDqzoBjnC/IZM/33luKgqhFaQSE/o/HKrZ8KIJnscOsPHkr4Lv+9M0
         TRHoc19sssUr2ZsK+CECKCjK6iGO7f8gUgDwgPzUNQNwpJIPeiu4/BFw51aYRQf4uHDK
         bmaFTRUc7HCrXotJA0LufAexew7pVGVmHbFIpVg+0FQHKYLMW/2VgPTv5dcCBscZO1AW
         y8Wt+gzQWI9bdFU99/XoswyuTSchZMZ8cG74082PP1qht6FOTa9x4UM7A5OlT5g6XFsk
         fcsw==
X-Gm-Message-State: APjAAAUHBA2l9fumwkPL1bAs01gOPWINovBhITupT9XqwhS0qC3Ik6dI
        EGWPlgW1xQ7cjoBAeTRNMCvfAiyv
X-Google-Smtp-Source: APXvYqx+2k6PtZ9nm1o/0oaJEWyE9cgO0ImqbmpBE+tIokOj8ypvmZtMyvnBouO1qrJOtajgsoBVNw==
X-Received: by 2002:a17:90a:6505:: with SMTP id i5mr20640088pjj.36.1574449208275;
        Fri, 22 Nov 2019 11:00:08 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 186sm8492070pfe.141.2019.11.22.11.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:07 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 10/22] t4015: use test_write_lines()
Message-ID: <69933168398c7524c29945435edd26a8b0520c39.1574449072.git.liu.denton@gmail.com>
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

Instead of rolling our own method to write out some lines into a file,
use the existing test_write_lines().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 7fb83c8eff..4c540b1d70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -771,9 +771,9 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
 	grep "new blank line" check
 '
-- 
2.24.0.497.g17aadd8971

