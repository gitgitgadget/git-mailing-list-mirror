Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B171820401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbdFLWPQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:15:16 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32940 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbdFLWOg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:36 -0400
Received: by mail-pg0-f46.google.com with SMTP id f185so50814994pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZ0y+Q+yQ6FkcE2SQWhkBdOmsiLPZz0wO2LsEmhj3/Q=;
        b=cmoWxKJLgMsVAR8kZF7edAhyN6nnu4gMUzP1a7xnIKN0IZgP7oFkT7WB9wRvJiBIia
         jwV9kRtXaJp7KsdJ56FWvG5PDSfcwz3rXanRid2/ijOGEirLBx14eS8hrVymZGGdWOBL
         VF7XZfnXYU5k74sqBTuH0ZkFGdY7u+WBPjaOeoAjs1/X9PL3Y1eCOQK08IxSvFxzIkro
         bes/6ELCoKG6MUiWqx1FdCUDo3oD8Vts8m418/0PKG+T1qvfMvIJwETzwRNSpWN54nWp
         guQ1g2/yptb7+k6A6sME1elqCSwCYFFOVdwknDNH8CVAnFW5W7y8MDVSiWw7ci+JMlWV
         nOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZ0y+Q+yQ6FkcE2SQWhkBdOmsiLPZz0wO2LsEmhj3/Q=;
        b=dAzYKifF/+N8fN1YBdvE7ZnWG/YoJ6kKUVj34Lt+Z4zX2aNae7VYatl+PrHMgmTP5e
         CfzEkevn/oa6yff0WdeVcwqEqVRf5Kk5ZPzAMlP0V9KjYGrwt3gCpqlRDFcRsXAandAz
         zt9vtSCGpPQ6WWsATMnmv3Up2oPGtTrhCj6mjHjFdWCuHoiBXU628L3jwNtZt2PehfXR
         IJxBR/C0GdlTw6Z6kJPpQaFKXCM3uQyDEuyxHnyFEL6/ineCIETWqQEMcZmI/2OIRirs
         Ve0eX4r24yVhRh6hSHN5UXPWzTctrLiPB9360Fo48b0rdV70XTtgMy6iOzMEOQ1zlCpS
         T3WQ==
X-Gm-Message-State: AODbwcB61ApwAwZ4nyK4v5bj2WHuN9ELJzV8LDl05/8lbDom+CWQlnxg
        C66xArHVNxeInc8nU3qeBg==
X-Received: by 10.99.160.104 with SMTP id u40mr59365484pgn.30.1497305675506;
        Mon, 12 Jun 2017 15:14:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/17] ls-files: convert show_ru_info to take an index
Date:   Mon, 12 Jun 2017 15:14:02 -0700
Message-Id: <20170612221408.173876-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5dbff9496..375fe09d1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -292,14 +292,14 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
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
@@ -685,7 +685,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 	show_files(&dir);
 	if (show_resolve_undo)
-		show_ru_info();
+		show_ru_info(&the_index);
 
 	if (ps_matched) {
 		int bad;
-- 
2.13.1.518.g3df882009-goog

