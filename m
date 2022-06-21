Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62BC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354507AbiFUWeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354481AbiFUWeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058DC264E
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i10so17092238wrc.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFUMVQSQKlu7nIYrPu5XWfVVrVG2zFi4qm1voYVbvHM=;
        b=UFW0suzc+AozRpw8P2jFM2uZ6xh3urCgbFu2vqZWyX+j8Dy4s6vKruyYKMhAuR+AKU
         ngOL5ckdHeMBnCF1gBlb+CG37juafLct0olHL5VlgoGhw8LMs3jZlHKz+2exFugqsp3O
         AYHHpBQ7HXm2FfZtFAIQTFeNsFXeOASbsDom0w9hLizVLLf+9ccx3XrXTB+gKvW1jyuD
         9O7yPZePcqprPb7cIa67RTp86uz9K/d880jB5xdpg/5u/+u5LrKK1I40Jg2hoRd2Wjlg
         FWjqHl1Ra8GHkogrW0782FUvjFvhkrbRTLxTWLlMnh2iFVz9EgUR+UMT109Nnkt1fmsI
         Avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFUMVQSQKlu7nIYrPu5XWfVVrVG2zFi4qm1voYVbvHM=;
        b=sMzHUNlVpaTw7Aa0xwyy66PRXA8dStyrxWcbJfc83u5IRmD9Ce88gxacCuvcGwWXqN
         S6OA+Y8rGwSn3wwZ6q8echV/3L4A/fF6c+xCs4h+a253/JMxFsxfQxH3AAd3paDJNEO1
         HiOD61VAMqirqO8EwUdub8+pzBiuS5SV4/F0yz++SfFzHhzaO/ofhdBfl9EgEk4ntfg9
         LTYLCYS9c83bDLdRtcu2wgPp6+f1YB0onBzpK2bi36YxbdEoR3tx6wuV3HICfgfiNG+8
         0/IhBJCk45ty49vxiQqdhdZscy8KA7Y4xNfM4Nvo2vYU6mErlWz+KW3TYIO8HhXkuvWV
         kriw==
X-Gm-Message-State: AJIora95hES6XXdOXy/7CTmZ9O/jl7e29KgXlyd5gEgvLTRia7hDX+y+
        WAbE9iDk8OaXuUrEid9+FPIFtQtOypBvqA==
X-Google-Smtp-Source: AGRyM1vWM3FN9Y3y8BRDAAp4MSv17g9W9WzjrDPulSuWnRNXuLj5okOLiOGu5mIKdC6I3oLB3hOVsA==
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id n5-20020a5d4205000000b0021b89eab5e3mr204232wrq.103.1655850869231;
        Tue, 21 Jun 2022 15:34:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] fetch tests: add a helper to avoid boilerplate
Date:   Wed, 22 Jun 2022 00:34:16 +0200
Message-Id: <patch-04.10-398818a5acb-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new test_configured_prune_type_branch() helper to avoid the
boilerplate introduced in 97716d217c1 (fetch: add a --prune-tags
option and fetch.pruneTags config, 2018-02-09).

Back then it was somewhat necessary, but since 6317972cff9 (fetch:
make the --prune-tags work with <url>, 2018-02-09) these tests have
been regular enough that we can always pass the "kept" argument for
"link", and "pruned" for "name".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 799e69dc1b1..5d118a6a806 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1006,22 +1006,19 @@ test_configured_prune unset unset unset true pruned  kept \
 # remote. However, because there's no implicit
 # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
 # command-line negates --prune-tags, the branches will not be pruned.
+test_configured_prune_type_branch () {
+	test_configured_prune_type "$1" "$2" "$3" "$4" pruned "$6" "$7" "name"
+	test_configured_prune_type "$1" "$2" "$3" "$4" kept   "$6" "$7" "link"
+}
 test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
 test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
-test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   pruned "origin --prune --prune-tags" "link"
-test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
-test_configured_prune_type unset unset unset unset kept   pruned "--prune --prune-tags origin" "link"
-test_configured_prune_type unset unset true  unset pruned pruned "--prune origin" "name"
-test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
-test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
-test_configured_prune_type unset unset unset true  kept   pruned "--prune origin" "link"
-test_configured_prune_type true  unset true  unset pruned pruned "origin" "name"
-test_configured_prune_type true  unset true  unset kept   pruned "origin" "link"
-test_configured_prune_type unset  true true  unset pruned pruned "origin" "name"
-test_configured_prune_type unset  true true  unset kept   pruned "origin" "link"
-test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
-test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
+test_configured_prune_type_branch unset unset unset unset - pruned "origin --prune --prune-tags"
+test_configured_prune_type_branch unset unset unset unset - pruned "--prune --prune-tags origin"
+test_configured_prune_type_branch unset unset true  unset - pruned "--prune origin"
+test_configured_prune_type_branch unset unset unset true  - pruned "--prune origin"
+test_configured_prune_type_branch true  unset true  unset - pruned "origin"
+test_configured_prune_type_branch unset  true true  unset - pruned "origin"
+test_configured_prune_type_branch unset  true unset true  - pruned "origin"
 
 # When all remote.origin.fetch settings are deleted a --prune
 # --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
-- 
2.36.1.1239.gfba91521d90

