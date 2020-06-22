Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BCFC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1F206E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMBM3wdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgFVVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgFVVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34851C061795
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so1062734wmh.4
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QqTHYCZp4B4SL99p8EPYIz4NiEXJaC5A1EVjDBkZzSU=;
        b=DMBM3wdvFHLj342jtozYyOumBld7msjrPnD5nCDcx7M6Hbyaif8sJQjqGUwj4FjUkr
         hJtASNb7E28tu4WlzAufsC8UIMX1lADQYocQlVqteXgdek7CEZAEov9LzIxOQxbcHjGN
         /Eur2w1bAn8/oAnvFHCAVVZVgYXTN8y07yybe1/yXXr+zkTrNO1tCpkrL3EFh3lpYW9Y
         bhMAHYD4G50/5DzL0HdCKYoNCpufaDJ92lKv37HOF3bzsX/tSbGE9DPbDhAtGaRwpwkm
         wr3bfSv6M6J90VPqh+UqoxLlLBCUflZZb5LyeHjj0P6dtcKXcJquKecRjJrx63CNb2hs
         bOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QqTHYCZp4B4SL99p8EPYIz4NiEXJaC5A1EVjDBkZzSU=;
        b=Scwqtt8OXeHRs6R/hhUt7Ox15ChCJswUtX+g/NSRgAt+/ybWeUCihdEHtpKXK/S2Ka
         irNRuSSn2RJZtDaqHkUzbzt4OczqvpWdmcTe0/3cii9DdnSh6e89scenJE3UIsQ9frxb
         GR/vcjLNEsulP3QUSzzmxYR5MgejEZqvdBQqS59qhDh6kDzh0BnASGbWpP5kjoa9cJCx
         1ZBPRe7WhoAxxK+Mn8XU9Dc68xjr+wXNl0kIuBe3eFPJjFb+dauRY+TFMvhPTyEz9fKw
         pMRFJvFNH3vQJu/t/jhW7RaJyvOR5PWBS/WSDsv6svHdAcSfWeuCmNWVur1KJceP/hfQ
         JkLw==
X-Gm-Message-State: AOAM530TEZkKoMZtIqqzZ7wYxKAJTjSl4ljAOy9FTbEc/4UfFseXt7nX
        OCVA55FDifjjZLim6v+CIiuLSFT3
X-Google-Smtp-Source: ABdhPJyC9upKBlpi/gHaHyaidNgOJXWe6ftyfm88AW9B0ju/E8kwI7Q9vxZzHSx9CLm47n27ufzhRw==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr22079225wmb.168.1592862934465;
        Mon, 22 Jun 2020 14:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm1052767wmj.14.2020.06.22.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:33 -0700 (PDT)
Message-Id: <c92b8d12ec653cd0e3e07ef0267effc418f80ab9.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:13 +0000
Subject: [PATCH v18 12/19] Add standalone build infrastructure for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable library is integrates with Git, so it become a first class
supported storage mechanism, but is sufficiently complex that other
projects (e.g. libgit2) may want to consume the same source code.

To make this possible, the library also compiles completely standalone, which is
demonstrated with the Bazel BUILD/WORKSPACE files that this commit adds.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/BUILD      | 203 ++++++++++++++++++++++++++++++++++++++++++++
 reftable/README.md  |  33 +++++++
 reftable/WORKSPACE  |  14 +++
 reftable/zlib.BUILD |  36 ++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 reftable/BUILD
 create mode 100644 reftable/README.md
 create mode 100644 reftable/WORKSPACE
 create mode 100644 reftable/zlib.BUILD

