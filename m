Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE6C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B547A61027
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhKFVt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhKFVty (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EBC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r8so19560686wra.7
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgJ/xyYMjewGrH+vO+CFHa2rpfIWkVFrGITZyco5Hy0=;
        b=eK5LtJjRPkTxfSLte5tUWTQjnWrjj6O1vs3KVUeNKFu0gGfqx6T3+HCMx1wp0yjXrr
         AI9VcJ7J4L4rV29A76//MFkSmxoosp1kT4thDgkAo2EOLROlLqizEvuA5/uIOdRj/d9l
         gbh5Txgsga3VbNZxzfoDnh/2Liliuo9LC1ZflhbVRuVpUBJkK8vwRqbv+QciWBuNnSCT
         RTZT5673dOnCuo/JD0TLWIFI9+cCn2iBc5loO0Rl7b8RAodrKjaVuru53U0DgIO597FO
         JtTwNKnWiper5hrmjPsJ6xtTKbGp3CtHMJHAdSILp6/ictqApj7abwP0L5j8QzHf2lcc
         dMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgJ/xyYMjewGrH+vO+CFHa2rpfIWkVFrGITZyco5Hy0=;
        b=Ff2MvJ8VNsgoDLUqIQqPfMvVvO+sURVJq2TSGPO7lLCWrdsv0jQRms7ANlycodVvjP
         Ehtmf66kLwqZyIomTZPyWz970UZ0CkGhQjPrsEJie20X/dI83DeuWfvaBLjr1sOFyqIV
         NjpVJjrQYQkztRub09gcdPvMh3eAK6qP98wXue8nZYBt0xvKl2xxBDzyN9mdpfNmrcnX
         O1wCrhYx4tbc29Kl0OnxrWDkcQj92Mr5iNn2gx3v2A7Eh9QOIRZK/gnfsQxrMt1xrzEZ
         UuZwlCublwceq+Vh0yv20R2b17FHyNY8Jt/mRHT2rNX0ybLfsf26VRVAubFAtjm4dWBr
         JSMg==
X-Gm-Message-State: AOAM532GfYZRn7uy2x3VwqyGUoZKkFvUPkwXeSq9KKfZ7/yQnq6j83wz
        q4L0jXueJ9fiXPoJFQ6R48y1ElK5DPSrnw==
X-Google-Smtp-Source: ABdhPJwoqU9GnqCV1vBN/29kLu06KPl1Bnrhg8wRi1u/i8N+WVGYaS9iPqXGnWPRaARowISwJA9NzA==
X-Received: by 2002:adf:f708:: with SMTP id r8mr79322828wrp.198.1636235230599;
        Sat, 06 Nov 2021 14:47:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] cat-file: correct and improve usage information
Date:   Sat,  6 Nov 2021 22:47:00 +0100
Message-Id: <patch-08.10-951fea02b83-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage output emitted on "git cat-file -h" to group related
options, making it clear to users which options go with which other
ones.

The new output is:

    Check object existence or emit object contents
        -e                    check if <object> exists
        -p                    pretty-print <object> content

    Emit [broken] object attributes
        -t                    show object type (one of 'blob', 'tree', 'commit', 'tag', ...)
        -s                    show object size
        --allow-unknown-type  allow -s and -t to work with broken/corrupt objects

    Batch objects requested on stdin (or --batch-all-objects)
        --batch[=<format>]    show full <object> or <rev> contents
        --batch-check[=<format>]
                              like --batch, but don't emit <contents>
        --batch-all-objects   with --batch[-check]: ignores stdin, batches all known objects

    Change or optimize batch output
        --buffer              buffer --batch output
        --follow-symlinks     follow in-tree symlinks
        --unordered           do not order objects before emitting them

    Emit object (blob or tree) with conversion or filter (stand-alone, or with batch)
        --textconv            run textconv on object's content
        --filters             run filters on object's content
        --path blob|tree      use a <path> for (--textconv | --filters ); Not with 'batch'

