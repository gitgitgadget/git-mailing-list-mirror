Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE27C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D9A208B8
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcYM/NFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgJFWFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgJFWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871EFC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so6449582wru.12
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kt9nZJzCHemqRfq1pjAQFPykZqAgfCKSp+NhhOC/G5s=;
        b=vcYM/NFRv5L0tY4ICJ1TdJ4HkpW9rzLHl2YVueqq0u0ARHVGLlqiGyrBUmowerf2ec
         8GJoDkiQ7A0jX6haXJ3Z2z9XFUS6jCM/B1W4TZV6JdG3aSQr2s0BKypw6iSCsXOWMEUY
         0J2HEHdfh/mNidiJWcOBuJyYadRhJ81QZpBPVmxdJJGrq9/v6Iq4rEXKkSjsA/2NefQR
         /mCIrYMVV5bldgyfYyB9h4rL0Ss1xbixcsK6rk0gm07dkAL8tDTt83GYVio88+n/LMBe
         +gb3+4Wj3oDO2kVzgCTlJe5d7hw7czAd6a1l69ewA8EFNIOGeqs1hVEszFjER7BM2j4+
         +VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kt9nZJzCHemqRfq1pjAQFPykZqAgfCKSp+NhhOC/G5s=;
        b=Yt9M5XMWFpMp2eXV+UZwdBiC1UB5vzVOHYAYxvBBcGzd8mDVKsQlhgDemkCZ56aCI0
         DYOMYg8V2+a+oe+nrOcyW2t+ckg1dVHlhfLYuVYNhSKVg/Vv3fsqwSa74NQq2kRKvy2f
         YaJKa2/3ZpW3YzFIH9mbFxroRCUb0NexiecQVwYWYzBSHsO0FoorNz0FcrCMfJSWb8hE
         W5xSznbNgeTU3CnUDRLsPISkDm/nGfB65CxD/5xnbq42sV/XfEGdWDwI5pcKjc8ji55p
         Fz8rXeSCSxySa1AyAOVHZLvSif2fWeUc1A6iV0DSitRlXr7mXQtKwS6kpTrDMRLa/88k
         CerA==
X-Gm-Message-State: AOAM532MjcW3XESO7PeIs6oZDTW6olw8mxgdhyjsPwTBpvFuS9ysAxog
        0+jd6IQVC+A+zPsAglfplJG40Q2nLew=
X-Google-Smtp-Source: ABdhPJxd2V0LNKGU45k2LEmv5XWyG158TX0JNM+/aHQpKXT5WZEH6LqMcL+1YPWH54PhCYL0+4IH+g==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr52991wrv.224.1602021916074;
        Tue, 06 Oct 2020 15:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm168982wrx.58.2020.10.06.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:15 -0700 (PDT)
Message-Id: <79b5f4a65197cea26ddc080c19dd2c5c7d424fc1.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:08 +0000
Subject: [PATCH v2 2/7] subtree: exclude commits predating add from recursive
 processing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Include recursion depth in debug logs so we can see when the recursion is
getting out of hand.

Making the cache handle null mappings correctly and adding older commits
to the cache allows the recursive algorithm to terminate at any point on
mainline rather than needing to reach either the add point or the initial
commit.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 35 +++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9867718503..160bad95c1 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -244,7 +244,7 @@ check_parents () {
 	do
 		if ! test -r "$cachedir/notree/$miss"
 		then
-			debug "  incorrect order: $miss"
+			debug "  unprocessed parent commit: $miss ($indent)"
 			process_split_commit "$miss" "" "$indent"
 		fi
 	done
@@ -392,6 +392,24 @@ find_existing_splits () {
 	done
 }
 
+find_mainline_ref () {
+	debug "Looking for first split..."
+	dir="$1"
+	revs="$2"
+
+	git log --reverse --grep="^git-subtree-dir: $dir/*\$" \
+		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+	while read a b junk
+	do
+		case "$a" in
+		git-subtree-mainline:)
+			echo "$b"
+			return
+			;;
+		esac
+	done
+}
+
 copy_commit () {
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
@@ -646,9 +664,9 @@ process_split_commit () {
 
 	progress "$revcount/$revmax ($createcount) [$extracount]"
 
-	debug "Processing commit: $rev"
+	debug "Processing commit: $rev ($indent)"
 	exists=$(cache_get "$rev")
-	if test -n "$exists"
+	if test -z "$(cache_miss "$rev")"
 	then
 		debug "  prior: $exists"
 		return
@@ -773,6 +791,17 @@ cmd_split () {
 
 	unrevs="$(find_existing_splits "$dir" "$revs")"
 
+	mainline="$(find_mainline_ref "$dir" "$revs")"
+	if test -n "$mainline"
+	then
+		debug "Mainline $mainline predates subtree add"
+		git rev-list --topo-order --skip=1 $mainline |
+		while read rev
+		do
+			cache_set "$rev" ""
+		done || exit $?
+	fi
+
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
-- 
gitgitgadget

