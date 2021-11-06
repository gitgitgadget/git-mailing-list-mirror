Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5983C4332F
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E15D611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhKFVty (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhKFVtv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE94C061746
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso8944518wme.3
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2BvJ07ODMQc6mT0PcKKlVh6MLlitNEUGixbqbryvmk=;
        b=kK3NwLZSN3C1PL97QngFblxmgv0x4GbUiR6Oy+066u1mr5mQpiN+nQl6VPRyaWmx9f
         1hRxb96+sbupyc2wdSOLQfopi6BJzJvUA8XmqYVxTjDHLMI52z8NsUpyUggIArc7kCBp
         7eEs5B3buJLuj7L0OVh7G+nePXYjeFeL8uRqvjHU9W44/1WZeauUdPfOlbJm8x9f3a6J
         2daG9Q5PRqNHylEAVQCGoX/1adG1vHzUmFuithdRnXfGT6hmyUQtbFr/6nol9NvDyhgy
         TvHuPdLJUbhOa4maTwFl97zhrtARO5VWJ0EQe0b/MCp40fj43ze8uLYiUSzEgX1yOTwV
         23YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2BvJ07ODMQc6mT0PcKKlVh6MLlitNEUGixbqbryvmk=;
        b=ikqIVStM3bVIIJDFawiH68fb0XaYkxQIo513QTLOD7NIX0gHenMv4t6CD8vj381pBo
         xTSk3+HANQrxKLpUEVzCT7lxS9PnALhPrESJRKEZ3FDOFIt3qIXy6O1whPBJL8ezG3/K
         s618P5QqeLewpbrY16xPf0mYtd0WV78HmcsufW6r3wrFvsyZrjUdPISI+uyOXE/5xgG5
         qR2MnMBAF3/dM/FmEAsfuiWvAvhmzAl14OW1/ys0fgblIIYTXv9/FZjui8GMGYzt7bvh
         ec3l8ZqdxFtgB6JD9B0tBPuuuFku7BSmE6t4vrruZ11DC9hekjRELKI33u/uaV4Gmc4y
         zFwA==
X-Gm-Message-State: AOAM531OoOfnImiimZ87ORboQxbDeJTC0TxOsWcIdeZ4Fqn0TEuI2aJU
        HrLXaF///DTyg0Z01uSnzNYdX2/9+NH1sg==
X-Google-Smtp-Source: ABdhPJyS4bvw72EBAeofS/a/6krDyPkuyc8rRrg2JZ1UtZ9qy66hNM1jaRfFcb+wzwEhJbQwGJcPIA==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr41740188wmj.120.1636235227706;
        Sat, 06 Nov 2021 14:47:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Sat,  6 Nov 2021 22:46:56 +0100
Message-Id: <patch-04.10-29b67330a48-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
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
2.34.0.rc1.741.gab7bfd97031

