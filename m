Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4BAC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhL1N3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbhL1N26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BC6C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i22so38341121wrb.13
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJVCD3/KxiepRc+knHCW08i00FyK7vh1olCmrhhD+TA=;
        b=msSTHl8kgb8Solm9ygw7hcM1Z+pMONIaQXPimTpmII7gMaKS7I4LrtUPQjUsN+wp/4
         zsAw7gBGSViUycTcEjZuI8LXR5QsDluXhz2EEKnZzwlGX8izkv2vvLXQkPfBvS3Z7/q7
         8Qc5/rAafKNwSyWWnYexbqTZQVETTKySYgie/fXyPE4Mka7nWZJ76i8pWcYIsbW/8M1K
         xUXZnxthszrBBt4nt46cdmWK5cSknfMRYro+MwCViHD2l7Q+v6puxJFRsdz38TBPbX0k
         2wpuRqM08tyAipZvqd/DgUvBIJPVpVB/gibCk0tkw/EEkqLezrca8kS+AXDCwF4EzcnV
         pyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJVCD3/KxiepRc+knHCW08i00FyK7vh1olCmrhhD+TA=;
        b=2J+VoUUPIBuWVwZoIc/pnA1n/cRJG1Xy2sToOIy5nMzZHLwvk1qLA7i9qO5SGDKg96
         rjg5EdjrubA246bkRrJK3e4x/oJDYAC8IEIXWd/BnxFliN3PSjx+KsLtczgoTEyzPhoQ
         vWMuxbnha+cDBnwTb7acNB9pmWcwDdplNQZ0MeQG+Vfy7bKv380XRQJ5r5eL6qpJnRx0
         oSgm3NlbQ9grVkifxK7GfzSlqNF4T2qSwQWMsoHri6eVGTZrB/BCxuvPVFLpOU2HuDby
         XapXQRpRBGDykm4Q0bNkNVDMduNXtPiKd+DBUJ8ckxaDcw4WtHiuObRCjKamrpaUV46Q
         PXmQ==
X-Gm-Message-State: AOAM532DgD83nsgU2va4q3RQeP8oryGeK0IH55swrE/8Uq+heTWfzzw+
        NcMtrQ9ehSowPUigHSLsDGVFUfBY9x8Cv7VT
X-Google-Smtp-Source: ABdhPJwjaSRdzsL7UB/PGj7TRcCd8d19CufxZW1OuK8GgLo10pNY3xUzNsMZ9lTVOFOmqVt2B7jkdA==
X-Received: by 2002:a5d:6046:: with SMTP id j6mr17575711wrt.517.1640698136035;
        Tue, 28 Dec 2021 05:28:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/10] cat-file docs: fix SYNOPSIS and "-h" output
Date:   Tue, 28 Dec 2021 14:28:44 +0100
Message-Id: <patch-v6-04.10-c4078ce9222-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
2.34.1.1257.g2af47340c7b

