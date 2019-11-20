Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B7C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28392068E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2rsv+Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKTVSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35129 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so404076plp.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5p2ZOQuy+iNIQ2CYDd7NpARtwccGqLHTFui/tKgJLs4=;
        b=N2rsv+SjzyH2B5vTR8XtmigzQA8bLMJ2QIgujUeAH1TrRHS+pbPd/D1s/hqQO74jb2
         jUzQlcQNngiNRSeRJD9feueRMand03Cr+QYSMC6k0JD4Qtot0Sh5mWMxZLFV9+7jokW/
         T4EC9+HA/oTYyhChciPGe6yAtdtzfr/Q8g9WYROxPCLG8227YyiTp1Wfd967my8FQTG/
         uevIBQvWMSyR/0xPxkL9ZLvm5R+qQMzbMt6F0LJ4JqGs3jPeoxkl0Tbnl96qwYNDf2bV
         Ne3/9R011Z5JdaT9zvFBwI5WoEt35evcFmN7jwJeVdhmfbcAWZ3ZlYj4fSa44lMpS4kC
         mm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5p2ZOQuy+iNIQ2CYDd7NpARtwccGqLHTFui/tKgJLs4=;
        b=dkd99YeCL67uMvCL2c3yNpbambhCDoyia13+NDlAwv0trRFqPVFSEGT+x25BiipUQ+
         qX5jd/U3mUa2JgcX1iQFC5Kq/ye/hoRldUi2qZR5QhYscsyW0ucf7MYw4EkGmEajIM5g
         pUg+LPdUxtW23+UjdaB+UDhpJNmvjq8yI8eXT3A7T447VyKau6lU19rLLCyYFrVfjFAm
         I6pZVuKcQ8WhFxktI+UFp9YQBTmZks7l2goCuo9FgitHr8JvKqYrmXo303oxxYAwKWS8
         vxI90dHunBcglD680+i/NHUdgjiWZ+aVujUlVfGona2VSsetx5MhN4Ul5VF9A2A2wx/u
         HUxQ==
X-Gm-Message-State: APjAAAWLf3xbE7HIZJN3tlzFAY2NRbxMLn1KspAWx4iukVdAzhGoHou0
        rEBHnGsIX1b3Knk89v15hnHlpTLn
X-Google-Smtp-Source: APXvYqz4RZSsduKMAFpbiTFstNJKDsfVw5wOWtzD4mGlnkDvgjiUPrfM0NDLuzk5Vh/gJOO4Ex7/DQ==
X-Received: by 2002:a17:902:126:: with SMTP id 35mr5155033plb.105.1574284720729;
        Wed, 20 Nov 2019 13:18:40 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id w2sm330458pfj.22.2019.11.20.13.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:40 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/10] t3206: s/expected/expect/
Message-ID: <92df18b261ce9299a5f76ab61c93ffeb0503521b.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
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
index 41606775d4..f654aed54f 100755
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
2.24.0.450.g7a9a4598a9

