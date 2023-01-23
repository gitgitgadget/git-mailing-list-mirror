Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E8C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjAWRPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjAWRP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9462B60A
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so15397139edd.10
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJffQ+wSx+zWVtvsPERwZgxa/0xg5ebkNBKJ8Ka/154=;
        b=UMCZ6+muaXeG4XnfVSXb04YwIIHZuR0s2hGGxYniJaKZJuuNfn2yaEXnLeFkdrEnQ2
         gNkmJcwr2XTIAuVT4PE8xSdLJOafDF+TkrPTnKlTAlZ5MiXW2a4iv8VLKcmf8ltYEiE2
         AOEG6b/DqUqb+cC987VwVd+hOqnARqbtgv4N5dTNZwm/vGOFsGhr2Eg1IUIFT5AFN/KG
         0WhoGRQRYjuJLjpOWOhApSplQ2NWs6bmfd1Sxle6t0BTYf7XKwmRThWHeYTAOOqDWdPG
         d0Wz4msIPHGLtc0+CpP51LuhMosK/EUGjqegGS7FcJ6mvi6z0E2cJtAMy7DLHdVehuEq
         2vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJffQ+wSx+zWVtvsPERwZgxa/0xg5ebkNBKJ8Ka/154=;
        b=cRm90K/YdtsGcrG965JllrpIpKWTPS+7T/Mvj1uoEB6ftWF7cgf5R7dRUqb+uYGNw2
         G6dQQNx937Sr3LJQwvgMkGIBemiqh2O3tWh/jMM/XNBNx1QltY4x6XRbGNo7K+/HxYSY
         cUtQo5e+cWggWV0CT80aRjvvLoT++UBBVy/vkv/4Ia0LPWisJGk7+n0sa5eDptiLu3cX
         40vz6kys2D+tTcHOvgHBB9i5V3f5IMLOfF2KpgYYF4Hq2AQEfsNoDbybJ24DwG7hoRh/
         ev81CeVaGimHsrsH41EXIEutPkZmvGCP2+5qRDEoGIG1N1T4VlOqWS4GY8MHEMLfYlr+
         dskA==
X-Gm-Message-State: AFqh2kqAKnhvn7IMYzu2zvoaUJXXk3dXKoPJtifatsL0hAMkPUOi2mz5
        BTdInO0RswxzhnOMmU4+qj3qYwvcnfzM5g==
X-Google-Smtp-Source: AMrXdXvD9qtnEYnTRYWjsrFjaXUADFVF0x68WQ+0hpVyGk7yhaY5R35Ie0IKG707ahjZsaMlG5K+Tg==
X-Received: by 2002:a50:cc4c:0:b0:49e:1c17:904 with SMTP id n12-20020a50cc4c000000b0049e1c170904mr23223877edi.15.1674494116133;
        Mon, 23 Jan 2023 09:15:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] sequencer: use the new hook API for the simpler "post-rewrite" call
Date:   Mon, 23 Jan 2023 18:15:08 +0100
Message-Id: <patch-4.5-7a55c95f60f-20230123T170551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Change the invocation of the "post-rewrite" hook added in
795160457db (sequencer (rebase -i): run the post-rewrite hook, if
needed, 2017-01-02) to use the new hook API.

This leaves the more complex "post-rewrite" invocation added in
a87a6f3c98e (commit: move post-rewrite code to libgit, 2017-11-17)
here in sequencer.c unconverted. That'll be done in a subsequent
commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..d8d59d05dd4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4834,8 +4834,7 @@ static int pick_commits(struct repository *r,
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
-			const char *post_rewrite_hook =
-				find_hook("post-rewrite");
+			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -4845,18 +4844,9 @@ static int pick_commits(struct repository *r,
 			/* we don't care if this copying failed */
 			run_command(&child);
 
-			if (post_rewrite_hook) {
-				struct child_process hook = CHILD_PROCESS_INIT;
-
-				hook.in = open(rebase_path_rewritten_list(),
-					O_RDONLY);
-				hook.stdout_to_stderr = 1;
-				hook.trace2_hook_name = "post-rewrite";
-				strvec_push(&hook.args, post_rewrite_hook);
-				strvec_push(&hook.args, "rebase");
-				/* we don't care if this hook failed */
-				run_command(&hook);
-			}
+			hook_opt.path_to_stdin = rebase_path_rewritten_list();
+			strvec_push(&hook_opt.args, "rebase");
+			run_hooks_opt("post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
-- 
2.39.1.1301.gffb37c08dee

