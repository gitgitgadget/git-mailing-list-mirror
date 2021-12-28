Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E28C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhL1PT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhL1PT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3ECC06173F
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b73so11850617wmd.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sM7KFaxVByM7wepakmrBILQFT/gCVlf/qGDWnLQmElc=;
        b=m/QGHjsxmvV6ZE9HRas4FXsTIJsU/XpZxhljsUvAYYIP2XWGm8TSmS91MLbUEueYXO
         Vj0KLisRyyArm8tF+bqYKC2cLYum6Mf4ZCkoacJxWzhPS1BFKNy3mxny11cVjV2drqvR
         Au0pLdkcoSPapzQoeBTLYq5tMdNLEamRQFUaIVIjLNRJVjF0aYqXx8LksJQGWTZIsG7I
         COYqWVivNZE3VJ86I/uHsOkwwRH2iNHCMeMJYJcVNNKkxJqLRdvmXvWHJn2/iAX1gidS
         K4VFMZvUxznxY3hXp1eEiYSUrrjoGk4VsEQCiaY6dYixdcx9YHLtl/fLfuh5ykMLrsQT
         4SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sM7KFaxVByM7wepakmrBILQFT/gCVlf/qGDWnLQmElc=;
        b=u6YHSnc5erdKbrLSzydZA5JwfP0kqiU+QB8kx/YVS7UDR30hRE4oYiv/dqmZLfGoO3
         OdDMg6nQ2oNDg98+LIeJO2jAf5zz1eQaLJ/dldlm81huhjOjX6ylw9bpbet7sxNv0FOr
         psrATZ2ONj54fsUnvwLFZA7Fw/5c1Vd09bjD/0FLmdAxGfFnYB4Mjew0n45rX1pDAqGc
         2j6Veb2738KD3gjMpGHuV3t5qi5YjzleEY0P+M3JTrhW0ngcwWBwsseNN4CwClSINxzy
         TpcJZ4N3LG3gSiryJ+7D+Ap/HM4R6o88LjjJlEVmQkCNcQPKmevgmGIGdjv1cu3EsdEt
         zM3A==
X-Gm-Message-State: AOAM533UfaPT22ngmxamikyN/CWF8l0PaNY6b9UJa8Lp0d1TTdDVzVuQ
        G3UuZozICxGW/8B3pv5DRluNsmLIkFWGLYVw
X-Google-Smtp-Source: ABdhPJyalT+kX9MB0S9nCUjssdzioI5wHqhB98ZmUlmuB+LhVsd3Obmgk2CMoqVaIan7RaKIsAO/kg==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr17820677wmg.185.1640704764979;
        Tue, 28 Dec 2021 07:19:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 2/7] progress.c test helper: add missing braces
Date:   Tue, 28 Dec 2021 16:18:58 +0100
Message-Id: <patch-v8-2.7-3ecdab074b6-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have braces on one arm of an if/else all of them should have it,
per the CodingGuidelines's "When there are multiple arms to a
conditional[...]" advice. This formatting change makes a subsequent
commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 9265e6ab7cf..50fd3be3dad 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -63,10 +63,11 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
 	stop_progress(&progress);
 	strbuf_release(&line);
-- 
2.34.1.1257.g2af47340c7b

