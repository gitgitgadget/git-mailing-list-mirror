Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55AC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A281C204EC
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tXneKQ9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHULyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHULwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 07:52:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D53C061344
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:52:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so839725pjq.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVO9lyuEURDCJ19hMM4wSddhgvERqr+utebc1E3NsxE=;
        b=tXneKQ9qNoFCkq5r+w5u4qyeYlhduagfuC+L++SM1tVOHTMwDhydotudDq36ziVDtk
         /y2EF2+w53xCemiinx/410QJHBzxl8qs096Xp8V7apJyLCVY0QqScJ9CRk7EBbxnQIWJ
         8nFbEH4ErWGsLGRIIZvZdrki4/sGGegFnnzY5XNdx0c7d9h+qZYWkgGFr3wbWup69suV
         6Py/xR+kxIdyfTmGkg9OPWm2a5GuNkm86qQ6P3ZF0OSkTUF4FXzZf/mFE79M8PYAksb7
         Xs9wL1qOGgIJ5khgFbuN/bYxd7lgv1XBs66GDKtvGXZ1D+02t+06RF2aoVp1FzovZ15L
         QaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVO9lyuEURDCJ19hMM4wSddhgvERqr+utebc1E3NsxE=;
        b=RKFD28Dm4PJ5ft+3cM5tDy3Mk3OuTgT49MqQkZsR3svNMax/RjQLAJPAlhyh4JC3yj
         vth20r0I38ZUhhNIBPbFHrzlx8GmIHKptDRlJa34T/8U0L87aqfeuw21s+bNTED11EDY
         MQ3BCgxMQCHRcuxmF8FL1tvb3vYJyDpENt+VIjoog2TsRLI24nvDL4ejbPDC07N3HL2n
         sNszDk4dptAJNP8TVuzqfeiuLz9fRwPE/6V33wkudD8SPoUmWOz2t3DzDVMA2LcdxbyY
         3LvvPRmUYfP6MAk4fl4znJ3BIi3z4sM5itA96ZTJpBM78q8TOzB3UduBsB3B4NhfhK6E
         BArQ==
X-Gm-Message-State: AOAM532ZiO2DTiQj+IVWKt24+LVqtTx0HfbgT19wo48hNfR+rbbRM5wd
        VtNlE7cYGNZnStVMeJO3eNOMUADdH+c=
X-Google-Smtp-Source: ABdhPJwXwj1+G00Hb9HEPxTRyAIfy/nizLnpbjeOcmqhsXpgQH5H4k0Lc+AcItV8399eEZqCHcG2hg==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr2093786pll.303.1598010722632;
        Fri, 21 Aug 2020 04:52:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id y1sm2300413pfl.136.2020.08.21.04.52.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 04:52:01 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 2/2] diff: index-line: respect --abbrev in object's name
Date:   Fri, 21 Aug 2020 18:51:47 +0700
Message-Id: <a9eb73ceab88aea517e978bfcba83bfafeaff3f7.1598010556.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.143.g760df7782d.dirty
In-Reply-To: <cover.1598010556.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1598010556.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A handful of Git's commands respect `--abbrev' for customizing length
of abbreviation of object names.

For diff-family, Git supports 2 different options for 2 different
purposes, `--full-index' for showing diff-patch object's name in full,
and `--abbrev' to customize the length of object names in diff-raw and
diff-tree header lines, without any options to customise the length of
object names in diff-patch format. When working with diff-patch format,
we only have two options, either full index, or default abbrev length.

