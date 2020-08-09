Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF1C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E487206B2
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn4DbnAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHICTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:19:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B78C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:19:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so3072447pls.9
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPBx10nJqc5PzZE7PBKTZIQLLVy6CTiOZFoYtu8+T78=;
        b=rn4DbnAtK9kTKhh69yzmahuomtYWYK4/WfsFld0Bc4LCGvdolMEtUO7Im3Y1RelUzS
         a9qcyGETU/5Zymxi+SdHCq3KxpnTljjK2+79u2l8V0wVDVa7YCJspYERqw/olyjBDKiJ
         Emc2QdUVZHoDMv5wX3xmta4LrhzNSOTFmNJzD3yyqqS2xDFUc3eO/WOLSrGMrV6YQaPd
         DY2JaQOxn1MC2+vDze45ZRW4K0O24n7HV912qRHbiJLizr1n7fDpIPBP+zbZ0U/TBW2n
         36URApPhnFmFPTQ7UfuTCgRKmm/lsDMhWdAZy3j6d32XgomILIPsKkbtz9fENFvUBJLz
         HTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPBx10nJqc5PzZE7PBKTZIQLLVy6CTiOZFoYtu8+T78=;
        b=j8VF68lRq0sXtD6+WCkCWFxf8VAu6T5qMtlKz2Ce3Ug7tYwTbPGCNu0O9qgoC7Sd3/
         X+/tYPALuqfx3vXYXtjkt92au+XyflPI7AvVk5F0f4IYtEFTGoznrvbny32oYFR3DLVA
         akEHe7vAKt6wqhplZ/BB8I4ejb4iT9tNTUPmBz1JYmC4qUivlf+Ib2IN2Z44fPUm5p+u
         oCRhSZSx1hA706dcqreo0nXAs/1Dt2ABgFdvrdmyPN1wSqdtGVP0uqWsSUDtJGsQ7feB
         D4SJxWXrqXTih81sSvNgeUbs5RXyYzqV9bzZYT5WQfNNl7ZjuyfhU4KCmGg+h9w/pP5l
         x0SQ==
X-Gm-Message-State: AOAM531o5k3pkYLwZhDLGxS584NYp/E+aY84wn8iDdN1OzXrkp1rNLYO
        NoSkhupMnro47AQsw+JbuLpuWL12
X-Google-Smtp-Source: ABdhPJzcf0pX3eu+LbApOfFpir/hEnk8PndHilMGAuFYaNiTvkyKqm/iglsv8uv4J+MXnokg5ap3dA==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr18721408plo.153.1596939574776;
        Sat, 08 Aug 2020 19:19:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id g129sm17631235pfb.33.2020.08.08.19.19.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 19:19:34 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [RFC PATCH 2/2] diff: extend --abbrev support to diff-patch format
Date:   Sun,  9 Aug 2020 09:19:05 +0700
Message-Id: <36c46357e56ce91025c4e447eaf19d485dc997d7.1596887883.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Not sure if this part should go to the commit message or not:

To preserve backward compatibility with old script that specify both
--full-index and --abbrev, always shows full object id if --full-index
is specified.

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
index d24aaa3047..b5dedb0165 100644
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

