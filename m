Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A161FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbdFHXmW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:22 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36413 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdFHXmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:09 -0400
Received: by mail-pf0-f172.google.com with SMTP id x63so22120959pff.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vyvrk3d0nuCjj+OfPCJbB2Ng4xa6owZUtzWag9S2A5E=;
        b=goqgYiqZUbTgBz1NhHfBUoX3FM1WW7b+U5ad6u3YLnYi73HgA94mZoS9xSz47pw9nV
         Spica+Yqkg1aO5Ycype5bnX0I4lnznVOImUXIp27TM2+nKy1EsX73Tg/CthKMB64xuXL
         riY6JXJadtgHEgyki0pZ3/tEsJRuiVmCrBEa8i45BVDSFiWIlwdsU+N8nUg/eZS2F0es
         q82eeM5WMWrqDZtM3dYxS6XNDxHLZHMZJKAxDU4jcOtQqvRqQtkOj8jRUjG6hm84y4XY
         ChuucL+696sxN9hSObkiaM9TVNsgx4Vp7jPNO5rebjKBpJlB19jBR2+qRTRIiY7ZSQMj
         KkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vyvrk3d0nuCjj+OfPCJbB2Ng4xa6owZUtzWag9S2A5E=;
        b=GSOlpZgk9Ud8iVJe0HLpF/fTrzCjqcCt5F4FLyCRKRqNTkzJDb43nr7pza2jSlQglV
         0g5DLm5ydrYlK/HW5yk+Sb8Yvz2+yM51BeeWg/fKuW2D1gZClUErLNnN3tNy//4QlXab
         Thxxzi6wtq4I4vyz5fHXOAmRkL5iAqqlvXCI11ys4iMzi0M4wVL1bNXDyImSCdxI9GCV
         5z4HtqPzsxf7vbFRr7hWnWbd0oO46c/vI1Lvu/BU8MKQFSRq7lAIm4cQ2gPbzBDuEMDL
         pRaoeWXbjA7+9K4VNMLx/9cFz6+h+SgQ3hZpSgb59V0tyLoVhWtqH57NMvyOMseBNlEH
         sWTg==
X-Gm-Message-State: AODbwcBZZNNHCyGIJgJfnWAFMzFR+Qchf8pysdCBce7Xc65w0aHwYhiu
        uiW5pEWJVjdEfY7r9HDzTQ==
X-Received: by 10.99.8.1 with SMTP id 1mr36291073pgi.15.1496965318492;
        Thu, 08 Jun 2017 16:41:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 26/32] ls-files: convert show_ru_info to take an index
Date:   Thu,  8 Jun 2017 16:40:54 -0700
Message-Id: <20170608234100.188529-27-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d00ca7810..2838e2f75 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -293,14 +293,14 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 	strbuf_release(&name);
 }
 
-static void show_ru_info(void)
+static void show_ru_info(const struct index_state *istate)
 {
 	struct string_list_item *item;
 
-	if (!the_index.resolve_undo)
+	if (!istate->resolve_undo)
 		return;
 
-	for_each_string_list_item(item, the_index.resolve_undo) {
+	for_each_string_list_item(item, istate->resolve_undo) {
 		const char *path = item->string;
 		struct resolve_undo_info *ui = item->util;
 		int i, len;
@@ -686,7 +686,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
-		show_ru_info();
+		show_ru_info(&the_index);
 
 	if (ps_matched) {
 		int bad;
-- 
2.13.1.508.gb3defc5cc-goog

