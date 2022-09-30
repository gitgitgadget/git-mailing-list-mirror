Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C67C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 11:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiI3Lg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiI3Lfm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 07:35:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8513C86C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so2093761wms.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=29W/1bR8qYv5R93TcvhCqBYqHPitTJj9eu3eIsGip/0=;
        b=m7iIUYetXZ6fNuduzHZ+XhK5XyiRiE5dqbU5rpljuaD9bDL39L8s5lo5UR+uDShyqq
         cDOK/hRyH/baWa98GnZuaVTZqtn7/QmHeER9OEp/Muzl8qrGEnWbu2fG2cu6PwEQ2tIu
         Cf1EwBc1TAO4VyHXxLOxV1feMwqjDZdj5A0odPEVvIU/Cqtba+arCMUMcwNjKmeZlw4I
         TnIbiZysMaDFujg/kNn1/IMD7AxtLd/BFWih5XO/mQ5eyKmGkyB58yWQDDgbaVP+qUeE
         eW7VQuODwTfjCzZHRucuGQ+5oE89y4KO4rd/4MWd63w82aXt/ZtoOWx7RFvXDKWP8Nk3
         e71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=29W/1bR8qYv5R93TcvhCqBYqHPitTJj9eu3eIsGip/0=;
        b=ZJsWweAmH3W0JtjgjwZjPzbuK9SYepXE+U2EXCc/rKlEvfqIScYgOv2qglazEaBy6R
         K4VGBPbwLKUrPogE6wFtAgExXDXRmMTpCAWfqu4cOF5vmN7nNFgTL9nKUA8k0ZuhEOBh
         HSj4nikJ3N7fH7R42rxXHOVWr9LZhFRGowsJDGFHS4uYh/6Ji7dGK3+C5Awhmu22lNGS
         7W/R3vOEne/lsvvbONZwGOZH0Vts65Hsp6vRpX5XyByNHZqsFm3rfYoztwBAH+tFMrvP
         rc+Jm2u9trr5rvJCE3VlHI6d5tBn1O6XE/xYaVvJ+2UuWPZiqWdbSQYNgLXnlkt1dkfi
         ilJA==
X-Gm-Message-State: ACrzQf1dDhDfZKmjyqRmDlOsTTRv+i35dfGOTm7PkyNv61nqgbfcYc91
        itySLDA3kh41CdC7R3YcU7lbxlByyMtBKg==
X-Google-Smtp-Source: AMsMyM7Qg1T2YuG2VI1ZBqfMv1zGUKBec7fiuum2lEYe3U9DAQ4bP1pzJMt6Hj/iVABodlr8BXssZw==
X-Received: by 2002:a05:600c:4f93:b0:3b4:c026:85a1 with SMTP id n19-20020a05600c4f9300b003b4c02685a1mr14098551wmq.39.1664537300236;
        Fri, 30 Sep 2022 04:28:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm1760799wrc.62.2022.09.30.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:28:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/15] run-command test helper: use "else if" pattern
Date:   Fri, 30 Sep 2022 13:28:01 +0200
Message-Id: <patch-04.15-6d15fbe6c26-20220930T111343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the cmd__run_command() to use an "if/else if" chain rather than
mutually exclusive "if" statements. This non-functional change makes a
subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-run-command.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index c9283b47afa..390fa4fb724 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -427,18 +427,17 @@ int cmd__run_command(int argc, const char **argv)
 	strvec_clear(&proc.args);
 	strvec_pushv(&proc.args, (const char **)argv + 3);
 
-	if (!strcmp(argv[1], "run-command-parallel"))
+	if (!strcmp(argv[1], "run-command-parallel")) {
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, NULL, &proc));
-
-	if (!strcmp(argv[1], "run-command-abort"))
+	} else if (!strcmp(argv[1], "run-command-abort")) {
 		exit(run_processes_parallel(jobs, parallel_next,
 					    NULL, task_finished, &proc));
-
-	if (!strcmp(argv[1], "run-command-no-jobs"))
+	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
 		exit(run_processes_parallel(jobs, no_job,
 					    NULL, task_finished, &proc));
-
-	fprintf(stderr, "check usage\n");
-	return 1;
+	} else {
+		fprintf(stderr, "check usage\n");
+		return 1;
+	}
 }
-- 
2.38.0.rc2.935.g6b421ae1592

