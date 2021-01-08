Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F42C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF7223A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbhAHSVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:21:04 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B7C06129D
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:24 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x15so11206062ilq.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQlZK0jd6JeMSvh7FeMG2U8oZmsTY8vnZxn+QdqX9BU=;
        b=QxURiWeo5xOV+7CXk9w+QHINGPvIMt7OJEKv+++LO2tE47PLIFIYRiJDZF8o+Fx06K
         ApuPph5scpX0SJnK+SWa6kHNjXVtuCGlysAB/tui6+ppk1gt785FDJxxSSpqHDmcUmzd
         L8MgtENnrIhBF8UjnAL+Xqt8bKugIACLCiB5fqG+yEcVtNzN5nhTw2yTDePuUJI8sWmZ
         KStn3VFJxLbJjW79N+d1E+QPZtDMRadVxVU1RiPD7EGeZYaDO3DF0fpbLbLKI981iy7D
         +9xBRtM8lTn/aGP4aCjYwNEbJu85ydSzQOGM7ZaZgCamqXoBv6GTWuqOPKue60vIYwoV
         sLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQlZK0jd6JeMSvh7FeMG2U8oZmsTY8vnZxn+QdqX9BU=;
        b=ACZCVTNZrBQF0G8MBMRETJCHooxoBbugaR+YiNBh/KF6ypjeB0YXfY/2ECVj8ngQaT
         UYyE5mh6nk2fNKnrfzFSXP+OFmZDdiu27pta81Zzq1g6OlIkowpZxJid1g8/IjCK88Qy
         D4//+QCE/QFUcz10SAGuASC/q7T2eNqvzt27dzwy5oXdbyHFGbRvKX9sQV/JCYACLfUI
         ZYCMdjknt8STl+8DM2DDFSO5S5J3wI0/jl7+QKxs4B39qG3rrIIjnGnmjxcRbgf2/80U
         THO5u5TSQMvU6f43SEKupQx0yRYNIEZSGN5wBcgeN5TCqMvqR2hs0vYZLl/JKe1p9UX7
         F1Bg==
X-Gm-Message-State: AOAM531J3wvhuiCs29gbP8RhIINhZESw+ffDdlOihfpLc3DzoSrNAzo4
        TIrxXkNKKF4sOevqXF++nF4aokOIOvdH+g==
X-Google-Smtp-Source: ABdhPJz9jks+MmKMPf4redwIAOVINsaJmV9/j4Dm0+2swuY7TJd0ltoW2ru8eOk0mNa7anTY48hM5g==
X-Received: by 2002:a92:1517:: with SMTP id v23mr5216982ilk.280.1610130023212;
        Fri, 08 Jan 2021 10:20:23 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id m8sm7445555ild.18.2021.01.08.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:22 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 6/8] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <2288571fbeb83d6bd98917f4788c3221aa973c81.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, we'll add support for unconditionally enabling the
'pack.writeReverseIndex' setting with a new GIT_TEST_WRITE_REV_INDEX
environment variable.

This causes a little bit of fallout with tests that, for example,
compare the list of files in the pack directory being unprepared to see
.rev files in its output.

For now, sprinkle these locations with a 'grep -v "\.rev$"' to ignore
them. Once the pack.writeReverseIndex option has been thoroughly
tested, we will default it to 'true', removing GIT_TEST_WRITE_REV_INDEX,
and making it possible to revert this patch.

At that time, we'll have to adjust the expected output to contain the
relevant .rev files, but for now this will do just fine.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5319-multi-pack-index.sh | 2 +-
 t/t5325-reverse-index.sh    | 4 ++++
 t/t5604-clone-reference.sh  | 2 +-
 t/t5702-protocol-v2.sh      | 4 ++--
 t/t6500-gc.sh               | 4 ++--
 t/t9300-fast-import.sh      | 2 +-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 297de502a9..9696f88c2f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -710,7 +710,7 @@ test_expect_success 'expire respects .keep files' '
 		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
 		touch $PACKA.keep &&
 		git multi-pack-index expire &&
-		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
+		ls -S .git/objects/pack/a-pack* | grep $PACKA | grep -v "\.rev$" >a-pack-files &&
 		test_line_count = 3 a-pack-files &&
 		test-tool read-midx .git/objects | grep idx >midx-list &&
 		test_line_count = 2 midx-list
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 431699ade2..5a59cc71e4 100755
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
index 2f7be23044..d064426d03 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -318,7 +318,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
 		test_cmp T.objects T$option.objects &&
 		(
 			cd T$option/.git/objects &&
-			find . -type f | sort >../../../T$option.objects-files.raw &&
+			find . -type f | grep -v \.rev$ | sort >../../../T$option.objects-files.raw &&
 			find . -type l | sort >../../../T$option.objects-symlinks.raw
 		)
 	done &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..9ebf045739 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -848,7 +848,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f h2found &&
 
 	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&
 	test_line_count = 6 filelist
 '
 
@@ -902,7 +902,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
 	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	ls http_child/.git/objects/pack/* | grep -v \.rev$ >filelist &&
 	test_line_count = 4 filelist
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4a3b8f48ac..d52f92f5a1 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -106,13 +106,13 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_commit "$(test_oid obj2)" &&
 	# Our first gc will create a pack; our second will create a second pack
 	git gc --auto &&
-	ls .git/objects/pack | sort >existing_packs &&
+	ls .git/objects/pack | grep -v \.rev$ | sort >existing_packs &&
 	test_commit "$(test_oid obj3)" &&
 	test_commit "$(test_oid obj4)" &&
 
 	git gc --auto 2>err &&
 	test_i18ngrep ! "^warning:" err &&
-	ls .git/objects/pack/ | sort >post_packs &&
+	ls .git/objects/pack/ | grep -v \.rev$ | sort >post_packs &&
 	comm -1 -3 existing_packs post_packs >new &&
 	comm -2 -3 existing_packs post_packs >del &&
 	test_line_count = 0 del && # No packs are deleted
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 308c1ef42c..100df52a71 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1629,7 +1629,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	INPUT_END
 
 	git fast-import <input &&
-	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
+	test 8 = $(find .git/objects/pack -type f \( -name "*.idx" -o -name "*.pack" \) | wc -l) &&
 	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
 	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
 	test_cmp expect actual
-- 
2.30.0.138.g6d7191ea01

