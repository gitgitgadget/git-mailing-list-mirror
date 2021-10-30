Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1CEC433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CAA60ED5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhJ3W1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhJ3W1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D00C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 207-20020a1c04d8000000b0033123de3425so4035150wme.0
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rDyCMrOCXTCTLgVNaLs+t3VNZhB2VdNHT2effvdT2w=;
        b=lB2/6LCUcoYgLUNARtaGdUwGderZzE3dLIjntew8bqH6X+a3p6ZtbhQQjkicZVviA0
         2ApoDYIZEvxmTmq0g4Ci7E50pnh4e+LF/gvMih4PL3yloGQOKvUTJ1Dm6cTlWcqww60L
         dsNAtKz/jf+lxQi8Glfyk+M9jstU4GzT4jVEPr/OU4F5XoOtaiATc/sHVwmmFcHpf82Z
         IQPSYB7BJTwpS3JpGHmM0S+002Rdhwj+iMrnUAngd8hUZw2wmfYXhxjUO+kFT5Xqr32S
         G25utJkdmFf/U4UNWADiT9SQ4yMy/3e/m9Ysatb3EJIkWZlvtjMzHjeKM8IXWS65bKtV
         Ljsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rDyCMrOCXTCTLgVNaLs+t3VNZhB2VdNHT2effvdT2w=;
        b=KqE3zIx5KICOKjNg/loZ1Rr9aIveBfViR60LY/12b0j/nvNczOzAXLKGzp9EYQGLAM
         iDMQpENwIa5vesr5rbvGLIUFg6VzETEDcw7B7ZJdUKQ/d1nqbrk8sjNPVNahRTdswnte
         C0AKP5wWLy3VYEss2a00xQnkCu5fe10LnUF+uUtE6HqCGB5F22u20qKLd92LVzCyP+Ls
         mIRuzUXd3VfuFIXXYaP29LswSZbqGvXLpx106CSUG+v7biPFfc3W4wLea0qb22kcaovW
         I4JxoVy1ioFWfQnBG4Mp0nmGBOtt4HBrWuLbRRD/uj4BtAFVz8VWIgH60gQuRcPnvrAk
         7tJA==
X-Gm-Message-State: AOAM5324liKL6jQhiYSel8UQbFcsMfFs5OQHbb+DfDNBER+8dUr/vxEN
        9RYFZ+Yse8q10CjZgZ9FeLYSjI4P3PUcnQ==
X-Google-Smtp-Source: ABdhPJw6YnW6aI8FkVPMW/wDwND6LB2Zjzi1IhxKSEEtbGe42E2hqqp/EXaSZT78a/ds2yhqRy6juQ==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr10765828wmf.6.1635632669229;
        Sat, 30 Oct 2021 15:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/15] leak tests: mark "sort" test as passing SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:11 +0200
Message-Id: <patch-02.15-a28d06d278b-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark a test that was recently added in e031e9719d2 (test-mergesort:
add test subcommand, 2021-10-01) as passing with SANITIZE=leak. It
will now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0071-sort.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index a8ab1748796..6f9a501c72b 100755
--- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -2,6 +2,7 @@
 
 test_description='verify sort functions'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'llist_mergesort()' '
-- 
2.33.1.1570.g069344fdd45

