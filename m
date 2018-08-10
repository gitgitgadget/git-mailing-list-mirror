Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FBE1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeHJTXJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35868 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeHJTXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so8889135wro.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BxSttT4NBaK2k3wxumAYt25+BF5yLA+gzNs2uDGhKSA=;
        b=pk/xrzyib0JmFrqan216K5FVMj7OT5/07NTzovgxZDh/AAwXozfPH+eB+qj/s6Zx6q
         ZhGZu6m9k3GKStyYabUwGdcPAITjymsWGH+XCGqrTK4oYmye0iXC42eHCmBF7OC3/fIg
         usvnXjLxl5Eq3V4tB55mS4fYPlInWDuebcR2s8vjdXvU5vEr5KzrhUsJYyetNiDpTqm6
         zu1zeJFUhBHI5Qptj1hmHlSL0W6y3+oyIt2vnhoGWcOVIFuP/7s8/9SYrw+wWq4yNfC0
         +CVdRgbfE0Vjq9Qj6yjvNLKHGYwQWE5w5z4DNO32qk/uZQya4QERKuUgVnc695wn2qNX
         tT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BxSttT4NBaK2k3wxumAYt25+BF5yLA+gzNs2uDGhKSA=;
        b=cZ8qLvWHPeZP3cNxRSAGmbZICr6CIsTbmV6F/rWPNUhAMUAe2lyDsvo1uNGAVyQDYe
         tmfIIvgYlgF4mXgohWkPmzhxiWtfw7qUVUHstD95DDkman2b+EeZxgFxYcEV+zLDJgMd
         z7Dt1jMHsvBnix/N6VfuZyEKjFcUKyCEkKdSyU4pD0ybbHhKp3+LaeTxvTmmCopzy3pL
         m7j87DFSFWUOE12/bYdzTbY3mN3ZTNF9RLEWZRcVld0/01c+pDJqCXxNyVRZJ2xYL+nf
         98zSc0vx4azfkakV6CZ3ZDc5CRKhavyccJUp2DQauttqrxmaZ5Uz/VStdTvDC4OggSgc
         Dlzw==
X-Gm-Message-State: AOUpUlF9mikLuxBuvBM3woke+C0AuBNvbHjERML4Rwecr5fANQTuZMLb
        zB28dgYbiQXmw/2A5ery/1Gywrnn
X-Google-Smtp-Source: AA+uWPxiMFeodowf1AdY4CqHUc4F6UGaEmrUMUKz0Nre7Lp5KBrGGQgOGhRdp4Z7X7WOSVqqt/JxUQ==
X-Received: by 2002:a5d:69ca:: with SMTP id s10-v6mr4631618wrw.77.1533919948863;
        Fri, 10 Aug 2018 09:52:28 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:27 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 09/20] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Fri, 10 Aug 2018 18:51:36 +0200
Message-Id: <20180810165147.4779-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of skip_unnecessary_picks() printing its result to stdout, it
returns it into a struct object_id, as the rewrite of complete_action()
(to come in the next commit) will need it.

rebase--helper then is modified to fit this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--helper.c | 10 ++++++++--
 sequencer.c              | 13 ++++++-------
 sequencer.h              |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 313092c465..bed3dd2b95 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -90,8 +90,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
+		struct object_id oid;
+		int ret = skip_unnecessary_picks(&oid);
+
+		if (!ret)
+			puts(oid_to_hex(&oid));
+		return !!ret;
+	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
diff --git a/sequencer.c b/sequencer.c
index 48447d7f0e..a56a781539 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4420,17 +4420,17 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
-	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
+	struct object_id *parent_oid;
 	int fd, i;
 
 	if (!read_oneliner(&buf, rebase_path_onto(), 0))
 		return error(_("could not read 'onto'"));
-	if (get_oid(buf.buf, &onto_oid)) {
+	if (get_oid(buf.buf, output_oid)) {
 		strbuf_release(&buf);
 		return error(_("need a HEAD to fixup"));
 	}
@@ -4460,9 +4460,9 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (hashcmp(parent_oid->hash, oid->hash))
+		if (hashcmp(parent_oid->hash, output_oid->hash))
 			break;
-		oid = &item->commit->object.oid;
+		oidcpy(output_oid, &item->commit->object.oid);
 	}
 	if (i > 0) {
 		int offset = get_item_line_offset(&todo_list, i);
@@ -4491,11 +4491,10 @@ int skip_unnecessary_picks(void)
 
 		todo_list.current = i;
 		if (is_fixup(peek_command(&todo_list, 0)))
-			record_in_rewritten(oid, peek_command(&todo_list, 0));
+			record_in_rewritten(output_oid, peek_command(&todo_list, 0));
 	}
 
 	todo_list_release(&todo_list);
-	printf("%s\n", oid_to_hex(oid));
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index d2b54adf45..fcbcd246c2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -91,7 +91,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(struct object_id *output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

