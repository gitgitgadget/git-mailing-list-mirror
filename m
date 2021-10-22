Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D6C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395F7610CF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhJVI6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhJVI6J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCF7C061348
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso2584306wmc.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytZQPlO9P1pFh9RzehhhYtcwvaGxiRmuht7ENhk+OkA=;
        b=PCma5JnYRma/vnv9l7Hy1yMlC6EK3JNlk96WaaCE9nd2aNyKSA3xSOA3soGBB7l7E4
         XFmdRz+PSsK5r4XC4xthWWEP97W79c8VKfVQYbpEwxqpbSiWmBh3VenDVsR241XV9Z+t
         UoIbeAnXXv6q38wMcuCe99TeU17ZgrHcASmBGpgDdsNNld7aAAMn1QWbee0cGTjCB9xM
         ZElp2PlVvcYmPbQuiFQL1IqxM92EBDEWouUYseM+3weXDWE3Y5BLo73we7wL4otIavr3
         24sVRqv7GgpeE8fXu0CdkkWgsOJpMHdNZ1rQInUSiOsjXrtDVqm7d7orL5y0gVM8C51f
         SuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytZQPlO9P1pFh9RzehhhYtcwvaGxiRmuht7ENhk+OkA=;
        b=klKBEjXJWQAimKVfGzwSCoaR5hdABmtscS/IJmwIqSQ0AnN0FIOPi2yBPt059Dbu9K
         bV9mTPnXvaQNIaVlTjgaNZYTeP0uGOAqrethqViRYAtlQBvn+ZMKdU0SLU+OSev86s11
         4W94YIuFdU9gEDS8fHE1b/xYd7V74M/X4+cOLNFKSdsUXdADWeDSEAWbOVarpWxBsDHh
         8aFJYcc1fdC+J8mt2nuxvi8ThXFmaKtkyqmk9kjdmU1urtbq2k8i+Nt6ObcN04XNyRd2
         mbJAQ22VG6/eTMe9Vx+LbLLnafGL+aLOJbjpsdmtKJA5+bnpJHbPSpDoeMnOW/PQg7HV
         4SMQ==
X-Gm-Message-State: AOAM533Ih8EgmmmnXobJ4PaYXl9OEHiLHMlDNP2SqDZkkog5NrsGQSC7
        ak/3eo93++rTOKWH/UCVghYhS0/kT+jskQ==
X-Google-Smtp-Source: ABdhPJwW26S3onpOChGWdpeXedBbEss43SB/QWYJybD8Tir33mPik8JJ1JM0kIk8HX1C7G4vKqdDWQ==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr13454469wmg.195.1634892950359;
        Fri, 22 Oct 2021 01:55:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] grep: use object_array_clear() in cmd_grep()
Date:   Fri, 22 Oct 2021 10:55:40 +0200
Message-Id: <patch-v2-2.6-033ca3f7b4f-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the "struct object_array" before exiting. This makes grep tests
(e.g.  "t7815-grep-binary.sh") a bit happer under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index fd184c182a3..555b2ab6008 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1196,6 +1196,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	object_array_clear(&list);
 	free_repos();
 	return !hit;
 }
-- 
2.33.1.1494.g88b39a443e1

