Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56DC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CEA2075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmDkrKfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfKZBSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfKZBSk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id d7so7349670pls.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LT4qNF5X/O3/rcowquJPvdNO/Dybfw4VtbipCOL3zQQ=;
        b=FmDkrKfK7M+ZC6J4sSBdYhFRPiuhAcrUgj9ghPkeZgk2V5RAmXZwOm6vZ/5oQQS8/k
         Hhs5SJfgb49rB5jHuw7hpTxZ2nAwfgo8VwvHhDrTrZki8KZFeoahTgxtLm940Id1OS16
         vC5M5UQqIs+zVwc6EhMfalgsfnU5cTd7FfxCSQi5yjAcnUoLVZWiD9aFMVagDOaQbmel
         7ZwAR3/fXYGZcPTu8cuo78xgaAXZ+unFOUyS2OXg/0xsa7iQd25WO8ps5cuOVWnPuDkH
         3Aoc4zItsSASWSQ8BhhMMseId1TGoJUZhkrg2tvzfy3581h4xz+9dcyJJJ7RLRywcQAk
         b8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LT4qNF5X/O3/rcowquJPvdNO/Dybfw4VtbipCOL3zQQ=;
        b=tROwdDRufeXrnj3kBzFI16xD0+w4VFG0nQbN8w6j+oaInnDFxMGSTljvsUkRsWd/vY
         2m7DdODNSaOI1WGUcK0Ncwq2V+4O+2/5oSFw8vB9U7JbT8x4PYUfaIK54gXfqUM7H+Ov
         adnJVv1sijlMuFwv/cnufeSSCUbBf+nYzsip1qH/58K18aPNLyylVcdXrTx7LhsW69fQ
         iMEp/CMsM+VZRFbZ36xY48jXR70dyOywzw1wO3R4qKrvXr9YNkxp6PEKjnPQRv0msj37
         ZvknMlNje+1tkjfeshJd8DTtaWT/aBl3kEnB+OPK5ArJcIwKYBCQ9+4LIqzbKuVSe4Z5
         DnRg==
X-Gm-Message-State: APjAAAUAGSpu111Fz5LrRMlvC1t/oYUUNjFDviZNHdjgvCT2gawiUoPd
        QPW9RScaQaf/Jl9OB6zqj9LFBMLv
X-Google-Smtp-Source: APXvYqy+tGO1hz4vawWJLhoj6VF9vqrGsWCihduonLvBuqwdQ2ME/F9c82aME9A+Aa/ZZd49DNehjA==
X-Received: by 2002:a17:90a:fd88:: with SMTP id cx8mr2797193pjb.66.1574731119357;
        Mon, 25 Nov 2019 17:18:39 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id y4sm9581870pfn.97.2019.11.25.17.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:38 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:37 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 22/27] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <c98a2a15090ac3d23757d1d4317d6a1bdcf5b115.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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

The original testing construct was O(n^2): it used a grep in a loop to
test whether any objects were missing in the packfile. Rewrite this to
use sort the files then use `comm -23` so that finding missing lines
from the original file is done more efficiently.

While we're at it, add a space to `commit_and_pack ()` for style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 59 +++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1d14ddcbdb..a6c3d34277 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -4,12 +4,27 @@ test_description='git repack works correctly'
 
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
+	for p in alt_objects/pack/*.idx
+	do
+		git verify-pack -v $p >packlist || return $?
+		grep "^[0-9a-f]\{40\}" packlist
+	done >orig.raw &&
+	cut -d" " -f1 orig.raw | sort >orig &&
+	git verify-pack -v $myidx >dest.raw &&
+	cut -d" " -f1 dest.raw | sort >dest &&
+	comm -23 orig dest >missing &&
+	test_must_be_empty missing
+}
+
 test_expect_success 'objects in packs marked .keep are not repacked' '
 	echo content1 >file1 &&
 	echo content2 >file2 &&
@@ -105,19 +120,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
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
@@ -128,19 +131,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
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
@@ -156,19 +147,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
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

