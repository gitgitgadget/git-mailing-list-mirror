Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133FC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991DF60F4F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbhJHTKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhJHTJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724CC061755
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i12so20028324wrb.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpUsMFj5n88bokfZ9JR7ANnZQk9c8UrFvAw0lEH6Te4=;
        b=bQwFhz5mEzNA0T2d3ZRmJHnXXPAW7v0POp+G/mdpJSg1SKwHxdQ9izBv/9IWo24cYi
         85SafR8f47FAEL8pMekp2i/evlgOHvl0eke5MoqccD+1bZGBTSOe0hjx06QCu//JW9oa
         TK5YA6tlZKI/RWY0NYbEspyUPeywvX/uTIwiL5jbal9lhEbuCELtho8K6Apdqb0VF6H7
         YcmWzzDMMDy8r6aG8b8+rIoh4cYxpCzl7XTdi7PH6tD3qjppqsCd5XQ5Q/zIBdwe2R7b
         gKccHo+sKu05pWK00nqNMR72YWi0Vhy4wReStsPmYgFD06yx5vGePW7W4cmQ8m0jZuKg
         tvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpUsMFj5n88bokfZ9JR7ANnZQk9c8UrFvAw0lEH6Te4=;
        b=HQX0v+9tlmRZAZohR9jaNAxdZOeOdPKmag0nnbwEwpJNVG5rysg9zklekYKrxuxktr
         T5qFTVVR0X0LUEnj0Iee9yCP8cI1tP+S61U1i3Kc0A1Ed44eBYdRtWq1/yXutaYxnGxO
         OtMf1SVraGxg9Vlt21GNoUO0vdYEFbzzaOQMmq6HVkPWh2jNXJyRXqu8j4St+ivu3xxv
         hryx9qQJglMsDnHhvkUNkXbkODUT3cVOm67jIkLV/feryV44QKyyQRp4TEtBkLx+2dRI
         5Z1Cy5Zy+qWqoUTn6XVeiFRscrcjSf8ipenRxaUVwX4QL+xG2dw3atynfwMXk8abD2ED
         TjCQ==
X-Gm-Message-State: AOAM532Sjsz100q+956/8evrztZz4zP9KrYoot/JhfypY1qYcD6/fJhB
        QvduxKCKqs+bfV3MgYhNpYo68ODcMsQaoQ==
X-Google-Smtp-Source: ABdhPJzsJQfRfEqfxUDkg6lpjTxoeWxPibKVZ+NXXRpebnkKSgvBQ//68rJkR/mcINv/VpIRF9AEIw==
X-Received: by 2002:adf:a31d:: with SMTP id c29mr6168428wrb.381.1633720075987;
        Fri, 08 Oct 2021 12:07:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/10] parse-options tests: test optname() output
Date:   Fri,  8 Oct 2021 21:07:45 +0200
Message-Id: <patch-v3-09.10-a82987a03c7-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were no tests for checking the specific output that we'll
generate in optname(), let's add some. That output was added back in
4a59fd13122 (Add a simple option parser., 2007-10-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0040-parse-options.sh | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index da310ed29b1..d6f391a497b 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -168,9 +168,45 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test_expect_code 129 test-tool parse-options -s &&
-	test_expect_code 129 test-tool parse-options --string &&
-	test_expect_code 129 test-tool parse-options --file
+	cat >expect <<-\EOF &&
+	error: switch `s'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options -s 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `string'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --string 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `file'\'' requires a value
+	EOF
+	test_expect_code 129 test-tool parse-options --file 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: boolean' '
+	cat >expect <<-\EOF &&
+	error: option `yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --yes=hi 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `no-yes'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --no-yes=hi 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'superfluous value provided: cmdmode' '
+	cat >expect <<-\EOF &&
+	error: option `mode1'\'' takes no value
+	EOF
+	test_expect_code 129 test-tool parse-options --mode1=hi 2>actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-- 
2.33.0.1446.g6af949f83bd

