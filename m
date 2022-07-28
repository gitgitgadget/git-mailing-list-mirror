Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81930C19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiG1Qae (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiG1QaY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A974DD8
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3431577wmq.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+9KLAtS07Gp07j/UQuFkCrlVBUtAPSpbiQ4csnWuMec=;
        b=o8urLJAjXSTx2K+XajwverZkty8ZGndfxTQ2ppqVVb3B2bes4mKc1x+eQFABa0v6Bx
         SShZStBYqyIx7YHEYmP5nBbrYbg5IzuACvkhi7lN9TnJsAD0Iw9QC8OUFsHt9Ue0CdCH
         HQXgyjn+ZVUzFCoatiyHdv/v8n9y/uSv1DNVNyQ1u3Mncz70TLqTuC3SBpV1AcQ4cuE2
         8TgH1s7z9oiruaQ/mSZD3X/E2x7Gc3cW6WEX/HUoih4p/tBOSPusWXx1IZy67KzECVAV
         i9JZeGPOBeudkTFpgeHMkbzYxNkpgQ6fMvlWMsR3ag4PaxSAdNHaF4TiXT9qY95nVG9O
         fLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+9KLAtS07Gp07j/UQuFkCrlVBUtAPSpbiQ4csnWuMec=;
        b=cSke44F+zxtkAhko5b3puljWlbw36msEsFXkREecv6zrkBl4IaA2l3qtJF7gfK8BSZ
         SsGvkHDNYjAOKknHwlGN/VVznpEIMB4+OzSIQpTV6uolPOgPScCk+gQU/74YI8NeruD5
         7PRzAyTnJxG2Z8FG0xSLqvwyhGuXNKIVcwynZeWBLh77v9jEaT0kP3jmgptEcn9Lyk+j
         ABrSr7aVvX5nfz2TSkSTEB18pXQY0P4aQh+r1a/y6mxS/gzSWqEjixq5bTR09lk/wFZv
         LYz5rtbAI53upGcDghbyU13wGJ62/okZ6aaP64ssQqjUktyTNJzXGMeHXXjKczAKfSm0
         z10g==
X-Gm-Message-State: AJIora+CLx07TLuEMrCZPT6YEo4dV9EvsMYWXndBv9XhWsMwPQABPWmo
        ESB/1oD1m81dFa1THgDnxhvlYKTwgt5Z4Q==
X-Google-Smtp-Source: AGRyM1v8qvlxOEDWpIXtJ1dVLbyQFvYziXDXlVQ08d/XkDDgNNEXx4nTfzF2HEsK+OcYqzCGafbhUw==
X-Received: by 2002:a05:600c:4e94:b0:3a3:455b:a277 with SMTP id f20-20020a05600c4e9400b003a3455ba277mr145298wmq.198.1659025822235;
        Thu, 28 Jul 2022 09:30:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/17] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Thu, 28 Jul 2022 18:29:59 +0200
Message-Id: <patch-v4-05.17-4e8e9197539-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24) and 3c3558f0953 (submodule--helper: run
update using child process struct, 2022-03-15) by not allocating
memory in the first place.

The "dir" member of "struct child_process" will not be modified by
that API, and it's declared to be "const char *". So let's not
needlessly duplicate these strings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 057cb6c0d42..35a168009b7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2105,7 +2105,7 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	char *hex = oid_to_hex(oid);
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = path;
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
@@ -2123,7 +2123,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2180,7 +2180,7 @@ static int run_update_command(struct update_data *ud, int subforce,
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
-- 
2.37.1.1197.g7ed548b7807

