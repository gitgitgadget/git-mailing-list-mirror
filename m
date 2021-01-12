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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6EFC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06FD23127
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438125AbhALVh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436877AbhALUTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF1C0617AB
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n16so2400773wmc.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJWKJ/CIVB8URp+6npPRrveo3/JUVRe7nRgR27ox9IA=;
        b=hbrW8NOks0MakctKNoASaHFWDk5/MK9l34JuhLBgcZBDfPLqxk0dboAmZo2C7Quddk
         K7hkz4ymp56AbUM7D988aJXvlb5QttRZJgSP+m3sw3o+n6doXZXg10pi4I1R5DDtmrXQ
         N9GpHMLT2vNLOiqio/0tFuCUg6xG+ZVzZfFw1dt/Ujemq1yToZvQMxw57kLPXbKBqkes
         vMSc1tQ5z4qSI26/qTr8LGsUNnMVSgtg1bob/unf9m3gHmfNjB+LaRa4EjhwzfN++Obc
         uQxEst4fH0rdo9bIWYYmGhLHKilfXKQafQxUL+704Nsco9yjiiz/a2mZXh5flKIY2H7C
         YDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJWKJ/CIVB8URp+6npPRrveo3/JUVRe7nRgR27ox9IA=;
        b=XctL+tWaRwvfyJkvLm0bM3ZbjBcrFVVTsKKSOUiXPsIMA0rsZxqp+u6IzGoL+Gs6Ao
         LotRR5Nfyk6XYkNBWm6az6jsMLQ/9q8TOWQ/PfhzAiEEIhCkTuMiYjRLaPZr4HJkyBnd
         Esq37hV5AS5CxEQ/SdSfQ9N4FfB7WQ9SvJk3tUOulNlJ8Hqj+zxPRot2WkCjdLl6pUg7
         XJDri1LlfYseJ/3avIIb7+1vh7aM01uJPK2l1tX2xW01wSx2lSMKdPblB78BRWTqhgU5
         kPfwK1ommGdk9+KLdhrI33QFySCcOIBwPrxXG8/6eO/fEKXnuh5C+po2I5pzQmHGOULY
         G7BQ==
X-Gm-Message-State: AOAM532JaI3tf2jMPXqbjlYgO7P5XhAYcnGw+jFKqcjsGIKsB0EkFDUr
        YvdDL4LlV4hBf1M/rlFnq/nu6915Xtm79g==
X-Google-Smtp-Source: ABdhPJw8AXqTkuCA311crKyklOyX3GW8ZKo3/YfwDJ2NTTLKf2L1gomSc1H/Ezx4biXEUZTZXTWA8g==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr897082wmj.154.1610482716064;
        Tue, 12 Jan 2021 12:18:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/22] test-lib functions: document arguments to test_commit
Date:   Tue, 12 Jan 2021 21:17:57 +0100
Message-Id: <20210112201806.13284-14-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --notick argument was added in [1] and was followed by --signoff
in [2], but neither of these commits added any documentation for these
options. When -C was added in [3] a comment was added to document it,
but not the other options. Let's document all of these options.

1. 44b85e89d7 (t7003: add test to filter a branch with a commit at
   epoch, 2012-07-12),
2. 5ed75e2a3f (cherry-pick: don't forget -s on failure, 2012-09-14).
3. 6f94351b0a (test-lib-functions.sh: teach test_commit -C <dir>,
   2016-12-08)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 396e039d2a..194b601bc0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -181,6 +181,10 @@ debug () {
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
+#   --notick
+#	Do not call test_tick before making a commit
+#   --signoff
+#	Invoke "git commit" with --signoff
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.29.2.222.g5d2a92d10f8

