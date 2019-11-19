Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D162EC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997A122419
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az6mzTBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfKSXzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35930 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKSXzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so13233483pfd.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l7eblVZ4wVsI1iYAZbLfEt0G2tqwBbkwLGhdLAWW1HM=;
        b=az6mzTBsBvHFDVoeADUre6/zkH0vlkccbKsFo/bimyevRShb3m0CCdYe+/Q+xpeH1N
         x/Gs8dmY+COobiEY2h13ota/LL/Ygp27iRKvzHReUdTdg8AjglDtstHs+ZualfbWqEvH
         BBskPHqN8nNOKGHVG4HmozyC5UV/WGI0ItQ5nOOJQf0NbNMZDk+F/JGsU2LmnE7SpDIa
         a8dVtbHRPRaT4r4UE4icbBCTcGjaSDXMpT/KNGxTMefsuhRJUMJ43i6t68tRuwBajnff
         zQmIuYoAFY9db1BlPyeWODmnYrRJQ0+FI4a9ZPiqwzaOgm100ODiL/Yv4NadfsnjCttx
         LS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l7eblVZ4wVsI1iYAZbLfEt0G2tqwBbkwLGhdLAWW1HM=;
        b=KyFvFE/jpxyUWdNKdf/Lyf+Vwq5SGocNVmPM6csjQ8HiXIIwRP9Y/IbX360Z9t8FyH
         jMOuhvLM39A7CTp34VtPp1EmN3KLNTXCgAVdjCfz702NzK5vXUzN1c/Ctv3oLXvaCzDQ
         aFEgf7Pewq9LRudHsshmyL+5WuxskIyGPBOS1De89HHEuh7/o1uIsQxhFfgrBqVaY2nf
         XQu169nLNqG7okmTc1vhNZHAc1wqMBudJxsXOyApuZdagttKEY974kzEJ18wOOu4lzOZ
         xiHeDepnD7JEOBp7oO6az8BnycGYQ8PGAZ9MtyAvQrpX5sgTuYMPvX2Y6LWih4mTsGQX
         mzsw==
X-Gm-Message-State: APjAAAUlSFDHVbwWynH94NTrCbVo9Qt3KJWwD8IMDgXThucg2BEM52NS
        pkHG0f5Mih6g5ppVC1dfXIIbvhH5
X-Google-Smtp-Source: APXvYqxvHswoiACvaGXrEbX0dMSmpq1cIUbwGhJ5y7twgEbN1ooVvZ3k84uecshoJpBlgoWktukRKg==
X-Received: by 2002:a63:e4e:: with SMTP id 14mr8534652pgo.237.1574207739621;
        Tue, 19 Nov 2019 15:55:39 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y14sm26931112pff.69.2019.11.19.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:39 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] t3206: s/expected/expect/
Message-ID: <2bbcafa08ae201f9612d37f6c7962a221e5d1d8a.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For test cases, the usual convention is to name expected output files
"expect", not "expected". Replace all instances of "expected" with
"expect".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 87c6c029db..e14b4951bb 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -121,88 +121,88 @@ test_expect_success 'setup' '
 test_expect_success 'simple A..B A..C (unmodified)' '
 	git range-diff --no-color master..topic master..unmodified \
 		>actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
 	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
 	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'simple B...C (unmodified)' '
 	git range-diff --no-color topic...unmodified >actual &&
-	# same "expected" as above
-	test_cmp expected actual
+	# same "expect" as above
+	test_cmp expect actual
 '
 
 test_expect_success 'simple A B C (unmodified)' '
 	git range-diff --no-color master topic unmodified >actual &&
