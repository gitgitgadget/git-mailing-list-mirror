Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E11620357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdGQULl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36178 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdGQULj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id c199so4542lfg.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WTN2O3LK73715VV0UjJ9jShCXScFAEQBqI7x7JKQZI=;
        b=R13U9LT7TRehkV8jdfX2ApcDTmzpf2ppFTgCCMiOghJwzFWROIUN9bAQelOQtjjWFL
         xpLo33KyzmYnPbkuOQ6m6MfnOgVHmxvPXBawInJ7PGJley4bqgEhE7EpKGEvsh588uVq
         sS05N5kSp7LyW7NrQe4ugW0rv7K+IihakPliJnIJBQqL1x9h7TYkDf2D6hkftd7KwzcT
         KwaH2U9gEQSNd+PP//rYyxkOAxVm9eUTwDYmEsw1i9a1GrY0zqEwSt+d35qHTCDwjU7/
         lh2Cx2e3DHOyKGl/+X6LVlsFt8t1RjzwMV7uSMe+riGJLCzLbwiiroVdbLPcxC+jHSbO
         qZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WTN2O3LK73715VV0UjJ9jShCXScFAEQBqI7x7JKQZI=;
        b=hnbauQUBB/zz6eaHiQq37HYkomyOn4beg3JiuSOcsrEyM4GIuEddyxv7gpqhUj7DYL
         U25UYMG5Y6ku0JQ8umneDBPnOEqgCewSRBPCC+yxXmxEIN1U56mdu+jyol14mZCw7sTV
         SEtFn52QIZKtHm9pLtEWvAGVDCkdcakkUSC8m+GSku6U6dOjOjKVck1O5PNPYlseWbJY
         gPWdNqEhxqr+EwyJWz/zDTIs9T6aPiz3Qos917zKd+Y4pnTrtcGCE3mue/6UeUwufDuA
         Yia5tpNtPnV1SeztzViEGaAzherKHL5xoM3YXK5x8D4SZeba62WTpD/07eF//HzQwsmV
         BttQ==
X-Gm-Message-State: AIVw112vHSsXacDC+oQdpezHiIOfhDirMK1TPFQ8KSS2IvgsOHKfm95/
        GS+A8AWQtBdpVHaR
X-Received: by 10.46.20.87 with SMTP id 23mr5518855lju.11.1500322298121;
        Mon, 17 Jul 2017 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:37 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 05/10] git.c: provide setup_auto_pager()
Date:   Mon, 17 Jul 2017 22:10:47 +0200
Message-Id: <b6ab825d3bda4b40201b0aa8e97c9fd721ed8171.1500321658.git.martin.agren@gmail.com>
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

The previous patch introduced a way for builtins to declare that they
will take responsibility for handling the `pager.foo`-config item. (See
the commit message of that patch for why that could be useful.)

Provide setup_auto_pager(), which builtins can call in order to handle
`pager.<cmd>`, including possibly starting the pager. Make this function
don't do anything if a pager has already been started, as indicated by
use_pager or pager_in_use().

Whenever this function is called from a builtin, git.c will already have
called commit_pager_choice(). Since commit_pager_choice() treats the
special value -1 as "punt" or "not yet decided", it is not a problem
that we might end up calling commit_pager_choice() once in git.c and
once (or more) in the builtin. Make the new function use -1 in the same
way and document it as "punt".

Don't add any users of setup_auto_pager just yet, one will follow in
a later patch.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h |  9 +++++++++
 git.c     | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin.h b/builtin.h
index 4186635de..3ca4a53a8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -113,6 +113,15 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
+/**
+ * If a builtin has DELAY_PAGER_CONFIG set, the builtin should call this early
+ * when it wishes to respect the `pager.foo`-config. The `cmd` is the name of
+ * the builtin, e.g., "foo". If a paging-choice has already been setup, this
+ * does nothing. The default in `def` should be 0 for "pager off", 1 for "pager
+ * on" or -1 for "punt".
+ */
+extern void setup_auto_pager(const char *cmd, int def);
+
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 79195ebbd..66832f232 100644
--- a/git.c
+++ b/git.c
@@ -33,6 +33,16 @@ static void commit_pager_choice(void) {
 	}
 }
 
+void setup_auto_pager(const char *cmd, int def)
+{
+	if (use_pager != -1 || pager_in_use())
+		return;
+	use_pager = check_pager_config(cmd);
+	if (use_pager == -1)
+		use_pager = def;
+	commit_pager_choice();
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
-- 
2.14.0.rc0

