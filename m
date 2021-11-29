Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14BC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhK2WWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhK2WVH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161FC091D03
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so18455328wrw.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWb20HI5W1J4d9hyLN/7bpGk2hYLwE+5yheZmIiO72E=;
        b=FeC//4qTxhF3qDcLKkyrpgdEHGhbmD3rGWeMNSYWeQ/hpbTn1Hwdn8N+EKxNADnDqB
         7b00X9m5ZnvbwtZ2Jv6kINrbtN/0YL4Ahq1u54+Xvo1pQHdQCgtQ8UeySc3XGo4yk7Jh
         lDe7RWdX9U36FkTNLjhTiXio0wPnMvH/Bmn1CVvm1s6lnFRIW6UNmq0MUqPa0MQLMg0S
         /VkwLzaVvC5fxcFPAHeyC4NqctMph4JZ04czdFmqKs6Mx2zIdW6WOZC+2T+e+dwrwJp6
         dLWI369yG3DWiaZ4hLqRFA3a6HmfFPOYbzh8DzQ9thOOtHs7rKztiyj3SqdF/OWQtUKj
         Ev4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWb20HI5W1J4d9hyLN/7bpGk2hYLwE+5yheZmIiO72E=;
        b=okoyKqTZstMX6oYmeaYVbR2GZ0OsiRj8eSQZjWHDx3qlywpBSMFsW0As4CkOjFpixe
         kyIJ3IeMZ6UkMpiNqZWKCzO+xcyX2w1q6MiqIWdrVuEm/Z2cuwNOEtLcpD1oY9yPlrwL
         keu+mke07Jav/CRBZPKbQJOxrWblhwoOe4aTugXmWz75PMLT4HgfpLIu0bFyvjf3WHZ8
         rRJseQ/RrIfUayvpWnIGUCqOaPp06+5NtS/nb2U5fvl6z+vGMyclNmLVTqjFoAdvVeXp
         S8cBu/+i7M1j7SGLxYfpCMmBXbppEEiRpGyV6BgAMel+2Ug4MsYCqVmD+WSiC6p0bboC
         KQjQ==
X-Gm-Message-State: AOAM533sUc6tAjhgsiYwvEzq3uE+R2Y80MysNvXi8XXgSGwWfvi8OySf
        rJUfAy8bHBewAQKTElhcZF6FpV1mbPyB6g==
X-Google-Smtp-Source: ABdhPJw1KZPt3veugKBDPzxfUvvxVKb/APDcqideFM5Hkw8+0Z3pticf86kC71qVJuXCA9lPXSO5lw==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr36983538wri.355.1638215961100;
        Mon, 29 Nov 2021 11:59:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] cat-file: correct and improve usage information
Date:   Mon, 29 Nov 2021 20:57:48 +0100
Message-Id: <patch-v3-08.10-a378dd30dd0-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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
2.34.1.841.gf15fb7e6f34

