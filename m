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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17EAC54E8E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C160220735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeLNBezp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgEKFuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728466AbgEKFuI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2316C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y3so9267638wrt.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/jMhbkkO4maq73ccMOhV79AHD3onW9OfMpRucl5jI3w=;
        b=BeLNBezpnkB9BDkWLPQ74HO4fqhwS/o8kM//f1SDSSdqVKMR4PHMabdLdoM7lRM7t2
         1fb5X3KbmvkddOeQVa99EuzoPePd5tRaDrPFJiekY97iTb8XdXta0JEWHKabqEaahYuX
         6yOPwABj5nJLLcwHJ7EYWwIV0kQ9y+HvdQDPS6vc3IcnTHt2VJzzx4Di2K+Qut2uJV0i
         2efQfZ2xUegwXKJkaYzc9hrfgjTOu6Bk9wa4Xq0n9Jgw7iuVFKePsMKEqWDBIYyx38Eg
         hnEQtQKO8bkihSuMoLU6BkEN+QLhtgh4wA+XqGtecoN8FLYoRXe5RblKqfPFHsxqjEen
         my9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/jMhbkkO4maq73ccMOhV79AHD3onW9OfMpRucl5jI3w=;
        b=OlS1MAxc5uDFOQIVimrKHs07R27G9XVj+N6IIDCi/ZKoVDa8R7rJMjvElR7NA1QCEc
         njV8iT3K4GuaDbTEWd1LectSpGMmkYMaZxHeWCLmoO5WFlAyWEhWCPxF0Wt6ykI2BwTe
         bbnW4oZUz62vvxaqPwmU/moy6cg9i8Dd+295C0uUvVHjsVD7IJr8Ftj99BX+OQJ9YSDM
         OMjv6dRZ9suVxQiCl1+6UQiz6H4Cn13+V2IsAL+NE42LHqpuBxFZ9r/8TpGQuGK0DiPL
         scLhc6lCfxpVpxKhj7jlTMf036WY1peuO4f1pp8a7fsKpbs+eyisvqbE21dMz4lw7ndA
         AWxQ==
X-Gm-Message-State: AGi0PuYG76DHsdYcsMxZJivLqrw1lK2ze+isNXolfx4OSX4X/X3RXeig
        AipjaBGCN9dDoePADCFOs2BiIoRr
X-Google-Smtp-Source: APiQypL89e0oo4bOvtu03ZeBI97xvTBlLSH7TK1U2oxJe1/GzXO8HwCNilzlXxmSGNeP4bnAw4Bwxg==
X-Received: by 2002:adf:e784:: with SMTP id n4mr17771228wrm.170.1589176205234;
        Sun, 10 May 2020 22:50:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm17567489wrg.84.2020.05.10.22.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:04 -0700 (PDT)
Message-Id: <c892ee9828b019973152c6fa27b59a06c1d93e11.1589176201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:57 +0000
Subject: [PATCH 3/7] subtree: persist cache between split runs
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

Provide a mechanism for handling problematic commits. If the algorithm
in process_split_commit is getting something wrong, you can write a
corrected value to the cache before running split.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index da0eede6979..90f92f4e949 100755
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
@@ -690,6 +709,8 @@ process_split_commit () {
 		if test -n "$newparents"
 		then
 			cache_set "$rev" "$rev"
+		else
+			cache_set "$rev" ""
 		fi
 		return
 	fi
@@ -787,7 +808,7 @@ cmd_split () {
 			# the 'onto' history is already just the subdir, so
 			# any parent we find there can be used verbatim
 			debug "  cache: $rev"
-			cache_set "$rev" "$rev"
+			cache_set_if_unset "$rev" "$rev"
 		done
 	fi
 
@@ -800,7 +821,7 @@ cmd_split () {
 		git rev-list --topo-order --skip=1 $mainline |
 		while read rev
 		do
-			cache_set "$rev" ""
+			cache_set_if_unset "$rev" ""
 		done || exit $?
 	fi
 
-- 
gitgitgadget

