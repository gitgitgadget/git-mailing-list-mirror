Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B8FC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278F20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzjhCx4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfK0TyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:54:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0TyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:54:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so11603538pfc.13
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNXcIvtvWOwcVTxfpktNTETrPxCxnPgY27D0nrw2y1A=;
        b=FzjhCx4aRGeewjJSNHK5s0n/bYEVudTGa6GXQ+UyrgX4mw39pk83YWLo8Dp+hJOfhA
         RhZBg/6qbZD6IS2l58ZvPohC17+FReyXOD3Hxt+J75Du/OqAS+sxsoo8roKnrvw6ErWh
         pF8AWmnRz+zv7oZbD+Of71Rb1jwbr66SUSS3R0sBOIgihXal+ge0VmAS+5Mr5EAS3a9s
         G3i2LbgGNt/e/JzamqY31Y6PsQq/P+cs+RerlAurW7pb6XY6VzmN3VqK8j5jn7yv6a+2
         Y5kCw344K8rdAJm4n2S4z6x2UxDgJTtNjwsm86ZvuKMzF+97LKspYfnJwwARZCRidiuA
         7MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNXcIvtvWOwcVTxfpktNTETrPxCxnPgY27D0nrw2y1A=;
        b=TZxYcJdypgiyzb4B/Emc9prIKyFkI9zbvHf2JXyWb/iCK6itDFFdLRpuClDoxMdwU2
         x714NOg9S/46t7CheiLHHlBrnmu5NouwQvNtfIHNTu6EqklZxZIjKkewbENivxbgvQkk
         gQokMcFpqihKQyzn42Ye60Ylm9qDnOR/vlJG+KoY6pFIL0b5ahLwdqtIldL9B7f/keqa
         ihyiFb9wZ8tPJXqOIwXvQTrO18qJn/VKhh+PQyK0NR1lusd044aAuPEjE3+J50EM4y6O
         eVqiitGOeS30OTi0OYDaYop+GXHuUt6gzSdZIibe38BHZ7EKgMmXN+aGkIkankC2rjF8
         33RQ==
X-Gm-Message-State: APjAAAUBy+tZWiXSACux9zjwQL8/S/Z31TxkJc9hrJbp9CA/Xu8UNXAY
        Z4BlJ2qYDlKr4Z3v1iFHxZYGrH9h
X-Google-Smtp-Source: APXvYqwa1QAWG+ghVIG2jHMZoUHK1+XLK9fd9UT0/JBY/HNCLuo6XMCN55BZ8VpgoiZ4oDqa8T7t+w==
X-Received: by 2002:a63:1f1c:: with SMTP id f28mr7211096pgf.406.1574884443861;
        Wed, 27 Nov 2019 11:54:03 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id h5sm1305074pfk.30.2019.11.27.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:54:03 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:54:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 25/26] t7700: make references to SHA-1 generic
Message-ID: <bf70cc5a0d1766b9e9ef43013fc476ec76a7d70f.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the test more hash-agnostic by renaming variables from "sha1" to
some variation of "oid" or "packid". Also, replace the regex,
`[0-9a-f]\{40\}` with `$OID_REGEX`.

A better name for "incrpackid" (incremental pack-id) might have been
just "packid". However, later in the test suite, we have other uses of
"packid". Although the scopes of these variables don't conflict, a
future developer may think that commit_and_pack() and
test_has_duplicate_object() are semantically related somehow since they
share the same variable name. Give them distinct names so that it's
clear these uses are unrelated.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 2493cc4e9b..1edb21bf93 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -6,31 +6,31 @@ test_description='git repack works correctly'
 
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
-	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
-	echo pack-${SHA1}.pack
+	incrpackid=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	echo pack-${incrpackid}.pack
 }
 
 test_no_missing_in_packs () {
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test_path_is_file "$myidx" &&
 	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
-	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
+	grep "^$OID_REGEX" orig.raw | cut -d" " -f1 | sort >orig &&
 	git verify-pack -v $myidx >dest.raw &&
 	cut -d" " -f1 dest.raw | sort >dest &&
 	comm -23 orig dest >missing &&
 	test_must_be_empty missing
 }
 
-# we expect $packsha1 and $objsha1 to be defined
+# we expect $packid and $oid to be defined
 test_has_duplicate_object () {
 	want_duplicate_object="$1"
 	found_duplicate_object=false
 	for p in .git/objects/pack/*.idx
 	do
 		idx=$(basename $p)
-		test "pack-$packsha1.idx" = "$idx" && continue
+		test "pack-$packid.idx" = "$idx" && continue
 		git verify-pack -v $p >packlist || return $?
-		if grep "^$objsha1" packlist
+		if grep "^$oid" packlist
 		then
 			found_duplicate_object=true
 			echo "DUPLICATE OBJECT FOUND"
@@ -51,11 +51,11 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git rev-list --objects --all | grep -v file2 |
 		git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packsha1=$(git rev-list --objects --all | grep file2 |
+	packid=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
-	>pack-$packsha1.keep &&
-	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
-		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	>pack-$packid.keep &&
+	oid=$(git verify-pack -v pack-$packid.idx | head -n 1 |
+		sed -e "s/^\($OID_REGEX\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -63,13 +63,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $oid, $packid, and .keep state from previous
 	git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
-	# build on $objsha1, $packsha1, and .keep state from previous
+	# build on $oid, $packid, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
@@ -78,7 +78,7 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
 	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo content3 >file3 &&
-	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
+	oid=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
 	git add file3 &&
 	test_tick &&
 	git commit -m commit_file3 &&
@@ -124,7 +124,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f alt_objects/pack/*.keep &&
 	mv .git/objects/pack/* alt_objects/pack/ &&
-	csha1=$(git rev-parse HEAD^{commit}) &&
+	coid=$(git rev-parse HEAD^{commit}) &&
 	git reset --hard HEAD^ &&
 	test_tick &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
@@ -135,14 +135,14 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$coid " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
-	test_must_fail git show $csha1
+	test_must_fail git show $coid
 '
 
 test_expect_success 'local packed unreachable obs that exist in alternate ODB are not loosened' '
 	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
-	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
+	echo "$coid" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	# The pack-objects call on the next line is equivalent to
@@ -152,9 +152,9 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		grep "^$csha1 " | sort | uniq | wc -l) &&
+		grep "^$coid " | sort | uniq | wc -l) &&
 	echo >.git/objects/info/alternates &&
-	test_must_fail git show $csha1
+	test_must_fail git show $coid
 '
 
 test_expect_success 'objects made unreachable by grafts only are kept' '
-- 
2.24.0.504.g3cd56eb17d

