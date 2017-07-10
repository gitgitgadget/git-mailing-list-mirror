Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62FB20357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbdGJV4Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:56:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32798 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbdGJV4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:56:24 -0400
Received: by mail-lf0-f67.google.com with SMTP id t72so12344045lff.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0Z2h3alzFtnVpT/IJHven7uAWndv7VzxVwrNPDNeNw=;
        b=ls07XmNhoBxnrccB6JU2+BpsBCK/oa8bRMC2VVy+AdcQSBWYPCGy9TBfBeRgH8LmIz
         s86zTEJwHZpr3sWoiV+sZ5dZGdxY/CS+Ac5AUqL6yxvWBbvOQnNTXbkgrLl6+AjWgo+w
         SeTSendBK05+GwXXXPPtkN8BXkgVBUkLNVvpIBZC19/vkjtLZ102WSkNd/rJ13ZCD3vZ
         RJuo0T8u1ha1FEp/fyywhRDt3xHaAGdwUzTP+AGDXzrY09YfdVHLLnenxNpFp2BXEiWJ
         N8g2V83Nk16yFjoO+xY1b9iUPMNDTwD/YbJ3wNbIClCwQ+rpb1RLh/H/H+IwdMTsXxzN
         3moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0Z2h3alzFtnVpT/IJHven7uAWndv7VzxVwrNPDNeNw=;
        b=mRpvRXuBLwgBSjSy8D8ugeFUgvPsHPXNpr4wOCCgaI8qSti0UtLySwptrs9bJ0/b46
         9ONe/WhkXiThd5JllH2GYnb4gw+rGrjKzjuyTsK+Tqx3C4KD2Aa483OZUUuJaADcoBp8
         UoZHwxXz1k6dushtQpDjWzGHSFJUkN4Z9JyDm9hZIP5Qql9BhvRF7W1GRVQX54qFxiAY
         L5FpK+v70o0QgT0I2s5Ch9E5sQfRWXQH4RdMj8q0tcUtZesK9yMdSptu78KYgd5Cvpaz
         iQix/4ZlpXQwJu3YXxIBWWv/OnnwfIQnCeJjxiF2Xtuab0+VuE11HXINWShClD545x47
         gRLw==
X-Gm-Message-State: AIVw1102mN7IaxAppnFUPf5ss54LaVTFPB+C4IeuEmzWo3ZDYdhWoZdf
        kh/hdy1cFlXK7uOEyvU=
X-Received: by 10.25.217.92 with SMTP id q89mr1690496lfg.70.1499723781942;
        Mon, 10 Jul 2017 14:56:21 -0700 (PDT)
Received: from localhost.localdomain (78-66-223-92-no2204.tbcn.telia.com. [78.66.223.92])
        by smtp.gmail.com with ESMTPSA id x13sm2617077ljd.64.2017.07.10.14.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:56:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/7] git.c: let builtins opt for handling `pager.foo` themselves
Date:   Mon, 10 Jul 2017 23:55:15 +0200
Message-Id: <62a5a588d880d1a41d6cdd54cd92ee577a0451fa.1499723297.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.13.2.653.gfb5159d
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
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
to respect `pager.foo`, introduce a flag IGNORE_PAGER_CONFIG. If the flag
is set, do not check `pager.foo`. This applies to two code-paths -- one
in run_builtin() and one in execv_dashed_external().

Document the flag in api-builtin.txt.

Don't add any users of IGNORE_PAGER_CONFIG just yet, one will follow in a
later patch.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/api-builtin.txt |  6 ++++++
 git.c                                   | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 60f442822..61fd8eeb2 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -46,6 +46,12 @@ where options is the bitwise-or of:
 
 	The builtin supports --super-prefix.
 
+`IGNORE_PAGER_CONFIG`::
+
+	Ignore the `pager.<cmd>`-configuration in git.c, instead
+	giving the builtin the chance to handle it and possibly
+	more fine-grained configurations (`pager.<cmd>.<subcmd>`).
+
 . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
 
 Additionally, if `foo` is a new command, there are 3 more things to do:
diff --git a/git.c b/git.c
index 489aab4d8..ae92f8ed5 100644
--- a/git.c
+++ b/git.c
@@ -283,6 +283,12 @@ static int handle_alias(int *argcp, const char ***argv)
  */
 #define NEED_WORK_TREE		(1<<3)
 #define SUPPORT_SUPER_PREFIX	(1<<4)
+/*
+ * Ignore the `pager.<cmd>`-configuration, instead giving the builtin
+ * the chance to handle it and possibly more fine-grained
+ * configurations (`pager.<cmd>.<subcmd>`).
+ */
+#define IGNORE_PAGER_CONFIG	(1<<5)
 
 struct cmd_struct {
 	const char *cmd;
@@ -306,7 +312,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
+		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
+		    !(p->option & IGNORE_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
@@ -543,11 +550,14 @@ static void execv_dashed_external(const char **argv)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int status;
+	struct cmd_struct *builtin;
 
 	if (get_super_prefix())
 		die("%s doesn't support --super-prefix", argv[0]);
 
-	if (use_pager == -1)
+	builtin = get_builtin(argv[0]);
+	if (use_pager == -1 &&
+	    !(builtin && builtin->option & IGNORE_PAGER_CONFIG))
 		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
-- 
2.13.2.653.gfb5159d

