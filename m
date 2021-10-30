Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8766CC433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5F460F45
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhJ3W1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhJ3W1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE7C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d5so7036227wrc.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vM8J+gF1oNZ7bw54oLZNIMOogvIs2nJatZrUXhTCDk=;
        b=d5hRS82W7KxGWTFOf9WWqc3FB2hriz2GfJGH1a8WKApPavqF8AdBtLbeBBMivBFdjk
         sJ6sRYBQKLtzUKP5H3JztxClpUYCx4C5H8FGK+KzJcQe4NYXTUvefGd+f513nmOogOZg
         Pxe7roAQGw1z76K2qDAGH0yCERMJ6l/Yv90/+YG/dtk/nFPvepNrKbEk7Wc1Dz2N0OEK
         wd4f2iFjwNieWCT6RsaCMrbF1OkkMk4x+kq3ZRvV2OWyBErInXfpwLBsAYQtnCWEsx6z
         +hNSDaj5KMY+2TSiBN833C4IIlKsEFqpEAe+HncVNyd4k/lLquVlcnzqIogz14fzV+VY
         3KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vM8J+gF1oNZ7bw54oLZNIMOogvIs2nJatZrUXhTCDk=;
        b=VddPQcubm709PK++AWn0vJC+Ou8mffh6SXzxnXn3VzcfRakLSRNMoEVkLBGn1/RY29
         04XUaDLh+3K7usTghUebk4UVtNMr1bK+yMFMXFR55ThHwI3mMnNIoEYEwpyt98VRufOe
         bhpHs9Vb1RuzU8YZgtHeqk9iSXHrGeFdpyWdFK3zh28ncaFshMdGwDLDgmLVctE2mAiL
         vYxzxATjyPJAGPDUPo33cccNN5VGN/Rcu7DI1S30kZnJLGNSy4MYFP4Bly6LAmX6OIyT
         NMs2aqwZUFKpGjfOyeIYkjlmPWLhIiHATdlAFAVCPXqUDSQsQGoAO5vrHcLeQF+No5NW
         wmIg==
X-Gm-Message-State: AOAM53345cn7ryT/pCdRpIqQ0SusUAYLq7VYAj2etfkuakFZVXnps5NI
        ySqcsG+/+bUsRTH+yNeAHRbKQ14Vh9DtVg==
X-Google-Smtp-Source: ABdhPJyekGyOBVJxmTYwelMeUGOvJUWHWeKffbhaBdkcX4Pf14adDxCnf4Oq4L7IWFx1T+DnSyQ9kA==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr18324642wrm.430.1635632671318;
        Sat, 30 Oct 2021 15:24:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/15] leak tests: mark some rev-list tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:14 +0200
Message-Id: <patch-05.15-fe2b05c7031-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*rev-list*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6005-rev-list-count.sh              | 1 +
 t/t6102-rev-list-unexpected-objects.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 0b64822bf62..d763de0041c 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -2,6 +2,7 @@
 
 test_description='git rev-list --max-count and --skip test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 52cde097dd5..6f0902b8638 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -2,6 +2,7 @@
 
 test_description='git rev-list should handle unexpected object types'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup well-formed objects' '
-- 
2.33.1.1570.g069344fdd45

