Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12D420357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdGQULj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36174 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQULh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id c199so4515lfg.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCzFDYKrW+ewsgvh9/1LJ32/qPTU1/VLEqtGl8+nZe4=;
        b=AnZzWPZIDwYTMZOVTSyVP3xCzM9aCvVExXpBYH5wWTI4TBPNGPFoR2w+PgXtw2d24n
         pJKhh6iivX0P3yuFugrJkaWjQHe3dwyhMMTtRZmRrIPO7j37kODICI8t/auEaIfqwwiU
         73BGSLL+VtDB+cwNeGokdFhh2pY6w4rl1ourCfa1M1a+4+t9+QPusicVCG5bLY/8nVYF
         IZ+F8HELPfLUPTFtr/MFSp6Yasa3WKHlloJpmJbOCJVOtIp2ZwjrJ9pmPSPnZZgBw3jI
         SDhWhvVytSKGQBGst2qlXodTQRItP+2BUA+XuqRDZaPNzxexrso2NuZa3rZd6pccMmAL
         ON6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCzFDYKrW+ewsgvh9/1LJ32/qPTU1/VLEqtGl8+nZe4=;
        b=fMAMj9HC6RkwgS2naCIK2JlzIH31ATs6Pd2g3ggxYNHLDxhCIw9lWupM/LJJOiU/Ry
         +cvOThRC645vvmtLoKduUsAtxPpi+XJshkag0I+M/Aqu7ADEq9M31AsosbynYllGxj6j
         aybHLbDilqMf/I3wgU6XKoi8twycWffit6Uwh2sXNw6zePmTCX7Yyi4FgYFvJIf+T1Fh
         WD3Ck9yeTM2dt7rVe4s0ihjk63ogSqDjwNqCSFoNFOnVKEwsz1Ha6i5KF+lpjTxjkTTV
         uV0F8FxWIVK3qjVsTot5KI/K7900gh8rDT6BHe9bB7kUGuqJ8v3bmlBaA4qkRc+Natah
         7ujA==
X-Gm-Message-State: AIVw111BOVjk0CIGuvp0vi2IDtWuJOooDakrGbh3UIqJmuF6GnbdVlPT
        NPkwF9aYe2zicexL
X-Received: by 10.46.69.85 with SMTP id s82mr2223472lja.69.1500322295768;
        Mon, 17 Jul 2017 13:11:35 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 04/10] git.c: let builtins opt for handling `pager.foo` themselves
Date:   Mon, 17 Jul 2017 22:10:46 +0200
Message-Id: <be05f05ba0066cae1f222c90464798fa5013a585.1500321657.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before launching a builtin git foo and unless mechanisms with precedence
are in use, we check for and handle the `pager.foo` config. This is done
without considering exactly how git foo is being used, and indeed, git.c
cannot (and should not) know what the arguments to git foo are supposed
to achieve.

In practice this means that, e.g., `git -c pager.tag tag -a new-tag`
results in errors such as "Vim: Warning: Output is not to a terminal"
and a garbled terminal. A user who makes use of `git tag -a` and `git
tag -l` will probably choose not to configure `pager.tag` or to set it
to "no", so that `git tag -a` will actually work, at the cost of not
getting the pager with `git tag -l`.

To allow individual builtins to make more informed decisions about when
to respect `pager.foo`, introduce a flag DELAY_PAGER_CONFIG. If the flag
is set, do not check `pager.foo`.

Do not check for DELAY_PAGER_CONFIG in `execv_dashed_external()`. That
call site is arguably wrong, although in a way that is not yet visible,
and will be changed in a slightly different direction in a later patch.

Don't add any users of DELAY_PAGER_CONFIG just yet, one will follow in a
later patch.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h | 8 ++++++++
 git.c     | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 7bcc08456..4186635de 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,14 @@
  *
  *	The builtin supports `--super-prefix`.
  *
+ * `DELAY_PAGER_CONFIG`::
+ *
+ *	If RUN_SETUP or RUN_SETUP_GENTLY is set, git.c normally handles
+ *	the `pager.<cmd>`-configuration. If this flag is used, git.c
+ *	will skip that step, instead allowing the builtin to make a
+ *	more informed decision, e.g., by ignoring `pager.<cmd>` for
+ *	certain subcommands.
+ *
  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
  *
  * Additionally, if `foo` is a new command, there are 4 more things to do:
diff --git a/git.c b/git.c
index 489aab4d8..79195ebbd 100644
--- a/git.c
+++ b/git.c
@@ -283,6 +283,7 @@ static int handle_alias(int *argcp, const char ***argv)
  */
 #define NEED_WORK_TREE		(1<<3)
 #define SUPPORT_SUPER_PREFIX	(1<<4)
+#define DELAY_PAGER_CONFIG	(1<<5)
 
 struct cmd_struct {
 	const char *cmd;
@@ -306,7 +307,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
+		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
+		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
-- 
2.14.0.rc0

