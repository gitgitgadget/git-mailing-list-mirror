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
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E441F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392990AbfIYUNy (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:13:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36073 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbfIYUNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:13:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so155744wrd.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/HNJ4oa/khQQUfeg3XoK7zRdCWG38Uj0B1kt+9pIes=;
        b=PXtVsIiNUe2P1RLyPa7iHFRPdc845V8MSPDXCB9R2g88o41CPYn0NNa+GpgCFuElsR
         bGAEUBdQryy0/79gnNoF+WWa2zJhlJI6ajg2b7UDus6kM0TdvoTRjZnuynYLt1QYgN4q
         aaJF93EYyPyDFqXVfT/zvqNHfB4WvyqDTPPeAbCuPEgOAS5JDiqJvWGpvpUPOqvh/+5X
         r5R9v67t9vug3ykLnRNm+al1y3ncZaI3dNAn0jxXooRJl5umEe+xP/OH/4cIKwzvPuz2
         wTBlu4iypLs1mpE96T/c3SjXUeC9tVDIld5tHo16hwjxViVINKvMl8n0cu1gALjFpgaf
         9cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/HNJ4oa/khQQUfeg3XoK7zRdCWG38Uj0B1kt+9pIes=;
        b=haxkQwq+71haZ2/ov+YsJdYCYX5EKkUKPg1JKh3cilYsK6QDjBNSGZs6LnFrF66okc
         asrioDmY3Mmuh2E4Q7NOaRMB03/jtNqB30fJCWFTT3Pri3el5JJGqjbISWGP6Hywh7jA
         BooBG1iExGwQniUtCeSLGtdSJ5snlll8adAFesdIGtKvy2saUTNF5mgyLbhqCmPs+unU
         /xXTv4LgahgQOJNeKDJVPeoCgf2kfvQBMuo7RrGjQi2A4fhLE8YSShfxGg4LWkdIynlh
         lQyL0OpuEaBLX561waOSOZuyDZ8O0ys5w++Zb4i3HX4OMsJNI/OoPdRiZvDiyzf968zx
         N37Q==
X-Gm-Message-State: APjAAAV1JIh60vmrtmPCh1Rrnupt7KuE0NJaCJEL3IjzdNyh83JUb9GF
        CD9PkVkJmPSgASIgXOUkfGzavsDN
X-Google-Smtp-Source: APXvYqxXrvaxe/p8qAMzoYlGRh3xb6Bru1IcmmIh2HY8eZrSPIiiUsHEbJco/eFWgmfBuhxm4GMI/A==
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr125711wrw.80.1569442431469;
        Wed, 25 Sep 2019 13:13:51 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.googlemail.com with ESMTPSA id d193sm138022wmd.0.2019.09.25.13.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:13:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1 3/5] sequencer: move the code writing total_nr on the disk to a new function
Date:   Wed, 25 Sep 2019 22:13:13 +0200
Message-Id: <20190925201315.19722-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925201315.19722-1-alban.gruin@gmail.com>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The total amount of commands can be used to show the progression of the
rebasing in a shell.  It is written to the disk by read_populate_todo()
when the todo list is loaded from sequencer_continue() or
pick_commits(), but not by complete_action().

This moves the part writing total_nr to a new function so it can be
called from complete_action().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 42313f8de6..ec7ea8d9e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2342,6 +2342,16 @@ void sequencer_post_commit_cleanup(struct repository *r, int verbose)
 	sequencer_remove_state(&opts);
 }
 
+static void todo_list_write_total_nr(struct todo_list *todo_list)
+{
+	FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
+
+	if (f) {
+		fprintf(f, "%d\n", todo_list->total_nr);
+		fclose(f);
+	}
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
@@ -2387,7 +2397,6 @@ static int read_populate_todo(struct repository *r,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
-		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 		    !todo_list_parse_insn_buffer(r, done.buf.buf, &done))
@@ -2399,10 +2408,7 @@ static int read_populate_todo(struct repository *r,
 			+ count_commands(todo_list);
 		todo_list_release(&done);
 
-		if (f) {
-			fprintf(f, "%d\n", todo_list->total_nr);
-			fclose(f);
-		}
+		todo_list_write_total_nr(todo_list);
 	}
 
 	return 0;
-- 
2.23.0