-	# same "expected" as above
-	test_cmp expected actual
+	# same "expect" as above
+	test_cmp expect actual
 '
 
 test_expect_success 'trivial reordering' '
 	git range-diff --no-color master topic reordered >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid r1) s/5/A/
 	3:  $(test_oid t3) = 2:  $(test_oid r2) s/11/B/
 	4:  $(test_oid t4) = 3:  $(test_oid r3) s/12/B/
 	2:  $(test_oid t2) = 4:  $(test_oid r4) s/4/A/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'removed a commit' '
 	git range-diff --no-color master topic removed >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid d1) s/5/A/
 	2:  $(test_oid t2) < -:  $(test_oid __) s/4/A/
 	3:  $(test_oid t3) = 2:  $(test_oid d2) s/11/B/
 	4:  $(test_oid t4) = 3:  $(test_oid d3) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'added a commit' '
 	git range-diff --no-color master topic added >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid a1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid a2) s/4/A/
 	-:  $(test_oid __) > 3:  $(test_oid a3) s/6/A/
 	3:  $(test_oid t3) = 4:  $(test_oid a4) s/11/B/
 	4:  $(test_oid t4) = 5:  $(test_oid a5) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'new base, A B C' '
 	git range-diff --no-color master topic rebased >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid b1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid b2) s/4/A/
 	3:  $(test_oid t3) = 3:  $(test_oid b3) s/11/B/
 	4:  $(test_oid t4) = 4:  $(test_oid b4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'new base, B...C' '
 	# this syntax includes the commits from master!
 	git range-diff --no-color topic...rebased >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	-:  $(test_oid __) > 1:  $(test_oid b5) unrelated
 	1:  $(test_oid t1) = 2:  $(test_oid b1) s/5/A/
 	2:  $(test_oid t2) = 3:  $(test_oid b2) s/4/A/
 	3:  $(test_oid t3) = 4:  $(test_oid b3) s/11/B/
 	4:  $(test_oid t4) = 5:  $(test_oid b4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'changed commit' '
 	git range-diff --no-color topic...changed >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
@@ -226,23 +226,23 @@ test_expect_success 'changed commit' '
 	     +B
 	      13
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'changed commit with --no-patch diff option' '
 	git range-diff --no-color --no-patch topic...changed >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
 	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'changed commit with --stat diff option' '
 	git range-diff --no-color --stat topic...changed >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
@@ -256,12 +256,12 @@ test_expect_success 'changed commit with --stat diff option' '
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
-	cat >expected <<-EOF &&
+	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid c1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid c2) s/4/A/
 	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
@@ -285,12 +285,12 @@ test_expect_success 'changed commit with sm config' '
 	     +B
 	      13
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'renamed file' '
 	git range-diff --no-color --submodule=log topic...renamed-file >actual &&
-	sed s/Z/\ /g >expected <<-EOF &&
+	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid n1) s/5/A/
 	2:  $(test_oid t2) ! 2:  $(test_oid n2) s/4/A/
 	    @@ Metadata
@@ -330,12 +330,12 @@ test_expect_success 'renamed file' '
 	    Z 10
 	    Z B
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'file with mode only change' '
 	git range-diff --no-color --submodule=log topic...mode-only-change >actual &&
-	sed s/Z/\ /g >expected <<-EOF &&
+	sed s/Z/\ /g >expect <<-EOF &&
 	1:  fccce22 ! 1:  4d39cb3 s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
@@ -370,12 +370,12 @@ test_expect_success 'file with mode only change' '
 	    + ## other-file (mode change 100644 => 100755) ##
 	3:  a63e992 = 3:  4c1e0f5 s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'file added and later removed' '
 	git range-diff --no-color --submodule=log topic...added-removed >actual &&
-	sed s/Z/\ /g >expected <<-EOF &&
+	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid s1) s/5/A/
 	2:  $(test_oid t2) ! 2:  $(test_oid s2) s/4/A/
 	    @@ Metadata
@@ -411,7 +411,7 @@ test_expect_success 'file added and later removed' '
 	    + ## new-file (deleted) ##
 	4:  $(test_oid t4) = 4:  $(test_oid s4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'no commits on one side' '
@@ -421,7 +421,7 @@ test_expect_success 'no commits on one side' '
 
 test_expect_success 'changed message' '
 	git range-diff --no-color topic...changed-message >actual &&
-	sed s/Z/\ /g >expected <<-EOF &&
+	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid m1) s/5/A/
 	2:  $(test_oid t2) ! 2:  $(test_oid m2) s/4/A/
 	    @@ Metadata
@@ -436,7 +436,7 @@ test_expect_success 'changed message' '
 	3:  $(test_oid t3) = 3:  $(test_oid m3) s/11/B/
 	4:  $(test_oid t4) = 4:  $(test_oid m4) s/12/B/
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
 test_expect_success 'dual-coloring' '
-- 
2.24.0.420.g9ac4901264

