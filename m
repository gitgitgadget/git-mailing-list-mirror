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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709DCC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431862082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXg2KDvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfK0Tx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Tx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so11447514pgq.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SprpPHFts+yK6L/4hjzS3PhdnhVvYxKd7dbVJf8t4vk=;
        b=RXg2KDvSV46WRBxtuSJai8DD/xDlRZdlh0qK3EP8G0e8xxBTcctYIwT3I2nZeTP4N0
         Sv3lGHnS3zM2+xTYttVAnFfaQFlJdyaurC/db652JGr259uEIWso9xomp4lT+GTOwoQS
         YTviI37USXIb82JNxuYs0RqnQKGmI3lDwH6bug6ME38tb373kR7dwhkENWuwfOBP0JBw
         aINQMQa2XHNT3yYhxRo/5oUskS23Nid5/5jEa02gzB/Yl7vrv3Y3STg9K8QwJ9P0Mlfx
         Hfa3BQbUH6KWWv0VA/8s3lWiwFdbv8dXlcE0MWFjHic09H0cQPyegvqlXY1uT1bj2A+z
         NVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SprpPHFts+yK6L/4hjzS3PhdnhVvYxKd7dbVJf8t4vk=;
        b=lNm+yGtg1ru0ZXaS001nhOtcVNwwkzBfdwx39s+f4V+tMFhmmpKhM5GTixPrK/SJ/P
         PRwS6/BIM/+V8re1FaOFPr9QTC5fVJBkGMUEm/0Mq28CxnhTtWTEmLdqiMTESjZhUI3C
         m+BtxgOpoJkF75cOBtvsfIIOdrkzhe8q5hLY+RnMiUHi9Ub34fpclO1Gvd0B/M3zRrKQ
         Bj55HGi7Rrq+ucIS072Ou7YEzKGA+UH5Zzce80j1KhMKegzoQUNMt2cjdszo3I2behDg
         Q/ugKoGlkw/7Di0iExe9XqpRkvELnSO6xemI0LcokyFUN3JJ8b1SDLJBtS+TOa3p0lz9
         q6lw==
X-Gm-Message-State: APjAAAVIE/kgqErSANoiWu30FM8nQYp6IUvvAHOaEUYGXEKMeFjAqcdK
        HV6A1rg7vUpmO2VeVnwYjPbCZya8
X-Google-Smtp-Source: APXvYqw9hzSnQpAsLx2OfAXC5fIPw33kyzR4cIW1McV1xYMBsPCuFGhLRT8jK7wfI5Zn2Cn/QBAelQ==
X-Received: by 2002:a63:1365:: with SMTP id 37mr3691564pgt.28.1574884436405;
        Wed, 27 Nov 2019 11:53:56 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e10sm8112455pfm.3.2019.11.27.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:55 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:54 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 22/26] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
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

The code to test that objects were not missing from the packfile was
duplicated many times. Extract the duplicated code into
test_no_missing_in_packs() and use that instead.

Refactor the resulting extraction so that if any git commands fail,
their return codes are not silently lost.

We were using sed to filter lines. Although not incorrect, this is
exactly what grep is built for. Replace this invocation of sed with grep
so that we use the correct tool for the job.

Instead of verifying each file of `alt_objects/pack/*.idx` individually
in a for-loop, batch them together into one verification step.

The original testing construct was O(n^2): it used a grep in a loop to
test whether any objects were missing in the packfile. Rewrite this to
sort the files then use `comm -23` so that finding missing lines from
the original file is done more efficiently.

While we're at it, add a space to `commit_and_pack ()` for style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 55 +++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1d14ddcbdb..4bcd9fcc80 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,12 +4,23 @@ test_description='git repack works correctly'
 
 . ./test-lib.sh
 
-commit_and_pack() {
+commit_and_pack () {
 	test_commit "$@" 1>&2 &&
 	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
 	echo pack-${SHA1}.pack
 }
 
+test_no_missing_in_packs () {
+	myidx=$(ls -1 .git/objects/pack/*.idx) &&
+	test_path_is_file "$myidx" &&
+	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
+	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
+	git verify-pack -v $myidx >dest.raw &&
+	cut -d" " -f1 dest.raw | sort >dest &&
+	comm -23 orig dest >missing &&
+	test_must_be_empty missing
+}
+
 test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 >file1 &&
 	echo content2 >file2 &&
@@ -105,19 +116,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
-	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test_path_is_file "$myidx" &&
-	for p in alt_objects/pack/*.idx
-	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
-	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
-		then
-			echo "Missing object in local pack: $sha1"
-			return 1
-		fi
-	done
+	test_no_missing_in_packs
 '
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
@@ -128,19 +127,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git commit -m more_content &&
 	git repack &&
 	git repack -a -d &&
-	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test_path_is_file "$myidx" &&
-	for p in alt_objects/pack/*.idx
-	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
-	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
-		then
-			echo "Missing object in local pack: $sha1"
-			return 1
-		fi
-	done
+	test_no_missing_in_packs
 '
 
 test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
@@ -156,19 +143,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 		fi
 	done &&
 	git repack -a -d &&
-	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test_path_is_file "$myidx" &&
-	for p in alt_objects/pack/*.idx
-	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
-	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
-		then
-			echo "Missing object in local pack: $sha1"
-			return 1
-		fi
-	done
+	test_no_missing_in_packs
 '
 
 test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
-- 
2.24.0.504.g3cd56eb17d