Although, that behaviour is documented, it doesn't stop users from
trying to use `--abbrev' with the hope of customising diff-patch's
objects' name's abbreviation.

Let's allow the blob object names shown on the "index" line to be
abbreviated to arbitrary length given via the "--abbrev" option.

To preserve backward compatibility with old script that specify both
`--full-index' and `--abbrev', always show full object id
if `--full-index' is specified.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/diff-options.txt                |  9 +++---
 diff.c                                        |  5 +++-
 t/t4013-diff-various.sh                       |  3 ++
 ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++++++++++++
 ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++++++++++++
 ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++++++++++++
 6 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b7af973d9c..573fb9bb71 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -446,10 +446,11 @@ endif::git-format-patch[]
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show only a partial prefix.  This is
-	independent of the `--full-index` option above, which controls
-	the diff-patch output format.  Non default number of
-	digits can be specified with `--abbrev=<n>`.
+	lines, show only a partial prefix.
+	In diff-patch output format, `--full-index` takes higher
+	precedence, i.e. if `--full-index` is specified, full blob
+	names will be shown regardless of `--abbrev`.
+	Non default number of digits can be specified with `--abbrev=<n>`.
 
 -B[<n>][/<m>]::
 --break-rewrites[=[<n>][/<m>]]::
diff --git a/diff.c b/diff.c
index f9709de7b4..20dedfe2a9 100644
--- a/diff.c
+++ b/diff.c
@@ -4319,7 +4319,10 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 	if (one && two && !oideq(&one->oid, &two->oid)) {
 		const unsigned hexsz = the_hash_algo->hexsz;
-		int abbrev = o->flags.full_index ? hexsz : DEFAULT_ABBREV;
+		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
+
+		if (o->flags.full_index)
+			abbrev = hexsz;
 
 		if (o->flags.binary) {
 			mmfile_t mf;
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f6bdfc13fd..5c7b0122b4 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -239,6 +239,9 @@ diff-tree --root -r --abbrev=4 initial
 :noellipses diff-tree --root -r --abbrev=4 initial
 diff-tree -p initial
 diff-tree --root -p initial
+diff-tree --root -p --abbrev=10 initial
+diff-tree --root -p --full-index initial
+diff-tree --root -p --full-index --abbrev=10 initial
 diff-tree --patch-with-stat initial
 diff-tree --root --patch-with-stat initial
 diff-tree --patch-with-raw initial
diff --git a/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial b/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
new file mode 100644
index 0000000000..7518a9044e
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
@@ -0,0 +1,29 @@
+$ git diff-tree --root -p --abbrev=10 initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+diff --git a/dir/sub b/dir/sub
+new file mode 100644
+index 0000000000..35d242ba79
+--- /dev/null
++++ b/dir/sub
+@@ -0,0 +1,2 @@
++A
++B
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000000..01e79c32a8
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,3 @@
++1
++2
++3
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000000..01e79c32a8
+--- /dev/null
++++ b/file2
+@@ -0,0 +1,3 @@
++1
++2
++3
+$
diff --git a/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial b/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
new file mode 100644
index 0000000000..69f913fbe5
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
@@ -0,0 +1,29 @@
+$ git diff-tree --root -p --full-index --abbrev=10 initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+diff --git a/dir/sub b/dir/sub
+new file mode 100644
+index 0000000000000000000000000000000000000000..35d242ba79ae89ac695e26b3d4c27a8e6f028f9e
+--- /dev/null
++++ b/dir/sub
+@@ -0,0 +1,2 @@
++A
++B
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,3 @@
++1
++2
++3
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
+--- /dev/null
++++ b/file2
+@@ -0,0 +1,3 @@
++1
++2
++3
+$
diff --git a/t/t4013/diff.diff-tree_--root_-p_--full-index_initial b/t/t4013/diff.diff-tree_--root_-p_--full-index_initial
new file mode 100644
index 0000000000..1b0b6717fa
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--root_-p_--full-index_initial
@@ -0,0 +1,29 @@
+$ git diff-tree --root -p --full-index initial
+444ac553ac7612cc88969031b02b3767fb8a353a
+diff --git a/dir/sub b/dir/sub
+new file mode 100644
+index 0000000000000000000000000000000000000000..35d242ba79ae89ac695e26b3d4c27a8e6f028f9e
+--- /dev/null
++++ b/dir/sub
+@@ -0,0 +1,2 @@
++A
++B
+diff --git a/file0 b/file0
+new file mode 100644
+index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
+--- /dev/null
++++ b/file0
+@@ -0,0 +1,3 @@
++1
++2
++3
+diff --git a/file2 b/file2
+new file mode 100644
+index 0000000000000000000000000000000000000000..01e79c32a8c99c557f0757da7cb6d65b3414466d
+--- /dev/null
++++ b/file2
+@@ -0,0 +1,3 @@
++1
++2
++3
+$
-- 
2.28.0.143.g760df7782d.dirty

