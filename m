Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A9C4727E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BE923A65
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgoK9OIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIUWBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgIUWBe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:01:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3AAC0613D1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so1087638wmk.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Iaubz4Z5RCnlOaRNxePs2n3D8EJw5yieWuKUtsG0RpQ=;
        b=MgoK9OICPt0rImP+XqLUiOmMloGuU2zk7JLoWqffBXvMKTs0iJZdLXTYpo/vZjkS+0
         y18f1GRkoh7iEPNrBWiTY7d8UQfg3G1DCHjZfWUlkUNIQ4ePCoGaTI0XNeeNwS1HafjI
         kqiVB79MOUscfyWNDUjxIIYKqwyFT5lZPy1ZOLTzblzi8hCU8AM2tS5u8PSRPTcWJwuc
         kIPzNSbnQ0kolSvuZfDrdowsC1s70QTA6OpPVyeeMCClJNW1IOOeKcqhobxlHN/Mu7SB
         GgX3Dfh9rKA48/6xipA0JrT52Ut9/027QvPpObHSLolqFGFHPrIEoq9tlbizSlfGNw8T
         KzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Iaubz4Z5RCnlOaRNxePs2n3D8EJw5yieWuKUtsG0RpQ=;
        b=OQMVhwQJ3Bx0dh6Sv+ijrdyhyMZvjqSCF1tDP0+XLXQedFQvPFJR7p3B6S3euY11aL
         SOx4fQMsbHXarsDt3jdwy4zK9bRXWk/nNe5wGrVH3jcZAyFwq/6UNYtiBiOKYf0VYbyW
         UDEVAavy681oOMTivwU47zzfVfWKyUUyBl+D9lne/dt4UQAoV42duYdFMJP2UwfuMBP+
         7dYQtfM8ymsrujBUk5KhoyHXGa6HoVFCB/iSt7Csr88m63bjDBAHZwja9AuqyAPIW9Vn
         0qecEVzp9TvDbMbJp3gYhd9ePwD+C6AoomC41GR/vQ2EWWAZfe09qyu5Za/ILaIog70i
         o4OA==
X-Gm-Message-State: AOAM530q7MjEi69uxiOZW8V5/6LUBpPFEVxBKLt/ozwEgp2iRjbP7VO/
        nEjdvb4aeJiNPCNpmnjPq/oKew9qgJk=
X-Google-Smtp-Source: ABdhPJx07aVLJ8wJnBrTaSXu4+O3VrsXvcQWOYhokb4uohRWY9LkZ5cktpkycwUY4Uw+RSUOLUAP2w==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr1333528wmt.22.1600725692512;
        Mon, 21 Sep 2020 15:01:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm23915505wrn.21.2020.09.21.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:01:32 -0700 (PDT)
Message-Id: <c2c1238b5d9dde684d100fa99437a813140cd615.1600725687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:01:26 +0000
Subject: [PATCH v2 5/5] t9902: avoid using the branch name `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The completion tests used that name unnecessarily, and it is a
non-inclusive term, so let's avoid using it here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..7b7bc6e4bd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -542,37 +542,37 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 '
 
 read -r -d "" refs <<-\EOF
+main
 maint
-master
 next
 seen
 EOF
 
 test_expect_success '__gitcomp_nl - trailing space' '
 	test_gitcomp_nl "m" "$refs" <<-EOF
+	main Z
 	maint Z
-	master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
 	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
+	--fixup=main Z
 	--fixup=maint Z
-	--fixup=master Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - suffix' '
 	test_gitcomp_nl "branch.ma" "$refs" "branch." "ma" "." <<-\EOF
+	branch.main.Z
 	branch.maint.Z
-	branch.master.Z
 	EOF
 '
 
 test_expect_success '__gitcomp_nl - no suffix' '
 	test_gitcomp_nl "ma" "$refs" "" "ma" "" <<-\EOF
+	mainZ
 	maintZ
-	masterZ
 	EOF
 '
 
-- 
gitgitgadget
