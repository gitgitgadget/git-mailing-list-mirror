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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F1C3279D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359DA208B8
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsSj4Zcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgJFWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJFWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C41C0613D3
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z1so15132003wrt.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Re0tTXNL4gDIhFxT3jXKNLquiU/iqwZdKc/tizSqJc=;
        b=nsSj4ZcfPmwjI1gVZXB9AKG4mBslDLMy0blALE26ZacVpmhJkIwVNhRuhPlvzqJJ+g
         R06MDjrbcxP054YmRb669QxXzSPhzkgx2dsRA78Wz/ggkuFau0PaPU5kBTrZzOYQPRHI
         L+OwfMxOJXzZM0CZDLJAAefkLIudmuW+2W61rMMAR7rt/CbBC/yEz/Y++oJujSOVHbNq
         B607m791DopS7rOq4rqf6CWPkQM0NMpnmCSTSapOmycmo8RSMdP08hDT5o+oMNyr/xM7
         Is/MONjVWZ7fRqbUhxDBtfY8FMAwIpeFNrWNGjmOcFdoFRJIjDzIy4ef5c5+PxTFYq99
         vhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Re0tTXNL4gDIhFxT3jXKNLquiU/iqwZdKc/tizSqJc=;
        b=iD7bo3iKkN8Simuped4PAzYPfv3bWy3gNmHMkdEIwQXAGTh1DcwCEtV3qjB8RTHtb0
         d5iiAxiRUxS+gXXXxdWVj8ZFmTziK61czlVwalPi67ixRZhwoaBgawyMQnDuK6dKzkUg
         WcUCi5wC+pXvaCRpicbJMZLrPI4lYlKupcroY12WV026dqpl6/ucjBwZJW20ZjozVuJo
         J6MsIMh8FoiywLKfuYhjBAfzUEjgBLJzkoU5vt87FbmXLQDAPD9Mhcx/jWnu7EaMqoCL
         keb3FLD++AY1ZV/gA/pFExOq0BEchUO+1sAeQgKmmYx1yeB7d18HJA8dIof7V28M0i0P
         3j1g==
X-Gm-Message-State: AOAM533caMuDrObBuyKpfHXK0uWzDo8tT6nk016SdgWw9EGfZu95kebT
        mDkLVNyDnc//b2N0ACXLC4JmZYOXLnY=
X-Google-Smtp-Source: ABdhPJzfGk2JVK7Qe+seaiVSwtC5cJ9QiyGwBP6UcFWne2/KzSnI8ncxLXsSwZNDD9adke6505ukmA==
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr46759wrg.298.1602021916900;
        Tue, 06 Oct 2020 15:05:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm107616wmb.25.2020.10.06.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:16 -0700 (PDT)
Message-Id: <8eec18388c86071db47512b84118e3b9111bd34d.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:09 +0000
Subject: [PATCH v2 3/7] subtree: persist cache between split runs
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

Provide a mechanism for handling problematic commits. If the algorithm
in process_split_commit is getting something wrong, you can write a
corrected value to the cache before running split.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 160bad95c1..c21d620610 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -27,6 +27,7 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
+clear-cache   reset the subtree mapping cache
  options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
 "
@@ -48,6 +49,7 @@ annotate=
 squash=
 message=
 prefix=
+clearcache=
 
 debug () {
 	if test -n "$debug"
@@ -131,6 +133,9 @@ do
 	--no-rejoin)
 		rejoin=
 		;;
+	--clear-cache)
+		clearcache=1
+		;;
 	--ignore-joins)
 		ignore_joins=1
 		;;
@@ -206,9 +211,13 @@ debug "opts: {$*}"
 debug
 
 cache_setup () {
-	cachedir="$GIT_DIR/subtree-cache/$$"
-	rm -rf "$cachedir" ||
-		die "Can't delete old cachedir: $cachedir"
+	cachedir="$GIT_DIR/subtree-cache/$prefix"
+	if test -n "$clearcache"
+	then
+		debug "Clearing cache"
+		rm -rf "$cachedir" ||
+			die "Can't delete old cachedir: $cachedir"
+	fi
 	mkdir -p "$cachedir" ||
 		die "Can't create new cachedir: $cachedir"
 	mkdir -p "$cachedir/notree" ||
@@ -266,6 +275,16 @@ cache_set () {
 	echo "$newrev" >"$cachedir/$oldrev"
 }
 
+cache_set_if_unset () {
+	oldrev="$1"
+	newrev="$2"
+	if test -e "$cachedir/$oldrev"
+	then
+		return
+	fi
+	echo "$newrev" >"$cachedir/$oldrev"
+}
+
 rev_exists () {
 	if git rev-parse "$1" >/dev/null 2>&1
 	then
@@ -375,13 +394,13 @@ find_existing_splits () {
 			then
 				# squash commits refer to a subtree
 				debug "  Squash: $sq from $sub"
-				cache_set "$sq" "$sub"
+				cache_set_if_unset "$sq" "$sub"
 			fi
 			if test -n "$main" -a -n "$sub"
 			then
 				debug "  Prior: $main -> $sub"
-				cache_set $main $sub
-				cache_set $sub $sub
+				cache_set_if_unset $main $sub
+				cache_set_if_unset $sub $sub
 				try_remove_previous "$main"
 				try_remove_previous "$sub"
 			fi
@@ -688,6 +707,8 @@ process_split_commit () {
 		if test -n "$newparents"
 		then
 			cache_set "$rev" "$rev"
+		else
+			cache_set "$rev" ""
 		fi
 		return
 	fi
@@ -785,7 +806,7 @@ cmd_split () {
 			# the 'onto' history is already just the subdir, so
 			# any parent we find there can be used verbatim
 			debug "  cache: $rev"
-			cache_set "$rev" "$rev"
+			cache_set_if_unset "$rev" "$rev"
 		done
 	fi
 
@@ -798,7 +819,7 @@ cmd_split () {
 		git rev-list --topo-order --skip=1 $mainline |
 		while read rev
 		do
-			cache_set "$rev" ""
+			cache_set_if_unset "$rev" ""
 		done || exit $?
 	fi
 
-- 
gitgitgadget

