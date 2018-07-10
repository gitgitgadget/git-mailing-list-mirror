Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F36B1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGJMR3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39211 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933176AbeGJMR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so14365413wre.6
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbeXweNbmUD8oV36kzAaCu1MYtlCA7EbpWYhMXPtHuU=;
        b=BeomWhBLpMtQuTtw0m0esKTWH/SwmLy68HVuSNwJvBigMoVgeNFiMbc6rnIz7Bbhst
         d0iD2OQw7vIe2wJUQ5fQOspK926FwgK8YfuWvfIRitpGopqIj3dyUqvD9h8WV9F1x1uN
         NEOrWo2/vaRQ5h2eu0uswfgzMjjztM5Ske7PhlHWu2lA9S8igyJgl7j2wW/ZndzaXvaU
         zWkUgERVujzZPssapJBwW3ZpOcxG1bS4XWcYeuwFK3dM8YUvljGX+59StVzU5mTgxMmK
         pgBbc8fyTo+HjdqhA+P4yIqsRAFZ8BArOk5X2BVmEgmjuDO5wMAcSVR4XVaTHA+2QzyA
         39gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DbeXweNbmUD8oV36kzAaCu1MYtlCA7EbpWYhMXPtHuU=;
        b=tg4gKnqZQ2P04gUtlnyFwcnTpbzdEmGrlvL4LrAsiaCirEnlT06myvs4ba/L3Fmsu7
         1+W+hAT9zrsNAgxnF0dgxjp20fPVrsJp9IVjP28Hksmt4udmxpOJYMnINyA/cBzg4FfA
         5nSne8wq4sLhPpfqUsHGZS7ovMU0TSs+bKZ7pTky+aabeOWjjisqGhhupoPmCwO/6nET
         6JJp86ukdFmhdA8IPqtI0FDbK5+2hF/0z7T3DUdf3+gCIj1UCqXWBeokrnPDVY1eWfyv
         JEqvDWaIWxcOzGVnx47/gfnU1uIv7MubjMWhk3uK80x1B/XJDCS8F2+h4YhBbUP0ilV0
         pNmQ==
X-Gm-Message-State: AOUpUlEvBNRVEs8bYbfNCKJfD+JfUmUwDhE6585Njcemwhh3uqnagTqf
        Yi7bG9qewOeDdIu40xCorp+WKEQn
X-Google-Smtp-Source: AAOMgpfi8mt7sS3va6LSwLloCvE8pavdullf56vYTPm6I1xNRyTrd7fbb94oOhmUNQeqp3/RrqHM/w==
X-Received: by 2002:adf:ed41:: with SMTP id u1-v6mr5878115wro.262.1531225045897;
        Tue, 10 Jul 2018 05:17:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 09/13] sequencer: change the way skip_unnecessary_picks() returns its result
Date:   Tue, 10 Jul 2018 14:15:53 +0200
Message-Id: <20180710121557.6698-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of skip_unnecessary_picks() printing its result to stdout, it
returns it into a const char *, as the rewrite of complete_action()
(to come in the next commit) will need it.

rebase--helper then is modified to fit this change.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c | 11 ++++++++---
 sequencer.c              |  4 ++--
 sequencer.h              |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index b9af96af7..d4cfe43e7 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -14,7 +14,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1;
+	int abbreviate_commands = 0, rebase_cousins = -1, ret;
+	const char *oid = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
@@ -91,8 +92,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
-	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
-		return !!skip_unnecessary_picks();
+	if (command == SKIP_UNNECESSARY_PICKS && argc == 1) {
+		ret = !!skip_unnecessary_picks(&oid);
+		if (!ret && oid)
+			puts(oid);
+		return ret;
+	}
 	if (command == REARRANGE_SQUASH && argc == 1)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
diff --git a/sequencer.c b/sequencer.c
index 2b6ddc6cf..676ac1320 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4392,7 +4392,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-int skip_unnecessary_picks(void)
+int skip_unnecessary_picks(const char **output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
@@ -4467,7 +4467,7 @@ int skip_unnecessary_picks(void)
 	}
 
 	todo_list_release(&todo_list);
-	printf("%s\n", oid_to_hex(oid));
+	*output_oid = oid_to_hex(oid);
 
 	return 0;
 }
diff --git a/sequencer.h b/sequencer.h
index 11a533461..25b50efe2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -88,7 +88,7 @@ int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
-int skip_unnecessary_picks(void);
+int skip_unnecessary_picks(const char **output_oid);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
-- 
2.18.0

