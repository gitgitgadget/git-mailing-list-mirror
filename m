Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D8DC43381
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E122AAC
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbhAYXjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbhAYXii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:38 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356ABC06178B
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:42 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t63so1704859qkc.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MAuJ79Y9rIRj65i5nRw+5tVkeKw7TVx76+IkmG27csE=;
        b=yS4PbsnYBDmFHQnd32uKeP01GPpXzJ9jvHAc8r3kHSgg5Iy9cPrXOmxP5zY9er5yeA
         0yZWai8+VnjVH25So5A//HHDAzEz1QRzWFW7xoCgEC8M9HTk3NvmxgUPDaQiAGa2kApY
         Fw8vqPyRKGJu9fLNBl52IC3JHTHRbnDR1PztH6tRAvfT9o8L9m0a8HGViAlEsE8IYzCJ
         H98SFHz3EDATTdc6RErvN5Bv+Bgza+tEK8irXoEPDDUThHhAQW73Choh1ZxGhARe466s
         DafX8ZA3c92TYsVF8h7rcNzsHjhPb7CwbF8Op1O0/LivWTYFoy5xaIyisBRN47owqLbk
         yTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MAuJ79Y9rIRj65i5nRw+5tVkeKw7TVx76+IkmG27csE=;
        b=qZ06UtqJ5hA4MNCa+vbvF1ZCjS5Iaca86keNTNrEj9CMnatE9CT4/f9le1j1+GyGu5
         p2Rq2BdNmC2MtuqQm3xJXctD9NEUIsznllTBf74JbeY243knPd89Sm8HIctuG6mfazJr
         DlL+6v7leycBbSweX6X0TsBieRONNkF1ATC8QpK4cOekBYQoASsUc1ToWnkXrikHMRBH
         U8HeelEg20+aPSuGzO2hk32ThQXqjqdg8cju0rPdw0x+dtKCWumDfv86QmRUuzALkcbF
         Npesj9LMbLIU9zzknX+u0URv/+mr7CrOF4UtXqoCNrBwa0QYQ0zLTgAVUZGpiS4F8nMo
         O90g==
X-Gm-Message-State: AOAM5312fTEHzutVryVNS+F76R5hIAA/fpxLHeSWKoY5sK+4YA2w648n
        w5oHcnrJl0C3+y/eMprmR6+7tc8D9mR2fw==
X-Google-Smtp-Source: ABdhPJziacvbQu+4WoXa75u/qwV5gjQ/zHSAAG3ElovIlIoxQZMXyTfzsewOvtL0ubfG+xCGlBN6CQ==
X-Received: by 2002:ae9:e602:: with SMTP id z2mr3306240qkf.403.1611617861114;
        Mon, 25 Jan 2021 15:37:41 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id y25sm12952602qky.14.2021.01.25.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:40 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, we'll add support for unconditionally enabling the
'pack.writeReverseIndex' setting with a new GIT_TEST_WRITE_REV_INDEX
environment variable.

This causes a little bit of fallout with tests that, for example,
compare the list of files in the pack directory being unprepared to see
.rev files in its output.

Those locations can be cleaned up to look for specific file extensions,
rather than take everything in the pack directory (for instance) and
then grep out unwanted items.

Once the pack.writeReverseIndex option has been thoroughly
tested, we will default it to 'true', removing GIT_TEST_WRITE_REV_INDEX,
and making it possible to revert this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh |  5 +++--
 t/t5325-reverse-index.sh    |  4 ++++
 t/t5604-clone-reference.sh  |  2 +-
 t/t5702-protocol-v2.sh      | 12 ++++++++----
 t/t6500-gc.sh               |  6 +++---
 t/t9300-fast-import.sh      |  5 ++++-
 6 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a9..2fc3aadbd1 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -710,8 +710,9 @@ test_expect_success 'expire respects .keep files' '
 		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
 		touch $PACKA.keep &&
 		git multi-pack-index expire &&
-		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
-		test_line_count = 3 a-pack-files &&
+		test_path_is_file $PACKA.idx &&
+		test_path_is_file $PACKA.keep &&
+		test_path_is_file $PACKA.pack &&
 		test-tool read-midx .git/objects | grep idx >midx-list &&
 		test_line_count = 2 midx-list
 	)
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 87040263b7..be452bb343 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -3,6 +3,10 @@
 test_description='on-disk reverse index'
 . ./test-lib.sh
 
+# The below tests want control over the 'pack.writeReverseIndex' setting
+# themselves to assert various combinations of it with other options.
+sane_unset GIT_TEST_WRITE_REV_INDEX
+
 packdir=.git/objects/pack
 
 test_expect_success 'setup' '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 5d682706ae..e845d621f6 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
 	for raw in $(ls T*.raw)
 	do
 		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
-		    -e "/multi-pack-index/d" <$raw >$raw.de-sha-1 &&
+		    -e "/multi-pack-index/d" -e "/rev/d" <$raw >$raw.de-sha-1 &&
 		sort $raw.de-sha-1 >$raw.de-sha || return 1
 	done &&
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 3d994e0b1b..e8f0b4a299 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -851,8 +851,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f h2found &&
 
 	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
-	test_line_count = 6 filelist
+	ls http_child/.git/objects/pack/*.pack >packlist &&
+	ls http_child/.git/objects/pack/*.idx >idxlist &&
+	test_line_count = 3 idxlist &&
+	test_line_count = 3 packlist
 '
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
@@ -905,8 +907,10 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
 	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
-	test_line_count = 4 filelist
+	ls http_child/.git/objects/pack/*.pack >packlist &&
+	ls http_child/.git/objects/pack/*.idx >idxlist &&
+	test_line_count = 2 idxlist &&
+	test_line_count = 2 packlist
 '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4a3b8f48ac..f76586f808 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -106,17 +106,17 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_commit "$(test_oid obj2)" &&
 	# Our first gc will create a pack; our second will create a second pack
 	git gc --auto &&
-	ls .git/objects/pack | sort >existing_packs &&
+	ls .git/objects/pack/pack-*.pack | sort >existing_packs &&
 	test_commit "$(test_oid obj3)" &&
 	test_commit "$(test_oid obj4)" &&
 
 	git gc --auto 2>err &&
 	test_i18ngrep ! "^warning:" err &&
-	ls .git/objects/pack/ | sort >post_packs &&
+	ls .git/objects/pack/pack-*.pack | sort >post_packs &&
 	comm -1 -3 existing_packs post_packs >new &&
 	comm -2 -3 existing_packs post_packs >del &&
 	test_line_count = 0 del && # No packs are deleted
-	test_line_count = 2 new # There is one new pack and its .idx
+	test_line_count = 1 new # There is one new pack
 '
 
 test_expect_success 'gc --no-quiet' '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3d17e932a0..8f1caf8025 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1632,7 +1632,10 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	INPUT_END
 
 	git fast-import <input &&
-	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
+	ls -la .git/objects/pack/pack-*.pack >packlist &&
+	ls -la .git/objects/pack/pack-*.pack >idxlist &&
+	test_line_count = 4 idxlist &&
+	test_line_count = 4 packlist &&
 	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
 	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
 	test_cmp expect actual
-- 
2.30.0.138.g6d7191ea01

