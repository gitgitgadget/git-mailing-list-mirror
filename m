Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D6C07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CF560FE9
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGLQrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhGLQrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46045C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so441634wmq.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BpUaFjhGxS3C09d2FSRXu7JDMRkadSACf+ZqspHQOk=;
        b=NGo1uAm6wVzhO/cGtZ4/AdiGnNW8/DmrkluK60FY/kHYS280mm0jSecyXoOOpqNOIh
         3i/3omPtfHbn39j0AGuRMSW70GbPkz/np5ToA1q9Lppe0h1n5T7AtIT2wbXz+3QLjx2C
         +soeQM0AjIB2wEANs/PjdFLE2n8jOBvYgYe4U/Ox0cn6V19T4/111/p0Y9Xv06VoXIhu
         PHjxSfxtWnX6nRB0524uXFzafLvy6rbHPAZ+KTgw27k/HGYOI9IJNAJC4uRpuHgYnHEN
         rY9d28VFcV01gP6oKoPhY8NY9GJr5nXhybF4AQookA8J6rwTkaifXuLwjhJrMocTYL1e
         jqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BpUaFjhGxS3C09d2FSRXu7JDMRkadSACf+ZqspHQOk=;
        b=kwOLugKfnYbsmqoa1r/RqgmucRICsRoFrfkrPWFdh3StnngjFmLrWKZGT1etQactAC
         iMgzQvebn29b07TLaN3n/EZOjQNjiLZ0VPAzEvJUvjfFft2fLYvq2xaOg61IHcy1ySX9
         p9wHKOziZ3PplJ83U5D59++JlO+VNtX7+1jhgfyENsb6SWA6msypHIWgnrvwf6WekpkZ
         g6WhYlaqXwOqxCsNFbVp4Tsd1uimmCUiOOz6ICEzhzZlzHetpCg6POWyFxk6K9aDU4GI
         Oo4r/IWZKZ8JVoKi5EAfkn7DoSUXdsLvj8H850XLSDPhTK1G2xXMSpiIm5lA8/ChHsH/
         WyWA==
X-Gm-Message-State: AOAM53207WznOrNNQCG0HcGF72oxoZJ54LslfnY4ybAyMbHW06D/8ZeB
        M+PS7XkarSWjTWnJMR/SYkYulkIAQFKgo/45
X-Google-Smtp-Source: ABdhPJzVZ6oHl8ZL45UqatvJaMnZU0UdGLGYI+7bsPQKIOk8YW3fRJBSx3k7PK++mgzdtLIF89rSPQ==
X-Received: by 2002:a1c:4c18:: with SMTP id z24mr9166466wmf.168.1626108264693;
        Mon, 12 Jul 2021 09:44:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm12988347wmb.40.2021.07.12.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] serve tests: use test_cmp in "protocol violations" test
Date:   Mon, 12 Jul 2021 18:44:17 +0200
Message-Id: <patch-2.5-64dfd14865c-20210712T164208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com> <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
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
2.32.0-dev

