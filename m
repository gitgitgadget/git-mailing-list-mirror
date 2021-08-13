Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E380C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701C36103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhHMNIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbhHMNID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 09:08:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB6C0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f5so13166131wrm.13
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NqiGd7UZb5BPkCPqvCDgmSg2YEJComAB+J/uOMxS5Ek=;
        b=OyPGcMLvcYsakqdFH/NNmZacSkwDLDC09oUcqzws1meMvev7MnvfY600d6lswIHIVj
         rTBxBaw8qA2tepJiVh9QtMODXSVl4izoNSDgwuaLesdmYDYDS9iY1icKPJ8j5GDuV3+s
         1hZKJmNhumiPfi8TrrI9GBwGDAVc8SvCp4RI4Sm1aEpnUXGGUbFRkkI1gNurGcBVCp1A
         k/QEpiOd8KiC+Qeo+Od2Sz05dZSnofGxDZHefjxP6WieQfMz1UzyRSdLyIMCRmH7MQq5
         oOtlk0aA2l1Vl7cX8FdLjK6wKkaNL9liDzNVFn7qsSlIA2eMvWkdIRNbX4F+SIC/9NTb
         4EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NqiGd7UZb5BPkCPqvCDgmSg2YEJComAB+J/uOMxS5Ek=;
        b=lh4lyj8RF8fMhtDVM6HTpN8gDdkR+DyN5c7ZqVfdUvQqG1YPnmyjbyl6yi0OhPpgen
         +xc/Uf1SofOTorkeCcFDe1XAuCGQEkeGKPdZitCZc7ypfGgnA1nVPYDUEp3SOCq4truO
         mi+grIwsnqlMMLUUjJOKYUvn3ff3cnn76ds4C50MhLxFCZ+ubbZm5niL/AbxIQqAGIlX
         KhD+Qr78gbEvVrUopm+Fspjk43KKW5O6g7wu5gJhPn3Rom1dKlfxTWP4mQumQO+A374K
         vF916aa0+zhDm+zFNp/W5zDRgB7CMNEhcA88cLKyKJ3RBGyHYzjiYpr1oMS0pTU3uStL
         13hg==
X-Gm-Message-State: AOAM532C2P5Zi2Ig8ipQLZoH+hsBNh4XmvuBh2NlFu2M985eTvzedocX
        ruLF9QVxSSW11Wq/4BRw8+Z8f2A+eco=
X-Google-Smtp-Source: ABdhPJxnRcDl7tSnNeBp9bXPyd/kKQfCiZeA5SiKM5Mu2EfXSMY3ypepWwE5MBEXyZ40P3iXxWMAgw==
X-Received: by 2002:a5d:61c1:: with SMTP id q1mr3028514wrv.87.1628860055761;
        Fri, 13 Aug 2021 06:07:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm1270633wmq.40.2021.08.13.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 06:07:35 -0700 (PDT)
Message-Id: <511cf9204ad5a785ffb2e2eebc757a4e58579826.1628860053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 13:07:31 +0000
Subject: [PATCH 2/4] rebase -i: Add another reword test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

None of the existing reword tests check that there are no uncommitted
changes when the editor is opened. Reuse the editor script from the
last commit to fix this omission.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf9528..d877872e8f4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -839,6 +839,19 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
+	git checkout E &&
+	test_when_finished "git checkout @{-1}" &&
+	(
+		set_fake_editor &&
+		GIT_SEQUENCE_EDITOR="\"$PWD/fake-editor.sh\"" &&
+		export GIT_SEQUENCE_EDITOR &&
+		set_reword_editor &&
+		FAKE_LINES="reword 1 reword 2" git rebase -i C
+	) &&
+	check_reworded_commits D E
+'
+
 test_expect_success 'rebase -i can copy notes' '
 	git config notes.rewrite.rebase true &&
 	git config notes.rewriteRef "refs/notes/*" &&
-- 
gitgitgadget

