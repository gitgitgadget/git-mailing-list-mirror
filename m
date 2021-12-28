Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98621C4321E
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhL1N3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhL1N3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696F9C061747
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i22so38341319wrb.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wteACnnsoa/n5oQav01+DwP+9JSWDpi9/EfApZuzJC8=;
        b=W8qFf96zYvq73tpv3CFvb85zA/HAiJP/dcnWFPpoE98uu9Id2tLU0aFwFU7kWmqYms
         NFQQzHhl16jDQkeE39iZUAx/JGutGQ0GpRofLibLSz5dB16HlS3WJtmGBA1CCULOTBYd
         tAgRUspnh6+Y4pTDr+PiOJzKgOQeUBgWN2tDqme6y1bYDKSn06p8SkvQpiKOgt0BNjrl
         R45SVaV7c7fGDXzwT/DHlptnKFT28gKr0E4doNKLbWiIuEbsqr31+CNt8/zsBwGxU+EL
         Hk0cN7vWDA7dqeqgBKvaAyty66ut96nS67P9SW0VEThJDUVuvTqJ6TrteGATRHhnZrGC
         UUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wteACnnsoa/n5oQav01+DwP+9JSWDpi9/EfApZuzJC8=;
        b=GCIJg6aZjv/26zdZDibpzRdUrZCfhOnuduJkoj8DdhPcaUtqYTzPnTJTbtWfbI7uB+
         tYiEUdn+LGcGekiMzKOppHeZZlvwcmACHVCNwGvQVOkANJBGoA6vo+iTWYsABqx3+6dJ
         hYrq8bqcaG6F89WRSQIXKL1WuAI/nNnk0903HoyW7SSWaK3hd/wIUgRJhRDnQv9BQlWN
         78Xl1JJEwyvoZOfGMRoB5Wrx5oiJytWeGsUKsNGY6SdLiEvI9jXU4rqV+JS5rMrYpM63
         iqz3yWtAlUFPFPBwSkZaUtpSR8B6B6TEBglvELExzLQLm3+8jFjG8Y2sH5QPa8m+SYcK
         fqhQ==
X-Gm-Message-State: AOAM530dfLfZ1B0Sx0b9hh2DGJMjCSNiGOd8fv8E3kzZEYDe13haDXpk
        szwB7pTEoESwnS+yqEnt8xKzW7mmztIyddnv
X-Google-Smtp-Source: ABdhPJxMMOrmgLFhxAqBsuyPwq7hRLamTxPHKztStRWnCw69lqt697PjLtl18tBAUl/XkV+qmYbdaw==
X-Received: by 2002:a5d:58f2:: with SMTP id f18mr16374622wrd.98.1640698138799;
        Tue, 28 Dec 2021 05:28:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/10] cat-file: correct and improve usage information
Date:   Tue, 28 Dec 2021 14:28:48 +0100
Message-Id: <patch-v6-08.10-af22a4cb134-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
index 895292074ae..b5b130d79c1 100644
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
2.34.1.1257.g2af47340c7b

