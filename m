Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FBB1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfKGC4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38058 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfKGC4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so425477plq.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOS+P/Y7B/XEm2uShhsNdFFG9Ck5AVuGA5610TQGU08=;
        b=e1jxpBtNjSGqzMl0h3yYrwUXB3G+gPDWdhgYWkoduuf5DiD1ms/Gyiga8zB1MttH5I
         3mcF/8kZMkS6f/QY6rny0L6jcHnNHBbb8eeFrPV1cFnQ3QsWsEpMUDc1UWi6V3GucqOx
         DsD+7MhQmc9G3Bh1qPKE/RymJKC39uqQcYyZS9TP48AUqiUvqyIKbHVM884FNS+DhTIW
         1jzkNQFhJb/WRvzeV70TBgXF38t3P7P9lf5lt3sQJ2LBRIcdO8Z22CpHNUCuE0T+tbmg
         u9uCgQxRTLmkYkufzH2EzRgDGsh6SzrRbnmN/Wopy1cHDsjPue/wX+ZpZYn/dUnjQSFY
         GpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOS+P/Y7B/XEm2uShhsNdFFG9Ck5AVuGA5610TQGU08=;
        b=KsW631JQ4xojXMC4zzFsKs3X5vH1uWeQss8G0NeoR1jLVliBhNOv4nPNWQaMlmJOC2
         hvwJDdKVxZZVyKnEt2jDH2E86o0Qd9kizwcbfwKBgjGj00+8LEx4wmiTqDAEcv6Do/ji
         HHVCNEFk/6uw1ZroZ3usslVruxwLz3K/dGfZqYVpoIT22VchrgWTGSoDvYrlWms+Ykys
         4RZdmCN/KR6PZLFqXALlFsnIcuY4AkPPWQcKxX1KLefaibfXf1T4iQQWfTDBuDQitdCQ
         Vv6dQinlgzn6KgnjarVhhwOZ9S2mMQv/jf1ctEAlJgJFkpq+dWp8AnV4a6fd2va2vHra
         gpHw==
X-Gm-Message-State: APjAAAV85qBqj1Tu7EcxZW+7vA9PRnznasTdnToC/PdQ5WIPc5FmGDQH
        BL6isxZ/6U/7NpbZOpo2LUSVkkve
X-Google-Smtp-Source: APXvYqxvt4JHc/N11WzWcbCj/ssUYXC4NerQEAqIY8NO1zMuNnDVOD4vEzMGYzdU5538Txx/K6UyWw==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr1152095plt.67.1573095397120;
        Wed, 06 Nov 2019 18:56:37 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:36 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 5/8] sequencer: reencode revert/cherry-pick's todo list
Date:   Thu,  7 Nov 2019 09:56:16 +0700
Message-Id: <304ac6c28972a7bec9c5c7b5e2ae3c107161e84f.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep revert/cherry-pick's todo list in line with rebase todo list.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 69430fe23f..a19954f2bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2564,14 +2564,17 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
 	const char *command_string = todo_command_info[command].str;
+	const char *encoding;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
 		return -1;
 
+	encoding = get_log_output_encoding();
+
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
 		const char *subject;
 		int subject_len;
 
-- 
2.24.0.8.g36796e2b67

