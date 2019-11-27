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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921DB20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwt3Lp8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfK0Txh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44302 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Txg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so10533096pjh.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IOdCZHq+8yw7YBBrvExEJd34tyBAih6z43dUJHDP6bw=;
        b=Dwt3Lp8VVW1UskMskDRPE5IU7vgzEvrDIdM8xeBVIfsf/3Oc3IkPYRbFIhX4kEa2xX
         xKqtSwGsnSpmYavYhXMZOrRW6KXiCFaezKtL2HZLsVc9MwZNjW3c5mY6WgMCm/kRlo8K
         PY6WFhp4dJBqDiyIV+a0r5+aEhaWDdcgC9FpuUiTr2yy1OxcPTrsXrM61rHXliGKR8Tf
         ot94KTAxdURTunagojVcjq67NBJB1TUVcNTV5Ebh9Wbkdm4w/L7o1m3IqghMw1KxWv4g
         d9tf5gCF+6QvdtSNSiXzUGBHOMJk4Mf01EHhPxPPbR0R/eR/izuogbpzljwi2Fm5OLop
         CQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOdCZHq+8yw7YBBrvExEJd34tyBAih6z43dUJHDP6bw=;
        b=oqxV8bnsI8Ya9ddgLA0WXU4IJLDKul/TwqcNcGDzMoreLcFkAkZKa4UMUDrPbL2Vdm
         R5dHlE4NSkYxz/kEVbJUfuw1Ftd5mE7K4f3OPIRxSpLPpyMTBOZcLCNveKHONW0ZKzI2
         P/LYQgUca8RhOJq+xkViW3M5tB97y5aJkiWZCg3cptpzbc5CHmPLVuhmGQ3t2JosC/HJ
         JK8NhwJSi1DFLPxuLhl6VQy1umbYCaTdLrMmgtq2PZyr5Y2+yUHR2lfePQ3wgN1/STpW
         a08VT49AtULojUrz0nUte12Zzw255SR7p6AouvXDd3sBex8cDOh/PPt2Glj1g3urz/0W
         RGog==
X-Gm-Message-State: APjAAAUa0k6ZrDv7Ro5XXtF9iSi0zmM34Izzpwdbo7J9Wyv6azK/31BF
        q1cziot4Hy2iq10d5nDZmh3BnYr4
X-Google-Smtp-Source: APXvYqzHMfqsDR/v2TAyXaj8CqAxiqeOAhyO5dtxP7UhlZ0kYaaNw5fjZrXm5joZh7Gah5HP57hKIQ==
X-Received: by 2002:a17:902:b610:: with SMTP id b16mr5961995pls.70.1574884415914;
        Wed, 27 Nov 2019 11:53:35 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id l9sm4150214pgh.34.2019.11.27.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:35 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 13/26] t5317: use ! grep to check for no matching lines
Message-ID: <fa238be28b5f4e1281d310eab0a6f90c15196d88.1574884302.git.liu.denton@gmail.com>
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

Several times in t5317, we would use `wc -l` to ensure that a grep
result is empty. However, grep already has a way to do that... Its
return code! Use `! grep` in the cases where we are ensuring that there
are no matching lines.

While at it, drop unnecessary invocations of `awk` and `sort` in each
affected test since those commands do not influence the outcome. It's
not clear why that extra work was being done in the first place, and the
code's history doesn't shed any light on the matter since these tests
were simply born this way[1], likely due to copy-paste programming. The
unnecessary work wasn't noticed even when the code was later touched for
various cleanups[2][3].

[1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
[2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
[3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)

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
2.24.0.504.g3cd56eb17d

