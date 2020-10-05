Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4975C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7820781
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9IQpNFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJEI4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgJEI4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:56:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A9C0613A7
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:56:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so3161595wrp.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=as30vl3Zo6S/X7oaMG157bBNNCILcbMFyUp1hWFX5tY=;
        b=o9IQpNFjJq4rrHZKyHMXlFzSWwS40cnDY+KWeKOwJ9iGLTC03iL0juO+gp0RZdB2EK
         MkAwnKqNsFELREahSKxKx2HBZW4w+grcQwZGqMmJ87jI1sT9LxJ5qx91HwQrRxE5f+Mf
         banTc2wMBcDVAo3rlret0z1x4XGm3hM+k/AIUxPApuPSY5ZoNuvVpSmao09GdJUqMxzu
         NAQgzeqRT85L/OkzvkPQgS95M8/xA/1ajmMUV/YQLJxoXZurcL45OkeyN4mm0nVPBJ1f
         /vCjuvonNr/58TT83Ij6epc5BjzH/5MgoTJM116oSOVrEBF6IMSiyHCCFkVIWAzyKmoR
         kF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=as30vl3Zo6S/X7oaMG157bBNNCILcbMFyUp1hWFX5tY=;
        b=kK2ocuvavWq4xHATnx0irx++D9I+98mZKKdQ0Z8CdMej0NCZ4pXmxy3AqEnQlPFIAo
         UzqlszDT9JzbA/hV5kt8N037Gy9BW62cDnsy+JqsbNABqs7eLwTLMEZ5KB8496vvxdVG
         EcWxBHsjtMHW5RxtWHfy/ujm7K5/WpzrzEcir8pJfZ4awPnJXD3gLXcZ0CxFus4RbS4/
         jCSiD0LrmmBFGZDKTUYaG2MUx2oLMcke2LSCNDfJCYikerd1IIyBh4UWoetMnM6Im62j
         KoDoIW755lljxd8a6mFJIQAHayaHipmbeGMfdClO1VgbCevB3D014vxrZ3eHDcJg3cBc
         DdpQ==
X-Gm-Message-State: AOAM532AUEuqshdjvM8kU59nZ3s1suDataP1r0nI0UvYCZ7hNjEbzhNs
        pzT6J2Khe6f1Ew+gUp+zIS30xGMq9yw=
X-Google-Smtp-Source: ABdhPJyASjNgDpqLqsrzn4FhyIcF+iipjdH05hgXX4VoUAJctskp3vCLCFQeFG41jCO7tsDKNdPGyw==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr16022221wrw.379.1601888198462;
        Mon, 05 Oct 2020 01:56:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm13314095wre.7.2020.10.05.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:56:38 -0700 (PDT)
Message-Id: <d3f7b39a2f11f4b05195f62190f75c84475c237d.1601888196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.1601888196.gitgitgadget@gmail.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Oct 2020 08:56:35 +0000
Subject: [PATCH 1/2] t1415: avoid using `main` as ref name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for a patch series that will change the fall-back for
`init.defaultBranch` to `main`, let's not use `main` as ref name in this
test script.

Since we already use the name "second" for a secondary worktree that is
created in this test, let's use the name "first" for those refs instead.

While at it, adjust the test titles where "repo" was used by mistake
instead of the term "worktree".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1415-worktree-refs.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index bb2c7572a3..7ab91241ab 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -76,24 +76,24 @@ test_expect_success 'reflog of worktrees/xx/HEAD' '
 	test_cmp expected actual.wt2
 '
 
-test_expect_success 'for-each-ref from main repo' '
+test_expect_success 'for-each-ref from main worktree' '
 	mkdir fer1 &&
 	git -C fer1 init repo &&
 	test_commit -C fer1/repo initial &&
 	git -C fer1/repo worktree add ../second &&
-	git -C fer1/repo update-ref refs/bisect/main HEAD &&
-	git -C fer1/repo update-ref refs/rewritten/main HEAD &&
-	git -C fer1/repo update-ref refs/worktree/main HEAD &&
-	git -C fer1/repo for-each-ref --format="%(refname)" | grep main >actual &&
+	git -C fer1/repo update-ref refs/bisect/first HEAD &&
+	git -C fer1/repo update-ref refs/rewritten/first HEAD &&
+	git -C fer1/repo update-ref refs/worktree/first HEAD &&
+	git -C fer1/repo for-each-ref --format="%(refname)" | grep first >actual &&
 	cat >expected <<-\EOF &&
-	refs/bisect/main
-	refs/rewritten/main
-	refs/worktree/main
+	refs/bisect/first
+	refs/rewritten/first
+	refs/worktree/first
 	EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'for-each-ref from linked repo' '
+test_expect_success 'for-each-ref from linked worktree' '
 	mkdir fer2 &&
 	git -C fer2 init repo &&
 	test_commit -C fer2/repo initial &&
-- 
gitgitgadget

