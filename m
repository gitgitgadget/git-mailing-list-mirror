Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE0DC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbhLVEN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbhLVENR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA5C061756
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so749571wmb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FMi1n8tjUkOdHThgoPnhGZ2kiYwEPCRmGRqo1KLGrI=;
        b=BWefyd3r++ZV3spk5p+jhW6F1E2USQ8vyscSFvO1OTcWtW61DDGok92vtOcyjpRMnE
         AdnjkfqiBoe5eDnIkM4Eb/WIT9NcIOxejbyRyRbg2n5t9dy5B8Ct2nOI8aFtOEMLc/do
         heaVen05eokXCDe1XEBVjN2DxQOwVKsBXylucr87d4xjaqVhsvZzKE1cYfcniFc3RpwU
         9FIeMDrDlZVtyUM8rOtIsfDTk9I0I51GNKFYaBnzx3nLHSeZalFqVbO2VEOj1LmHp2rO
         CcB8M12kJD7x6Ke2HeLl4YOx1xfAy/5GQlRfyQcKVYIvShH7n/VwAC0BceGHp/5+Byvl
         PgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FMi1n8tjUkOdHThgoPnhGZ2kiYwEPCRmGRqo1KLGrI=;
        b=5K87UpOqChAnHPV3UIUN1K8lGd/Uy5aawEtjYuXVL1N2RZtDWZnU5TKGTSfBNY/+Tm
         NKB62xd4q6yljNr9IjcRHUa9vrCNIqja5IA/XNPEg6hpcjz0Cg8JTSXqXkOq5Xwqhngi
         0izsgQymfWt8bVl7AfZ+BXygHMFnxD0pFQc5ilBnNZnHliHevuqvpgwxL1VJG+542P41
         zs7tquGygnLLlputoJFbF8jBRUd1Bqo0jh3/pGBZwgMthpjfnf+ptkL04hBgj+JwtPx9
         AHwo4IX3OpiHj2JBS1ZvNraeIL9Vi+TZldLtxEgE4x8L5Acnp9EJtX4dGg9k4tqs1c/z
         JC2A==
X-Gm-Message-State: AOAM533TVO9VyYcHHWPHERUeCuu9qo8sptrRiUYvoiGYtkeRWABm8oxq
        aybnOGzCoE/IowxaesfN7M8Ahf+iU3o9Bg==
X-Google-Smtp-Source: ABdhPJxRNaWnuOtkx+i6ubWCQ/5Ia6fUy5Zto3rm8yBx3SZQFgaDxkY93Iyw8hHcT0KRXRiP7gj/Qg==
X-Received: by 2002:a05:600c:3657:: with SMTP id y23mr799336wmq.160.1640146393339;
        Tue, 21 Dec 2021 20:13:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/10] cat-file: correct and improve usage information
Date:   Wed, 22 Dec 2021 05:13:01 +0100
Message-Id: <patch-v5-08.10-16b6bb8aaf2-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