diff --git a/reftable/BUILD b/reftable/BUILD
new file mode 100644
index 00000000000..d3946a717c0
--- /dev/null
+++ b/reftable/BUILD
@@ -0,0 +1,203 @@
+# Mirror core-git COPTS so reftable compiles without warning in CGit.
+GIT_COPTS = [
+    "-DREFTABLE_STANDALONE",
+    "-Wall",
+    "-Werror",
+    "-Wdeclaration-after-statement",
+    "-Wstrict-prototypes",
+    "-Wformat-security",
+    "-Wno-format-zero-length",
+    "-Wold-style-definition",
+    "-Woverflow",
+    "-Wpointer-arith",
+    "-Wstrict-prototypes",
+    "-Wunused",
+    "-Wvla",
+    "-Wextra",
+    "-Wmissing-prototypes",
+    "-Wno-empty-body",
+    "-Wno-missing-field-initializers",
+    "-Wno-sign-compare",
+    "-Werror=strict-aliasing",
+    "-Wno-unused-parameter",
+]
+
+cc_library(
+    name = "reftable",
+    srcs = [
+        "basics.c",
+        "block.c",
+        "compat.c",
+        "file.c",
+        "iter.c",
+        "merged.c",
+        "pq.c",
+        "reader.c",
+        "record.c",
+        "refname.c",
+        "reftable.c",
+        "strbuf.c",
+        "stack.c",
+        "tree.c",
+        "writer.c",
+        "zlib-compat.c",
+        "basics.h",
+        "block.h",
+        "compat.h",
+        "constants.h",
+        "iter.h",
+        "merged.h",
+        "pq.h",
+        "reader.h",
+        "refname.h",
+        "record.h",
+        "strbuf.h",
+        "stack.h",
+        "system.h",
+        "tree.h",
+        "writer.h",
+    ],
+    hdrs = [
+        "reftable.h",
+    ],
+    includes = [
+        "include",
+    ],
+    copts = [
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+    deps = ["@zlib"],
+    visibility = ["//visibility:public"]
+)
+
+cc_library(
+    name = "testlib",
+    srcs = [
+        "test_framework.c",
+        "dump.c",
+	"test_framework.h",
+    ],
+    hdrs = [
+            "reftable-tests.h",
+    ],
+    copts = GIT_COPTS,
+    deps = [":reftable"],
+    visibility = ["//visibility:public"]
+)
+
+cc_test(
+    name = "record_test",
+    srcs = ["record_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Drecord_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "reftable_test",
+    srcs = ["reftable_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Dreftable_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "strbuf_test",
+    srcs = ["strbuf_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ] ,
+    copts = [
+        "-Dstrbuf_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "stack_test",
+    srcs = ["stack_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Dstack_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "tree_test",
+    srcs = ["tree_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Dtree_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "block_test",
+    srcs = ["block_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Dblock_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "refname_test",
+    srcs = ["refname_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Drefname_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+cc_test(
+    name = "merged_test",
+    srcs = ["merged_test.c"],
+    deps = [
+        ":reftable",
+        ":testlib",
+    ],
+    copts = [
+        "-Dmerged_test_main=main",
+        "-fvisibility=protected",
+    ] + GIT_COPTS,
+)
+
+[sh_test(
+    name = "%s_valgrind_test" % t,
+    srcs = [ "valgrind_test.sh" ],
+    args = [ t ],
+    data = [ t ])
+ for t in ["record_test",
+           "merged_test",
+           "refname_test",
+           "tree_test",
+           "block_test",
+           "strbuf_test",
+           "stack_test"]]
diff --git a/reftable/README.md b/reftable/README.md
new file mode 100644
index 00000000000..0345015c575
--- /dev/null
+++ b/reftable/README.md
@@ -0,0 +1,33 @@
+This directory contains an implementation of the reftable library.
+
+The library is integrated into the git-core project, but can also be built
+standalone, by compiling with -DREFTABLE_STANDALONE. The standalone build is
+exercised by the accompanying BUILD/WORKSPACE files, and can be run as
+
+  bazel test :all
+
+It includes a fragment of the zlib library to provide uncompress2(), which is a
+recent addition to the API. zlib is licensed as follows:
+
+```
+ (C) 1995-2017 Jean-loup Gailly and Mark Adler
+
+  This software is provided 'as-is', without any express or implied
+  warranty.  In no event will the authors be held liable for any damages
+  arising from the use of this software.
+
+  Permission is granted to anyone to use this software for any purpose,
+  including commercial applications, and to alter it and redistribute it
+  freely, subject to the following restrictions:
+
+  1. The origin of this software must not be misrepresented; you must not
+     claim that you wrote the original software. If you use this software
+     in a product, an acknowledgment in the product documentation would be
+     appreciated but is not required.
+  2. Altered source versions must be plainly marked as such, and must not be
+     misrepresented as being the original software.
+  3. This notice may not be removed or altered from any source distribution.
+
+  Jean-loup Gailly        Mark Adler
+  jloup@gzip.org          madler@alumni.caltech.edu
+```
diff --git a/reftable/WORKSPACE b/reftable/WORKSPACE
new file mode 100644
index 00000000000..9f91d16208a
--- /dev/null
+++ b/reftable/WORKSPACE
@@ -0,0 +1,14 @@
+workspace(name = "reftable")
+
+load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
+
+http_archive(
+    name = "zlib",
+    build_file = "@//:zlib.BUILD",
+    sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
+    strip_prefix = "zlib-1.2.11",
+    urls = [
+        "https://mirror.bazel.build/zlib.net/zlib-1.2.11.tar.gz",
+        "https://zlib.net/zlib-1.2.11.tar.gz",
+    ],
+)
diff --git a/reftable/zlib.BUILD b/reftable/zlib.BUILD
new file mode 100644
index 00000000000..edb77fdf8ee
--- /dev/null
+++ b/reftable/zlib.BUILD
@@ -0,0 +1,36 @@
+package(default_visibility = ["//visibility:public"])
+
+licenses(["notice"])  # BSD/MIT-like license (for zlib)
+
+cc_library(
+    name = "zlib",
+    srcs = [
+        "adler32.c",
+        "compress.c",
+        "crc32.c",
+        "crc32.h",
+        "deflate.c",
+        "deflate.h",
+        "gzclose.c",
+        "gzguts.h",
+        "gzlib.c",
+        "gzread.c",
+        "gzwrite.c",
+        "infback.c",
+        "inffast.c",
+        "inffast.h",
+        "inffixed.h",
+        "inflate.c",
+        "inflate.h",
+        "inftrees.c",
+        "inftrees.h",
+        "trees.c",
+        "trees.h",
+        "uncompr.c",
+        "zconf.h",
+        "zutil.c",
+        "zutil.h",
+    ],
+    hdrs = ["zlib.h"],
+    includes = ["."],
+)
-- 
gitgitgadget

