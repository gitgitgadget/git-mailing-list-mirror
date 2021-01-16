Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A7C4332D
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B8C22AAA
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbhAPRRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbhAPRPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:15:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477AC061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 09:15:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m187so3746276wme.2
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnxDAOvlNGvGemBz1cVyatdzsQp9lfyfLygG0ZiwPBI=;
        b=aufa15G5gcMNoSDoVOFTJ3jmBA55guoUu2ukJ8SA4epk5WMMSJmAhIyS3l73vQtgvp
         NHOwC8OkRRLUnypJV4+/HrMUXCWrfVw5TYciXDj6H6N0+45pTegVTUyvIDHoSSIrg/qo
         IYtsWnQM/bTcmbXTrtk1g9QOb4Eba5HSvxe4gjUgKtmoHIbcArbaoFlWEdvn1T2KDiIT
         BnvLI4KaPXeBbwGWEzJBCG4o6jYMOUMJpDRuZt5BsBr1q7RkrlNNZlnHvx7SiIeQRTfW
         9egp42C3gfwJQXlOhvwNA4UbgKrAgzLaRkA1xty0mJNdm31ikPmglNUk2lHxT7eo+O5/
         Uetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnxDAOvlNGvGemBz1cVyatdzsQp9lfyfLygG0ZiwPBI=;
        b=sl6/j1r6tv2PZ245wTL7kCpjUvXEwdVROVWptJL8UVgIXatiBeJq8ukAX6/B2bq9hH
         Q3dFUL7MLhJjmnJvG8c9yynjZPLbxQvFBpf6hmwPBvF1UQC1JA3AxuL8v1EiCx56YwAx
         RIJBeGvu54+SBof+AAIf8MmAqeA7B1e2IK8/13A8wFS9sBI8PpKQwII36cJmBMrRwngZ
         b8Z03aGVi5U3mIGQaQRYUSJUqOnh24Ua48S6gHV/A/RJvdHgYXaW3e3kAMJGkdtX1Kss
         5Csf8w+PKfwmb74xO4FAqB1OJcIi5FTs0seUsb44h7ACQsOfVCx96LO/tGP5ATNpF/V9
         AJbg==
X-Gm-Message-State: AOAM532U7HhQJGUfT1089UUDW6UwdiYC+0gRXx1njEQPPuk+RtE1j98K
        ETQtIq6mSQ9Gh0bHFzZzOR0WjLUnUOjaSQ==
X-Google-Smtp-Source: ABdhPJyZ0Cf3scRfHkaBI7WC54GQTPwwc/VMSx0BVC4VmxEGiCQvWqe3ZPkfIw/Qk2PRKJi8phLJIA==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr14037182wme.42.1610817303696;
        Sat, 16 Jan 2021 09:15:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm16342105wml.34.2021.01.16.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:15:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Greaves <david@dgreaves.com>, Petr Baudis <pasky@ucw.cz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] fsck doc: remove ancient out-of-date diagnostics
Date:   Sat, 16 Jan 2021 18:15:00 +0100
Message-Id: <20210116171500.20092-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <4269557C.1050606@dgreaves.com>
References: <4269557C.1050606@dgreaves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove diagnostics that haven't been emitted by "fsck" or its
predecessors for around 15 years. This documentation was added in
c64b9b88605 (Reference documentation for the core git commands.,
2005-05-05), but was out-of-date quickly after that.

Notes on individual diagnostics:

 - "expect dangling commits": Added in bcee6fd8e71 (Make 'fsck' able
   to[...], 2005-04-13), documented in c64b9b88605. Not emitted since
   1024932f019 (fsck-cache: walk the 'refs' directory[...],
   2005-05-18).

 - "missing sha1 directory": Added in 20222118ae4 (Add first cut at
   "fsck-cache"[...], 2005-04-08), documented in c64b9b88605. Not
   emitted since 230f13225df (Create object subdirectories on demand,
   2005-10-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fsck.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index d72d15be5b..bd596619c0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -129,14 +129,6 @@ using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
 Extracted Diagnostics
 ---------------------
 
-expect dangling commits - potential heads - due to lack of head information::
-	You haven't specified any nodes as heads so it won't be
-	possible to differentiate between un-parented commits and
-	root nodes.
-
-missing sha1 directory '<dir>'::
-	The directory holding the sha1 objects is missing.
-
 unreachable <type> <object>::
 	The <type> object <object>, isn't actually referred to directly
 	or indirectly in any of the trees or commits seen. This can
-- 
2.29.2.222.g5d2a92d10f8

