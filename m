Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF26C433E4
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A7C207DA
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXgr0NPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgHTMgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgHTMfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:35:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD12C061387
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so926556pjr.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlAqBmne8Jjp6X3nqZAajMHeqmcJWw51N8GdwtqaRrA=;
        b=MXgr0NPpvwwMflsLCJwU3SwMm53M87szm2racSnOqEYqIeUExjsHtu4pkAQLbeSn/b
         F0fnkrncJ4DbMn26dTkmtavSIHcnbzvAlwp/QTQlJFfYDAE5qBzwJ9H6UgZoj4pumNP3
         bNlV0+fIbdHhWCcrliy5CZa6nkdN4TtBrRILu5HD4+RzJJB7uIoc0Yk9QnXVM4DU6mKC
         SIZhMZSjqyVRNcQeWHm32424tcZFuOyT/KmKyRrMweT9323IzEzFVQfAOC2dqWfvBmyh
         nl6mGen7rlPp4Rvf2Iio28sanz5En5YxeWj4cMmfM6NmXMKInS+MrEbT7wz3LngFNfnJ
         /XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlAqBmne8Jjp6X3nqZAajMHeqmcJWw51N8GdwtqaRrA=;
        b=OvOeENJvYPjvzRL8IpVZdjINzxGVkrWyYQ2NfJ4J9aCkNpDoiGk7QYh19ZP1jLd3Cz
         4vsa6CNrVjCpJUiENIBIdvEFH5E5Ui3vRKpquGZhzC/TGlam+UTEaeHLvCLl10dLiLyH
         azRs+9YBcRAIZpU33Zcv2qYh0F9Hnq5ljj9tQTb+j8KHlPabaSD4ghd/itnoljL1aBHC
         u1mS773RaNWQDgvM3BBqEajJrv0RdU73qkIutE/qxgkCbdipjod9xqrFYahGe2z5w3/1
         /KGLhFw8SKGgOjceb4v4rbCXMVDGokNpGOPPWAFy3FZvrct71nXWsV1Pf4ju9Fd2wNq6
         AFEQ==
X-Gm-Message-State: AOAM531dLIYDKjzIzGMDEB7aO1RkP+6A+RYNrTYJyk9M2X3mQKIwc7Ug
        m+ZIz++ChjC2mlLfC6KnUBkdDmSVzTM=
X-Google-Smtp-Source: ABdhPJxo/32kftV8KlHWb7SOnI9RHQKJLxp1XiG5UbpyjAbzdUAr/ib5plra1RddysLzavjXmWTnpg==
X-Received: by 2002:a17:90a:6807:: with SMTP id p7mr2430326pjj.42.1597926949038;
        Thu, 20 Aug 2020 05:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id h5sm3171054pfk.0.2020.08.20.05.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:35:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 2/2] diff: index-line: respect --abbrev in object's name
Date:   Thu, 20 Aug 2020 19:35:35 +0700
Message-Id: <3cec490500ebb7037fe13fd70bbbb43d035a65f5.1597926783.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.143.g760df7782d.dirty
In-Reply-To: <cover.1597926783.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1597926783.git.congdanhqx@gmail.com>
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
index b7af973d9c..1bb897d665 100644
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

