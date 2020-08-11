Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA1C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7142075D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVn38Xe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgHKLuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgHKLuH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 07:50:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B85C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so6713460plk.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9XoaAsvPeDnY5GdAcnbsvK5W3qwFpBoNjMfO85QUic=;
        b=OVn38Xe7+quFHkjxVhAogE8z8g3PlIL72oJxS1FGGxA1WygOP2XYbxOLc/94LfE1SH
         teTGWmVA6yooBiYkeXdjO2OS7dVsr4YHL6xlgyPN7Xye44MEzAMhKFPjrdTLA8bUe9Ti
         duV5M0HULLdRHXNeNtNkxrPJEKuYTkZYxDTv4Bor2d8X4DjBg5884mGOWBFT9G8tz9q6
         fp45PL6VclZGzEcGA+PRMhzWMiKT5IUXswnGEBjyMPpM9lg//2QRD/X1K03lkP5RG+Vz
         hl6x+OTB57FzW2jZscam+4eGRjswdmCgBLoQXKS5EgV5pToM3Fn7z4Xc+Teq2xOSj8dj
         Va4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9XoaAsvPeDnY5GdAcnbsvK5W3qwFpBoNjMfO85QUic=;
        b=W8FmVuRYlwhADCQGW0aaY4UTsohuqBTBVFQaS4O1e21LqUzD+1DRGhGAAFS02rMstX
         nFclFhYzbF5rLQL70XlFbEdMPHhfknHHKvmNGbPXTr2BC9K+dlE6CU+cu2qCY0quRwHK
         fmTEXaIMntncU0N+NW1VwBSeWJNnDf6DxaCPZW3mpRnSgPEz5wcoZMxvhM6M+jFIXieB
         q0P70EmcvvlRI5F9mR34x2nc80J8WnZmGntD69O8jWpp19Dh9mD7CD0SzNBTtSU3UCQE
         ZGe1QoLTGubHx6kZn/NEuK+pOCHrrkzZhS5UiJMY9oiS/jr9Zz8UBdKGLz07ioN7SM/B
         /eIg==
X-Gm-Message-State: AOAM533yu5ODZgQCUujvompv3EOlnjKSQxCdduGTYWz6yllG0EjbxrdY
        QPiDok77R8dpE5ISsNUE76GbbAnI
X-Google-Smtp-Source: ABdhPJzgNfN1eXZZAjdfX1owGU0X1sENB+rYUeC44iqbAdnJbv60jROFh9v6LHEveeWGDxr3AkIVOQ==
X-Received: by 2002:a17:90a:c593:: with SMTP id l19mr701426pjt.20.1597146606474;
        Tue, 11 Aug 2020 04:50:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id q73sm3019220pjc.11.2020.08.11.04.50.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:50:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/2] diff: index-line: respect --abbrev in object's name
Date:   Tue, 11 Aug 2020 18:49:57 +0700
Message-Id: <12acf1fe5db55199102d27eeb93524a96f914a05.1597146478.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1597146478.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1597146478.git.congdanhqx@gmail.com>
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

Although, that consistent is documented, it doesn't stop users from
trying to use `--abbrev' with the hope of customising diff-patch's
objects' name's abbreviation.

Let's resolve that inconsistency.

To preserve backward compatibility with old script that specify both
`--full-index' and `--abbrev', always shows full object id
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
index 7987d72b02..c11efa7865 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -441,10 +441,11 @@ endif::git-format-patch[]
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show only a partial prefix.  This is
-	independent of the `--full-index` option above, which controls
-	the diff-patch output format.  Non default number of
-	digits can be specified with `--abbrev=<n>`.
+	lines, show only a partial prefix.
+	In diff-patch output format, `--full-index` takes higher
+	precedent, i.e. if `--full-index` is specified, full blob
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
index 3f60f7d96c..e6eb4dd4c7 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -221,6 +221,9 @@ diff-tree --root -r --abbrev=4 initial
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
2.28.0.215.g32ffa52ee0

