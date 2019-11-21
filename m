Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF24C43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECE220885
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTVgBCbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKUAqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36162 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id cq11so629827pjb.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MuFj+mdISjZ0yedf+NDisslQRTro0nNwv4BA5jMU80k=;
        b=GTVgBCbBM51g7tAQ+hR7s+t1GvpuguT/hSDFaXobb7ZtNrTV3DMNBJkl3qJlwiVWC5
         vW8yd6Tf28j0ZVYEPKyvsOD3k8oIIfBCh/cTzEUf73noed8vOn5xPeWq6VaFBdh4jDp2
         yKRaBDCpVzYeTQuELsq3rtI+SGKp/qLQ3tPoHuJ9sPEb7K8vmqJnkrDctul8MF50/c5M
         /WOJO+mbTehxvmWX+mxn4yQTqzFdMQNJn5DzhfkiDGpWZ+DTDXgZcQs3RqTAqIvXbgbT
         +Yzt9X38G1CIX6nX6Yz0Sc3zanBskGG3+97krgnXRIMx36RZqO0sYQwSov/9lyekg0A/
         Nzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MuFj+mdISjZ0yedf+NDisslQRTro0nNwv4BA5jMU80k=;
        b=cx/HbOQxsjc6qHm5uFm2SRpCl3qG3jZRmmNwgKV8rsG2kWqWBQPRhFcL4B8X9iYRj/
         QyDqw6FFAZJzst24dietHl8W/a4i9pkDrcOJBhQ+ZPqOfdzLp9eH2ZHDtlP2q/R+/ySI
         EBrzBEqoQUs/je/VvSF3rmHlEv+jYwpB+piKlQzG6JbqANKYrrtMF9+48XTdDfgqdoVC
         QwE1QYrMQx8vkr4LnM0o2IP9YuL6TrhSHXMErXif0Ek3ln6rTWVX/6YOP1KuL4sDo+3k
         oWyxAayMhnOCS6ZpSSJo5WFZbPxHRgSjMFc3znh0aLUukI/TgG3loUlomDLpcaEu5vIF
         JyyQ==
X-Gm-Message-State: APjAAAXzVWHuZIAVVVm290asZziuGF60mvgS3ez/vYPfXZ3grW83AZ7w
        7j5YzLFLXfE1JhhFfg8O9ip3VPvN
X-Google-Smtp-Source: APXvYqy2fbkUpZDbhIZ8u4oGAcAeZN+Pnm4fG+h75kVDGq0CKDyBY6egiyg7/kT9hgO+Rtjyypmsmw==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr6624421pjo.39.1574297160482;
        Wed, 20 Nov 2019 16:46:00 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j186sm581261pfg.161.2019.11.20.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:59 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 05/21] t3600: use test_line_count() where possible
Message-ID: <97ad3604dd9a84f20d4913e69bf2b16a6f7c5103.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
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
2.24.0.450.g7a9a4598a9

