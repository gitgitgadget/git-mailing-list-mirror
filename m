Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2363C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4653522404
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEGo1Erw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbgJSVfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgJSVfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:35:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF63C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so1323724wrv.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=MEGo1Erwn+1xeo0IOG2F5zpq3HQfgon9FaCD1RwS0xmOFHwvdSU59v2rU7bzHIKYI5
         3f2Z0xD2gWoXR/wMMSes0nvlH616LG3cYQTxPPY8DBGvQNjTAkh+j5KhKgYl94fq6xhz
         QWdRP0o99G1sVprUcnzGHkYC5o+lrB3aUobPsgVRzsKMEQNIaFrrRsNL6cQF6lsOvTq2
         rnLEDn4ZZd000pmaM7EfwZBvk7EJRqxJ/GrRo+22SvDwbOlaSH/lrnGexIDydcSy5+8t
         /Cf+O8fvj22qrKZ/Z8Ow47Zm47YYLBf9rQDPOTR7W94QWvJUi5xZmcgZ2nX6OGdF8uga
         mg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=f5yYH9unq9tTriW8ZZxKKo+wpOrfWKU5xoh/ATSXcjcBPUcHsANJvvLppC/5yn2GKR
         AiwGYqBO620L74JNagpKkE1kp10HL8cUVCa0zOZWYT44sbW9o97rZQ3l8HwfM7AodAA1
         5JwFDsPe+TA3C1vA1iGchOqJT3otzqAohIb2aOB+TIq4O4qMMUwR32kIW2K0uSTQ8lRt
         AIDIDLqdIFQGyKSXoiI4sKTqNlSCJkFGqN+4Xu41rS19pcQGTLdIHDIdpFbJCSYve2Rg
         1dUHruvi7fYlNkpLz91zPwZQuu/FDcUv64u67vzgKmNT8khiuwvxv+qit4DrkFb3Ol7Z
         XFSg==
X-Gm-Message-State: AOAM530GE8EBHiXPCndSrNPAMXb+QejkAKY4erwEwE7i7rT0DWERhcwz
        HMf6kNtj8G69Vvw9vfN+7NfC7D7aZV8=
X-Google-Smtp-Source: ABdhPJyZapCw/wECXq2oA3J/mu6ZGsKPaZvOuKiN5+5QMXUCNMqfpq075CcJHL03lB3KUCkUl5gofQ==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr1284128wrn.257.1603143319456;
        Mon, 19 Oct 2020 14:35:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm1503569wrc.23.2020.10.19.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:35:18 -0700 (PDT)
Message-Id: <1c7876166f5d9262c44c9df0f613e7d0beb98722.1603143316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 21:35:13 +0000
Subject: [PATCH v2 2/4] t/perf/README: elaborate on output format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/README b/t/perf/README
index bd649afa97..fb9127a66f 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -28,6 +28,8 @@ the tests on the current git repository.
     7810.3: grep --cached, cheap regex       3.07(3.02+0.25)
     7810.4: grep --cached, expensive regex   9.39(30.57+0.24)
 
+Output format is in seconds "Elapsed(User + System)"
+
 You can compare multiple repositories and even git revisions with the
 'run' script:
 
-- 
gitgitgadget

