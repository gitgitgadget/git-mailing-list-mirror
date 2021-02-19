Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6880C433E9
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD7C64E86
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 18:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBSSNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBSSM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 13:12:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72055C061786
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n8so9716967wrm.10
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 10:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=L9BsEPnnPaHIIbUCSH5AnhJBMxeA7zelzow7i45op94=;
        b=hebLGQAQei41319H9+y1a+dxIh2cmonxIeCTQrc98lnfx4S2e7J0JhDjqi8mwN6+et
         8roEttpMWblVZJg8DbM95dIM+BHG75tkEsZUaWvncvKp7geGXDLeQFar75hH5QyI3VqT
         5BkZguhd4Nj4kfodi62VZ+Xpuk5Y07TSdF3Xqv0Hyl/uDIwnNKC0xS1Bv74KeV20HiQu
         wXqvCgXU48h7U+DjIgZW+tbuDDe5wO2EUweEMHnb369gmQycJQ2ItZPwjZgbjlzZvM8U
         fRJIY7kFvH1bQTGmUpbVE0PUS7uWIb/FDPc/UJuKxkHeHeyP+n5VQ75Uc8l5bE+8FPvB
         ydhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=L9BsEPnnPaHIIbUCSH5AnhJBMxeA7zelzow7i45op94=;
        b=tQ6J1MdSjei+Pjr17xdBLWshP6NvZtEZ+FQxlICNpol8JgCQB274kY84h413SGysWP
         IjSOJPEytci/iDFIJJPBcwICpLpr9lNRfQvOq2I/BGAk1BjEOOoiLXPXTzXJ+2hbW823
         i7lCAbc4GH9013SAuAaQMrS4tCZJxgMplqjgKmpllLl4JYUleg8v4sWQ4bX3Qq1P90DW
         94TusIpkiHbEgS1SYsyJeQyomljCWnJqav4d2GMF8COFGD0T0HIGDuHEaDt880cPWcXZ
         UH9U7cU7zI61dap/chCJgwgvYiZ9D1xxaKiW3DCP/I6DVgDI3XWxYK4JqxvKLyQNndmW
         dluA==
X-Gm-Message-State: AOAM533fQtgypGkZE6LqXvWibhRHBOhz8bOLHQtU6gkuREpdH3XF7UE1
        bnsmnDg+BPR/r5U8IYUDa0DB4xyZ8Vw=
X-Google-Smtp-Source: ABdhPJylhFRi/2zGhhOqkSRfPGM2JMgD4kCLNFcGSjplzg/1O/H9jHb8CKTFhPhZncPJJiGNU2iCyw==
X-Received: by 2002:adf:9c89:: with SMTP id d9mr4163537wre.229.1613758336231;
        Fri, 19 Feb 2021 10:12:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm13831264wrt.26.2021.02.19.10.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:12:15 -0800 (PST)
Message-Id: <0e113e958b3514d2579eb46c1005fd7b26e0a077.1613758333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.880.git.1613758333.gitgitgadget@gmail.com>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 18:12:13 +0000
Subject: [PATCH 2/2] hash-object: use the new HASH_RAW flag instead of setting
 path to NULL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrej Shadura <andrew.shadura@collabora.co.uk>

While setting path to NULL works and flips the condition in the right
branch inside index_mem(), doing so isn’t obvious for the reader of
the code. Since index_mem() now has an additional flag to disable
filtering, use that instead.

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 builtin/hash-object.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 640ef4ded595..8e0543b12bc5 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -59,8 +59,7 @@ static void hash_object(const char *path, const char *type, const char *vpath,
 	hash_fd(fd, type, vpath, flags, literally);
 }
 
-static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
-			     int literally)
+static void hash_stdin_paths(const char *type, unsigned flags, int literally)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -72,8 +71,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally);
+		hash_object(buf.buf, type, buf.buf, flags, literally);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -89,7 +87,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	const char *type = blob_type;
 	int hashstdin = 0;
 	int stdin_paths = 0;
-	int no_filters = 0;
 	int literally = 0;
 	int nongit = 0;
 	unsigned flags = HASH_FORMAT_CHECK;
@@ -100,7 +97,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			HASH_WRITE_OBJECT),
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
-		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
+		OPT_BIT(0 , "no-filters", &flags, N_("store file as is without filters"),
+			HASH_RAW),
 		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 		OPT_END()
@@ -132,7 +130,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	else {
 		if (hashstdin > 1)
 			errstr = "Multiple --stdin arguments are not supported";
-		if (vpath && no_filters)
+		if (vpath && (flags & HASH_RAW))
 			errstr = "Can't use --path with --no-filters";
 	}
 
@@ -150,13 +148,12 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
-		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
-			    flags, literally);
+		hash_object(arg, type, vpath ? vpath : arg, flags, literally);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags, literally);
+		hash_stdin_paths(type, flags, literally);
 
 	return 0;
 }
-- 
gitgitgadget
