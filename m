Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiCDSdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiCDSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783446667
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x15so13889003wru.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibaIM9S0GLZ7B+5sPZnpeyNcRAycvQm7iaJwe34oXYs=;
        b=q1BaD9x/feZKveY0d0BRukd0Bo7Q2gwiidWOQyg3QhPmgEuOresMHnZCz8mfynT8f3
         lHG5fdrzOzFwKACYI3gx1GPMn6WUZiE0WFsP7MB7YNtMt3xjforQC0AJSV93ElFWiq0Z
         9Vu1dZ3xYEHD3rznR8DE4WwcKApmXvrxmCWsFwoBzGrNR6N8PR7mGqLDBWqZg1L+1T0J
         p99U/2i+OAQblsbnwyxGFpdQYwd4++bRpRoAnpw5YtaMGcKHltbEjpgNlFEghySS+Tne
         DgNrFc1T8wkAXjSYfiWlmJ0tXQvK1OVWhWOLilTDTN4tZ+mTlF+suI0C3W6O5CGckf3O
         KUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibaIM9S0GLZ7B+5sPZnpeyNcRAycvQm7iaJwe34oXYs=;
        b=0qLxu1++AFSDUtLf9UNGZD4uFjmqCz3tZ4ovMviB4i9ePmjnrKdlhXIqFFq69hnc0l
         rAtOqpCoVwqd3GfYq4Ut3YSMC05TtrbMf//6ifH8kLiCNOAdntDTBmYH/WSv/v4dqU9v
         qdckFLqMSbnPjTXNKyZULPShiInQOAnXFHTDhYYpyE8IJYaK63RMYLINKeNY4HX8I6y1
         a6M5D4lXJsfh8Scx4cSPLjTPwL9v1ZdQ50GWBMFQ/iodWu3XqFVDpYoGwgGbGBH3BYwg
         7M9s7NZNa8UCenfVG/pUQG3zMP/uU8rMLhkzMlVzngmzhIb7g8xsMhpc3JKJExuzLjTi
         LlTg==
X-Gm-Message-State: AOAM530rctLNF94oM5TXdG0lG5fH+0NBU3e8anGlkmEMgobYDSkmbH6e
        gMhX1kFLNpeN3trYsdEMoyxk7lHJFg9DZA==
X-Google-Smtp-Source: ABdhPJyG0jtRbZ3cL8YH9kfI0ilO8huZ6bkbgouVZ9lW4jp+fH89pnzpsdIeYmYhKpA3QndpIdcKbA==
X-Received: by 2002:a5d:6251:0:b0:1ea:9412:fc8b with SMTP id m17-20020a5d6251000000b001ea9412fc8bmr930wrv.657.1646418751718;
        Fri, 04 Mar 2022 10:32:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/14] commit-graph: stop fill_oids_from_packs() progress on error and free()
Date:   Fri,  4 Mar 2022 19:32:13 +0100
Message-Id: <patch-v2-10.14-27f5190ce59-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in fill_oids_from_packs(), we should always stop_progress(),
but did not do so if we returned an error here. This also plugs a
memory leak in those cases by releasing the two "struct strbuf"
variables the function uses.

While I'm at it stop hardcoding "-1" here and just use the return
value of error() instead, which happens to be "-1".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d0c94600bab..aab0b292774 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1685,6 +1685,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	struct strbuf progress_title = STRBUF_INIT;
 	struct strbuf packname = STRBUF_INIT;
 	int dirlen;
+	int ret = 0;
 
 	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
 	dirlen = packname.len;
@@ -1703,12 +1704,12 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
 		p = add_packed_git(packname.buf, packname.len, 1);
 		if (!p) {
-			error(_("error adding pack %s"), packname.buf);
-			return -1;
+			ret = error(_("error adding pack %s"), packname.buf);
+			goto cleanup;
 		}
 		if (open_pack_index(p)) {
-			error(_("error opening index for %s"), packname.buf);
-			return -1;
+			ret = error(_("error opening index for %s"), packname.buf);
+			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
 					FOR_EACH_OBJECT_PACK_ORDER);
@@ -1716,11 +1717,12 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		free(p);
 	}
 
+cleanup:
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 	strbuf_release(&packname);
 
-	return 0;
+	return ret;
 }
 
 static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
-- 
2.35.1.1248.gb68c9165ad8

