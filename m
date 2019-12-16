Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A9C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C388C206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiO/J+Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfLPPsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35351 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfLPPsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so7870639wro.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H0W2IHMkwNuzWHBmhT0DY+Y6Xi/xz/EJUmh6xgLGtTY=;
        b=GiO/J+TyfTqlgvO4qDBjwZ7DMEIhFLaP+eyZjxq7qTSba35+nzVxRaGtYFlQqkNsTW
         3hZmblJ7wjKQQzNjFXyaJ3Bk+HZVU7CSVKjbs4rMqPwkhkjiMr5j4utNLEIKhahifDq4
         K1rMrsXaO/4pNbPesJEuKjT7YfOEPSa94DK7k0HTmUa6886gASAJXXpRQVB42c5ZwFFn
         ecodTnhYsxLQEsurEIOWwT5g82V0mcLoFsGBnxJC9g25/kK3qXXXQDuWFCWG/LbW6szz
         RY6Z/SwNPNYu4+WSVEL/inAAraQAy1kakaIwSVXYVApmViw0wFIYTq29hWV6etH+YOjv
         zQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H0W2IHMkwNuzWHBmhT0DY+Y6Xi/xz/EJUmh6xgLGtTY=;
        b=XwFx6kR1RIz/GW3+UaXqn5EY5ni8s8hrqPDjJXasuzXAkdiTWkydAR5+gss7nLaCyj
         RNdCGIGBcm+QTCRKWeT3zgDBj9i+JPpiQnZgHm+ceZpRUYj3nibrtCcu9vXCByC2KHVm
         gAMG1uyCN8a06h0fR8D0HtTFPmCCL8eJ0XCj1FRO+h9S3Rnmw0X1u+wF5SW1ZKA69rrg
         u3MgDCTxsJmIoFQOiTCZjpry9NcBJUB2QO3lCIAzgLr6bgtJzaWe+fIo4HINvCGJNinG
         f+8IobiZrtvJ7hfAff8ZfzK+qOJripN7/UunuNsiYIbc6feiiJ/yTh5kFx2+x9d+og98
         diag==
X-Gm-Message-State: APjAAAVfARAYpkQEaIjLIECx7Un0sUNKk5s4W4+FiX44q2dXI2Z6Q3ko
        pQfFUdNemOSAGq3YEy5catQDW47+
X-Google-Smtp-Source: APXvYqxcj0hJVSFMKX5gAeoG0qPARuBkt1s12dYwBR+lcHsZwZMbJ/B8QTm3fn5vxf+u5Vi+XQscJA==
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr32079554wrn.101.1576511289462;
        Mon, 16 Dec 2019 07:48:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm22385296wrm.51.2019.12.16.07.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:08 -0800 (PST)
Message-Id: <c7cd46d3a3bcbf4a5cfe2aa6aa71b3713801892b.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:50 +0000
Subject: [PATCH v2 02/18] t7526: add tests for error conditions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Suggested-By: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t7526-commit-pathspec-file.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4e592f7472..68920e8ff9 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -61,4 +61,28 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git commit --pathspec-from-file=- --interactive -m "Commit" <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=- --patch -m "Commit" <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with \-\-interactive/\-\-patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=- -m "Commit" -- fileA.t <list 2>err &&
+	test_i18ngrep "\-\-pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
+	test_i18ngrep "\-\-pathspec-file-nul requires \-\-pathspec-from-file" err &&
+
+	test_must_fail git commit --pathspec-from-file=- --include -m "Commit" <empty_list 2>err &&
+	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err &&
+
+	test_must_fail git commit --pathspec-from-file=- --only -m "Commit" <empty_list 2>err &&
+	test_i18ngrep "No paths with \-\-include/\-\-only does not make sense." err
+'
+
 test_done
-- 
gitgitgadget

