Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AFBC433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C3923719
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 14:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAJObD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 09:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJObD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 09:31:03 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C21C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p12so6210731pju.5
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3F4p2ho4+Gf6lI1cihzMMR/eRQOqlWM7v6ceruSdvE=;
        b=ZzYRKJLvJgTMWGXblaWa17gzeEel9/SmHrbFiVdShrePu2yaMUROINHVpR4W1eA97t
         X77B0Sc+Z7NdFZwqi3fNiFlh81FfVXbqy21QFQY2/Xqf32ULVXbaBY2Wt+/FEwPvmGlB
         oMwd+xa4YgR4EfB9hzvadP1EqO6TysRcdreb1v25dUZsJe7VKLZ7XUgRMDN+Y6MyiiCB
         ZGI+UqO+zi53PvtcQOEEnOBOpqe0tzHtNJfxrzEtoqpGkVqtK0/r0uqlrUgu/6RSmxcb
         HOOkXKGfdwt110CZTqLPwVKl2lNKS2RdsHbfoBedxKVMwoj3ZDHcvXphXh57wGp2S2dg
         vEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3F4p2ho4+Gf6lI1cihzMMR/eRQOqlWM7v6ceruSdvE=;
        b=ufAyRrZDM8pr+oWI/uP1QoXXw5ndQggHOQjYHUpjQPenBHC0J44m6/bZvIlEumw/Z5
         tszvXJM7fiFIVfABdUmh03drK+Slw4EkPCRpoVPHaqPnHkORRRBUs9GDgei+CUhkmQP6
         qEMPR6UI8sVPSNJBl3dsePHUxP+79OgXTY5kCeypdn+4Yjv4l6gGdkTw+Jtj66idOrbg
         bkLG9Rp3SPUw+MyRdpAtW4+Gc+3bhElN13Jc3XxKOksBdFLZCFAAoi5mSyP9qmgI0qnB
         6K4JZ3titf8gjLmGL30njLiR4KuT0a0he+lIsdwmzinygsM2SA3fl4OmrjX6PHimsez5
         fk8Q==
X-Gm-Message-State: AOAM531Zzx4sBAb2bPaHqNc1VoNRILIch2sLMrjadEMvZTsSnIHZeXPX
        tSm0OLTy9KSrIaK6/UfcH6k=
X-Google-Smtp-Source: ABdhPJxFKIVBB6H8RlEZjPPXVzIayoeDUifnHfrhzAYuX/++3RaBHpJ/atPt1dNWxmQSjS10mVZ54g==
X-Received: by 2002:a17:90a:12c4:: with SMTP id b4mr13136572pjg.234.1610289022669;
        Sun, 10 Jan 2021 06:30:22 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a13sm16044863pfr.59.2021.01.10.06.30.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 06:30:22 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 0/3] improvements for git-bundle
Date:   Sun, 10 Jan 2021 09:30:16 -0500
Message-Id: <20210110143019.5625-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqbldxg466.fsf@gitster.c.googlers.com>
References: <xmqqbldxg466.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Introduce two improvements for git-bundle

+ Commit "bundle: lost objects when removing duplicate pendings",
  which fixes command like:

        $ git bundle create <file> 'master^!'
  
+ Commits "bundle: arguments can be read from stdin",
  which add "--stdin" option support for git-bundle, like:

        $ git bundle create <file> <input

## Changes since v4

+ New patch 1: Add helper functions in 't/test-bundle-functions.sh' for git-bundle.
+ Move t/t6020 to patch 1.

--

Jiang Xin (3):
  test: add helper functions for git-bundle
  bundle: lost objects when removing duplicate pendings
  bundle: arguments can be read from stdin

 bundle.c                   | 109 +++++----
 object.c                   |  10 +-
 t/t5510-fetch.sh           |  26 +--
 t/t5607-clone-bundle.sh    |   4 +-
 t/t6020-bundle-misc.sh     | 465 +++++++++++++++++++++++++++++++++++++
 t/test-bundle-functions.sh |  47 ++++
 6 files changed, 583 insertions(+), 78 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh
 create mode 100644 t/test-bundle-functions.sh

-- 
2.30.0.2.g06d2f50715

