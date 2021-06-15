Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07DC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B3061481
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhFOONl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhFOONX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:13:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE33C061280
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so18511731wri.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5GBBqDj3sAlzQLzqWAxVV3AqolGMSjRBCtydTjbOBA0=;
        b=NulzNmQRp8gUwkUNJHJvvW0n9Jub1N7dgvRrWg24/DYbV0e50iNUympuOiXbn24PVs
         27Xc19aqVLUMvF6w7Lw2dcjhI7Eky0/q+xXE+4xfGFk+Wy8zkmcK/1lxue7g2dvNoELx
         XXZh6QxXPkGQ2OzqI0LlzO0z/k6YO23GxbduXn6AfDas+gP9Sn5IQ+EOAoK8wXUyNDZ0
         bxBXDTxLnDH4Pw/bm7gdhtaa0BK0mYrWlEX5bxSXouf87+Pf30XR5qCp2PBjfGIo8ixo
         Xh3frKtwXD0k2Tm6FRyXWLNG7TxaGbsQ7NPSbDNaAmbyzapwx/NLixrXp2KoXQ3RkGz8
         B1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5GBBqDj3sAlzQLzqWAxVV3AqolGMSjRBCtydTjbOBA0=;
        b=JP5UzngyHbMVQppbesqc/DxHH9weC0uGjs9yrkuZWIQyQ/rSM9GNVSmsFwt9rOPaqd
         kgM2rSh4Af5X3SWLZ3HdLYgaUDusrhlzGLgEToO82L8PZUzSFqeODbZ8nKzUVRFVmV8a
         U5RAFj4Yb20T9Gn+wpc8kh9vEASVUSZ0FIy4CauKLAzVywzcv/aU25eRfPjDDCYZs43n
         S7i5cQ40PfLFqgx/IljH+z+3W2L1jwvCiHFGf9Uaux90jXMCNQuHw17PWrZiQ8sKNnRC
         AlQsGZQskolqiJRf+IqBn9Y02cAn98CiF4/Ak+1BQrfK9tQndlDUXKnaQMYKGhIr3jPt
         zYTg==
X-Gm-Message-State: AOAM533EujGP1hXEb3omboEjFdw88XQohprzb4d4kazZtxRXSwryyk7Q
        yrYsz3okJmHSnUgHVYU4qr1aHRDXa7M=
X-Google-Smtp-Source: ABdhPJzR+CNP5ifAlxZROto/Yb2K2EQpzRWpvMG2cm5zAE7D8Glmb1/AKJQxvs3Qgh+8lDjgPUwVsQ==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr26003452wrs.170.1623766276840;
        Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm18644216wrw.97.2021.06.15.07.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:11:16 -0700 (PDT)
Message-Id: <6f6fa1b9466eceec053c4cd20e1e4c61063806da.1623766273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 14:11:11 +0000
Subject: [PATCH v3 3/4] *: fix typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

These typos were found while searching the codebase for gendered
pronouns. In the case of t9300-fast-import.sh, remove a confusing
comment that is unnecessary to the understanding of the test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c               | 2 +-
 t/t9300-fast-import.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f9c400ad3062..7bb96f8f7124 100644
--- a/config.c
+++ b/config.c
@@ -2837,7 +2837,7 @@ static void maybe_remove_section(struct config_store_data *store,
 	begin = store->parsed[i].begin;
 
 	/*
-	 * Next, make sure that we are removing he last key(s) in the section,
+	 * Next, make sure that we are removing the last key(s) in the section,
 	 * and that there are no comments that are possibly about the current
 	 * section.
 	 */
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..7607ef65cb99 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1538,7 +1538,6 @@ test_expect_success 'O: comments are all skipped' '
 	commit refs/heads/O1
 	# -- ignore all of this text
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	# $GIT_COMMITTER_NAME has inserted here for his benefit.
 	data <<COMMIT
 	dirty directory copy
 	COMMIT
-- 
gitgitgadget

