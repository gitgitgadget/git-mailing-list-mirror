Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BFD1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfDXPOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40134 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbfDXPOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id y49so1967675qta.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyWYfa/VjVaccdyj+N5244gjx8A8lRlicFoJTJE9VxY=;
        b=ivfUZBI4xwgSKlSxC2R+gbmnNtnETnI4wORjE7MAT9O8qtaADzWwa2VYOslwxEZM/m
         5eUUEsWQ5EwJL+Ycp2yOT8YNnt8YYMWHp5gAPTDyL2BcJw1SEYLBj5EACd3MduJFHyDa
         I1T3b0KkL/dc4w7mk1az4JIGIJj5e2zyGoWijuAL7XLzFtK2lc9deNE1MAHxppxQ/PNq
         zXdBQFYqyO0+OV0oBe40QPKUPCMKEsSNZiBzxltSMwPBokTzOdUjKRbRq1vdLyA25g6e
         z5CRxk1+TTBTOcgHmwQJEKNBb7XNyAxx05IE5OewiE9Jy3anxkWrY9NmgIHKGCRwhDof
         CwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyWYfa/VjVaccdyj+N5244gjx8A8lRlicFoJTJE9VxY=;
        b=Yus/OMc6/oxu7g+nQOx0QMpN5Sv7Cia+E3N/Vruvq6aLd3QdugRU+3SRH+P0J6YP+E
         HtY6RyQsbIBKkjgk0Z0Vlv/GagUC1PFOqhElQt7T4jwcPWB1tymVdGNtj6C9vjD2RkKf
         rFrBhaPUMp05aiYZalzIE93knYPaG21P+iED0m5f0w7uBRSU1OSDgOGukyTwpSIWJv8u
         eDNX//j5GiQ2l1Z+PZTR0NzFqDFamaK6PCtBdmxjIQb+mD/ARxm5dZRCf3WohTe/hXPZ
         fYYm2MtpyXnxo7IB21f7fQbEsOahJP+o7DvRjNiFTtHEksYW9T03c8zVYNNiBc5xw5Mi
         3pxQ==
X-Gm-Message-State: APjAAAXTzLkb52I2vhDFHOIjVhDaGK1dyQDUmkapxWSoMtWDGS7d80ft
        +o9FC9g/6fcwmiXcg2Mq+ecWJdMh
X-Google-Smtp-Source: APXvYqy5VbwDly2NZFP6jpoFPF+Td8Mu+4LennR8yKOk4t0z3yRWR7u3W4pw+pyo5KsoNiFjYg50rg==
X-Received: by 2002:ac8:88f:: with SMTP id v15mr27169034qth.382.1556118890903;
        Wed, 24 Apr 2019 08:14:50 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:50 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 07/11] multi-pack-index: prepare 'repack' subcommand
Date:   Wed, 24 Apr 2019 11:14:24 -0400
Message-Id: <20190424151428.170316-8-dstolee@microsoft.com>
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

In an environment where the multi-pack-index is useful, it is due
to many pack-files and an inability to repack the object store
into a single pack-file. However, it is likely that many of these
pack-files are rather small, and could be repacked into a slightly
larger pack-file without too much effort. It may also be important
to ensure the object store is highly available and the repack
operation does not interrupt concurrent git commands.

Introduce a 'repack' subcommand to 'git multi-pack-index' that
takes a '--batch-size' option. The subcommand will inspect the
multi-pack-index for referenced pack-files whose size is smaller
than the batch size, until collecting a list of pack-files whose
sizes sum to larger than the batch size. Then, a new pack-file
will be created containing the objects from those pack-files that
are referenced by the multi-pack-index. The resulting pack is
likely to actually be smaller than the batch size due to
compression and the fact that there may be objects in the pack-
files that have duplicate copies in other pack-files.

The current change introduces the command-line arguments, and we
add a test that ensures we parse these options properly. Since
we specify a small batch size, we will guarantee that future
implementations do not change the list of pack-files.

In addition, we hard-code the modified times of the packs in
the pack directory to ensure the list of packs sorted by modified
time matches the order if sorted by size (ascending). This will
be important in a future test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 17 +++++++++++++++++
 builtin/multi-pack-index.c             | 12 ++++++++++--
 midx.c                                 |  5 +++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            | 20 +++++++++++++++++++-
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 6186c4c936..233b2b7862 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -36,6 +36,23 @@ expire::
 	have no objects referenced by the MIDX. Rewrite the MIDX file
 	afterward to remove all references to these pack-files.
 
+repack::
+	Create a new pack-file containing objects in small pack-files
+	referenced by the multi-pack-index. If the size given by the
+	`--batch-size=<size>` argument is zero, then create a pack
+	containing all objects referenced by the multi-pack-index. For
+	a non-zero batch size, Select the pack-files by examining packs
+	from oldest-to-newest, computing the "expected size" by counting
+	the number of objects in the pack referenced by the
+	multi-pack-index, then divide by the total number of objects in
+	the pack and multiply by the pack size. We select packs with
+	expected size below the batch size until the set of packs have
+	total expected size at least the batch size. If the total size
+	does not reach the batch size, then do nothing. If a new pack-
+	file is created, rewrite the multi-pack-index to reference the
+	new pack-file. A later run of 'git multi-pack-index expire' will
+	delete the pack-files that were part of this batch.
+
 
 EXAMPLES
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 145de3a46c..c66239de33 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,12 +5,13 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
 	NULL
 };
 
 static struct opts_multi_pack_index {
 	const char *object_dir;
+	unsigned long batch_size;
 } opts;
 
 int cmd_multi_pack_index(int argc, const char **argv,
@@ -19,6 +20,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
+		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
+		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
 
@@ -40,6 +43,11 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return 1;
 	}
 
+	if (!strcmp(argv[0], "repack"))
+		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
+	if (opts.batch_size)
+		die(_("--batch-size option is only for 'repack' subcommand"));
+
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
@@ -47,5 +55,5 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!strcmp(argv[0], "expire"))
 		return expire_midx_packs(opts.object_dir);
 
-	die(_("unrecognized verb: %s"), argv[0]);
+	die(_("unrecognized subcommand: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 299e9b2e8f..768a7dff73 100644
--- a/midx.c
+++ b/midx.c
@@ -1112,3 +1112,8 @@ int expire_midx_packs(const char *object_dir)
 	string_list_clear(&packs_to_drop, 0);
 	return result;
 }
+
+int midx_repack(const char *object_dir, size_t batch_size)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index e3a2b740b5..394a21ee96 100644
--- a/midx.h
+++ b/midx.h
@@ -50,6 +50,7 @@ int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(const char *object_dir);
 int expire_midx_packs(const char *object_dir);
+int midx_repack(const char *object_dir, size_t batch_size);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 65e85debec..26ae8b3f62 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -383,7 +383,8 @@ test_expect_success 'setup expire tests' '
 		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
 		refs/heads/E
 		EOF
-		git multi-pack-index write
+		git multi-pack-index write &&
+		cp -r .git/objects/pack .git/objects/pack-backup
 	)
 '
 
@@ -417,4 +418,21 @@ test_expect_success 'expire removes unreferenced packs' '
 	)
 '
 
+test_expect_success 'repack with minimum size does not alter existing packs' '
+	(
+		cd dup &&
+		rm -rf .git/objects/pack &&
+		mv .git/objects/pack-backup .git/objects/pack &&
+		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
+		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
+		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
+		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
+		ls .git/objects/pack >expect &&
+		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
+		git multi-pack-index repack --batch-size=$MINSIZE &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

