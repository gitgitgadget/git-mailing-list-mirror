Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB513C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392272AbiDUURl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392262AbiDUURf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:17:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA463C8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c10so8200159wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rykYwV184Lwzck3W+SVmZMd3E4Ln/SjrwPXsvi9smg=;
        b=co2tJFCY1EmKbM3Tc1n0T4oJjXI7VyGBfIt5WzN4fVyfS/9KLFTWifiMkAFDm+1IXb
         sFKeiQYV67WqtG8JA9T0W98wuTZKY2YU1CkxbCCl+Mhr4pobSPhfknHx/EwO4dp+6Fbv
         p2T8uL8dYTpvQP32BKG5GQogGh890kEzWIjdH9/xdCHseLDE3zl98LPIo1z8DmwqK/WO
         BD0hvGSTdI1JFeQg9a89mgehnwpojIqute8EwCBPvI3ZMfUNEcTC+GECAZjR+KccS5OP
         h6pMkHFr6Z4AxSHntppcSpCmt+ytLMNyfbwDiDhd9mWVJuGjAU3BlvybdN80YuhnmTmu
         7DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rykYwV184Lwzck3W+SVmZMd3E4Ln/SjrwPXsvi9smg=;
        b=iDs3pVJr42RPmKkNkvLPVBYNbj47hxaFH9SB8kmSoyMBN+z7VA5kXsqUW1BzzCOhY4
         5ZpKtJdzOjWBxP+AeTzlCKd2aWeZNCQiWuyXbyvyVbyEfaBGis4Lfh4vAhjkjlt9cjb3
         JHio+LMbCaJPWCfW4D5T7wNS2NdK9r6N6iE3AjJjN9cCoUgCxXLO7FS9rzqBfYDhsc5F
         eoA+UToNdUm2GIHkE6qopPiFbrr1iNDWhHmBlafCgQBlWda30bUFP8te4T+OPvi/1rdQ
         5D/5zx8PfxwCMlb00OFW31v88+euSGmL/90afIBJzsFeNjT+iNukpj6vrNatKrc+/LYB
         nWbQ==
X-Gm-Message-State: AOAM531In5xYUjxDFDr5tRtGG2k6k878ZqAKxClUWcFgsjsJoMOtpFNr
        kHw06aYAzRHP3SlAj4cjX2fQV/1Acb/80Q==
X-Google-Smtp-Source: ABdhPJwaagArTRJGfqgMYcF+MK6qb4w3+fhLn+8xn/GGvu1iVMQGPZ/GkZVa7bhWn+wDBL6g5AqJuw==
X-Received: by 2002:a5d:6d50:0:b0:207:c10e:911 with SMTP id k16-20020a5d6d50000000b00207c10e0911mr1002383wri.137.1650572083122;
        Thu, 21 Apr 2022 13:14:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm1309wme.1.2022.04.21.13.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:14:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] object-file: fix a unpack_loose_header() regression in 3b6a8db3b03
Date:   Thu, 21 Apr 2022 22:14:37 +0200
Message-Id: <patch-4.4-7698c0f11a8-20220421T200733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.gd068ac2c328
In-Reply-To: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220421T200733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my 3b6a8db3b03 (object-file.c: use "enum" return
type for unpack_loose_header(), 2021-10-01) revealed both by running
the test suite with --valgrind, and with the amended "git fsck" test.

In practice this regression in v2.34.0 caused us to claim that we
couldn't parse the header, as opposed to not being able to unpack
it. Before the change in the C code the test_cmp added here would emit:

	-error: unable to unpack header of ./objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
	+error: unable to parse header of ./objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391

I.e. we'd proceed to call parse_loose_header() on the uninitialized
"hdr" value, and it would have been very unlikely for that
uninitialized memory to be a valid git object.

The other callers of unpack_loose_header() were already checking the
enum values exhaustively. See 3b6a8db3b03 and
5848fb11acd (object-file.c: return ULHR_TOO_LONG on "header too long",
2021-10-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c       |  8 ++++++--
 t/t1006-cat-file.sh | 10 ++++++++--
 t/t1450-fsck.sh     | 13 +++++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5ffbf3d4fd4..b5d1d12b68a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2623,8 +2623,12 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				NULL) < 0) {
+	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
+				    NULL)) {
+	case ULHR_OK:
+		break;
+	case ULHR_BAD:
+	case ULHR_TOO_LONG:
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1b852076944..dadf3b14583 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -681,7 +681,7 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 
 		# Setup and create the empty blob and its path
 		empty_path=$(git rev-parse --git-path objects/$(test_oid_to_path "$EMPTY_BLOB")) &&
-		git hash-object -w --stdin </dev/null &&
+		empty_blob=$(git hash-object -w --stdin </dev/null) &&
 
 		# Create another blob and its path
 		echo other >other.blob &&
@@ -722,7 +722,13 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 		# content out as-is. Try to make it zlib-invalid.
 		mv -f other.blob "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "^error: inflate: data stream error (" err.fsck
+		cat >expect <<-EOF &&
+		error: inflate: data stream error (incorrect header check)
+		error: unable to unpack header of ./$empty_path
+		error: $empty_blob: object corrupt or missing: ./$empty_path
+		EOF
+		grep "^error: " err.fsck >actual &&
+		test_cmp expect actual
 	)
 '
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index de50c0ea018..ab7f31f1dcd 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -774,10 +774,19 @@ test_expect_success 'fsck finds problems in duplicate loose objects' '
 		# no "-d" here, so we end up with duplicates
 		git repack &&
 		# now corrupt the loose copy
-		file=$(sha1_file "$(git rev-parse HEAD)") &&
+		oid="$(git rev-parse HEAD)" &&
+		file=$(sha1_file "$oid") &&
 		rm "$file" &&
 		echo broken >"$file" &&
-		test_must_fail git fsck
+		test_must_fail git fsck 2>err &&
+
+		cat >expect <<-EOF &&
+		error: inflate: data stream error (incorrect header check)
+		error: unable to unpack header of $file
+		error: $oid: object corrupt or missing: $file
+		EOF
+		grep "^error: " err >actual &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.36.0.879.gd068ac2c328

