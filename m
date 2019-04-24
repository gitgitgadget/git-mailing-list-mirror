Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73281F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfDXPOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37613 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfDXPOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id z16so20680776qtn.4
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6H+N929r8R60/wZq6VTPfiFZ5jBhmCGMJNLiY+0rvx0=;
        b=Y2yRmwICC08rFGnRGI082ysJbPvNaQ/qbBpihWLzlxvDJabM2LfZO4SonRmXlRQR7P
         TJPTLVi5PfJe1qUyVerP0a3FUX50HmD5k0OTh+RpFEmSO+hpNL5KT7a8Jb+1NlWQTAXt
         wV8SthO4VSyXANEaHpHBNndSfrAmE5F+BHpETVt5n/Ygdyfry5azmgN7r+7daD8ZTLm3
         ocy8zmQH7K/KpdVjCvkC4lM6pKxyA8Qv7e3zATiW348+IegJiNnRf7HjxwcEJ8GdDqwj
         Lv0Cov298DLmzA9AQpvwYY86PgMJkZRTO/322iiO9z/r6R36wGT4pAJIVsSykcqTQ5tP
         sd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6H+N929r8R60/wZq6VTPfiFZ5jBhmCGMJNLiY+0rvx0=;
        b=hw/CNjqNAHFXwAefbvQUlAzcw+LSVaN7du3Gqs3UlxOnb0yidtkhIoSYUWFHUYSmyW
         BWSLRx453irXZElW/ZxCynzn/N9KtgSMj/bBEecWoHh2mG7o9i5vCiyJT+nByMl/OTt1
         QrKHVHejqXx5OJPYnxQRKXEQ91hg2wtmByUr79tTEr1WyGNkpM86fUIFCw9g71mresL2
         FJhNoZzDbT+KrEGanEoimRCppXFB83eJEBKvOsABl0iBAg3pFTAdI7TmBN1HkppsGrBP
         Zt5cQ5n3Ap4EjASim4syRIRb85CGFXD7izwSKafZNgPxfpCo9JM0NKn+j+nh4NieS44U
         Wj3A==
X-Gm-Message-State: APjAAAXB+yFTr1p4Auu/4sFCRUeYcoTCaCErt2ys7rL/uDyp7DQhbm8F
        +IFF0+SPRarQdZwlXzGog+cF+S00
X-Google-Smtp-Source: APXvYqx7WgDbqMcYY/J76bKcOjIaITsj2NKaBtRiCJUy2hWTngJqVvHyxACWAa38kVoEf2CBSczB0g==
X-Received: by 2002:ac8:740f:: with SMTP id p15mr20311369qtq.244.1556118886437;
        Wed, 24 Apr 2019 08:14:46 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:46 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 03/11] multi-pack-index: prepare for 'expire' subcommand
Date:   Wed, 24 Apr 2019 11:14:20 -0400
Message-Id: <20190424151428.170316-4-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index tracks objects in a collection of pack-files.
Only one copy of each object is indexed, using the modified time
of the pack-files to determine tie-breakers. It is possible to
have a pack-file with no referenced objects because all objects
have a duplicate in a newer pack-file.

Introduce a new 'expire' subcommand to the multi-pack-index builtin.
This subcommand will delete these unused pack-files and rewrite the
multi-pack-index to no longer refer to those files. More details
about the specifics will follow as the method is implemented.

Add a test that verifies the 'expire' subcommand is correctly wired,
but will still be valid when the verb is implemented. Specifically,
create a set of packs that should all have referenced objects and
should not be removed during an 'expire' operation. The packs are
created carefully to ensure they have a specific order when sorted
by size. This will be important in a later test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt |  5 +++
 builtin/multi-pack-index.c             |  4 ++-
 midx.c                                 |  5 +++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 49 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 1af406aca2..6186c4c936 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -31,6 +31,11 @@ write::
 verify::
 	Verify the contents of the MIDX file.
 
+expire::
+	Delete the pack-files that are tracked 	by the MIDX file, but
+	have no objects referenced by the MIDX. Rewrite the MIDX file
+	afterward to remove all references to these pack-files.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index fca70f8e4f..145de3a46c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
 	NULL
 };
 
@@ -44,6 +44,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(opts.object_dir);
+	if (!strcmp(argv[0], "expire"))
+		return expire_midx_packs(opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 730ff84dff..bb825ef816 100644
--- a/midx.c
+++ b/midx.c
@@ -1025,3 +1025,8 @@ int verify_midx_file(const char *object_dir)
 
 	return verify_midx_error;
 }
+
+int expire_midx_packs(const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 774f652530..e3a2b740b5 100644
--- a/midx.h
+++ b/midx.h
@@ -49,6 +49,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
+int expire_midx_packs(const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 70926b5bc0..a8528f7da0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -348,4 +348,53 @@ test_expect_success 'verify incorrect 64-bit offset' '
 		"incorrect object offset"
 '
 
+test_expect_success 'setup expire tests' '
+	mkdir dup &&
+	(
+		cd dup &&
+		git init &&
+		test-tool genrandom "data" 4096 >large_file.txt &&
+		git update-index --add large_file.txt &&
+		for i in $(test_seq 1 20)
+		do
+			test_commit $i
+		done &&
+		git branch A HEAD &&
+		git branch B HEAD~8 &&
+		git branch C HEAD~13 &&
+		git branch D HEAD~16 &&
+		git branch E HEAD~18 &&
+		git pack-objects --revs .git/objects/pack/pack-A <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-B <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-C <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-D <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index write
+	)
+'
+
+test_expect_success 'expire does not remove any packs' '
+	(
+		cd dup &&
+		ls .git/objects/pack >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

