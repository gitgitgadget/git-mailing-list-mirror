Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D321C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiKCRH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiKCRHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C026C0
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so7033807eja.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0++G7MJkrywL1OFyLPkPQ3Am3lw88f1JOQSJsOEsKA=;
        b=GofkviQicaWStJi98Mdb8rTBNH+GXtOUrJSQ8f128Jq51r6jcVDXQBjANSOlj3iK4S
         xhZXv8fOIN+LXskdaZ1H0EkquKPHSGQXdj4wYs+H7h5CRi5wk1BiDh9aLzC+l/DnVRwt
         NEJ9g0chcWh5rnMOhWIy3Y/D2OZ3NLyoNBHRZfZJjb8+5RM7cugcS8NhDF6g67BfK9Mz
         J6G4IpJDz61uv46rY2gTOxEje2gtdUWcxWgCInPI7+0G/yeMFDsZdQUkOB6Ar+Khhw49
         kyCEBuihfJj/ssHSExMW74OMhAPKNM1t54MYyFkvQnq6cXZ785COd1T81nUgfAt8cNJG
         rsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0++G7MJkrywL1OFyLPkPQ3Am3lw88f1JOQSJsOEsKA=;
        b=tSfjUwaTqfPIhz8sf50aNX/L1svkb9DatE0DVFDxYHD880ccuFwjSn4Vn+PJoCSuZ0
         Ez8iaz0Wv4QoNxoxPeco/WV2KsjhMVIZwp80r5mheKucnKUflSZqwhCCLm1qUsfLo05W
         AFx3E9pvCCtNNw+Lq1Fx7kI3LgCxHPCdXsgHxA+ues0odaEXdzDtsBzQJHWWNpSIsnmr
         3m0Uu/2Y2bRpV3Tg2hDjlhGi3EgQZkPjN/J210O/wJTisHNwO12htkVmd6n63r95DTg4
         WEN999QxKRSLWdQi+PFXad4W7tyKyMqdjnpbhh21o1a31WGFX63Q/foXukFTjqenB9lh
         TVCw==
X-Gm-Message-State: ACrzQf0XAOO7DEzYDenra1jeXcSvqHfOLAFwB/j+zxIfsSzqJshvy/Gc
        j1aV/cKEZVvmLnRYwsA3Ilk1ttK9p5xZZQ==
X-Google-Smtp-Source: AMsMyM4LAtjycmb3+Mzl8adcc5U7bsjVGRwKLpHf908rj2GTtJMqJu3pYzxBVQoCywNrZy5Wtiv/Ng==
X-Received: by 2002:a17:907:783:b0:76e:f290:8b5 with SMTP id xd3-20020a170907078300b0076ef29008b5mr30455948ejb.395.1667495194014;
        Thu, 03 Nov 2022 10:06:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/17] revert: fix parse_options_concat() leak
Date:   Thu,  3 Nov 2022 18:06:15 +0100
Message-Id: <patch-16.17-f7d39020a7c-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free memory from parse_options_concat(), which comes from code
originally added (then extended) in [1].

At this point we could get several more tests leak-free by free()-ing
the xstrdup() just above the line being changed, but that one's
trickier than it seems. The sequencer_remove_state() function
supposedly owns it, but sometimes we don't call it. I have a fix for
it, but it's non-trivial, so let's fix the easy one first.

1. c62f6ec341b (revert: add --ff option to allow fast forward when
   cherry-picking, 2010-03-06)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/revert.c            | 1 +
 t/t3429-rebase-edit-todo.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0f81c8a795a..8bc87e4c770 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -221,6 +221,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	opts->strategy = xstrdup_or_null(opts->strategy);
 	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
+	free(options);
 
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index abd66f36021..8e0d03969a2 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -2,6 +2,7 @@
 
 test_description='rebase should reread the todo file if an exec modifies it'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-- 
2.38.0.1451.g86b35f4140a

