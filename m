Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE02CC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiGMNQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiGMNQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C12628C
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay25so6502525wmb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mol2P9qRiDB02MBAu8YnwLHPZ9g3oGYn7gZYpj+O4DI=;
        b=Nzg1KbIQl0gg6mzXSIL/bDE9TaZQtxJeSU6rxBndA4C65TEfuLBYlANg0xH633hUbY
         TNuk9FwKSU5JnCyvwWIAgd7PFGVSy32xo78jXTzdAMraokwIGO/zicf5BP5bRnBbBHxc
         PdNggD9IgiARkh4rYHyhFYVRFX0FP9QGoCjRM+FwcnnCtBoKzy392BKeySnxzN2hh9nR
         oxDLBE+iOC6jLMKRV7N4KoudZmDzlN95Y3RNTxA0sbqA81Q2/NzsxY38TkoproPW4t+f
         PQlzccrv1ixDnlcMLMgR75V90RHz6HW6inH6VXqGfp2I8szDuKK/KgXJzZRgvaIxq9a5
         9PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mol2P9qRiDB02MBAu8YnwLHPZ9g3oGYn7gZYpj+O4DI=;
        b=ltQUesgeM2RsDrioR/FFzaZ00NcAP7ZyTfKjOJjcpM/r17OZsbTskYfJCMQA0K9QaN
         LoG8h9BmZ8vE+PnIeq352iCmemXXBq9h/N03G0R2+u7WeGyEhisit2Eh09CdKCoOioGD
         X4niand2m6Br7OaNVtKZzGAWkWkfqiZhIIvSku23ykeAIPSydb4b0z+m8IhOsAPYRI3Z
         Gb1ywUo7ShjcqbWUWtz6lVPy9SlX/yVYnK78UrdDMkwBkEtvUkT8QzhcnIccBA/2VGZQ
         FEGADKFtp6Btow5wufP1P8uQo9DyXrn2u10l82qJ6CQJxKvBpWLDhpy02eyzDPWdc+iD
         yBnQ==
X-Gm-Message-State: AJIora+53yh+TcEVRzJ5QZhH11M+wlZ25+K+Lsi5uhexcf0R1pikj8h6
        TsG2MqWyHMghqBfX/qr6m8ZCD9YLXfaD9Q==
X-Google-Smtp-Source: AGRyM1uFw3l7IG7TmsRWGheMmMj2DXqEbqExSd56VhVZr9+TvHbl6BpRfO/3jm3HdUnm5QGqhEtk4Q==
X-Received: by 2002:a05:600c:a4c:b0:39c:6517:1136 with SMTP id c12-20020a05600c0a4c00b0039c65171136mr3604095wmq.12.1657718185641;
        Wed, 13 Jul 2022 06:16:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/11] submodule.c: free() memory from xgetcwd()
Date:   Wed, 13 Jul 2022 15:16:06 +0200
Message-Id: <patch-01.11-f1c847ad613-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
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
index 2af16c647d5..3fa5db3ecdf 100644
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
2.37.0.932.g7b7031e73bc

