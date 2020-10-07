Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68DC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9386B207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 07:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7mjAShi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgJGH4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJGH4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 03:56:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D4C0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 00:56:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so650890pjb.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=A8qILUB9OEEbGui0R20rtjYicU327BY8O4waGk+BN4E=;
        b=q7mjAShizXQYK63PkgWVDaK+28h1nY06Udyxla4nulFeTIuXKK92wpDpt+rWkjb/gI
         gVBUN3NSjBhaGBY109ostXJne4AertJSSGy+PSotbUYGzxMKhk/Q3B9ZdHFMUqbSCfqX
         oMonpKoHmEMWPUCWtKC7sMx1DvGnFUQ4k9IzENtnOEbkbAz/S2TeaofBBbLszSJ7n8dA
         lwcA193lDQHjFJXf+71Sf7VmY/8d6w4BCIk8R1ixaIs9vBu0swelPon8JsBaeLEAl7Dx
         xzE+CixBTdXKEvrChSxOV3GOQIiJd+AV6yBms9XFXjQIncBaDKWAh0LPyswqHWJCvFgu
         57hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8qILUB9OEEbGui0R20rtjYicU327BY8O4waGk+BN4E=;
        b=grQ5hWUD9Pl/LwCzGL/I2HwVzK9Xm/Qfwmf0+Sih5oFVV1RP7nM/7VtdQR/qsuQn+i
         /ZWFCZPv2w/9mbOhaMX8JVI7XUfSOeZGk0M+sro78p8Y+0q7+3dFk1IKTX6eKmpuUs8Q
         Nfs4M5H+vH/kUTYEIyycm0TgqdSyVcPcY5UJbZzYwI5pCXVIJtjZ4fvBGJzdWsQVBmFG
         Ul0LOfrQtJbSjIEEtW0tzCSLxdUIeVf5Wo5/e/IEIRv2WJzknmq2FW4d1crHIvfwBREr
         iBlM/xkbUS7bx/i5L4UfchUFWPDj9U5ZXr7gPuUnVwR4v4pWYH3ZtQiB5rf/wpSjtorc
         r9Sg==
X-Gm-Message-State: AOAM5330eT5n5K/3XrIncPnkb9FSce2dlpcbsKkw7v7ZHxss5XhqYxuC
        xQNMzJGoNrF/sXGKGt9t9JDZILE3RCQ=
X-Google-Smtp-Source: ABdhPJwtRxa0GeyoxXoKF7dMS7LEkKmy+2Jv15sGzV07vnvRAgsm0vX5h7GKNtaTCOqClLdq5wzNPQ==
X-Received: by 2002:a17:90b:710:: with SMTP id s16mr1932114pjz.138.1602057389858;
        Wed, 07 Oct 2020 00:56:29 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id n9sm1909950pgi.2.2020.10.07.00.56.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:56:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 4/4] t2016: add a NEEDSWORK about the PERL prerequisite
Date:   Wed,  7 Oct 2020 00:56:18 -0700
Message-Id: <a20544f18a1dfbeea44faad8538d2de3baf3d62b.1602057332.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602057332.git.liu.denton@gmail.com>
References: <cover.1601814601.git.liu.denton@gmail.com> <cover.1602057332.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the builtin add-p is used when $GIT_TEST_ADD_I_USE_BUILTIN is
given, we should replace the PERL prerequisite with an ADD_I
prerequisite which first checks if $GIT_TEST_ADD_I_USE_BUILTIN is
defined before checking PERL.[0] Mark this in a NEEDSWORK so that it can
be addressed at a later time.

[0]: https://lore.kernel.org/git/xmqqsgat7ttf.fsf@gitster.c.googlers.com/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2016-checkout-patch.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 999620e507..d91a329eb3 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -18,6 +18,10 @@ test_expect_success PERL 'setup' '
 
 # note: bar sorts before dir/foo, so the first 'n' is always to skip 'bar'
 
+# NEEDSWORK: Since the builtin add-p is used when $GIT_TEST_ADD_I_USE_BUILTIN
+# is given, we should replace the PERL prerequisite with an ADD_I prerequisite
+# which first checks if $GIT_TEST_ADD_I_USE_BUILTIN is defined before checking
+# PERL.
 test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
 	test_write_lines n n | git checkout -p &&
-- 
2.28.0.942.g77c4c6094c

