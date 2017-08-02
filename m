Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2F420899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdHBTlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33526 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdHBTlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id y43so97435wrd.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge/9wxMDLHx8FBtufRI/9WMI9xemT+n4tNSRd2YrE3E=;
        b=EhWsrGYy+apX7ajIR4ZvCcHssgO7RpuE1or5PoZ8VqFVSE9q19MsbOFjqEylPClDkO
         hl3DRuxDDS4ex62V5Pnpids3rMyZqKVuRnwzGfk0Wqln4vlxKc+Nto8PL4lPEXepRzDS
         TCg5MBik3bymjfuFnk8W4h3JXzpkNEgtWSr0Mi0gUQVtwUYE+Z88LV7UFehJGzj3QeZN
         0EO3YUWQnRjWTj9xXpD4OSFBTKxGd80toeXV/d34oHjooHMkrTpJuJLvf16feqhb2MY0
         WyFTyxL/VBR8ZFRiNkJR9b8qF8DiVnSTgwTUMxn/KVCXEJeA2sDW8cQeM+m2XJFChWHf
         1b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge/9wxMDLHx8FBtufRI/9WMI9xemT+n4tNSRd2YrE3E=;
        b=iuHvlfeSrLHj2Pd1YeaeJAdsRj0jjUbwR3vetL7hfxlnr1mZZDxPT2lJZkd1A1jP0S
         lX5roOPPVSYjTyj8NtgEfiYcElRNuAohLqSZnBr0FW7g/rq814HgXU1NiLCKvpR6AY9G
         DhP06vEV+qsJRYg6/tq1ZspfwOhDNn6t30nyz7T/9ZAkktOxA1S4VpC9wifBogZRpF7Y
         NdCf4qbIj0UmMw793czoJ2U93bKBqs4Cs1kGnb/lp1DYOnns5DqWdNWVAbybZWeY/7KJ
         qmew1qvWRtZaVA4I8ZLpcGofWSSC/TrxMtbiFbbQk98n7fOp1TjUqcW/QhAknWvPgjZ9
         K1Zg==
X-Gm-Message-State: AIVw112XXjlqkDyAS8jlU7ky6/7aGokYls8osp8cR4X8RlvcS6lGftxV
        ts7NeLqkI7yC3x8O
X-Received: by 10.223.166.173 with SMTP id t42mr18728212wrc.272.1501702874102;
        Wed, 02 Aug 2017 12:41:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/7] git.c: let builtins opt for handling `pager.foo` themselves
Date:   Wed,  2 Aug 2017 21:40:50 +0200
Message-Id: <721f7b86825ade920b68bd5659cdde19111014ce.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
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
and a garbled terminal. Someone who makes use of both `git tag -a` and
`git tag -l` will probably not set `pager.tag`, so that `git tag -a`
will actually work, at the cost of not paging output of `git tag -l`.

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
index 8d87d06da..0f3a7b770 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,14 @@
  *
  *	The built-in supports `--super-prefix`.
  *
+ * `DELAY_PAGER_CONFIG`:
+ *
+ *	If RUN_SETUP or RUN_SETUP_GENTLY is set, git.c normally handles
+ *	the `pager.<cmd>`-configuration. If this flag is used, git.c
+ *	will skip that step, instead allowing the built-in to make a
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
2.14.0.rc1.12.ge2d9c4613

