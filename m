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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E36C433E6
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76664E5F
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhBTRIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 12:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBTRIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 12:08:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD853C06178A
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f7so13115858wrt.12
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HdRZS4Xcca9nkeyMrzU/2QBlHALHw6j/z6aRutsVlYY=;
        b=swmKSPAnlTiNqFZrfAavbRhmbxGXze8glDLh7rvGHezY+SLVKtsPbh+s0a2Dv+oyIs
         1JAbjhEUrp1aRCq0aY6TFyAGS5I6DkhaaiUt7emRbNWNF0TgVLRMaRrY46sbu1oqcEJC
         pSCGmz9weg0CYm7iW014natyUlwZrmpOmKLkEs2zTwxwV3+i+XlnkMx4NlrAaF+z4dse
         7J0tIe3ny68s2NmTnEsWfKwLfBGL8W9kuBYkFtQ8APEPlzaq/ZpAv9pGASZ4gUZxikX7
         RsK+OwfBikVijO8tLOCkLYGDdUAM1tBflFUziqMBq3Ge1HojJc6NyoHMIgRCqalqfcH5
         bUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=HdRZS4Xcca9nkeyMrzU/2QBlHALHw6j/z6aRutsVlYY=;
        b=bHTHWPGzbst3YtX2SIohlEBCnAGlsiek38/xwBnuTAO4JdIMDr+fxNE7djUEm723Pa
         Cj+O0rZtYEYjJR2DZ3NnWLvQacUa3AwVpojzS1MD0JQLB4nbALuPWn1r6id3vyeDxNJN
         JUqaMF7asnHjC+LAWhg0DdRjaxIEsIiLOeZh31MJ+rqkrJJEJpuHg1Bg4JnFxbYZ5Odl
         Qy2aalVLfvg0AKM9ARhwzMFExygEFJqRMGFfx8gVJOed2OWjwceAmmK2LUq3YmAb27uO
         7A4rqT0EO68goxT3tNuqg6at3yCvE9bAIRYPdHi9V73rLUymv+M1Svg+zD+sTW3dtAV7
         YqkA==
X-Gm-Message-State: AOAM533HIBcJyQLmfKeQx4AIs+xoLtbXSa953vGKUG+MQYTpcYvzCMKP
        2nSWLGUysgNTAxuJ2NZzg+S9Earmfsc=
X-Google-Smtp-Source: ABdhPJzBkWGtLaNtnrmobatIZ+jdUlfxZ5WQ29PyYIG2aV+nGM90T8E3cfwe8LqOml2LMPN8DPytPQ==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr13812204wrw.415.1613840867814;
        Sat, 20 Feb 2021 09:07:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm19216742wrx.77.2021.02.20.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 09:07:47 -0800 (PST)
Message-Id: <810d4005fe8f018e7e8e179cbd005cc203b06441.1613840865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
        <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Feb 2021 17:07:45 +0000
Subject: [PATCH v2 2/2] hash-object: use the new HASH_RAW flag instead of
 setting path to NULL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>,
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
index 640ef4ded595..6f261a1f00e3 100644
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
+		OPT_BIT(0, "no-filters", &flags, N_("store file as is without filters"),
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
