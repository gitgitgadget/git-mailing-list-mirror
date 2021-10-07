Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381FBC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A7C60F5B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbhJGKDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhJGKDl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74DC061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v25so17268442wra.2
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LEfwCf43QO1pqRoSXsotu02cyLzxMw2j6ARgGPFOoQs=;
        b=NUAqo3rAqTMRZTBL/xpNfkqpwcUjWNT406yGA6ofXRGd82hOkiUirG/+ZMJY3iDK+A
         XMPlLHLcOlqtcWHFloRDXWJLC4V8wttnTEAvIH/tbgQ0JuuY5afppwTyLKZNdvzZCuIt
         /tz8Oi1MC2DjIdkOPNOPOvDyQHBzdKJ1CTEltBtduwynNIOLTe0fYNplwqOoiChGlfjM
         HvLwpLX/oSVaF5YITT8n0g9D66gg4dquu7comlq8ykwJtbbGOzq7MI7WdtdpHOvlsbWm
         +r/UdtadkcfX8ioyV0Y9vRGbs6ZYOXaGIJcaDBg5zojTu1Zy1+EVU0iIyTd/cZ/sOZbs
         kAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LEfwCf43QO1pqRoSXsotu02cyLzxMw2j6ARgGPFOoQs=;
        b=JUNOE3mapQ4lfU4YDvucQTAZ0RmVGaB64NBgVRpUmADkc1/z7nY6OOHQ4Dh70T0VVH
         HHv1oZglsg7MT8CdpBslggxsSNC8h+p60ltSyIn+W0PYyqEktDYN/Ng49ubBfghmkvjk
         i53NN+Db1P1HtpvrV6b/469j4gEAKZZ7z+P/fpOM4ME8UyWthDmNYDIl2ju44KWJQFW0
         r6N2n/sdLir0j1/zMuHccSnh66GKj4roZMSCIcAAyZ85dTXOCZceLQuQbuQoiDiPDn1M
         adlwuIYYNRvlafwWS3vJ2TOHqop0NXiObwDIt0+SdXgJv1CAyfnQ8SX5vXzmVnzqyeYw
         kSyg==
X-Gm-Message-State: AOAM530HEBJwHoVbpLaUs0/ChsQzfsbcwAf+ezmHJGLQyebLyObrA9Kh
        4dsiaENwLGq9jUEDvy8S4dNidAqwkxixQg==
X-Google-Smtp-Source: ABdhPJzB02JW1TEz8VFwTlNAHbkhecxE/GM5onQNK81FF8HPsxcIph1cU0l7uWv+/ctMP/qpFu4QmA==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr4182008wrs.293.1633600905635;
        Thu, 07 Oct 2021 03:01:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] tests: fix a memory leak in test-prio-queue.c
Date:   Thu,  7 Oct 2021 12:01:31 +0200
Message-Id: <patch-v2-1.7-37cdf0ee348-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-prio-queue.c, the lack of freeing
the memory with clear_prio_queue() has been there ever since this code
was originally added in b4b594a3154 (prio-queue: priority queue of
pointers to structs, 2013-06-06).

By fixing this leak we can cleanly run t0009-prio-queue.sh under
SANITIZE=leak, so annotate it as such with
TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-prio-queue.c | 2 ++
 t/t0009-prio-queue.sh      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index f4028442e37..133b5e6f4ae 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -46,5 +46,7 @@ int cmd__prio_queue(int argc, const char **argv)
 		}
 	}
 
+	clear_prio_queue(&pq);
+
 	return 0;
 }
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index 3941ad25286..eea99107a48 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic tests for priority queue implementation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<'EOF'
-- 
2.33.0.1446.g6af949f83bd

