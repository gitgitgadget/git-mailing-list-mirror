Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE1C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2CF208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWIRu3Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgGaP1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbgGaP1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE63BC06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 184so9613241wmb.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uROyZFHfZL1AuaJO9EBSwQ88aC63JQnbHsrD23bCT6I=;
        b=IWIRu3Rbhh0VWfeBybqAzczbgx1w3RIz63Ndf65xQhF3dQc1Q84AbXjbMm+SedcMFr
         mWuV8OzctOsb0PaPZShVcNIlKGeuYJfHfJQADQ83qHa1NadhgR4rq/wTIhkejpzI8LYz
         2ajySdxVtvWk9dbeXk3YhOEdBPUBcIBhGTVhx3Xrp6T4zGP01V7IF4csh5Uc52o5WeA4
         USIPKpgScU07FHWJ2Pixr9cHuGABZGx0X3aB1xzSNw2c2JYSK8MiLvVL+0hpByTgavKG
         MIlyVUCPQWswPzYUOumL6wyAelbj6B20I5rdUCL4cDp+B3tPuytQVoqkONldfRjUL9AX
         E2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uROyZFHfZL1AuaJO9EBSwQ88aC63JQnbHsrD23bCT6I=;
        b=go/otI/m9gKn36sX4QorDXqmGKpfHonZBY/46etfZEe7xQbEHNVv6ofXtJBXXhh+V4
         j8ABf9BvaMsiv8Ia9Ztn7saE1sOmk/Iesc3GRCUrTzJPwF+VLIaoqQjWRfAOCkyKPsN+
         SG20KJg1rMyIBRmZL8uD5a95TsBS39o+gYGvFOKGotUUtY3UWHaN+uOR8cNqNj8LhppU
         qaBp5wWfpTpib/3PpXX0hybJDsiIE5BrtwOCxT04c61S2wwGtwHfbg9Zvofsm7KI7YfL
         gPmigKjZM9zRK3kDjhM5XI5Ayyea28xrCx5mzPQ2NXqD5rnag1q/i1S1os/PE8ymL09V
         1xcw==
X-Gm-Message-State: AOAM530VLqUM1Wz28G+CoSczwJS8Wnb8mESIhK0usIx0WC6gQmMFeEqg
        1VLOMrD1YCx23ZuYqQCor+zvUDJL
X-Google-Smtp-Source: ABdhPJw8pl4CMCcUBVzDi/BDsWIIgqkMDKHgqg+9cX7nVdxDs269rTt0xOdQstxZfUXPpaFLhCPMvw==
X-Received: by 2002:a1c:62d6:: with SMTP id w205mr4667304wmb.154.1596209256108;
        Fri, 31 Jul 2020 08:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm13661843wmg.25.2020.07.31.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:35 -0700 (PDT)
Message-Id: <70ce4ce49d0bbb8f9964687a511ca22aa0c50050.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:09 +0000
Subject: [PATCH v20 13/21] Add standalone build infrastructure for reftable
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
index 0000000000..d3946a717c
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
index 0000000000..0345015c57
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
index 0000000000..9f91d16208
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
index 0000000000..edb77fdf8e
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

