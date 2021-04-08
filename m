Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5B6C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4582F61104
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhDHPFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhDHPEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38AC061763
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so3587614ejz.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TgcPChjNYhPVkz49K3frhW3QdyWBAtp4NeeeynEsOQ=;
        b=rxVX+/Y51GotC/sVTB3EPY3xxoxRPdqb14HxgpLMVYAERpeky/8XfPZW+O6AbASCxx
         M0hMVOCsJGog2M6H3rnPfWTiTlwAT6qcIDFPicQoVPFFAI09rK+dj8P5dFVofVr00CsE
         eCcEMB95U+00GdL2V/ILaeZWRIFGP5CeWVj4aNwVsjAvqKHTQhDvnna6cVSctw+6v6be
         fIkoybyUsx2ZdyzqgrDF2hi/Z0EOxNT7ZQ+tBeAWJis3Qk8AIUk9IuEVLRCa5Xhjb7Ko
         CFBxUFGtKY8qWJburPOHlVxym4fF+jqdBQ9Zczz7uKNcSqTWgzmb3D4v/fmVmeyF3q1t
         FNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TgcPChjNYhPVkz49K3frhW3QdyWBAtp4NeeeynEsOQ=;
        b=Fco+qyrmird3VA6x72cnF6i5UCcCoMwgm7RmLF+t727LphntSn9LSLBrxvpSFOWHtH
         f+WLd4ttz10D6QXRtJY7jTis2N0VWm4bOBEVv+wlEJCS8dH8jGe3V0Q5NChXs1z1aVmw
         PW+GhYGu8yt9j4jph/G1NDePjbWPAU4Y3E+tW6ia9dFTCWs2278Xh18gW+71em5oF3Hk
         XvB/3Z2H00jcbIFiViTGpx60fv2rTeOfNWgqAWkSClN8su6nvNaEl1q2tfrcJjAvJ8wD
         KeWzGUHsGtXlf1GSGEkulIqLPKkWo0yRBO61az+VwvuZo5GhAOl4mr7KrkUkyrC5Jege
         BKog==
X-Gm-Message-State: AOAM5305DwoSkWGhOFKHEXY0Mw+9z0PrHHERDKoj9qPL1ZmmOtDKwwvi
        izaCJ6+ujw9+aWALHFGM5/YmZtOso+hkOg==
X-Google-Smtp-Source: ABdhPJw9WhbzyvMbGGGaOaXqvNRFkohj6VF9ubsHFu0sumOgaheX5//uFfr6PJ7ppqFTv1XemTB87Q==
X-Received: by 2002:a17:906:af91:: with SMTP id mj17mr10606327ejb.228.1617894279190;
        Thu, 08 Apr 2021 08:04:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 8/9] blame tests: don't rely on t/t4018/ directory
Date:   Thu,  8 Apr 2021 17:04:23 +0200
Message-Id: <patch-08.10-3583078715-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) so that the blame tests don't rely
on stealing the contents of "t/t4018/fortran-external-function".

I have another patch series that'll possibly (or not) refactor that
file, but having this test inter-dependency makes things simple in any
case by making this test more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 29ce89090d..04a2c58594 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -482,12 +482,22 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 test_expect_success 'setup -L :funcname with userdiff driver' '
 	echo "fortran-* diff=fortran" >.gitattributes &&
 	fortran_file=fortran-external-function &&
-	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
-	cp "$orig_file" . &&
+	cat >$fortran_file <<-\EOF &&
+	function RIGHT(a, b) result(c)
+
+	integer, intent(in) :: ChangeMe
+	integer, intent(in) :: b
+	integer, intent(out) :: c
+
+	c = a+b
+
+	end function RIGHT
+	EOF
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
 	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >"$fortran_file" &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
+	mv "$fortran_file".tmp "$fortran_file" &&
 	git add "$fortran_file" &&
 	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
 	git commit -m "change fortran file"
-- 
2.31.1.527.g9b8f7de2547

