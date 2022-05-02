Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DFC433FE
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386591AbiEBRNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382485AbiEBRNi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:13:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3655AC
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:10:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a170903124800b0015195a5826cso6811652plh.4
        for <git@vger.kernel.org>; Mon, 02 May 2022 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MG17PURULN3OASD5uWrKve8WRbCujnWrVG6t7FyK5kQ=;
        b=W3qepcNfGdhTl7z+s5sfvFqJMwoulRvQ9FtWNSlTa+g+4Jtc7nPJxjxrl0x1PfCJ41
         Z3/hgeFoWCOulX5dOTsrb1IS3iToEmrU9dyPtlEE9GPzrcrJqiR9h/Ful2q7lhhA0R8/
         PIPrqIMDXZpauEnwh+HgP9rS5PRrI4TEANFEFsX6kXuHhEBHigZlAGLFNQwKPCNIK4sh
         ZM9M5bqQWPg6/Nc7AGDRgkKFvPWCUnOss7MITaxrVygOxxup3i7LyLzaroNOB//wjIws
         gFM1kdsI9mAY6GwY4is6y/0GY+yw4PSHK5ACUVFP1nvBkrLgv6qbr1cZFs7QpPMfKFDv
         b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MG17PURULN3OASD5uWrKve8WRbCujnWrVG6t7FyK5kQ=;
        b=J2cg4qViZnKkQtPSgVa7b8A/NoNyS6IRvabeeQWnSGi67UzT6SpvkPkOiRaRdnKjfj
         rG9S1813MwMLD/Jzz/vYsA/NsY/BDJ/kz9dENyqIyEAGZW0jy70GFcGXACywgqExr1ek
         onOC0uoX+CZ5dbr38oFnB10L43wi+4JIsker2ty3FV3jUexn0N/RmZq2KRek5WvtIiSQ
         DoqR/RfY7qqBhPhoCxtPvmLjAHsC8Ddaz1ACdXPl3kbAeKqMzgS1OireEb8G6KNNWS3P
         yww9ILGa/eac7Ld7I/hjARhr3rhJc+U9X2iPSa0WWKVOjU90d87Wm+4WSJ27VMle4pjo
         s69w==
X-Gm-Message-State: AOAM533ScbQlAt4HkSVbt98E0vi9rXOHtwgkBnkb6p8TWuT5lHlcRPlO
        OlkpweQmc5uKFnxsJOkxhiCyYl01DKRWyG+TFnaIncT8ZYBsF5fLBTk9lrZBapnWhxxVTqMR1Q6
        LDHYE73DpweO53g3WOQnUG+ZbVguXcyD/Qwi3ly9qioB9FITgmWFzrBtqyITLV+ay6w==
X-Google-Smtp-Source: ABdhPJz8nn7UMES9r57zY45u2o3tECGPHszZJuJt5S492PSHdyfe9K1nGOIkdNu4cavDY3RdRNyhCF5nmuJD++w=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:1acb:b0:50d:fa52:ced with SMTP
 id f11-20020a056a001acb00b0050dfa520cedmr2730801pfv.76.1651511408653; Mon, 02
 May 2022 10:10:08 -0700 (PDT)
Date:   Mon,  2 May 2022 17:09:03 +0000
In-Reply-To: <20220502170904.2770649-1-calvinwan@google.com>
Message-Id: <20220502170904.2770649-8-calvinwan@google.com>
Mime-Version: 1.0
References: <20220328191112.3092139-1-calvinwan@google.com> <20220502170904.2770649-1-calvinwan@google.com>
X-Mailer: git-send-email 2.36.0.rc2.10170.gb555eefa6f
Subject: [PATCH v4 7/8] cat-file: move parse_cmd and DEFAULT_FORMAT up
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, calvinwan@google.com,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would be useful for a future patch to use these definitions so moving
them higher.

---
 builtin/cat-file.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 50cf38999d..cfe74c36eb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -34,6 +34,8 @@ struct batch_options {
 	const char *format;
 };
 
+#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
+
 static const char *force_path;
 
 static int filter_object(const char *path, unsigned mode,
@@ -556,6 +558,16 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static const struct parse_cmd {
+	const char *name;
+	parse_cmd_fn_t fn;
+	unsigned takes_args;
+} commands[] = {
+	{ "contents", parse_cmd_contents, 1},
+	{ "info", parse_cmd_info, 1},
+	{ "flush", NULL, 0},
+};
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -583,17 +595,6 @@ static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 	*nr = 0;
 }
 
-
-static const struct parse_cmd {
-	const char *name;
-	parse_cmd_fn_t fn;
-	unsigned takes_args;
-} commands[] = {
-	{ "contents", parse_cmd_contents, 1},
-	{ "info", parse_cmd_info, 1},
-	{ "flush", NULL, 0},
-};
-
 static void batch_objects_command(struct batch_options *opt,
 				    struct strbuf *output,
 				    struct expand_data *data)
@@ -659,8 +660,6 @@ static void batch_objects_command(struct batch_options *opt,
 	strbuf_release(&input);
 }
 
-#define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
-
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
-- 
2.36.0.rc2.10170.gb555eefa6f

