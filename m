Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2773C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA9861165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhHYCXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhHYCXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18842C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mq3so15520776pjb.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=majvrSXHl7BgoXNmFyWu//0uxk8/uZXDOVmVHxMZ18k=;
        b=tm/C2BDySHkBpqPdOe2vHFNS2EBUKz1rodzeEtnPO/7CrlBCHGAq3tz+HLrQOB4S5Y
         f2GzHX5OgXLbwkoQ0kYULiQ/he/fIlSod0/9cSfZD17kdp+Xqmn6jv11B/KRxuSHHApH
         sx7o6ftw+IVZqJRmZkFWrbSjfsRMlUoJgV8xGbC3doLFYSjiIE/cz7GOkLQJ+Warc1YF
         hCnT/Edh3ph0ZmXlph8BGPSAPsFpZoT7GnYdRHXx/BpoL2wqxIVZTy1zH22dFYx+Bpez
         UHCnFCw5aSM0sKFCc7mmAhmdjRw6urpZO2U0hOEnL3bxbrCYatuMqjSccpJRZ5iw9WPx
         D8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=majvrSXHl7BgoXNmFyWu//0uxk8/uZXDOVmVHxMZ18k=;
        b=YcjbpSrjUJEBJzUqmG2t4ciXa4M1RLdC03h7Vsg8uyRKzSt9RHBevYNvi5MPsVKWl7
         3KkgnEqVa4nCaWHKh+CD7mfKDDMXddHtF7AS/4jiEb/JfFpdTp6U5L0azk35n2qm5zCg
         zKXEwCwJklHnybQ8E50G5PrIieWgLwgadnotw0kwLyX+o+r1RPvpw4I7Tp3Nv2gZWYFP
         8TmeP3K3v2lgGspOYCk3yvRjum+s9pXAsXFXrqG/qYcAYC1i2gbBMELzCgusR0/MvYqY
         dQnXIVxifVgb1jwbS4HhJfOmzKsxHR0rFSu1MTIeUNaUg4VBW2xIQlGCZru21LNud/CQ
         k/fg==
X-Gm-Message-State: AOAM531JMCTFy4t0eao2/YKKjKt3C8ZX/6oefEYxGYzKrMBkxiDfYne1
        SbIy0e7FstYLAns2tdHa83M=
X-Google-Smtp-Source: ABdhPJy1Tc7uX9imVR3EQipMfGvk4aI7mQpjBwkXtsMbKhKyKRMwKR4vM7aqjmDd1We42oq86mOtyA==
X-Received: by 2002:a17:90a:d204:: with SMTP id o4mr8009289pju.15.1629858145632;
        Tue, 24 Aug 2021 19:22:25 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 07/14] t5702: support for excluding commit objects
Date:   Wed, 25 Aug 2021 10:21:51 +0800
Message-Id: <3b5f9732b814a712094091027c8229988e2ba791.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 292 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 266 insertions(+), 26 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e6314b53b0..5ad52e0cee 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -824,17 +824,47 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 '
 
 configure_exclusion () {
-	git -C "$1" hash-object "$2" >objh &&
-	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
-	git -C "$1" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-	cat objh
+	objt="$1"
+	P="$2"
+	oid="$3"
+	version="$4"
+
+	oldc="uploadpack.blobpackfileuri"
+	newc="uploadpack.excludeobject"
+	configkey=""
+
+	if test "$version" = "old"
+	then
+		configkey="$oldc"
+	else
+		configkey="$newc"
+	fi
+
+	if test "$objt" = "blob"
+	then
+		git -C "$P" hash-object "$oid" >objh &&
+		git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+		git -C "$P" config --add \
+			"$configkey" \
+			"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+		cat objh
+	elif test "$objt" = "commit" || test "$objt" = "tree" || test "$objt" = "tag"
+	then
+		echo "$oid" >objh
+		git -C "$P" pack-objects --revs "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+		git -C "$P" config --add \
+        			"$configkey" \
+        			"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+		cat objh
+	else
+		echo "unsupported object type in configure_exclusion (got $objt)"
+	fi
 }
 
