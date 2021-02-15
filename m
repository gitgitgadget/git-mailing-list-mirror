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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA094C43603
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A281664E51
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhBOQDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhBOPvm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:51:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6AC061224
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g6so9447386wrs.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+OHjJIpz4gQDWXJCfmjn7hKqWx9ySgKfEtGy5rLasw=;
        b=sL3ulTfoe/p718rv1Dpiv9P3WkKe97pG9Sl3/OfBoEc9asW9QkmEiixYJFtwf4onsw
         hRdCddhi2Kis7zzZZf6ukkB1HEh/JXq6h6LxfDw5hjCjNXzcW3/22uNC2O4VITj7t7Jd
         Tm+TRXpKfggpBVy/DtbyAtqX/xfh+YIwJPtzkevJeP4/Bz/oYk7UQtNXERZ+VxSb25js
         BEygKrQfHBNaWWC4Q5+NgcS+KO+xrv7nEkrLAbJg4XqwkJX+uovNdunPaXgaJe2fCKC0
         lk0hu/lUVtQ8z0wJ99To7QFUJxxVBBgPuGUP5bZjoNyqRqAiMql0FvKuvh6We1HcMknf
         8pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+OHjJIpz4gQDWXJCfmjn7hKqWx9ySgKfEtGy5rLasw=;
        b=G+Afg905bK+5L9rZD7Fc8Y4R5aMfDjd2wttANArLfyeacvA+X8vM7BDivKEzS4f0jO
         +UjNCsOHMoCS47MzQsaIpQgdyBlYeNOd6AoUHX4L8TDSdhbXcrVlfrlR9XTtMJTanJ3V
         YzVPapaWpgdaK4R8dCEFK4zzp/Mh2b2QM5/PfF5GVBjRxPqDXkSYK7qHMLJpnQhEI7Ga
         1ENUoRFfj4aXhxVR2VhgSLGB/z2HO9lmHQVxjlXgoEaJcQkJsLIGiOqKLrDB3uxLJht+
         cBX5fNRCJf1YHaZoTvdcKCqunSNzpZy37QmGYOOue8j/mMtzIeTBLggN1lQCasiQilrd
         KCAA==
X-Gm-Message-State: AOAM532TpRJLXwhMg9BdDw9K/CDWQCmG0e0uueYYznnfQfzEqokXkS9G
        5mUxs9WxW1NyHa0SCfpy3iq1BAGSB3XQuQ==
X-Google-Smtp-Source: ABdhPJzBEDe5sRznuGBdHe+1jJjQnpyhm98zH5FXMxACg1MNdwhl8Okz9vPTvATZ1TF3kQp7Iorfmw==
X-Received: by 2002:adf:9546:: with SMTP id 64mr20074396wrs.247.1613404235578;
        Mon, 15 Feb 2021 07:50:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 75sm9672617wma.23.2021.02.15.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:50:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diff: test and document -W interaction with -U<n>
Date:   Mon, 15 Feb 2021 16:50:20 +0100
Message-Id: <20210215155020.2804-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++++++
 t/t4018-diff-funcname.sh       | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8ca59effa7..3c19c78616 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -88,6 +88,11 @@ endif::git-log[]
 --unified=<n>::
 	Generate diffs with <n> lines of context instead of
 	the usual three.
++
+Under `-W` generates diffs with at least <n> lines of context, if the
+number is lower than the context `-U<n>` would extend the diff to then
+`-U<n>` takes precedence.
+
 ifndef::git-format-patch[]
 	Implies `--patch`.
 endif::git-format-patch[]
@@ -763,6 +768,9 @@ endif::git-format-patch[]
 When showing the whole function for context the "@@" context line
 itself will always be empty, since the context that would otherwise be
 shown there will be the first line of the hunk being shown.
++
+See the documentation for `-U<n>` above for how the two options
+interact.
 
 ifndef::git-format-patch[]
 ifndef::git-log[]
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index f3374abd98..38dc029917 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -98,6 +98,11 @@ test_diff_funcname () {
 		test_cmp W-U0-expected W-U0-actual
 	' &&
 
+	test_expect_success "$desc -W interaction with -U<n>" '
+		git diff -U9001 "$what" >W-U9001-diff &&
+		grep "^@@ -1," W-U9001-diff
+	' &&
+
 	test_expect_success "$desc (accumulated)" '
 		git diff -U1 "$what".acc >diff &&
 		last_diff_context_line diff >actual.lines &&
-- 
2.30.0.284.gd98b1dd5eaa7

