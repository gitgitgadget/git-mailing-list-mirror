Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5EACCA479
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiGAKnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiGAKnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D086BC5
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so3462061wmp.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ynx/ukDtxgn6C5N+YHBkf5Ff7kNqpYhzRIuZydRw0n4=;
        b=hc1seTXaAESYoBMiqIDPfG27dcQGJEF9+2xz5LslT3bYGWOr6TLLSNBCr5oaHbgUfF
         bJGCc6taiY4RY701v5kzbYBpAfMtURJdClAAnoABsqY36IlVzerkotv4Y73cIGmLYKXf
         3U0LEqjTpJXGzU9+Pg4PTJ9xbG1P0KvixnhAwKgHdsCkw9eKSBpESWBKYJmgQ6xmdK7A
         84n77yv8g2GarQRKiU5fxrguG7CNRn75LQt6+g1bY1G4rTiSojVTEcm6L1DX3P/Jr0tU
         R001uJ57EZQH1cUWedQ0Fxlq61c1Qvlkhdncrs8dOfmbhwhEWx1Mg4urPQM4tiP9g9He
         A18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ynx/ukDtxgn6C5N+YHBkf5Ff7kNqpYhzRIuZydRw0n4=;
        b=4ElqJCvCbaIy4+q4YZuq5UonzJCtV44nS3YoiDPBCn/ejylz+aXXXRivVJHVvU3LM0
         KZsmX+2AqmKSDMnIOIqmEFevxxmNSRw1O07g1+A720ZjdM2xaS/FRJqn6RfsXywp3UQZ
         tgPiDQsJr8B0CpwGeqpB37DzJjlTdnTPU1A42InVHYN0l03BfauV/Ldo1V7Vilb5nijU
         /kEUIBF6eYmT/rXxfwTq14teWt3BqW3+rJOoaoH20f5Kmhf92XCnfekhMyQzYpZvqT45
         dS3YbhMArpiJvc4rth6OmyRqJTxwe2SbC5szU80Qd8Dix3SxJLKu+UZjJdZwfAt2dii3
         IBsQ==
X-Gm-Message-State: AJIora89NWZhpr4z5NDV+VyNsGTmdkiDowEZDIJAmsA/Mh2YJzu9l2UJ
        3bsXt5FBlj4i/R4uMzF4AN25kknAxkr0+w==
X-Google-Smtp-Source: AGRyM1tXY23TvuBWXVn6zG7yhAcMBa/715vt2m10QnbXSrJwDPSSLF8AGWkRomWIF71GNhEkd3lgxw==
X-Received: by 2002:a7b:cc10:0:b0:3a0:7d75:b576 with SMTP id f16-20020a7bcc10000000b003a07d75b576mr15603098wmh.92.1656672185880;
        Fri, 01 Jul 2022 03:43:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] submodule.c: free() memory from xgetcwd()
Date:   Fri,  1 Jul 2022 12:42:52 +0200
Message-Id: <patch-v2-03.11-691b178aaf0-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in bf0231c6614 (rev-parse: add
--show-superproject-working-tree, 2017-03-08), we should never have
made the result of xgetcwd() a "const char *", as we return a
strbuf_detach()'d value. Let's fix that and free() it when we're done
with it.

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
e.g. "t/t1500-rev-parse.sh" now gets closer to passing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 4e299f578f9..06073b2e7be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2388,7 +2388,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
-	const char *cwd = xgetcwd();
+	char *cwd = xgetcwd();
 	int ret = 0;
 	const char *subpath;
 	int code;
@@ -2451,6 +2451,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 		ret = 1;
 		free(super_wt);
 	}
+	free(cwd);
 	strbuf_release(&sb);
 
 	code = finish_command(&cp);
-- 
2.37.0.900.g4d0de1cceb2

