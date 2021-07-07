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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DEC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC41561C9D
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhGGKYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGGKYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F66C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:21:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u8so2412878wrq.8
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUr/sWnNygNlAvP4NqEhdrfQfyD1jQt9Zw3BiPYvi6Y=;
        b=seWpoLSArwp6W4wExzv8+iI6Kw0y2XrRqBN7iK1NbU7QgWcwQFanMautbfMy5gnj+M
         srv6uwr29fRubNyH+iQygp+pACdwAN+8anGYVR1a8NsWYcEQzIlT0CZDMt2EUCfVqvc2
         81EDhVeh3sB9c8zYouP6vyl2xyNEZrgNkdX4ntGtd9oFTg+A1XTxTJ3V6dlbAkuV9Wzy
         QJq4AMSVU/W4pZz/2QcWyrnryvxxaeNcUM0V/KO6eGBQTTh887HSUIUfXUh+/4DMnO6X
         yMvBavS34yOIuG6xH71+5XVznIl3d7C8i/9sfO6SsVaejNmS8duPlAA9XHSV2WrSQRWa
         4R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUr/sWnNygNlAvP4NqEhdrfQfyD1jQt9Zw3BiPYvi6Y=;
        b=lyN4mDAK+ebsdZiXV7fDeBmtWESu1zz2sKnvfV42UdapmRdpl7hjGhWeuPtdgt7ECZ
         278G3Mjo77ODkArsqBVsT8omQfVMRZmOU/efDnGqHnvX4QC6VnQoMgD0zs9qsC/yCG9d
         25XunNw1rTkf+gVQTIAm+WEbpMUfKq6Rn6//PD3ML+NWxad/6uom2oQFSV7+vFQdQBAC
         XBy9UC7/jSt2Yy6USLb/Ruby3K8fzecDec5jqfNQYLAYe3RfnzWBQlaTIYD88iuLm+QT
         0OCm9KvXgVondUjUgTQd5abR681SvfTNGWswRhPPD9+q98CYZkWCIZCUhBxDIMG7vW8M
         hQJA==
X-Gm-Message-State: AOAM530b4NaAuqISvfHXg12ZC4SToRQJloaYIlPguN+VwogElyaVpEZl
        udeCku4hsuI69+upBA+L40663I+EKXESUg==
X-Google-Smtp-Source: ABdhPJyfU+5MFYiloGA1XMB4aOrWj8fzOD8+QGwJNWE8gZMfgHjNLb44JWvK1PZpDWL5Gg0gxhWJuQ==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr20286317wrt.79.1625653316427;
        Wed, 07 Jul 2021 03:21:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] serve tests: use test_cmp in "protocol violations" test
Date:   Wed,  7 Jul 2021 12:21:46 +0200
Message-Id: <patch-2.5-c3544fb53cd-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the protocol violations tests to check the full output, not just
grep it. This changes code added in 4845b772458 (upload-pack: handle
unexpected delim packets, 2020-03-27). The newly added test in the
preceding commit already did the full test_cmp.

I have a related series to tweak the output from upload-pack et al, we
really want to make sure we have this exact output, and not fewer or
more lines etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5704-protocol-violations.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 95f68e1d4b7..038fffd3d03 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -14,9 +14,12 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 		# protocol expects 0000 flush here
 		printf 0001
 	} >input &&
+	cat >err.expect <<-\EOF &&
+	fatal: expected flush after ls-refs arguments
+	EOF
 	test_must_fail env GIT_PROTOCOL=version=2 \
-		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after ls-refs arguments" err
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
 '
 
 test_expect_success 'extra delim packet in v2 fetch args' '
@@ -27,9 +30,12 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 		# protocol expects 0000 flush here
 		printf 0001
 	} >input &&
+	cat >err.expect <<-\EOF &&
+	fatal: expected flush after fetch arguments
+	EOF
 	test_must_fail env GIT_PROTOCOL=version=2 \
-		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after fetch arguments" err
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
 '
 
 test_expect_success 'extra delim packet in v2 object-info args' '
-- 
2.32.0.636.g43e71d69cff

