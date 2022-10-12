Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C10C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJLJCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJLJCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122BBA900
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so793329wmb.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oieYuUBWHUvjDP07aFBGjc0KXeNB5ghCqeSuFf4IYe4=;
        b=J891T86GhpmC/aNpEKhUSX3O3oSFVUcozDzd6DZYisjcgpuOVrTCg4utYoS/HomerU
         4Bdnz/i8Hi3BFqMFAiecmf1AolQyC1pz/BQogYuZhhfy5EJbIhBC+Idsc6rZQfphKh/o
         U+cBJr4WLSI4s/Vx1Q1PWyzoPQiMiFu5lgolIY14rLrk5HtJZWUAyrA1gogdsE1YqebF
         eJT/Keb2XXudYl4C5nImoc/O1p+NWQzq8KGc3cuJ/B32P98i4dDCRvuXjsl+Me8nd1DQ
         jyTF+lPdbjTuUTSBB1NJ5YnOfCThCjkKHoLMUSUQxivilwi1kHFF+3gOgwqfQwF1YSns
         By+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oieYuUBWHUvjDP07aFBGjc0KXeNB5ghCqeSuFf4IYe4=;
        b=v2ogn9VMuxAxdfk7Q5WvyNFTlazBXVEUf2UCYiBp3LgumHH3uYo52nY8SXQtxB1IT4
         NKpjGH0zW9YDAJP0/W5Gpz1+rFtB7NB9iYrlV+f8HpgLU3ss/FbgnfAFQzkQD7DVy/Be
         oZX7kWMHynG5oc1Sp1z9PkrWZs6OJT8U5oi9gfgBBrnIY35hoEcjNzaDMdcYVV4vc3Vb
         uXzwEMks0p2DIcU9EvwqHF8pl9OX8Kn88i7Yer/GFsSprdTtGPRVUeDQQ/v9Y76YamuK
         YqvSHhb7BO5OfrZ3FDZw3f2FPKLvlSknDSOsOYHE9kz1SJtrhkVLEo4JoUDoIBouENfJ
         uxiQ==
X-Gm-Message-State: ACrzQf2iEn0ZRy/Df4QDa5KRr1x6v0sZOj6GNLDp2ogNLhCCkrG/LjMp
        3L86c2o/btizC5Y6fbLwMsoC/Ub6fj6Yjg==
X-Google-Smtp-Source: AMsMyM5hwCSs7jmNvd9xyssBkaMiiIFBMbBbQF03ToXH4t5T/Ibn2ulNFJGVrZuqaEhvX8srYye52w==
X-Received: by 2002:a1c:27c6:0:b0:3c2:e6df:c79b with SMTP id n189-20020a1c27c6000000b003c2e6dfc79bmr1949843wmn.14.1665565305171;
        Wed, 12 Oct 2022 02:01:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/22] run-command.c: remove dead assignment in while-loop
Date:   Wed, 12 Oct 2022 11:01:15 +0200
Message-Id: <patch-v2-07.22-b90961ae76d-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code that's been unused since it was added in
c553c72eed6 (run-command: add an asynchronous parallel child
processor, 2015-12-15), the next use of "i" in this function is:

	for (i = 0; ...

So we'll always clobber the "i" that's set here. Presumably the "i"
assignment is an artifact of WIP code that made it into our tree.

A subsequent commit will need to adjust the type of the "i" variable
in the otherwise unrelated for-loop, which is why this is being
removed now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 642e6b6e057..bd45828fe2c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1689,7 +1689,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
 
-	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
+	while (poll(pp->pfd, pp->max_processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp);
-- 
2.38.0.971.ge79ff6d20e7

