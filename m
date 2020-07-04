Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE1C433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB25F20826
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch9ECsaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgGDWSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgGDWSr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 18:18:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB31C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 15:18:47 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t25so36432990lji.12
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+24Rt3E1VaXQxl4e9naKX5PE1eFWGHsxe7hYfaq4oMg=;
        b=ch9ECsaDrN8Rql6rFzEgwRdnxWk0NFg4EoPsetPz50NrRaMH6O+GbU4NW6zyNof1Pq
         LWDY/oJw2yXIC6pNs1Cz1nz38gKxnhjeuzCYy7fOhmDOHyuZWMvjpiwgLewEYldgzaBH
         vmgR9JV7jPGmSIDgfYDID8oJx+GkM6QJ+0G7KaIfGQJW7qpenbGqo3UkKYRmTneWUksV
         7L4HuoghUwFApqUW0puJK9LCQyWqQfddgvoHSH8S6zdL8djnNE5ydSCaZm9/8aQGSMkm
         3RUBqpulnx8fWqHBM4Iqs4bSr9iCK2wG4IcglYg1Y82MTxor0fUjN3r2G4XrrQ/jiIJF
         aDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+24Rt3E1VaXQxl4e9naKX5PE1eFWGHsxe7hYfaq4oMg=;
        b=cyMbtxQAszpOw/krsOM7zhXjnkdYcbcnmStGIAxaa0h1Lch9MeICnzpiGVB5NhJ223
         clvipsmntU579Qq9+77AmIJDHMIg+YIJEHrwHPhV9m9/xo3b/1df5hPNX18V7fm/cqWC
         0vrtBj27MS8BE0kSePKJyasz4ZxsrkfK2DVH1bncCEWME0QKuzMwrs6Im1HsFOH6EAsk
         7MrKFdgO0ilPToNotHNJnrXOz2HzsVOxH9cJu1UvY978TgNXvzqUlvZel35R4ZsZkcKN
         SjmWjcl8Nfx3hr0b8u+8xj9Jl7fI1vwueNqRgetXBL1VcnFGUPNR44U4jPzWGyuHxRJF
         OP0A==
X-Gm-Message-State: AOAM530qDvxifAgm/4W7VqXKeZLLOr/3P/jyluxLjFNoaABoCyu3KVcs
        uogz73srLW1EKDIRKKwuiyG/MFJLotA=
X-Google-Smtp-Source: ABdhPJzt0YpKjDcu0KaVdHhQmyn6cJpWMgw0+0oeZUZoLhnY9INFzfe9O3JIuXouybJH6UH7cAKO9Q==
X-Received: by 2002:a2e:7804:: with SMTP id t4mr23387977ljc.8.1593901123934;
        Sat, 04 Jul 2020 15:18:43 -0700 (PDT)
Received: from elaine.localdomain ([46.46.195.162])
        by smtp.gmail.com with ESMTPSA id n25sm5588776lji.28.2020.07.04.15.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 15:18:43 -0700 (PDT)
From:   trygveaa@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Trygve Aaberge <trygveaa@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Wait for child on signal death for aliases to builtins
Date:   Sun,  5 Jul 2020 00:18:37 +0200
Message-Id: <20200704221839.421997-1-trygveaa@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Trygve Aaberge <trygveaa@gmail.com>

When you hit ^C all the processes in the tree receives it. When a git
command uses a pager, git ignores this and waits until the pager quits.
However, when using an alias there is an additional process in the tree
which didn't ignore the signal. That caused it to exit which in turn
caused the pager to exit. This fixes that for aliases to builtins.

This was originally fixed in 46df6906f3 (see that for a more in
explanation), but broke by a regression in b914084007.

Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
---
 git.c         | 2 +-
 run-command.c | 1 +
 run-command.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index a2d337eed7..c8336773e3 100644
--- a/git.c
+++ b/git.c
@@ -767,7 +767,7 @@ static int run_argv(int *argcp, const char ***argv)
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
 			i = run_command_v_opt_tr2(args.argv, RUN_SILENT_EXEC_FAILURE |
-						  RUN_CLEAN_ON_EXIT, "git_alias");
+						  RUN_CLEAN_ON_EXIT | RUN_WAIT_AFTER_CLEAN, "git_alias");
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
 			die("could not execute builtin %s", **argv);
diff --git a/run-command.c b/run-command.c
index 9b3a57d1e3..a735e380a9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1039,6 +1039,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 	cmd.silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
+	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
 	cmd.trace2_child_class = tr2_class;
diff --git a/run-command.h b/run-command.h
index 191dfcdafe..ef3071a565 100644
--- a/run-command.h
+++ b/run-command.h
@@ -229,6 +229,7 @@ int run_auto_gc(int quiet);
 #define RUN_SILENT_EXEC_FAILURE 8
 #define RUN_USING_SHELL 16
 #define RUN_CLEAN_ON_EXIT 32
+#define RUN_WAIT_AFTER_CLEAN 64
 
 /**
  * Convenience functions that encapsulate a sequence of
-- 
2.27.0

