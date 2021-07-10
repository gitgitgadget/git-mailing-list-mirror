Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D7C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13D4613BE
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhGJNkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhGJNkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43BC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g16so6586315wrw.5
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OgnxKgzRElTXk1BTXxILsnwfavRXDyy4w7BU4Z0hWws=;
        b=U3DUCqc8pg9UsMVN4DdC2aqnspk+c0oLHM4efVtpcSA4mrRzZNtA+Rjs+Np5cxMttF
         DBYm/sonRrWAcbwOxEaFLmv3lIV/65W+n6IS0iZ56TiTbCLOG4ZXMamS5IsFJBXq5o/O
         0tJdMyt2y59wTv2uygT45FFutcXOFECsGRjGadOr7bk3Tdyo3Z2xuOjryruigUW2K6LH
         vTEqBBxdN7oIkFzRYwGFs3tf2KiiWGLaN3YA9EweHTh3jt8rjJaovylYur/TfYKn8R8t
         rlctZ17ePZOrHfDtSJTlILf5iAINUK+1Vbkox2QTeHxCmkx0EEU1lAXMdUCv/cSMsBGf
         x0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OgnxKgzRElTXk1BTXxILsnwfavRXDyy4w7BU4Z0hWws=;
        b=kT5yoLa/tVmSjydgTxRXngqrCl8OwZ4mwnnjKEZLU5VKweyV2s6lM6PsCgRjV2y4dl
         QG0rZl0y5zxgTEbRxlSnYljs8GkrbtI25qM3p5PMk8BGAWA+4/o41gdgjTP7NPmhBv88
         ZhcK5GAYODcfD/b0L5iVuwgRaNuxHrNIoNuINm5V4u0iyTMaKOx4oORXgwS7rFrsrS/e
         iYs0TwlYIjyqLcCwDY9d3MwUAH9C8rfTcyk77snyFOvVcGaJSo0rL3yRxvdn8BzIX0Se
         t5IbQGoeHcKu0jJ14EQ9UyKQe9p+kHb1bDzDCnpgyTWYAsAA3rRMWBDiCfa5nKbEr036
         NHeQ==
X-Gm-Message-State: AOAM531U0eXmrayAfK1Z4Ktdaafh9hSiuvk5TrtKgj5eWmKUw+w/a8Gy
        rPY0bQotSKsR7lVQiA8pt2Vosg5ymm8QBw==
X-Google-Smtp-Source: ABdhPJxQyzi9hidaZ6p/3KMHbZrOE9Sf197/ugRqLxVE0vU2VqGyfqXmyI6z0buvM036ZJLcGDwfQw==
X-Received: by 2002:a5d:6b91:: with SMTP id n17mr19893650wrx.385.1625924251516;
        Sat, 10 Jul 2021 06:37:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/21] fsck tests: add test for fsck-ing an unknown type
Date:   Sat, 10 Jul 2021 15:37:05 +0200
Message-Id: <patch-02.21-634f991d7c6-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 7becab5ba1e..f10d6f7b7e8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_done
-- 
2.32.0.636.g43e71d69cff