-test_expect_success 'part of packfile response provided as URI' '
+part_of_packfile_response_verify() {
+	config="$1"
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	test_when_finished "rm -rf \"$P\" http_child log" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -843,10 +873,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
-	configure_exclusion "$P" other-blob >h2 &&
+	configure_exclusion blob "$P" my-blob config >h &&
+	configure_exclusion blob "$P" other-blob config >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
@@ -879,9 +909,11 @@ test_expect_success 'part of packfile response provided as URI' '
 	ls http_child/.git/objects/pack/*.pack \
 	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 6 filelist
-'
+}
+
+blobpackfileuri_fetch () {
+	config="$1"
 
-test_expect_success 'packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_when_finished "rm -rf \"$P\" http_child log" &&
 
@@ -890,9 +922,9 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob $config >h &&
 
 	git init http_child &&
 
@@ -900,6 +932,215 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 	git -C http_child -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
 		fetch "$HTTPD_URL/smart/http_parent"
+}
+
+test_expect_success 'blob-exclusion (using uploadpack.blobpackfileuri): part of packfile response provided as URI' '
+	part_of_packfile_response_verify old
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.excludeobject): part of packfile response provided as URI' '
+	part_of_packfile_response_verify new
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.blobpackfileuri): packfile URIs with fetch instead of clone' '
+	blobpackfileuri_fetch old
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.excludeobject): packfile URIs with fetch instead of clone' '
+	blobpackfileuri_fetch new
+'
+
+test_expect_success 'tree-exclusion: part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true"  &&
+
+	# Dir struct
+	# 	.
+	#     |-- A.t
+	#     |-- my-tree
+	#     |   `-- my-blob
+	#     `-- other-tree
+	#         |-- other-blob
+	#         `-- sub-tree
+	#             `-- sub-blob
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/other-tree &&
+	echo other-blob >"$P"/other-tree/other-blob &&
+	mkdir "$P"/other-tree/sub-tree &&
+	echo sub-blob >"$P"/other-tree/sub-tree/sub-blob &&
+	git -C "$P" add other-tree &&
+ 	test_commit -C "$P" A &&
+
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	othertreeh=$(git -C "$P" ls-tree HEAD other-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD other-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	otherblobh=$(git -C "$P" hash-object other-tree/other-blob) &&
+	subblobh=$(git -C "$P" hash-object other-tree/sub-tree/sub-blob) &&
+
+	configure_exclusion tree "$P" "$mytreeh" config >h &&
+	configure_exclusion tree "$P" "$othertreeh" config >h2 &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that my-tree and other-tree and theirs complementary set are in separate packfiles.
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 3 out.objectlist
+		then
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi
+		elif test_line_count = 2 out.objectlist
+		then
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi
+		elif test_line_count = 4 out.objectlist
+		then
+			if grep $othertreeh out
+			then
+				>othertreehfound
+			fi &&
+			if grep $otherblobh out
+			then
+				>otherblobhfound
+			fi
+			if grep $subtreeh out
+			then
+				>subtreehfound
+			fi &&
+			if grep $subblobh out
+			then
+				>subblobhfound
+			fi
+		fi
+	done &&
+	test -f mytreehfound &&
+	test -f myblobhfound &&
+	test -f othertreehfound &&
+	test -f otherblobhfound &&
+	test -f subtreehfound &&
+	test -f subblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 6 filelist
+'
+
+test_expect_success 'commit-exclusion: part of packfile response provided as URI' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	mkdir "$P"/my-tree  &&
+	echo my-blob >"$P"/my-tree/my-blob &&
+	git -C "$P" add my-tree &&
+	mkdir "$P"/my-tree/sub-tree &&
+	echo sub-blob >"$P"/my-tree/sub-tree/sub-blob &&
+	git -C "$P" add my-tree &&
+	test_commit -C "$P" A &&
+
+ 	commith=$(git -C "$P" rev-parse A) &&
+ 	roottreeh=$(git -C "$P" rev-parse A:) &&
+	mytreeh=$(git -C "$P" ls-tree HEAD my-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	subtreeh=$(git -C "$P" ls-tree HEAD my-tree/sub-tree | sed -ne "s/.*\($OID_REGEX\).*/\1/p") &&
+	ah=$(git -C "$P" hash-object A.t) &&
+	myblobh=$(git -C "$P" hash-object my-tree/my-blob) &&
+	subblobh=$(git -C "$P" hash-object my-tree/sub-tree/sub-blob) &&
+
+	configure_exclusion commit "$P" "$commith" >h &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	for idx in http_child/.git/objects/pack/*.idx
+	do
+		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
+		{
+			grep "^[0-9a-f]\{16,\} " out || :
+		} >out.objectlist &&
+		if test_line_count = 7 out.objectlist
+		then
+			if grep $commith out
+			then
+				>commithfound
+			fi &&
+			if grep $roottreeh out
+			then
+				>roottreehfound
+			fi &&
+			if grep $ah out
+			then
+				>ahfound
+			fi &&
+			if grep $mytreeh out
+			then
+				>mytreehfound
+			fi &&
+			if grep $myblobh out
+			then
+				>myblobhfound
+			fi &&
+			if grep $subtreeh out
+			then
+				>subtreehfound
+			fi &&
+			if grep $subblobh out
+			then
+				>subblobhfound
+			fi
+		fi
+	done &&
+	test -f mytreehfound &&
+	test -f myblobhfound &&
+	test -f subtreehfound &&
+	test -f subblobhfound &&
+	test -f commithfound &&
+	test -f roottreehfound &&
+	test -f ahfound &&
+
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+		http_child/.git/objects/pack/*.idx >filelist &&
+	test_line_count = 4 filelist
 '
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
@@ -913,9 +1154,9 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 	# Configure a URL for other-blob. Just reuse the hash of the object as
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
@@ -923,7 +1164,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" hash-object other-blob >objh &&
 	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
 	git -C "$P" config --add \
-		"uploadpack.blobpackfileuri" \
+		"uploadpack.excludeobject" \
 		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
@@ -942,9 +1183,8 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -976,9 +1216,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1000,7 +1240,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1024,9 +1264,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	echo "path = include/foo" >>"$P/.gitmodules" &&
 	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
 	git -C "$P" add .gitmodules &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
-- 
2.31.1.456.gec51e24953

