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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1B11F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfKHJoJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so3629573pgu.4
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8F0cPDRY1pwzQHZq+1t2iHqI8+yhrhOMfl9ZH3X7uNE=;
        b=jXKyJCZrnopM1BLtfqRfTo4uOfShpSzGUtfbM8k5EXgLjl3fGskMTg4idh7AxokYrX
         F1vMl97yFt4weKFrQmB8hl1hOr1Tu5xToWKa4ytkWF4cD3ZL/4iY7tueg0qazxGrUHUb
         24cpNKqMB5+nCriJiz50auzMafUMoxKJaiwAuALUSSYsMORDAfAM7Syf146VamJ1zAmE
         VAY9pdu69sVnrOtslolxDxwMIWwjAKtioZStbfDad11guSAQFlOTFWt9YspZeIHbI9VN
         A7kYZsDzBFRDVgw3wzb5m8Lf5jncLC/JZPh6GXFqhtPe9+p0SXeviZdVY/+RnWUSxXji
         tXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8F0cPDRY1pwzQHZq+1t2iHqI8+yhrhOMfl9ZH3X7uNE=;
        b=kJ/w85jfMDuoDZ56vQvXqZz9w5WukH7mIPEviL+uTF6xMJ/5YyU7tXj0DaMj0vCNno
         C2pqZIXmc9w9Uk7qobBjocua0QI6AokZ8d1MmhS80+vZj++FXWNGY9ZdHn7+Wzkvxpdd
         Skw/BQuJxo2ReGSX3qxKU+YBIMy6N33x47at1+KQV1XJsZbdyR2CphG5U0+p5VNr5ZZT
         j+v5IO63Br+5nEFOCg8Z7YzButsPMSTmgpqSUmoUrGYrPZIvC7o+9n9ssv1XoDOmFNQA
         itj+d0WqyNWj8Eaaui+iT0fbSE7hbC/AEt+EyrB2Nft9Fi7ZTc0jG3YOS7mlV7RTxAiP
         vL7A==
X-Gm-Message-State: APjAAAW1RS9qcTXFYe16ogOKtskVyWBkWhCcODL/i3jWiWHXtGCpxTan
        AyUneHVDBNaGwB7vAyGAhE1loDrr
X-Google-Smtp-Source: APXvYqzoveMJR/mPZkrpL6f0MSbBQXTmPYSMmMVFlvUy+yaREO7RcCuzGmabNPbX2mHf81+hatU0tQ==
X-Received: by 2002:a65:66c7:: with SMTP id c7mr10516923pgw.407.1573206248560;
        Fri, 08 Nov 2019 01:44:08 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:07 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 5/9] sequencer: reencode revert/cherry-pick's todo list
Date:   Fri,  8 Nov 2019 16:43:47 +0700
Message-Id: <40fa7594923d877c780f28ebc73f28cf16ab8568.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
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
2.24.0.8.g2e95ca57d2.dirty

