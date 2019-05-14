Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4181F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfENSsJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45539 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfENSsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:08 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so154936ywa.12
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axdepppcWwepaUXDh1Cn0fOU3ssNWmrVISP9q6cCias=;
        b=CGz1/ttGDix5pQ5AqQXQ/OLcoEfY0BJ+a2C0Gp/84BmVTOQANTII8qqoEQltsmkea7
         IFvD8vrE8jp8v5zZ26N0Kg4uYFUa+vgefO//x2FGarKRJJqnkk1oX9xpbSo2Upy8DcBM
         n9HxcD7Vnd11uvIyWS513juD67/HgQsCwntdqcqjAGW2drC/mgMkn974auhfkAKheYED
         9J03mFgAemK/fzt2JnxC6F+Key9nLxgq4AE7Ta8lHl+N0Y83r12gjLi2mIyd1ZrC/xtY
         KDfisBPaTyRCRPa3SbZkyfgjsuSgKB/fkgi83RthYmvUia4QtqFIAydpLigpYu71/KbR
         QhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axdepppcWwepaUXDh1Cn0fOU3ssNWmrVISP9q6cCias=;
        b=brV2g2cYBSaPEuHc1QRH5CLEB18+2LNdWc84QBvMEqgKTMMXU9bRaK8TTd2eRW7eWT
         GU/n0FmroGq8r9QSLoTIcZTkUA8rifGSiDlSeuz7RTweAaOAFPCI8EjET7o8bwt5c0Fq
         PG4FMyqgZB2FrB4sVkjgsBpDXxXUQlf1fz9JN7vC3mxKkEYyGcSfhEhF5O5Opp9Olo2R
         19bDwTFmmcCzsxUR1b1TWc6oxKGORJTKzA0OnrxJmnV+zZaiPYFzHhBMW0RVsUNyCYxU
         65VPTIGTZCGwOMqeUwnvFrU7Pa1A5noo04SICwBRcRZASUUfavfLgFVCZIrLHFwicslr
         gUwg==
X-Gm-Message-State: APjAAAUCn0ZCULpDgMW9Tu6kVuLY4m64qVG8ksJ2xqfBj/6gP8UDJlhb
        XbIWHjjbWBb2FZK+/qT7ShLOhx8YTqM=
X-Google-Smtp-Source: APXvYqzujqUUrW/JZE+CdAj5iY86RXBe096QF3Av/SKUz4tpQ1Zo5x3K3GgoxcfSFJ23AnQTdMLPsA==
X-Received: by 2002:a81:9ad3:: with SMTP id r202mr17439223ywg.139.1557859686461;
        Tue, 14 May 2019 11:48:06 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:05 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 07/11] multi-pack-index: prepare 'repack' subcommand
Date:   Tue, 14 May 2019 18:47:50 +0000
Message-Id: <20190514184754.3196-8-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
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
index ad10d40512..b1ea1a6aa1 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -6,12 +6,13 @@
 #include "trace2.h"
 
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
@@ -20,6 +21,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_options[] = {
 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
 		  N_("object directory containing set of packfile and pack-index pairs")),
+		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
+		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
 		OPT_END(),
 	};
 
@@ -43,6 +46,11 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	trace2_cmd_mode(argv[0]);
 
+	if (!strcmp(argv[0], "repack"))
+		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
+	if (opts.batch_size)
+		die(_("--batch-size option is only for 'repack' subcommand"));
+
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
@@ -50,5 +58,5 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	if (!strcmp(argv[0], "expire"))
 		return expire_midx_packs(the_repository, opts.object_dir);
 
-	die(_("unrecognized verb: %s"), argv[0]);
+	die(_("unrecognized subcommand: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index 9b0b4c1520..fbed8a8adb 100644
--- a/midx.c
+++ b/midx.c
@@ -1226,3 +1226,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir)
 	string_list_clear(&packs_to_drop, 0);
 	return result;
 }
+
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 505f1431b7..f0ae656b5d 100644
--- a/midx.h
+++ b/midx.h
@@ -51,6 +51,7 @@ int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir);
 int expire_midx_packs(struct repository *r, const char *object_dir);
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 12570fe7ac..133d5b7068 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -398,7 +398,8 @@ test_expect_success 'setup expire tests' '
 		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
 		refs/heads/E
 		EOF
-		git multi-pack-index write
+		git multi-pack-index write &&
+		cp -r .git/objects/pack .git/objects/pack-backup
 	)
 '
 
@@ -432,4 +433,21 @@ test_expect_success 'expire removes unreferenced packs' '
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
2.22.0.rc0

