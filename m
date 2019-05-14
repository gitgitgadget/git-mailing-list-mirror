Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560261F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfENSsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:06 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34878 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id k202so47808ybk.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4s0Z+0C5dUqbeM2oTRwfFmJd/GWgOCJKYiUE6/Z08Rk=;
        b=idKUOjPKk2hOB5lAbzCwSJIDAf8TxPN/6USVMbjl0oGSPYS609pLSCzddtOs5pMzQe
         ufugn+GZIEAgfxlPqlohaOOksQ9402fBjzgpJgAZX2e2lFMkiBIplCGVloR9JopvgO7Z
         dC6T2S9nweN9kHz7my42FxN+rlayez+5IbbZKZc8PYh19fAOx+AT/asDWO1jeCynwcJB
         9GDJdnUZ4CeRZCKvixyzIIO5hg9IGXjUtiIep4kid36HjaFpkPeVq5fKqz3rhG5Ud83F
         u1u6LG/UdNacqlMuavOXMLs4WuakDCSi/A+KqY6spm3p9UzCRpnx0ez4UlU+acZjiNbq
         nrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4s0Z+0C5dUqbeM2oTRwfFmJd/GWgOCJKYiUE6/Z08Rk=;
        b=j6a0amOPFkcN5lbqWo87Tp59IomMhCFEQAIwCR+ciCwTWJVOvJgb0qMInaXL3UnOOb
         40YsT38IbgkJurGtCZvRZROHRfQPI96A+/BOc/2Nx6cFNSyd0R8av/Rbrq1wU3Cf8OZ1
         rynyvDHDxa+oJwNI4q7W4JceT4W25AVJd+TYiVWfheJrDwpL9kZJ6nm61RLt/I96dMOK
         de+xAf7qaC8DjAYbh3ylUXb4QjaLZvkdmkTw2bhccwEDOujcXKsmNgsiutKoLhD5GLrq
         4FT+CAabSFU3zKdJJ59m/qhB0Y2Qwi1kPLedxjfwgHwoeSAHpET70CqzqU/Rsd9/lGAw
         /z8Q==
X-Gm-Message-State: APjAAAWJLSxu7xJ2mIXUhODjVtz368eINJe+DZk/LoNhy97lesLagZ79
        mRmCBamBfnKy99G/Ts6g1cFeOUo9iuk=
X-Google-Smtp-Source: APXvYqyVZjp1BcS9Edntofvk/mqjsTlPGSMgwlp3+We5QJv1AfUkJIVatqqZLggrQ253Igmcxvrkyw==
X-Received: by 2002:a5b:74c:: with SMTP id s12mr18300994ybq.436.1557859681704;
        Tue, 14 May 2019 11:48:01 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:01 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 03/11] multi-pack-index: prepare for 'expire' subcommand
Date:   Tue, 14 May 2019 18:47:46 +0000
Message-Id: <20190514184754.3196-4-dstolee@microsoft.com>
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
index 72dfd3dadc..ad10d40512 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -6,7 +6,7 @@
 #include "trace2.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
 	NULL
 };
 
@@ -47,6 +47,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 		return write_midx_file(opts.object_dir);
 	if (!strcmp(argv[0], "verify"))
 		return verify_midx_file(the_repository, opts.object_dir);
+	if (!strcmp(argv[0], "expire"))
+		return expire_midx_packs(the_repository, opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index e7e1fe4d65..3b7da1a360 100644
--- a/midx.c
+++ b/midx.c
@@ -1140,3 +1140,8 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 
 	return verify_midx_error;
 }
+
+int expire_midx_packs(struct repository *r, const char *object_dir)
+{
+	return 0;
+}
diff --git a/midx.h b/midx.h
index 3eb29731f2..505f1431b7 100644
--- a/midx.h
+++ b/midx.h
@@ -50,6 +50,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 int write_midx_file(const char *object_dir);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir);
+int expire_midx_packs(struct repository *r, const char *object_dir);
 
 void close_midx(struct multi_pack_index *m);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1ebf19ec3c..1b2d32f475 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -363,4 +363,53 @@ test_expect_success 'verify incorrect 64-bit offset' '
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
2.22.0.rc0

