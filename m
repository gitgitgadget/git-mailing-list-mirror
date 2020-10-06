Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB2C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19756208B8
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt+Mladt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgJFWFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgJFWFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB7C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so6449719wru.12
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BM5Qxo4wzcdQ2tkPzZekE+/HK7yjO7v3Zi8fVCPCIHE=;
        b=Pt+MladttjL7aVGw+HKJl4HFo4yh4EdJo9dlJY19nyZa5lO5/btkh3gGczXZEKTYLS
         M4dmaAaUf/jKvXKvjqLdbB/TBXSVsSQ2i5vdxdKpDTOF/PdfDH/0EpzUoGFpIrPuochl
         QrDLllxMQfwQ9um89GAaRFhtaMNQb8rUq/y4RY34z2GyYhU8LtTy20X6hiS8PZIvFlmQ
         lH2qy0xcvpC8v6+QlIAAVg0KvdKByVmH8OQGf8wWcdjNdgJNcjdPswwXyhcH35ahgTYW
         /+19ikmP8MLzuSJnL/Wc7x1HCB8ZT4pORVA5fWMWejAVRvdwmEtQe+FUHI47TsSgUTrU
         zPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BM5Qxo4wzcdQ2tkPzZekE+/HK7yjO7v3Zi8fVCPCIHE=;
        b=aQDd9xqfa5uQu3fSziqtY4CyuM4WadmbrCFRJtqvXvGlX5oOHm2ktxiVkdJLbhUdKR
         CGL28tv8deH+LLTxBbko3oW0LRQtgBVUAvt05aQ5CpXujogFvhmCn2kWmlL6yre6LCsU
         MdaKJgIlwfRy4jqH2xnkee7ZAGd/IU+Zvex+lSZlGQkluMJKplAjeQcPYjqnhSoXqve7
         vT47sxdzWG9L94uXL8RC6bxqfkf3As9qs42iqDGFpT5Wt3g0L9Ko02xPgYSqm6C0xhwv
         TCftwNEHT1jsLqdhSlcOjYJ7gGpMsOqK1SwFzlENCtnG8g1lwgOcg512FaiJdWorfPIc
         PAhQ==
X-Gm-Message-State: AOAM530hw//x5Iz4ZZCm/qIklSiHVCL2vJ0AOcBlGOEhdRihUj2koh8x
        DtSH8GdGlO3HSMnrQdbttDMRJ3JpJNc=
X-Google-Smtp-Source: ABdhPJzcCTyEdCOSg1o39C7bCNfKaDQ/6PdnYVLe6lTxIR37oLn6K+Qy42PFiAabjlWZowxypywurw==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr50610wrs.232.1602021920117;
        Tue, 06 Oct 2020 15:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21sm87147wme.36.2020.10.06.15.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:19 -0700 (PDT)
Message-Id: <fe2e4819b869725f870cd3ce99f1f8150fe17dc1.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:13 +0000
Subject: [PATCH v2 7/7] subtree: document new subtree commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69d..a5a76e8ce6 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -52,6 +52,12 @@ useful elsewhere, you can extract its entire history and publish
 that as its own git repository, without accidentally
 intermingling the history of your application project.
 
+Although the relationship between subtree and mainline commits is stored
+in regular git history, it is also cached between subtree runs. In most
+cases this is merely a performance improvement, but for projects with
+large and complex histories the cache can be manipulated directly
+with the use, ignore and map commands.
+
 [TIP]
 In order to keep your commit messages clean, we recommend that
 people split their commits between the subtrees and the main
@@ -120,6 +126,21 @@ and friends will work as expected.
 Note that if you use '--squash' when you merge, you should usually not
 just '--rejoin' when you split.
 
+ignore::
+	Mark a commit and all of its history as irrelevant to subtree split.
+	In most cases this would be handled automatically based on metadata
+	from subtree join commits. Intended for improving performance on
+	extremely large repos and excluding complex history that turns out
+	to be otherwise problematic.
+
+use::
+	Mark a commit and all of its history as part of an existing subtree.
+	In normal circumstances this would be handled based on the metadata
+	from the subtree join commit. Similar to the --onto option of split.
+
+map::
+	Manually override the normal output of split for a particular commit.
+	Extreme flexibility for advanced troubleshooting purposes only.
 
 OPTIONS
 -------
@@ -142,6 +163,9 @@ OPTIONS
 	This option is only valid for add, merge and pull (unsure).
 	Specify <message> as the commit message for the merge commit.
 
+--clear-cache::
+	Reset the subtree cache and recalculate all subtree mappings from the
+	commit history
 
 OPTIONS FOR add, merge, push, pull
 ----------------------------------
-- 
gitgitgadget
