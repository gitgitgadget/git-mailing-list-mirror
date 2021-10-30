Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E711C433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FF760F4C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhJ3W1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhJ3W1K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6172C061205
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d5so7036347wrc.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIKZE6NpK7V9NWP8l6N8Og5/RDEe+sfNPsqhQa8T8/o=;
        b=gZ/ENDJ7ER0ZsYlrcSb964zexTFpszGAojtGrbrt66O5nsGf1XwHS10d8VPHrReOjo
         111ky7qb37NnI+rdjgI4bjLm3O6AIUtozN2h6u/a5ctCb5Bf2rbD3x7I0jBU0dOiEkPm
         +wjKcllfQsX2GcTdJ3ODnNH6WFnqlZ01gmz/T/d8IsvgLl/1UEpZATk/9HHNyJGXbm74
         /P18nnUlzaD74ZWnFZ7hnGdSqlE5rcR9PLluAnp8pp3VxY6MjG5f20aO5VxxUycNH/3z
         sKEpm9FFer1J3DAKwCdJyOXiZwyarl7dSwC0uz83up0kzkXQZrBdq/JxWSpoJmhSugho
         +lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIKZE6NpK7V9NWP8l6N8Og5/RDEe+sfNPsqhQa8T8/o=;
        b=P3uXnJL1+kVQ0jsdSN/hLQFT4JEg396LNQYRK9+XgtDhYHide1XdqeBNbjPV5vR3D7
         qSoAwX8vusgR/upDNzsbkixYOR0S404kEPS3NREiZHXtyMmq8zJRWnt1xvfxo9K1gAfn
         0RpCrThsIxOyw1nE3ORINVtHqH4tDUHdue9Jmer64vaD7lgqan2cVrjG0PLBaIMXKqA9
         Lwzf/2iA4LpR65afTO5thkuHFR4T/y7vEI61SbvU/S/YYqXoUVEXDnXsWr3hyehXMiPr
         OpQoAl1i3B9v25low+Te32L7dGjskcuzWVYPEQRPY5Uc0RDLQU4ostQc79d2LdxX9+kQ
         YOgQ==
X-Gm-Message-State: AOAM531JXWbm6/LlqurjMVnE5qETmXgmYYOknyt6Pdj3uhmIQ2wjAkLq
        eWB1gJ8iwlQ5lVwDks9J3EtwWy5lkYnDVw==
X-Google-Smtp-Source: ABdhPJztJUgDYBVIIztTPSD11K8PrDrz4WzP2WvvDqqqxR9B4HtYdUi+6sQCqPdVVk5B6kdnWdj+8g==
X-Received: by 2002:adf:f551:: with SMTP id j17mr22879938wrp.392.1635632676367;
        Sat, 30 Oct 2021 15:24:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/15] leak tests: mark some clone tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:21 +0200
Message-Id: <patch-12.15-0ede991b623-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*clone*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5602-clone-remote-exec.sh | 1 +
 t/t5603-clone-dirname.sh     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index cbcceab9d56..56329aa160e 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -2,6 +2,7 @@
 
 test_description=clone
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 13b5e5eb9b9..8ca1f094237 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check output directory names used by git-clone'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # we use a fake ssh wrapper that ignores the arguments
-- 
2.33.1.1570.g069344fdd45