The old usage was:

    <type> can be one of: blob, tree, commit, tag
        -t                    show object type
        -s                    show object size
        -e                    exit with zero when there's no error
        -p                    pretty-print object's content
        --textconv            for blob objects, run textconv on object's content
        --filters             for blob objects, run filters on object's content
        --batch-all-objects   show all objects with --batch or --batch-check
        --path <blob>         use a specific path for --textconv/--filters
        --allow-unknown-type  allow -s and -t to work with broken/corrupt objects
        --buffer              buffer --batch output
        --batch[=<format>]    show info and content of objects fed from the standard input
        --batch-check[=<format>]
                              show info about objects fed from the standard input
        --follow-symlinks     follow in-tree symlinks (used with --batch or --batch-check)
        --unordered           do not order --batch-all-objects output

While shorter, I think the new one is easier to understand, as
e.g. "--allow-unknown-type" is grouped with "-t" and "-s", as it can
only be combined with those options. The same goes for "--buffer",
"--unordered" etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 49 +++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f507e3ae46c..1d7f79184f0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -666,35 +666,44 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	const struct option options[] = {
-		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
-		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
-		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
+		/* Simple queries */
+		OPT_GROUP(N_("Check object existence or emit object contents")),
 		OPT_CMDMODE('e', NULL, &opt,
-			    N_("exit with zero when there's no error"), 'e'),
-		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
-		OPT_CMDMODE(0, "textconv", &opt,
-			    N_("for blob objects, run textconv on object's content"), 'c'),
-		OPT_CMDMODE(0, "filters", &opt,
-			    N_("for blob objects, run filters on object's content"), 'w'),
-		OPT_CMDMODE(0, "batch-all-objects", &opt,
-			    N_("show all objects with --batch or --batch-check"), 'b'),
-		OPT_STRING(0, "path", &force_path, N_("blob"),
-			   N_("use a specific path for --textconv/--filters")),
+			    N_("check if <object> exists"), 'e'),
+		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print <object> content"), 'p'),
+
+		OPT_GROUP(N_("Emit [broken] object attributes")),
+		OPT_CMDMODE('t', NULL, &opt, N_("show object type (one of 'blob', 'tree', 'commit', 'tag', ...)"), 't'),
+		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
-		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
-		OPT_CALLBACK_F(0, "batch", &batch, "format",
-			N_("show info and content of objects fed from the standard input"),
+		/* Batch mode */
+		OPT_GROUP(N_("Batch objects requested on stdin (or --batch-all-objects)")),
+		OPT_CALLBACK_F(0, "batch", &batch, N_("format"),
+			N_("show full <object> or <rev> contents"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
-		OPT_CALLBACK_F(0, "batch-check", &batch, "format",
-			N_("show info about objects fed from the standard input"),
+		OPT_CALLBACK_F(0, "batch-check", &batch, N_("format"),
+			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_CMDMODE(0, "batch-all-objects", &opt,
+			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
+		/* Batch-specific options */
+		OPT_GROUP(N_("Change or optimize batch output")),
+		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
-			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
+			 N_("follow in-tree symlinks")),
 		OPT_BOOL(0, "unordered", &batch.unordered,
-			 N_("do not order --batch-all-objects output")),
+			 N_("do not order objects before emitting them")),
+		/* Textconv options, stand-ole*/
+		OPT_GROUP(N_("Emit object (blob or tree) with conversion or filter (stand-alone, or with batch)")),
+		OPT_CMDMODE(0, "textconv", &opt,
+			    N_("run textconv on object's content"), 'c'),
+		OPT_CMDMODE(0, "filters", &opt,
+			    N_("run filters on object's content"), 'w'),
+		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
+			   N_("use a <path> for (--textconv | --filters ); Not with 'batch'")),
 		OPT_END()
 	};
 
-- 
2.34.0.rc1.741.gab7bfd97031

