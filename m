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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A31C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3826F208B6
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSOTVrNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgJFWFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgJFWFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A9C0613D5
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so6449658wru.12
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pg4fNLNTjDSdd0vPCIQXtLYWhyk5ubFa4AGmgLOS+/o=;
        b=bSOTVrNdIIgtHQ8z7R4qXVJ4Yo8ES7XVpHEbqGv711QIL3SAYnv0GzNMAD3hIUW6x0
         0oE0hgnb5BDKE7wZOcW1SRZb5d5XS7uXSq/P/ryDqVUbT3NVqyxcs2f1+Sad4DHj/0lJ
         MNhLVNiHjmqDqkXSJ5cYKn2dfvzUTe7Jj+ZbOtfLuqZ9JvKbGLCZUI1M6bMy1BcAC+zV
         jBZfrjRTJNtMLOzWOlR0lj1Fe+q1J17DY0/gaIVn7iMDN9MSbgN9HcPVLWhkGlJSL4fo
         4s/KBeW3u+R8aDaTJ4WDjFPb1LCV/QxAv3Yw8M1CISvwE1BqgUCs1oEzx/qH682AR7BD
         C0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pg4fNLNTjDSdd0vPCIQXtLYWhyk5ubFa4AGmgLOS+/o=;
        b=TNa298OFcrK0Hj9yBFTagQgNWlwefOnPMWBFnmQETD057gTE+kTpwnJp1nHBLLotBl
         6uwxBDHhjizQzATB9jkYOzg5FTJK45Nh5ycg3hn7ShF57+shi2l3QeBAO0Ca/42+dyTb
         s93Jg/YU1e7/ZHa2q3bOK/0lwKxCjBKsQ9xh8NpfB0Rz05vt4cyd3x4MEs+oVweZ7PhN
         nUaElj8ZG6CHjPyu4/vn2jDU7rZisAfoprNNigWJEIYM1o2AqWUys94g+4rXYL0K0l5G
         jKwgk+x55UX4nv6/NWnoYNceur80VARao+H1buelM8v/VI8roKWkdhlwPtTG50ZcA+20
         AYxg==
X-Gm-Message-State: AOAM532yk2TLrL45Aru8VX4WNcOllXaqUi+8uaOITdZ7eZ+sfqSgIDNj
        zCAYRgQnfhh0npGzACjHCSOtTKPfYz8=
X-Google-Smtp-Source: ABdhPJwAX1kO1U5qB6tR4Y3baTelFYoV5bKc3ZUl70JXEhIIJx2eJb9riUvEPtc/JuO/jx1oLmnFYQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr11293wrs.405.1602021918483;
        Tue, 06 Oct 2020 15:05:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm157709wrn.56.2020.10.06.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:18 -0700 (PDT)
Message-Id: <2d103292cecfef3b29d221b3d8f05adb0add4475.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:11 +0000
Subject: [PATCH v2 5/7] subtree: add git subtree use and ignore commands
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

Tell split to use or ignore larger sections of the history. In most cases
split does this automatically based on metadata from subtree add.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 78 ++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1559100c0e..e56621a986 100755
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
@@ -431,6 +433,18 @@ find_mainline_ref () {
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
@@ -796,20 +810,60 @@ cmd_add_commit () {
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
@@ -827,7 +881,7 @@ cmd_split () {
 		done
 	fi
 
-	unrevs="$(find_existing_splits "$dir" "$revs")"
+	unrevs="$(find_existing_splits "$dir" "$revs") $(exclude_processed_refs)"
 
 	mainline="$(find_mainline_ref "$dir" "$revs")"
 	if test -n "$mainline"
-- 
gitgitgadget

