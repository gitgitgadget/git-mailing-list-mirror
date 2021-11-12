Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C67C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AFD60ED4
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhKLWX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbhKLWXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0116C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7827164wme.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAPm3iv7tlwZYzmUSh9XXNtV3u7Kivwh/Zm8ZCuW2Ms=;
        b=o0rF+OBl41vY9d7hhcl1rZa2Z7GNnmSVpTr0ihi14EcGpaLl6HItKp/A4LbMETvsJr
         KBHGYarI1YuerPM4vPV4sD5Q/WQMT37mg01ByfsuSPHJMv0v4ZLD5hBKf7y2sqklQYmH
         ndlrlRBKW2ZVMQ4kri9WwzP076bnQEzO6lqZHGXLKa2/zkyQw8ASVsGz52TtOtCt5TmA
         OM+eglAoWtIWocWVdYK0KuI+1cpsl1wAn62i+wp9DKnc8Qvm6XQtJ6MqBr3mOLoxOjfY
         ojv5Bzv+C2ft7jIrm/ixMwMFxAjZ4y2/HJwqKQIq//jcRV5pOrVsYbR2iH5ZUaOFyJkh
         45KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAPm3iv7tlwZYzmUSh9XXNtV3u7Kivwh/Zm8ZCuW2Ms=;
        b=JCZ7imxCy2Pyp+NejhCGzxu1p8ndYUy49IsBGLdybGRMEtEA1P0lxO3iOxt7xJCA2J
         Fj5G837qEwAXp6xxOv/xcDq1LXbnm/egqXsi1IwwU6gOlaWztkq7+MIfykuyJ5UOqzTq
         P+jKddae9UEyHe421W86DFbvAaLdcEFIn3r1Rvcky3EngAzeIY8RwjNYyrTRURxV1mEp
         VfilCE6Te4OaBKINqQPJKxwK0Wr1BNNoXDzzIxFfgqEf9ZcoTV8zBVNnqPu8D2TzjCgQ
         5y39TriY1vyFjAkFspYT1AQS10+k3bwFay69FIDYg2wTJEYMc3dKn7hcPt3/gxSTQv7d
         npMA==
X-Gm-Message-State: AOAM5300kJctnIV24L+vLCJOtJ6ifnfCZYBrwiobW42kFmktGuBnbvC9
        mJ/uxtPzeNC/n1CJhMFxcXBvVqj//QGBeQ==
X-Google-Smtp-Source: ABdhPJypLHXWV9qKj8K7xyFrR16WrZi88doZa4Z6b7Y9XdSNZ/LDmc6qdU4ID2kZTr5Z5aL4A5tULA==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr38172967wmd.137.1636755658141;
        Fri, 12 Nov 2021 14:20:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] cat-file: correct and improve usage information
Date:   Fri, 12 Nov 2021 23:20:06 +0100
Message-Id: <patch-v2-08.10-0842df64695-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

