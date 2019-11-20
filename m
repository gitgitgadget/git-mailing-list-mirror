Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF095C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1DD2245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZQ+jjDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKTAvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34651 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so12951776plr.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kU+Q6G8qopZi4s0dWF3JcdVw7ZV4xtAispcHmOihLU0=;
        b=GZQ+jjDKPwGHj04dVjTUYCRc9OoWVAQh6GkPr/82V7rT/gqSlcwZ8MpU5dAV5meFXn
         +noujpJbdgoOX5xRCan5vifkHxAtVLJVM2aiKRJsx+hnlx0d1tiHY1igLJTwOZp7W1NR
         0ri4mXDOT/mgd4UpVDvnUMm99akS1mOYOCh0ECRi59KvcVeas6RL+CRHD57Dhyazcu3T
         7aeB3bMBNGehq5kOV1gcdYb7gLvdgTHeFkLZEhu/oHFJn5BMS4eUR4kJsd7VeH8PDfWI
         ipr8zLkJWQjFRFjh5bIU78cyzcU52IkNktvmKxo62qYHNF5ivw9IxgoSIww/OSvqSQt8
         vehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kU+Q6G8qopZi4s0dWF3JcdVw7ZV4xtAispcHmOihLU0=;
        b=JJsE7cBQ2A2Q80+kQ4GDmyDPGXJbqpJVKOFOxxyYndWT7Q7jrM4w2xNdI08mUvf+sx
         P2HiAKs8dHqHZhf4fRX5WUegZieu0OywWjAfhKpHAA0BUFjR5/p52vCn3tGfaqGCwFO0
         fKpjfJzjm+GBX2Ajw1bzM4jv1+X1cgA48vYfrlg3F1YYzj7mn8QsihRMb0ShoEZ7NceS
         ocQSeJkJXnsO1jwKA2LvHGBrwQts+5Mbl2QYAozd8sCrP8vGPKb3vGZDy3bCSOII3U/g
         kYTWWqIXjT6dQBWSiAh0d0BwVRPlORs3+SCdEtoKkdyLqiIS6OD3LVqwo0R1E6e7e+jK
         hGSg==
X-Gm-Message-State: APjAAAVJWvorgcOKibreQHqrTzR0MWYLOg0FKLU7ksKR+qIi1ZrDHN21
        VXRf0v/1FLkkp4cqdum/ZLut38YF
X-Google-Smtp-Source: APXvYqyGtN+VkIKW/xV7z4hngMDO7+GE3fwLqos/wA0NrbgP3e/DH1v4O95IV+m2G7M9DF9AEyHjOQ==
X-Received: by 2002:a17:90a:a4e:: with SMTP id o72mr532691pjo.66.1574211078481;
        Tue, 19 Nov 2019 16:51:18 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a68sm26445248pfa.160.2019.11.19.16.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:17 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 06/11] pretty.c: inline initalize format_context
Message-ID: <fa375f8271fd30b0e4be5f10c4cb10deb45afee5.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of memsetting and then initializing the fields in the struct,
move the initialization of `format_context` to its assignment.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index e4ed14effe..da154affd4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1612,14 +1612,14 @@ void repo_format_commit_message(struct repository *r,
 				const char *format, struct strbuf *sb,
 				const struct pretty_print_context *pretty_ctx)
 {
-	struct format_commit_context context;
+	struct format_commit_context context = {
+		.commit = commit,
+		.pretty_ctx = pretty_ctx,
+		.wrap_start = sb->len
+	};
 	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
 
-	memset(&context, 0, sizeof(context));
-	context.commit = commit;
-	context.pretty_ctx = pretty_ctx;
-	context.wrap_start = sb->len;
 	/*
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
-- 
2.24.0.420.g9ac4901264

