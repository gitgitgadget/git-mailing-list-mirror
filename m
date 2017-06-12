Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCB420401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbdFLWOp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:45 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:32957 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbdFLWOm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:42 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so50815766pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/EU0A25TcrRpwmX/Pzv32qJ45SbtLIBooaRL+AwcXZQ=;
        b=Kb/CY+3e2Ne4FKa4nOFJKxsmiAHzEALmXs5hdnf3yPzOYbtEn7rWrzFQfC4MsanXCe
         TjoNeeolEzgOqkCzD/KOh3VYsAYEA1vpZhrH5fSq2xsJFjgN3q5+DkB+1PfFB7Oc5Jsx
         rbzpVZXq+k0WnwyZInWNw7oaQwLWGpKRU+zgdhJnZGL9+OtUmZ0DxkIcSPoqtF5cTg8w
         mHcsxzPqjUmNLlEFhNiQ2jhyWQUsQfTTAjehLwV30LpC4Umi3g7C/7LCH2NSYcmCBETn
         xKlZ98yAi2jDvddJg1GXtnCGUN44XxpEcMa9f4nLkp2eGtcU5x/t5CiiD6ftZPaZwCOg
         QGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/EU0A25TcrRpwmX/Pzv32qJ45SbtLIBooaRL+AwcXZQ=;
        b=QIyC1vTXp2a+tl3ZmKUuIPI/M4752/30sUCvUws2lRp0OTs0JZk/3Bwqbk2eE+O/6M
         VEDPeeGIYjC6bdkX8AA2nvjNJx3OwIjNybnndLFjEBemrljw4jQ8XytknQGw7cFkOZ3Y
         MDpb3SYskL1NiGyGygN3QzS+xbvIacSjEYzTj+mbBL1A/DJRzi3JQxUSttxyKwaJP3sq
         Ruqto1IOnuQLoK8r9kRfS23Q67Gvr1f/O7SIKj5LG0VYDf/a7m8L9Kp6AFpBUzW55wF/
         viqXxzWkJbAd7z+rRFfx/gq/ZBNoy2DRKPY1YCC78HOgdcjcvAm3qLo4PP6paPu79f3Z
         XK7w==
X-Gm-Message-State: AKS2vOxxcIQ0eOgcQEfx84OQD6zVo6CnCTgahCChI77g3nhpHmqnTSZE
        QCHm8Lz6dR594VqfJZyorw==
X-Received: by 10.98.144.80 with SMTP id a77mr10968771pfe.148.1497305680802;
        Mon, 12 Jun 2017 15:14:40 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:39 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 14/17] ls-files: convert show_ce_entry to take an index
Date:   Mon, 12 Jun 2017 15:14:05 -0700
Message-Id: <20170612221408.173876-15-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b1626b13b..927aa6746 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -232,7 +232,8 @@ static void show_gitlink(const struct cache_entry *ce)
 		exit(status);
 }
 
-static void show_ce_entry(const char *tag, const struct cache_entry *ce)
+static void show_ce_entry(const struct index_state *istate,
+			  const char *tag, const struct cache_entry *ce)
 {
 	struct strbuf name = STRBUF_INIT;
 	int len = max_prefix_len;
@@ -276,7 +277,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(&the_index, ce, ce->name);
+		write_eolinfo(istate, ce, ce->name);
 		write_name(ce->name);
 		if (debug_mode) {
 			const struct stat_data *sd = &ce->ce_stat_data;
@@ -352,7 +353,7 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged :
+			show_ce_entry(&the_index, ce_stage(ce) ? tag_unmerged :
 				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
 		}
 	}
@@ -370,9 +371,9 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
-				show_ce_entry(tag_removed, ce);
+				show_ce_entry(&the_index, tag_removed, ce);
 			if (show_modified && ce_modified(ce, &st, 0))
-				show_ce_entry(tag_modified, ce);
+				show_ce_entry(&the_index, tag_modified, ce);
 		}
 	}
 }
-- 
2.13.1.518.g3df882009-goog

