Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A6BC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhK2WWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhK2WUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC89C08EACE
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l16so39328079wrp.11
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KS1LZoZmyQUlFikA0SzXzlUcQaoqhadOMtB52qs/RcQ=;
        b=ObutaYuR1ZwGzed9emoR7uOTzCYb27Im/enp7Y6khpdYIcdagiu1m34cGMDz9C2xhA
         CcBQtB1r3cgX6jFkT2D7SfINJa68m+Q+7Pvs3D3CAyn1k6sBVPZVH7K4XXmehozbmReS
         wusI+zNGJTX1nvzU0VPqUshFpiT3Cb5kSrXmSv8dlX6DCBwaBFZIM2d1IFG8hDx7d7Kk
         yEY5gMwE0o7fwG4WjL/SuhYfCliHW7R1iIQJIPq1nmpcrCxvvk3OsQng4kkUdXXiV2ju
         7g4FCytVFNLwA9cbLhDJSt07U6NIQKNOjghj0BbpPxksazFKC+dKl38DoaVSS1v8zNuP
         wJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KS1LZoZmyQUlFikA0SzXzlUcQaoqhadOMtB52qs/RcQ=;
        b=TfS+2Tc9bOM1COYJFAPEYEN8Knnze5RTItEUqVZdwYtiDoPDOqrDMe7dTDVI7qfw1H
         fkZQuCw8DQVLlAL2d+CsU3i+rlbYEICyTrsc+kzWpAfmCP7R/UmWMRjBSmsKBc1uqkWN
         GYns7HwqlYug2G5otYSkJqnvBqkjhU3eOwHtB+xaJLLUSAQdVHVHjoOoSNe30AQ49mmR
         KjOrV6iSJzaVlYWF08f2okwha9FSqqB0EWxiQqhIuXKNNqcIB/+3DC90AMuNchAB7TSq
         CsASDjyNjCbSr1EZNBlvon12SEp+R/gdLGofXMkUg69UqPFHsbpIZMv45o1XjwX/2EFx
         m1jg==
X-Gm-Message-State: AOAM533XrOpI4BYdo6tL21sL/TW5dsgWto3LqPSalSDdU+NMMoBWxoz7
        AoE/Og1x5PRIZol1IREHTUTIL459evwc7A==
X-Google-Smtp-Source: ABdhPJy0RElnKgebYpV8AGL9LxGpUYyrYO0UGkJ7bGm71xaGtWVfkWebS5IuxbatkT1iKcMHG7Ztug==
X-Received: by 2002:adf:9e4b:: with SMTP id v11mr36678274wre.531.1638215957609;
        Mon, 29 Nov 2021 11:59:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Mon, 29 Nov 2021 20:57:44 +0100
Message-Id: <patch-v3-04.10-597bb97b90a-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were various inaccuracies in the previous SYNOPSIS output,
e.g. "--path" is not something that can optionally go with any options
except --textconv or --filters, as the output implied.

The opening line of the DESCRIPTION section is also "In its first
form[...]", which refers to "git cat-file <type> <object>", but the
SYNOPSIS section wasn't showing that as the first form!

That part of the documentation made sense in
d83a42f34a6 (Documentation: minor grammatical fixes in
git-cat-file.txt, 2009-03-22) when it was introduced, but since then
various options that were added have made that intro make no sense in
the context it was in. Now the two will match again.

The usage output here is not properly aligned on "master" currently,
but will be with my in-flight 4631cfc20bd (parse-options: properly
align continued usage output, 2021-09-21), so let's indent things
correctly in the C code in anticipation of that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-cat-file.txt | 10 ++++++++--
 builtin/cat-file.c             | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 27b27e2b300..73ebbc70ee2 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,8 +9,14 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
-'git cat-file' (--batch[=<format>] | --batch-check[=<format>]) [ --textconv | --filters ] [--follow-symlinks]
+'git cat-file' <type> <object>
+'git cat-file' (-e | -p) <object>
+'git cat-file' ( -t | -s ) [--allow-unknown-type] <object>
+'git cat-file' (--batch | --batch-check) [--batch-all-objects]
+	     [--buffer] [--follow-symlinks] [--unordered]
+	     [--textconv | --filters]
+'git cat-file' (--textconv | --filters )
+	     [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 86fc03242b8..1df7f797cb6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -619,8 +619,14 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
-	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
+	N_("git cat-file <type> <object>"),
+	N_("git cat-file (-e | -p) <object>"),
+	N_("git cat-file ( -t | -s ) [--allow-unknown-type] <object>"),
+	N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
+	   "             [--buffer] [--follow-symlinks] [--unordered]\n"
+	   "             [--textconv | --filters]"),
+	N_("git cat-file (--textconv | --filters )\n"
+	   "             [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]"),
 	NULL
 };
 
-- 
2.34.1.841.gf15fb7e6f34

