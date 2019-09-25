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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A95C1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393028AbfIYUN6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:13:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54020 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392996AbfIYUNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so106340wmd.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKVLyJi7ifLixEMSOYvTCiEFgG+LMY/l9FzMSQ4sFBs=;
        b=GavdMUbkl5+tfIia2vPXPuxM0U9v+1AUVybcKqGIuHAN1dEDZcxYQuasbGM+p2FmHP
         d03j7xzEVG/6z/Mtk8sZ51db0BYjd1cypw3meDw5hqZElLFvUuRl3Yld/dGd5R8Qsnt/
         eDHFGd7zJNUz1aXGuqKM2QGlbIKzMpkd2+JaGx2FgrIGwgPdzVyFS3HLgWxs2uvptIwd
         i37zaZB7NqAAp6TYwhF6DQnmmnmKVFLbx+kdrlqNz+eCEOeOkhOTDTlKxJpVwBi0+cei
         DlbnaOGNavQHSlkMa3/3LTkHCXjH37EZVjT0xZdSmmJElr7R30ussJWHar1hS1PoQbsX
         8z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKVLyJi7ifLixEMSOYvTCiEFgG+LMY/l9FzMSQ4sFBs=;
        b=h7Cfx8Cep2Uaryg0TNy9DiQzPzPLVdZP0brs9jDb/QzTQh63b4ozkCgSSHPFpQoCif
         8nzroH4iGtXFVhqA0PpeNo5sqAfw14/FSa/P+pcLATf3NDkkZTqEa4nd1oRCeCVvufZs
         v4qoRoraVoycDsoxtH1W3K18RIKVOyTW7FoqdMl5rdb9ePHIPSZaM7tlj3Bp3jq2ocdO
         DymQAorcP1v0SFJuZrakORZ/3ij5/F0T9PP2OrX6nUeJvmOZf6IV1WbobKKGj7+w7d+d
         LxUYUvwlQg7JLDHlF4IdLUcfPeMmFfzFZM/dq/f4UIP6/kEFWg10E4ehQqldbbqIBjgq
         oqyA==
X-Gm-Message-State: APjAAAUncu7MIDT6hxreUmKVbLuTBUYgD7wqtCohOHjlGrct6byzFx7T
        Y0OllMUIN0IGfr6m2sJ8HKTB2Qlv
X-Google-Smtp-Source: APXvYqy+hJD+Lb/lMVLFn1097e+q6cJU1e24HY3HkzU6c+86GlyyKiCyixVBwZV6Qttcg/gr3UtGlA==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr13326wmb.93.1569442433979;
        Wed, 25 Sep 2019 13:13:53 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id d193sm138022wmd.0.2019.09.25.13.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:53 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 5/5] sequencer: directly call pick_commits() from complete_action()
Date:   Wed, 25 Sep 2019 22:13:15 +0200
Message-Id: <20190925201315.19722-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, complete_action() calls sequencer_continue() to do the
rebase.  Even though the former already has the todo list, the latter
loads it from the disk and parses it.  Calling directly pick_commits()
from complete_action() avoids this unnecessary round trip.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ec7ea8d9e5..b395dd6e11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error_errno(_("could not write '%s'"), todo_file);
 	}
 
-	todo_list_release(&new_todo);
-
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		return -1;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
 		return -1;
 
-	return sequencer_continue(r, opts);
+	todo_list_write_total_nr(&new_todo);
+	res = pick_commits(r, &new_todo, opts);
+	todo_list_release(&new_todo);
+
+	return res;
 }
 
 struct subject2item_entry {
-- 
2.23.0

