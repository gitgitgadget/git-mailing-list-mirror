Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF096C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDQU5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDQU5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:57:04 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60BCC3E
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m14so9983888ybk.4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764865; x=1684356865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEJ9qzbPbjrFbQGLENPt1su2NVmD89oNuuCJMqep5HQ=;
        b=rOf8UBlMuV9DT2p5cjkQr5+8xf6qPa5ilWPUqtwgX3D5sY0voAfAw8Ai3+c2dtJ9SU
         HJ1+LhLkGHqqSxECNhkcHdWGsmgfPPU9yD7h6Zd504wBBQiMOKnQ4iSEF64dcjr+9wAN
         fn46Eu4LO1ZE+s83DzuIuOIu0NMy14XYB0B583/GzhMgfWkqSAFnleipozsAA24PvxFJ
         n3gX4BKdY2urVx7xqnk8FpvKmbpQZbJpjQdPyAI2GsnavnqU3rjZaw7Tbux/6Yeaz+mf
         MoE+2gGQiYdTgsS0x2RM5nqWaExBy7U78CwjBP+5laOn4FEpLLLcU6ptafAbJWQKPax/
         1KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764865; x=1684356865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEJ9qzbPbjrFbQGLENPt1su2NVmD89oNuuCJMqep5HQ=;
        b=Tf+lb7Kxqsty71gyOnjHflRRUESw90+i7fxGuIIntTdhNl77VNr4cDFHenGwvNGWnf
         Eva+9uwmr4g89I0wlw6Fdt3lQiCbrZLfeaDSLCHjcFvZHMSHGiVPF/+208EGLLI4mdPz
         fel8fno9JdzUKe1WGQ2JV2JFB7eO6S/3X1P6HZasUqUPj1+pTCqYQ73CHcultsh0Gup2
         Dkm12hmJxpd5exa+kBla/GnwxMy3wMSEKbRP3YEp/RvJOWmpqD3GW5XsvRIdv5m+GxdU
         6Fyn5p6QR9nLnnRZ0O9qESiIolXankw5cwjwFovn8Q1rJzZtcuyj7OA3QnUTqYzx5JR6
         QHjw==
X-Gm-Message-State: AAQBX9fOFfiPLhm9bpykt31GN41DS0WaxKVApK/Nz9KhXwYCm2+zm3IE
        u7tOd3dasCxdByDeWP05ic4dKEggGeT7/MlyWuThFA==
X-Google-Smtp-Source: AKy350Z1R/4qZe/izrG/a1xUYJ+IyThdYuiCgwe0j6leYwXGsL+j7BwaIHOLcCqds5sqILiU7nbxKQ==
X-Received: by 2002:a25:4555:0:b0:b8f:2257:af0c with SMTP id s82-20020a254555000000b00b8f2257af0cmr14442796yba.15.1681764865523;
        Mon, 17 Apr 2023 13:54:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d71-20020a25cd4a000000b00b8f5b3b7115sm3131933ybf.60.2023.04.17.13.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:25 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/10] t/t5304-prune.sh: prepare for `gc --cruft` by default
Message-ID: <44006da959eeeaef93a33d73071fb5edc45cd45b.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of the tests in t5304 run `git gc`, and rely on its behavior that
unreachable-but-recent objects are written out loose. This is sensible,
since t5304 deals specifically with this kind of pruning.

If left unattended, however, this test would break when the default
behavior of a bare "git gc" is adjusted to generate a cruft pack by
default.

Ensure that these tests continue to work as-is (and continue to provide
coverage of loose object pruning) by passing `--no-cruft` explicitly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5304-prune.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 5500dd0842..662ae9b152 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -62,11 +62,11 @@ test_expect_success 'prune --expire' '
 test_expect_success 'gc: implicit prune --expire' '
 	add_blob &&
 	test-tool chmtime =-$((2*$week-30)) $BLOB_FILE &&
-	git gc &&
+	git gc --no-cruft &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-tool chmtime =-$((2*$week+1)) $BLOB_FILE &&
-	git gc &&
+	git gc --no-cruft &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 '
@@ -86,7 +86,7 @@ test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
 
 test_expect_success 'gc: start with ok gc.pruneExpire' '
 	git config gc.pruneExpire 2.days.ago &&
-	git gc
+	git gc --no-cruft
 '
 
 test_expect_success 'prune: prune nonsense parameters' '
@@ -137,44 +137,44 @@ test_expect_success 'gc --no-prune' '
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
-	git gc --no-prune &&
+	git gc --no-prune --no-cruft &&
 	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
 '
 
 test_expect_success 'gc respects gc.pruneExpire' '
 	git config gc.pruneExpire 5002.days.ago &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire 5000.days.ago &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc --prune=<date>' '
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
-	git gc --prune=5002.days.ago &&
+	git gc --prune=5002.days.ago --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
-	git gc --prune=5000.days.ago &&
+	git gc --prune=5000.days.ago --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc --prune=never' '
 	add_blob &&
-	git gc --prune=never &&
+	git gc --prune=never --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
-	git gc --prune=now &&
+	git gc --prune=now --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc respects gc.pruneExpire=never' '
 	git config gc.pruneExpire never &&
 	add_blob &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire now &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
@@ -194,7 +194,7 @@ test_expect_success 'gc: prune old objects after local clone' '
 		cd aclone &&
 		verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_file $BLOB_FILE &&
-		git gc --prune &&
+		git gc --prune --no-cruft &&
 		verbose test 0 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_missing $BLOB_FILE
 	)
@@ -237,7 +237,7 @@ test_expect_success 'clean pack garbage with gc' '
 	>.git/objects/pack/fake2.keep &&
 	>.git/objects/pack/fake2.idx &&
 	>.git/objects/pack/fake3.keep &&
-	git gc &&
+	git gc --no-cruft &&
 	git count-objects -v 2>stderr &&
 	grep "^warning:" stderr | sort >actual &&
 	cat >expected <<\EOF &&
-- 
2.38.1

