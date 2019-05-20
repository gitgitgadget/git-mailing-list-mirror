Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ADC41F462
	for <e@80x24.org>; Mon, 20 May 2019 22:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfETW3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 18:29:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 18:29:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id f204so905177wme.0
        for <git@vger.kernel.org>; Mon, 20 May 2019 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HDE0WbmAxOX4+SV6yXBcO+8F4mExL9ENWZP1DOT7YY=;
        b=tJKTamKFkTwch255o8RjqH7iqZWl4wr5fNhV8TVVQw8CuKRmzBy7UqV7Z6IpIg7i60
         Rai0gDRXabqTc9I/uvRqbzO96ASInf+HhCQN++n9bVHkumfaZsBHMl2uC/CjTkcZ8WEt
         XYjwvavpWLObqc6Om5J0NM1tkp0yBHQlFJ8+Wci51pMvdrybv5ApqsjoPHTE5UGpzWmA
         uuTFc7+LXn8IJ/2B/aRa7VU5vfZsffNQECmCSoo3UG1MESl3bhJWu3ZCZ9TOYXOABzXB
         Yde9tjkbgHEeDsUkLIoD/yHIuYjG6KlTf/7rDpJC6SZOMEiBjkylAD7/SagxecC2efFh
         NdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HDE0WbmAxOX4+SV6yXBcO+8F4mExL9ENWZP1DOT7YY=;
        b=EpbxwQTrsPUJYAkkhuOjeh6eDpfWjQgwaa5WJVWyLWgpsnNXRPuWrSj/3MRRSNp3Wn
         pATKdG8+kQ5rFaDL1tWUbnAnjwtn/+55XkRkKBAKzNp40/uMWnOo7M+D2k2pYpg9XXrZ
         afXfYOrMWvFl9tz8fRmaSaYaFlyV3e9gRdVc8JwsYa6cVV2dujTGhB0NDRZIHHOJ9d5H
         S/VQxdTNWc2RO01WjX0BeDTK7YNd1pl7vHCJhrx8rZBXs8qMJyjcXAmzmCdPa62B16e7
         D/I1n1q/BaeMnQ8bJ0CtEFgu04epbBMlBVRwSFc2+YEEjjMSxvQ55R+M999bfXBlMzST
         cVkA==
X-Gm-Message-State: APjAAAVeYYaLVIJvhiQUpCieiDeBfPt6pyrpCrdCSa+p2bdMMte3JTPJ
        qIwJFuDjGcqWPvd0mLVMr9NsR9qZE7Y=
X-Google-Smtp-Source: APXvYqybyzsfVDOC3amVkhI9t8DUKF970OSR71F209fm31GPOzW6mLS7TAOF+yk2KWIKQ9+LJpMM3w==
X-Received: by 2002:a1c:cb82:: with SMTP id b124mr932051wmg.107.1558391382990;
        Mon, 20 May 2019 15:29:42 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h8sm2010671wmf.5.2019.05.20.15.29.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 15:29:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] hash-object: don't pointlessly zlib compress without -w
Date:   Tue, 21 May 2019 00:29:32 +0200
Message-Id: <20190520222932.22843-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When hash-object hashes something the size of core.bigFileThreshold or
larger (512MB by default) it'll be streamed through
stream_to_pack().

That added in 568508e765 ("bulk-checkin: replace fast-import based
implementation", 2011-10-28) would compress the file with zlib, but
was oblivious as to whether the content would actually be written out
to disk, which isn't the case unless hash-object is called with the
"-w" option.

Hashing is much slower if we need to compress the content, so let's
check if the HASH_WRITE_OBJECT flag has been given.

An accompanying perf test shows how much this improves things. With
CFLAGS=-O3 and OPENSSL_SHA1=Y the relevant change is (manually
reformatted to avoid long lines):

    1007.6: 'git hash-object <file>' with threshold=32M
        -> 1.57(1.55+0.01)   0.09(0.09+0.00) -94.3%
    1007.7: 'git hash-object --stdin < <file>' with threshold=32M
        -> 1.57(1.57+0.00)   0.09(0.07+0.01) -94.3%
    1007.8: 'echo <file> | git hash-object --stdin-paths' threshold=32M
        -> 1.59(1.56+0.00)   0.09(0.08+0.00) -94.3%

The same tests using "-w" still take that long, since those will need
to zlib compress the relevant object. With the sha1collisiondetection
library (our default) there's less of a difference since the hashing
itself is slower, or respectively:

    1.71(1.65+0.01)   0.19(0.18+0.01) -88.9%
    1.70(1.66+0.02)   0.19(0.19+0.00) -88.8%
    1.69(1.66+0.00)   0.19(0.18+0.00) -88.8%

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bulk-checkin.c              |  3 ++-
 t/perf/p1007-hash-object.sh | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p1007-hash-object.sh

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 39ee7d6107..a26126ee76 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -105,8 +105,9 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 	int status = Z_OK;
 	int write_object = (flags & HASH_WRITE_OBJECT);
 	off_t offset = 0;
+	int level = write_object ? pack_compression_level : Z_NO_COMPRESSION;
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, level);
 
 	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
 	s.next_out = obuf + hdrlen;
diff --git a/t/perf/p1007-hash-object.sh b/t/perf/p1007-hash-object.sh
new file mode 100755
index 0000000000..8df6dc59a5
--- /dev/null
+++ b/t/perf/p1007-hash-object.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+test_description="Tests performance of hash-object"
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+test_lazy_prereq SHA1SUM_AND_SANE_DD_AND_URANDOM '
+	>empty &&
+	sha1sum empty >empty.sha1sum &&
+	grep -q -w da39a3ee5e6b4b0d3255bfef95601890afd80709 empty.sha1sum &&
+	dd if=/dev/urandom of=random.test bs=1024 count=1 &&
+	stat -c %s random.test >random.size &&
+	grep -q -x 1024 random.size
+'
+
+if test_have_prereq !SHA1SUM_AND_SANE_DD_AND_URANDOM
+then
+	skip_all='failed prereq check for sha1sum/dd/stat'
+	test_perf 'dummy p0013 test (skipped all tests)' 'true'
+	test_done
+fi
+
+test_expect_success 'setup 64MB file.random file' '
+	dd if=/dev/urandom of=file.random count=$((64*1024)) bs=1024
+'
+
+test_perf 'sha1sum(1) on file.random (for comparison)' '
+	sha1sum file.random
+'
+
+for threshold in 32M 64M
+do
+	for write in '' ' -w'
+	do
+		for literally in ' --literally -t commit' ''
+		do
+			test_perf "'git hash-object$write$literally <file>' with threshold=$threshold" "
+				git -c core.bigFileThreshold=$threshold hash-object$write$literally file.random
+			"
+
+			test_perf "'git hash-object$write$literally --stdin < <file>' with threshold=$threshold" "
+				git -c core.bigFileThreshold=$threshold hash-object$write$literally --stdin <file.random
+			"
+
+			test_perf "'echo <file> | git hash-object$write$literally --stdin-paths' threshold=$threshold" "
+				echo file.random | git -c core.bigFileThreshold=$threshold hash-object$write$literally --stdin-paths
+			"
+		done
+	done
+done
+
+test_done
-- 
2.21.0.1020.gf2820cf01a

