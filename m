Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFDBC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3169322201
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRe4l4No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbgJPWu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391398AbgJPWu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:50:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9FC0613D4
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so4622775wmj.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=WRe4l4No7UsYFZRsGYAhJ73fLlgfa04GFu0L8ytwjdWRjYuchYD9Nva4jjqHZffS7f
         QwWJ/eu6cQoKP+9eA+9yG43XayfmQHQcYLBtExeREWWaBJOCbxBnY5N42y8jYQXYSSyi
         VBV2AlG5KjSrjr+fy5rAFeLPYV/iC+DYXG/k9S6I6tb8drMDRDcbIIhyx9AbsyAIC9WA
         RaRcKQUI4IEEL0yatUzGZGegd1HjahO/NA0xNazIaYxp9awPM51J6v5FxETucvi4Rr7J
         kmO0HLK80+eYcb8A7xFeoe0EnfgW8lkADzK/KuV80HdwSmVYRLgDHonR3a3NIoBJvFlY
         Tw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzrCPnbUvNSakWF2bvkdGZ4dwzkAgsYCMdLnhb7Mw8c=;
        b=VYe3QB080ZNbGiZ65yVjx+XpgWw8qNIypPD9LRVXLQr2j5Me/YnCrJKksFAEwd1HXn
         XdwVFuMfTj47geJ2Wpzw5Myo5tg76dRltMKvuGto/fZvJ1oIOrz2+hGSaOylKcCA4Txn
         ZQdPTnSwf8ac1x+iyURHGlAi2Tfqc2Ztzko0KnON0BwNtBxZTYplZTB/ZUnL/nfbzbnY
         hvmdpx6AZabkANQBIoHs5nPG+k5TOcldDlaMOP7m5rU6PwMXKiztI1Gzu6vDZdmr44jY
         a7FhOvhRpGbOqvdFyM3Z3nGPNleVKII2iHVhc4keQ4Ypauo5u9pWzeCAIveK8vFsFdcF
         Wxog==
X-Gm-Message-State: AOAM531sLueXCJQINCS06jLYAp95dhzzAWxHjFpta8k3CFlwth4QmK5Y
        euThIXWbT2GR1xiQ2OUD7gS3nGNcE1I=
X-Google-Smtp-Source: ABdhPJxzn4yfA4twZdR3aOw5aBf8xIzAk1CiQHtpwu6Utw7g35MUYM+tqsoTj6gINIAWxyMARWKz8A==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr6153881wmc.32.1602888655818;
        Fri, 16 Oct 2020 15:50:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm4625444wmg.40.2020.10.16.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:50:55 -0700 (PDT)
Message-Id: <7c7a3d9a348075e0aad7790019c0a44f0d306cb0.1602888652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
        <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 22:50:51 +0000
Subject: [PATCH v5 2/3] t6006, t6012: adjust tests to use 'setup' instead of
 synonyms
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the new ability to pass --run=setup to select which tests to run,
it is more convenient if tests use the term "setup" instead of synonyms
like 'prepare' or 'rebuild'.  There are undoubtedly many other tests in
our testsuite that could be changed over too, these are just a couple
that I ran into.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh   | 2 +-
 t/t6012-rev-list-simplify.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index bc95da8a5f..99a1eaf332 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -339,7 +339,7 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_expect_success 'prepare expected messages (for test %b)' '
+test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
 	This commit message is much longer than the others,
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index b6fa43ace0..7254060240 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -168,7 +168,7 @@ test_expect_success '--full-diff is not affected by --parents' '
 #
 # This example is explained in Documentation/rev-list-options.txt
 
-test_expect_success 'rebuild repo' '
+test_expect_success 'setup rebuild repo' '
 	rm -rf .git * &&
 	git init &&
 	git switch -c main &&
-- 
gitgitgadget

