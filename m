Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D31C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ED021823
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzVIdCDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfLDWDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:03:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45048 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWDP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:03:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id d19so282095pls.11
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbJBz6lo+xgCtsxlGt18hk9MuyrM8XiQvoH6NL1DSIU=;
        b=mzVIdCDhYLjolYnmPMufskCYcE0O02N4/eh1fYV3wLKy/hH+VmeCxhCZH+aRKVn0mM
         HWIk5rk2B8amVJHqS/ZnUtQF7skvnXGqGD5B6Do6rqSepewbkdrMkp90r28d/f9ULuqF
         gl8dqhzJmpb2MQ+e7N3+AfjLcqk1sWzpT5BcKr3nV9kflKTXKeh8eCYpYh9COH7Tx8Ho
         82v5q4LkQHhykgUI5CK4NQhssWFBAydBIlUmKQ68RTxsMVXpL3Bl9E6FYrq8AQ86P8B4
         6TCAUqycbQ9HUnWdXQtlIG8V1ndSIw0V+u5przrFcQYpcunoaLTR/LLwcz8+zj7nRCtt
         eXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbJBz6lo+xgCtsxlGt18hk9MuyrM8XiQvoH6NL1DSIU=;
        b=YOnyhzaGhQdkHrnUQ7ov9ddFroiAh+xO/USXmYRETvqvLJPMytrStoX7RM7d4wNMT8
         VROOQcgpkDPsIlCS0zEDbK0PkLvrwEfXaB71FHBZSwNpYe4U0JJ7px3ydtLtGDGpdfP/
         dotDnlAChVzROOWXeCIo8gZnUvHv9kk24CWYVMBnKHMvOqifadQT5FICm+Yqi7hj/jtw
         4xMeX7PEf/GFjzUavDKrsbk1+iBBqXWCwlO3cCCjJ0kS+xqE8A2SHOvQMVNnojDgNjQ9
         cr25OLeZQ9j2ph9sDz2Nhbrv0f/o4uXMWvrcYqvSXnHnHTWx31iOjGu5I7VXVbRzXNfK
         C3Ow==
X-Gm-Message-State: APjAAAUrl3VxpvTw9VrTgqTVRHIIKq+1F/Usy1yftHMdujIpUrv7ruuv
        JlP5QhmQWASnXC48VKxgHgqMiOin
X-Google-Smtp-Source: APXvYqz9tVdlG34Erz7epngy9ASxDDHd8x2nvf4j/QxMgyQXo1c0RI9YYU7S0aEvEmaaKhqIMSbyAA==
X-Received: by 2002:a17:90a:c095:: with SMTP id o21mr5679993pjs.41.1575496994341;
        Wed, 04 Dec 2019 14:03:14 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id p68sm9648732pfp.149.2019.12.04.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:03:13 -0800 (PST)
Date:   Wed, 4 Dec 2019 14:03:09 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 1/5] t7700: consolidate code into
 test_no_missing_in_packs()
Message-ID: <3008ce8deb4055f39fd4e1331b30666b40b26eaa.1575496684.git.liu.denton@gmail.com>
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
 <cover.1575496683.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575496683.git.liu.denton@gmail.com>
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

Instead of verifying each file of `alt_objects/pack/*.idx` individually
in a for-loop, batch them together into one verification step.

The original testing construct was O(n^2): it used a grep in a loop to
test whether any objects were missing in the packfile. Rewrite this to
extract the hash using sed or cut, sort the files, then use `comm -23`
so that finding missing lines from the original file is done more
efficiently.

While we're at it, add a space to `commit_and_pack ()` for style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 55 +++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 40 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1d14ddcbdb..5fb9e99f34 100755
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
+	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
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
2.24.0.578.g4820254054

