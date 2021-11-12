Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA26FC433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A692660ED4
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhKLWXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhKLWXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABABC061767
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z200so8957351wmc.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHcgkmmvHOezsCWyrvLz5vZQClyvX60Hdtcd0IFSWq8=;
        b=iaDk+2WoH2uspOnlNGaLrm0MgxYm1Yb7tyuWtwgiplZcekayXozroIUKWZ5QC/ZfoB
         3Sb1EIblxGzfcRxCkF30EsjkLTcaV/kfaSRH4wSgGY6lf4i3dCE6bsrRabahST9BUTFp
         JOCLJG6GRfbiYaBkBiS6YZlNl7/ZF0E7JX1oep9y8YWd4vX6VGisJ3GjxamRaqjP5DOY
         Dx3LEBuVhL1asZDEZqWBiHMxpR2ljlfcr8PLIPZPFSX6xiv+VCpQ4uEm6xG23WTa1LgF
         mCw9CqrYFVGax/qXSPpfPVxAYVEgR9QeLPj+a9YLkBdBLZety/+01evSn51dpmffnu8C
         WXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHcgkmmvHOezsCWyrvLz5vZQClyvX60Hdtcd0IFSWq8=;
        b=k5t2VqShma8/oz2NqrrDWYQyC8qgwmpbLIVTS+3EGn9And9+ACI9F4cdsFXQyrRled
         LDIvgCnf5/AN21XIKIEPs7q5hyrgBr3w5e9JgflIRZWcNjRD7Wn8eBZpM92oVVbUpggK
         mfqxJMMxFB75m4H6PKRGXna2EFASynFFqZ+6CXFZ6933u0xX6DKSvIicS+q9yAuc2aaa
         m/il7KFHQLCGiMZGqfLZR1F+Z9phacTJufv/b6s5GV34+NBFuApdNV5W8yDUlLbw8JrM
         rJQDcpndeiPPnml0KDxFLHAnJsuFDLd9pTsxqxZAiSMoSL6a9ECSzMcW1jjrumc6/+oU
         FA/w==
X-Gm-Message-State: AOAM533Pp1Ocv12oUU12dIBBDVsz9dIPv93Q/pSjgPAiIGmCpkKiF6Mh
        EWueXn82bW+Il3mF/Fa9jWiAG8eFmExTVQ==
X-Google-Smtp-Source: ABdhPJzCDmck43vKzX/+wpRzWCVe6W9xWhdNzJpktn4vhDWMc2ZYIwFaAk7BC52QSNJMfyf5BMAC/g==
X-Received: by 2002:a05:600c:1e26:: with SMTP id ay38mr21165569wmb.14.1636755654687;
        Fri, 12 Nov 2021 14:20:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Fri, 12 Nov 2021 23:20:02 +0100
Message-Id: <patch-v2-04.10-b9c935b95b7-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
2.34.0.rc2.795.g926201d1cc8

