Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C625C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516D261166
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhJFJwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbhJFJwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A942C06174E
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f4so2238719edr.8
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAFnyYuHf0Hrm+CLAfi4fI8eUHXctSLr7haDJJFtryY=;
        b=oApjQYXKa/9ZXgrpBbxftjKv0FY5ZgR8F8UZiAWFYWCq4lGLDyBoB2CSmHloqY5Xuo
         DEkk7/01H3VWuH1C3gi0+58Gty3t1znvqWwk9SuY2XPNnRu3vhhVDXF7UEXawP5Z16PG
         s+ydEk1Ccv8Evyk3uDhJTrKRp1OAvrWM928eeibzIRLnFqvU0Nv+y02CnbPGPgW8nPJt
         KjlUhaI3OXUZU0dWRc7RJBo8pXq2J0fDa0NfO2F4P8vbllJ4u5izyuS3kDIzbcL942oy
         biJBMny72RN231lsGD5ldm/tuDlB5G95TVM16F3by3hRzlC5k6BM8gS5WwqaJH0lOkSe
         LCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAFnyYuHf0Hrm+CLAfi4fI8eUHXctSLr7haDJJFtryY=;
        b=X18gY70SQONGdTKmIcA1C20LAXThaMSM+1CNhZIT8aJ3J0LI4aGmWHVe68MUuQ/fin
         pI8ZaFp1hCjTYnml6KwQCrLvtJdELmCtUljyjDrzgVDk493zCS+U2kadc59r1R3gI4vQ
         A9CulWv9tzm3qpKnqhqVSSUWlbfUU/tplUhMPrTPo7MpXdQl9BIxmsO89d4cryUMrdHD
         NkNWmEv2yVxf3mh1p+ngzjOcno7TIy4IMoxaFpkDHVLksHiw/nKLuQxIIBtS23JmJdrv
         YWj8DLz/VnqW7bd6D8xCr71OtMmEFeqSQro0rAgOZYtHqNFvwxj/dqkkeobdvcVu1jkE
         GVvA==
X-Gm-Message-State: AOAM531ozsRbyZeZVVcklnNz+o+W0U+ThOH4OKNkJL7L98YHCPOlYHc6
        sHTMvlrbT7hYbbFB2Qc22xfkZZU+HEZpaw==
X-Google-Smtp-Source: ABdhPJxwHKLifREZ6nR7TYvPXCk7q1iRvN99y4z/SlCy6ThK5aMvBi7DCBCetTy1K8RFNwQvq/4z4Q==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr32751857edd.258.1633513842965;
        Wed, 06 Oct 2021 02:50:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] leak tests: mark all trace2 tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:32 +0200
Message-Id: <patch-05.10-da2631ce626-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark all tests that match "*trace2*" as passing when git is
compiled with SANITIZE=leak. They'll now be whitelisted as running
under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
"linux-leaks" CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0210-trace2-normal.sh | 2 ++
 t/t0211-trace2-perf.sh   | 2 ++
 t/t0212-trace2-event.sh  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 0cf3a63b75b..37c359bd5a2 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility (normal target)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 6ee8ee3b672..22d0845544e 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility (perf target)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 1529155cf01..6d3374ff773 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-- 
2.33.0.1441.gbbcdb4c3c66

