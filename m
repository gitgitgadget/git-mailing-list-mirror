Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D5DC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5724720735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adCYmMBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEKFuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728785AbgEKFuJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020DC061A0E
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so17638838wmc.5
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q3CDo3iINoX2jrAZCp4h+DfjOWi6Io775H/NKTSfSGk=;
        b=adCYmMBWeblZpbSO8ZXm9bKpi2I3dWB0hDTzgyqX2ZNb3Iy9v5X/RP8t0hqKfCj/L7
         o2+eG8PHkb4gBMT99OjwEAZOhVXrEEwCzQkdVPw3go7jZRWQY52Ho+EHWzlHTLjBGSOl
         gregDirZwObvumDd014D6uaSgwNVCViMaIZLx4IQPeWTp09PbTOEg7QPbygC8vDydi/f
         Gp8M6FLgbxN7Jrxoz8x07iJwsLw7beAy1hxKLG8Dla0OMFzCIhuw8dtjaDlnGw/KDs2r
         VYBy01VbyP3gyLsKQL8xJVnJxf42ktRlHDVU1u7XcdD9Decr4jTjsqM5coeh8B80sRmy
         PHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q3CDo3iINoX2jrAZCp4h+DfjOWi6Io775H/NKTSfSGk=;
        b=XpHiEqusZDE1sRh5UJZ0jxKGR44SquC7dhMU3+1Ks3G3ZGepToa32FvcwgOwmCCTn3
         OBL9nvd5lRLAjCZksza3fXl9bu7FH2WuMVH1TIDCp7QpzjU5K0GBPAmEycYR6JLN5hdh
         6iUai86iYwqHFveStq7TyMCU6ARctE8ZwYf/+N1Skvf2UIMBBWe+2MrjRrK6Ri1odVpw
         Kl/zAtGNKirMt3+Spew9HoODIklbFAcLCLAqMSV5ITPJNVvBysQRoWAQdgFUe6EpN2Ox
         WB+4EoOcZRob4WXLDhETDHDgPtNMCpHWdzczc9lgwZOxANUXgkpD7LLw5wsdpD73imun
         4u1A==
X-Gm-Message-State: AGi0Pub3t7mLoKOXK7FIhaK9j9J/EFLjBpwhfclwQMS0lFkOGpxmQdZ6
        7GaV8dFWnfcj8Z9BHglvWuxGukTn
X-Google-Smtp-Source: APiQypJ6H3Cryg0z9397/xY8zfYuKz0zvImJDRVFSNMYElnILhYdgVCJoCbME9byi3SzJAb2qY46fQ==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr22575157wmk.8.1589176207317;
        Sun, 10 May 2020 22:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y63sm25989652wmg.21.2020.05.10.22.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:06 -0700 (PDT)
Message-Id: <a76a49651bfb43f29892b0fec6887832f70b3e89.1589176202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:59 +0000
Subject: [PATCH 5/7] subtree: add git subtree use and ignore commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Tell split to use or ignore larger sections of the history. In most cases
split does this automatically based on metadata from subtree add.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 78 ++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index f8ae1283cd3..1ca8b2f1101 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -9,13 +9,15 @@ then
 	set -- -h
 fi
 OPTS_SPEC="\
-git subtree add   --prefix=<prefix> <commit>
-git subtree add   --prefix=<prefix> <repository> <ref>
-git subtree merge --prefix=<prefix> <commit>
-git subtree pull  --prefix=<prefix> <repository> <ref>
-git subtree push  --prefix=<prefix> <repository> <ref>
-git subtree split --prefix=<prefix> <commit>
-git subtree map   --prefix=<prefix> <mainline> <subtree>
+git subtree add    --prefix=<prefix> <commit>
+git subtree add    --prefix=<prefix> <repository> <ref>
+git subtree merge  --prefix=<prefix> <commit>
+git subtree pull   --prefix=<prefix> <repository> <ref>
+git subtree push   --prefix=<prefix> <repository> <ref>
+git subtree split  --prefix=<prefix> <commit>
+git subtree map    --prefix=<prefix> <mainline> <subtree>
+git subtree ignore --prefix=<prefix> <commit>
+git subtree use    --prefix=<prefix> <commit>
 --
 h,help        show the help
 q             quiet
@@ -162,7 +164,7 @@ command="$1"
 shift
 
 case "$command" in
-add|merge|pull|map)
+add|merge|pull|map|ignore|use)
 	default=
 	;;
 split|push)
@@ -433,6 +435,18 @@ find_mainline_ref () {
 	done
 }
 
+exclude_processed_refs () {
+		if test -r "$cachedir/processed"
+		then
+			cat "$cachedir/processed" |
+			while read rev
+			do
+				debug "read $rev"
+				echo "^$rev"
+			done
+		fi
+}
+
 copy_commit () {
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
@@ -798,20 +812,60 @@ cmd_add_commit () {
 }
 
 cmd_map () {
-	oldrev="$1"
-	newrev="$2"
 
-	if test -z "$oldrev"
+	if test -z "$1"
 	then
 		die "You must provide a revision to map"
 	fi
 
+	oldrev=$(git rev-parse --revs-only "$1") || exit $?
+	newrev=
+
+	if test -n "$2"
+	then
+		newrev=$(git rev-parse --revs-only "$2") || exit $?
+	fi
+
 	cache_setup || exit $?
 	cache_set "$oldrev" "$newrev"
 
 	say "Mapped $oldrev => $newrev"
 }
 
+cmd_ignore () {
+	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $revs
+
+	say "Ignoring $revs"
+
+	cache_setup || exit $?
+
+	git rev-list $revs |
+	while read rev
+	do
+		cache_set "$rev" ""
+	done
+
+	echo "$revs" >>"$cachedir/processed"
+}
+
+cmd_use () {
+	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	ensure_single_rev $revs
+
+	say "Using existing subtree $revs"
+
+	cache_setup || exit $?
+
+	git rev-list $revs |
+	while read rev
+	do
+		cache_set "$rev" "$rev"
+	done
+
+	echo "$revs" >>"$cachedir/processed"
+}
+
 cmd_split () {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
@@ -829,7 +883,7 @@ cmd_split () {
 		done
 	fi
 
-	unrevs="$(find_existing_splits "$dir" "$revs")"
+	unrevs="$(find_existing_splits "$dir" "$revs") $(exclude_processed_refs)"
 
 	mainline="$(find_mainline_ref "$dir" "$revs")"
 	if test -n "$mainline"
-- 
gitgitgadget

