Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C0C4332B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C9D235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbhANCFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbhAMWao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:30:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22623C0617A4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:33 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id c7so4467329qke.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JnwXMfy71TFG3OSt+vbb+6ryqmj8M60Ak9pyu+d4MB4=;
        b=FI9mzWg3lvb8QI5vsTohpR+eBnyHqZ+Fsx2wsNOy6L9y7HqVBDc6i46mB+4m2PQyPX
         LTuJ7MFp9S2Fel+5Y1JEHCfAuZIhHTylT1rcAN0h3nQtvxDlMuWqCDeAf1wKbCMbzPZ2
         DKF95TxOwt3VxeYWikNyq9HJqOORhgTPBvqsKW63MTlPpwXZLH7Qjg1GLkH7/QTdZyZT
         wrnJi/w0Jpf6SZ/ym+THmiyQgqEL1ekV6ICHLWwz+4Lj3czy5yzsDtlpXu+RGgFSgtel
         s0mnvrhT4EUg+nBLYEuHXRywhEe3K0yZdDOFOVZvuTizY1zAJd4uo2r087Ie209g8qSP
         N+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnwXMfy71TFG3OSt+vbb+6ryqmj8M60Ak9pyu+d4MB4=;
        b=hvKROPtLNvZyXfD0f+6Gx54kdsWbqGmfucOGN7hFPwo9PhsWFkgU/D2/81bkYUCwSL
         CgcfXHQehHardurU8DUBgX2VYY/9NGi2J2uoDTCRTwNlp+xp3O1qkDr29PRH+4ncf6tb
         Sgp/O4IdVoTqvuBKpjhdMCXny5A/O6f8zz2y3WUYDyb5weBlIzW6sQu8Aq6y0O39g4V6
         1NkQYv5z/JUzMBQB0ZHDuQoecmh3kF6Dq7fWFqRgon+87cFxBnGyNjn0FiLplpKPO6SX
         908xC0wtuycxv8moeQim6HUmUDVpYdb6M+qGRHUKtqPNtP+C6FMOLxJaJh1nbOjkYtI6
         X4Fw==
X-Gm-Message-State: AOAM532UAXLiZcLZhXWQgQ9DB9cOwrDB4CODZzRVIY5080AR1ySvNNBZ
        E27RnTwNq2F40rUh0Gjgy/crzOykV+OtbQ==
X-Google-Smtp-Source: ABdhPJwfve0k/+rJhPYkxdTLM0uk5ju1A0edeiGddV9tLdLJIt6vkcMzvfZeJDW8FUwCnfaqDQRR3g==
X-Received: by 2002:a37:a14a:: with SMTP id k71mr4256320qke.33.1610576912084;
        Wed, 13 Jan 2021 14:28:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id e11sm1895662qtg.46.2021.01.13.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:31 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 6/8] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <12cdf2d67a30e3d082bbe0597e3ae97bb753f8bb.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
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
index 2f7be23044..7d93588982 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -326,7 +326,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
 	for raw in $(ls T*.raw)
 	do
 		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
-		    -e "/multi-pack-index/d" <$raw >$raw.de-sha-1 &&
+		    -e "/multi-pack-index/d" -e "/rev/d" <$raw >$raw.de-sha-1 &&
 		sort $raw.de-sha-1 >$raw.de-sha || return 1
 	done &&
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..73cd9e3ff6 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -848,8 +848,10 @@ test_expect_success 'part of packfile response provided as URI' '
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
@@ -902,8 +904,10 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
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
index 308c1ef42c..2cc1f43c1b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1629,7 +1629,10 @@ test_expect_success 'O: blank lines not necessary after other commands' '
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

