Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3579208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeHHR6w (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33156 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeHHR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so1495281edr.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BlUrgJOdF2qW2jB/4L+vblM3SxrGm24aP6z2MImjrqs=;
        b=B+TqIc1bOH+ijijmshBZQaSAcEe+zHrAaaWwrl+EpQhKXrb9pdRvLYdy1migtVu/yb
         +n4zof5m9d+NxHV2n8ctqLEDco9dPF8T5ImHMwYLudEZQ+niceQLEs01Bs5lkM0eNIOW
         LAYKgSWTdVUrDYPJoQxzsPLQZnGxkkFLe6HwiG+vvBu4Pxi9WV+rPsbcg5Y26ZLVjdEq
         3bgtxXbn5ani8GsZC8IY6491plaUk8retIu4lnqRBpAld6pVNEsKjOIgdHMs24sq1qfg
         gB096CZshHUetOnSBAXpCASvkQGtoyu8hRkctpbutNUTq1ZGHah7Afv6tY9xWzggMYAH
         j3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlUrgJOdF2qW2jB/4L+vblM3SxrGm24aP6z2MImjrqs=;
        b=MK4Ngn7yuZoZoXZDLxExeAUYv1CHi7nJ44RFhwbrwzJpLsk63uLrHLAXv+jpctpjgN
         ANbC2KnJQ7WCTAnLghwJxFxJ2J27rdwhEveRq6hhAhGjfCXSAV8ybRxpvWY0+j69n6jT
         9zCGTvHamIHF+KkrYyvhZIr41Po5ZpLFjDjXu17+/Y/D209/0LPyWNimzDRzOW1VDNNT
         LZroztMu2QEV3pDlzLdYLmhfN27pmFYt9Gdmyj7ZMbUvy0PTFgYcVvxJafvqTZc0UzlZ
         2ScV8BE4xZI1IaylHFuCDsHZf8yXNV1Wpp4xM9O8g4hYmMAFs6RCLrk722sxJ+/bgU4x
         DB5g==
X-Gm-Message-State: AOUpUlFaEgUCcEvNI88RPtDLnpAtpBdH02prHNE4MJ6o1axdb4cOyqs6
        3ThCLiSPw/HmvpetG1+kJl/IM7zV
X-Google-Smtp-Source: AA+uWPwjGYOCIc2qXvPdKqkg/QM8CvJzRmO/MFGJEoHn8oUE1mWkEwWy+fxFqoHRiCcph5dXguE4ZQ==
X-Received: by 2002:a50:aa3b:: with SMTP id o56-v6mr3798618edc.23.1533742718460;
        Wed, 08 Aug 2018 08:38:38 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:37 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 6/6] builtin rebase: error out on incompatible option/mode combinations
Date:   Wed,  8 Aug 2018 21:21:35 +0545
Message-Id: <20180808153635.19944-7-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on the GSoC project to convert the rebase command to a
builtin, the rebase command learned to error out on certain command-line
option combinations that cannot work, such as --whitespace=fix with
--interactive.

This commit converts that code.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fb8ab5a177..4e69458161 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1098,6 +1098,28 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (options.git_am_opt.len) {
+		const char *p;
+
+		/* all am options except -q are compatible only with --am */
+		strbuf_reset(&buf);
+		strbuf_addbuf(&buf, &options.git_am_opt);
+		strbuf_addch(&buf, ' ');
+		while ((p = strstr(buf.buf, " -q ")))
+			strbuf_splice(&buf, p - buf.buf, 4, " ", 1);
+		strbuf_trim(&buf);
+
+		if (is_interactive(&options) && buf.len)
+			die(_("error: cannot combine interactive options "
+			      "(--interactive, --exec, --rebase-merges, "
+			      "--preserve-merges, --keep-empty, --root + "
+			      "--onto) with am options (%s)"), buf.buf);
+		if (options.type == REBASE_MERGE && buf.len)
+			die(_("error: cannot combine merge options (--merge, "
+			      "--strategy, --strategy-option) with am options "
+			      "(%s)"), buf.buf);
+	}
+
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
@@ -1106,6 +1128,25 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	if (options.type == REBASE_PRESERVE_MERGES)
+		/*
+		 * Note: incompatibility with --signoff handled in signoff block above
+		 * Note: incompatibility with --interactive is just a strong warning;
+		 *       git-rebase.txt caveats with "unless you know what you are doing"
+		 */
+		if (options.rebase_merges)
+			die(_("error: cannot combine '--preserve_merges' with "
+			      "'--rebase-merges'"));
+
+	if (options.rebase_merges) {
+		if (strategy_options.nr)
+			die(_("error: cannot combine '--rebase_merges' with "
+			      "'--strategy-option'"));
+		if (options.strategy)
+			die(_("error: cannot combine '--rebase_merges' with "
+			      "'--strategy'"));
+	}
+
 	if (!options.root) {
 		if (argc < 1) {
 			struct branch *branch;
-- 
2.18.0

