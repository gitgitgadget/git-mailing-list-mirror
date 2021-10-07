Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8959C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA7460F5B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbhJGKDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240759AbhJGKDm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:03:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46147C061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:01:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so17343657wrg.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thKgVTFvvWsH/dbEPfxiuVm5rtByQeSEHqaFoI5ose8=;
        b=mzwicukIHmbW9qLL8oLzcVg+sxJZpn0J+kF5Tywve4aF2fRoe2E6nIrky3YBRPgMRT
         8Lqb0IQ7Bb3acBLTW1OwMgoCyehb4kkVb3/nsGMZ0pODc7zoeGTNCEZJyAdQKyembrza
         d9Ys+lEZoWGQCQUI5y/MsCFDVC6wAhsZJEFaC/lyYJGjsVi4+ef+4tvfN/ZXAWWSHiGn
         nnrYiFEXUMxoTuiBlLAj4AZ5nP2wnQITmNyazNRz2oNYGQTT3pBz9J9HxFP9QQTLSefp
         7pMntfFSixOwdTg4ubOzqj6QX/EikEKvUFNKK6k0B8FIytj2sBa2MhaUahZl4bdWpDJa
         BmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thKgVTFvvWsH/dbEPfxiuVm5rtByQeSEHqaFoI5ose8=;
        b=l3GBT7km0JCIzIkk4RelPQccWJOWtBXlLvV2HS0+0ZGtcz5LoUH9uzctJP26JaYnRH
         03l8OaC6xGQM0D5NmvQduLc424ecn0gmU1f6WE+8OFOHAc3I0dLFBe9IYdyeLo9kAaXl
         HbnrDRMyFdhj4f5/EjU6CmB2crpXXi/2PapeWkjKgNDXtWflz3YxRFErk/y2zNHLub5R
         Co6xxysnpVNcL75aeBtyG894vKyXbAlM1P7zN69YVAlZwC0hj6YtzeSUJvnuehRvqO2D
         hnjZPDIt69cKbXW9sf2saTVOYiuziQ/eOzF453/5N1lv2VItTM1IV0T6p+LNsvJrPsZO
         VQHw==
X-Gm-Message-State: AOAM532C362aUxLxWSRBYNsjyQbBkS1oL4wUtHEjIe1mqY6dEz9Yas6H
        HtU4Y5MKdxK4POVTHF6+XRy6uQFBDLfBPQ==
X-Google-Smtp-Source: ABdhPJwBycVYmh9tRDinKUY6cJC2PP84GIu/C7OH320d0Gdkzr6UDt6LMGGDvbIzVLZK46wThs63hg==
X-Received: by 2002:adf:e604:: with SMTP id p4mr4201209wrm.79.1633600907436;
        Thu, 07 Oct 2021 03:01:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f16sm628559wrr.53.2021.10.07.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:01:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] tests: fix a memory leak in test-oidtree.c
Date:   Thu,  7 Oct 2021 12:01:33 +0200
Message-Id: <patch-v2-3.7-33a4b9c7c68-20211007T100014Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-oidtree.c, we were not freeing the
"struct strbuf" we used for the stdin input we parsed. This leak has
been here ever since 92d8ed8ac10 (oidtree: a crit-bit tree for
odb_loose_cache, 2021-07-07).

Now that it's fixed we can declare that t0069-oidtree.sh will pass
under GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-oidtree.c | 3 +++
 t/t0069-oidtree.sh      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 180ee28dd93..d48a409f4e4 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -45,5 +45,8 @@ int cmd__oidtree(int argc, const char **argv)
 			die("unknown command: %s", line.buf);
 		}
 	}
+
+	strbuf_release(&line);
+
 	return 0;
 }
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index bfb1397d7b2..74cc59bf8a7 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='basic tests for the oidtree implementation'
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 maxhexsz=$(test_oid hexsz)
-- 
2.33.0.1446.g6af949f83bd

