Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B2C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DA864EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhBXTyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhBXTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67223C061222
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p3so2804372wmc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FN0keZbyeJBed2PZ2BnHxfrCE+eaOJxl4AOhzI+t4E=;
        b=Ko1HoW77RN1d+WPXxLqI4jVKzxvRlNZPF92hwg2yJt8cBFB394LSZswvaAi4MNSNbf
         /mBhaeK9Of1Q/WO4lSTbRwZLgWSjmwqYg5OWZvTkFaI2vVcGaEhtKEmq2U8o+PInjsb2
         p94ftDHkicsmWSlV09NFA6zeNEUsFniVdw0BzIkB2zbKQSlvH2KnT3tMGkUyjQUVAcJO
         16+4iZJ1rp93QDzM6n5QbveLXMRDXL5nF1eBFrp7tXnMz4BkApEcokWAJcZS3EARh+0P
         dEc10YLikJi7vpHoZBFWcTNHB05QjjwhtT+pHkUAhAEZoG9ehUnfHWg7jCbjqBW5JMOH
         pwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FN0keZbyeJBed2PZ2BnHxfrCE+eaOJxl4AOhzI+t4E=;
        b=lCR14Y/blVYJAs3UX+ojuPEwgW6enwZ90fkE+BT5UiQ7bFe3/0lTPtUDiM0Orz5bVP
         zDQfPQSjE5eFrEY8qhS0aR16XeKCXaizseNuVIaqr7Jmfpmq6WGUxZiCrJlkiggqatxO
         4XuoVyxdbW0AGJusJz6gvWTACZIXP5IsIbBuoMjc34fto21oiUaxwMpdGDuUISu9Y+4D
         xJTpH+5bXSI8h459SV8UqqzP899dxAamIoTSKx9/NBwYcb64MpPPvwtwTTFheUPC9RiQ
         y4Uk9SW8CQqekLUXzX/24JKnCL/u7N83VAEhIamEpKH+HvbgVQXpkGyWti0g/2nfwu40
         fAFA==
X-Gm-Message-State: AOAM5309zS/5Hv3nIR5JmXanF3QVwSjAICEFrURMjOzHnUPMPoy84OZW
        lWxfYQDuhqWls1nu/9K7jdghAvsOLq2kmw==
X-Google-Smtp-Source: ABdhPJxDzCKTl+jdXQCBiUmVBxF3aiTPw/EoX/8iMi2e+AwQjIU4ioJzjOg8akGlVLELU9r8xkvlcA==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr5247667wma.68.1614196328905;
        Wed, 24 Feb 2021 11:52:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:08 -0800 (PST)
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
Subject: [PATCH v3 19/35] userdiff tests: do not do compile tests on "custom" pattern
Date:   Wed, 24 Feb 2021 20:51:13 +0100
Message-Id: <20210224195129.4004-20-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f1b75fbaf1 (t4018: convert custom pattern test to the new
infrastructure, 2014-03-21) we have been doing the basic sanity check
of whether patterns in userdiff.c compile on the "custom" patterns.

That we were doing this was an emergent effect of that change and an
earlier refactoring in bfa7d01413 (t4018: an infrastructure to test
hunk headers, 2014-03-21).

This was never intended by the test added in
e3bf5e43fd (t4018-diff-funcname: test syntax of builtin xfuncname
patterns, 2008-09-22), nor is there any point in doing this. We'll
error out in the custom.sh test itself if those patterns don't
compile.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 71a7b474cd4..b80546b4d7f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -20,12 +20,7 @@ test_expect_success 'setup' '
 	echo B >B.java
 '
 
-diffpatterns="
-	$(cat builtin-drivers)
-	custom
-"
-
-for p in $diffpatterns
+for p in $(cat builtin-drivers)
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
@@ -50,6 +45,11 @@ test_expect_success 'last regexp must not be negated' '
 	test_i18ngrep ": Last expression must not be negated:" msg
 '
 
+diffpatterns="
+	$(cat builtin-drivers)
+	custom
+"
+
 test_expect_success 'setup hunk header tests' '
 	for i in $diffpatterns
 	do
-- 
2.30.0.284.gd98b1dd5eaa7

