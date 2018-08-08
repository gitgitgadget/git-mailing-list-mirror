Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23661F46C
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeHHVUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:33 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:50646 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbeHHVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:33 -0400
Received: by mail-wm0-f53.google.com with SMTP id s12-v6so3828248wmc.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CpB6x3MOdRINoTkkgYa68pusKG9Ir1BTvi57CvOdQlo=;
        b=ESO0kzdlaZsxl4HAGUK4Sxvmc3f7G9Uu/nRGRtBAVzBftXDDLQeHQNWGeYb7phQDSW
         2ynk1C9wHxCtt/QRgieMQ8+BTrMHUsqHt2SSg5uofYSafH4ujxe0OsBQBT6RxVLMM299
         iptMg3ChrQb6iUGN2bFsFURO/BGOrEMQPeaL63aBlAzPW5IxhT6bjHhF2V7hDMu7J56X
         A7EFNpPsLiYXvQ4pHCLtybJ4Vv81PpncISmqX+Smctl9zNh6t856LCJu9xRf/UjJ1jBs
         FGsYs0u9nx4AxXn7XovD3O6Vmr+naKifbKB3BhQqQtCgNSqXCxGU5446GI8dUIK/WDSK
         AGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpB6x3MOdRINoTkkgYa68pusKG9Ir1BTvi57CvOdQlo=;
        b=Cx14jsvWEL+pdJ2FCjiRdyFzNgkqw9/l2rizYzHZm9PazvMB7P6dzLjarruZ85czdH
         MIodOPJqsux3guYpgkTdhS0XrHZhYMFK8bVn7hffvV6hp3+eJN4awXzB0RwVcFhVVWkN
         oFDJ967z7G/+15JwzTcqRHBGmctRvG0i6Ac+KxC49BQZH8n9rdTPygdX4ctIuk0k2Cb5
         Stmodp/SOlNpxr0IhOLfiCkTPbAKYZ7Fl1pX5egRbzZObmqy5UK9fioZvGvpsY9bdLf2
         NJ7/ABk1M2IxaK0dQg0ru5UFX85hFWUGHKZ1bX7bc8UjGYcOjy6FchnLCYcdXQqlxjbi
         vtGg==
X-Gm-Message-State: AOUpUlFqOyNaIyfpmmdo19CfGOusXL4lCBsTCc7oaA32iQ3ewIfJ+db+
        QY4U5W59YfbmqYwFud5mtqCFLQij
X-Google-Smtp-Source: AA+uWPzul6Wj7fiyUt9imzl7kSxuXEsg14JlD5HqXOuxzLj5g5l7xj2TuWHHNz4Wq8S0YGMANU1s0Q==
X-Received: by 2002:a7b:c086:: with SMTP id r6-v6mr2557682wmh.119.1533754771134;
        Wed, 08 Aug 2018 11:59:31 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:30 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 16/26] stash: replace spawning a "read-tree" process
Date:   Wed,  8 Aug 2018 21:58:55 +0300
Message-Id: <0683dfe7cf0528c0288b57914e7626b5c7108909.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of spawning a child process, make use of `reset_tree()`
function already implemented in `stash-helper.c`.
---
 builtin/stash--helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index a4e57899b..887b78d05 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -984,21 +984,18 @@ static int stash_patch(struct stash_info *info, const char **argv)
 static int stash_working_tree(struct stash_info *info, const char **argv)
 {
 	int ret = 0;
-	struct child_process cp0 = CHILD_PROCESS_INIT;
 	struct child_process cp1 = CHILD_PROCESS_INIT;
 	struct child_process cp2 = CHILD_PROCESS_INIT;
 	struct child_process cp3 = CHILD_PROCESS_INIT;
 	struct strbuf out1 = STRBUF_INIT;
 	struct strbuf out3 = STRBUF_INIT;
 
-	cp0.git_cmd = 1;
-	argv_array_push(&cp0.args, "read-tree");
-	argv_array_pushf(&cp0.args, "--index-output=%s", stash_index_path.buf);
-	argv_array_pushl(&cp0.args, "-m", oid_to_hex(&info->i_tree), NULL);
-	if (run_command(&cp0)) {
+	set_alternate_index_output(stash_index_path.buf);
+	if (reset_tree(&info->i_tree, 0, 0)) {
 		ret = -1;
 		goto done;
 	}
+	set_alternate_index_output(".git/index");
 
 	cp1.git_cmd = 1;
 	argv_array_pushl(&cp1.args, "diff-index", "--name-only", "-z",
-- 
2.18.0.573.g56500d98f

