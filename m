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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEEAC54E4A
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E0220735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XltBJSxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgEKFuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728425AbgEKFuI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D54C061A0E
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id 50so8718121wrc.11
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AAxY8j945f69v90NhqlHuUZ/gMyEzGE+f4u2VTugB6k=;
        b=XltBJSxIXJ6mJWzelJkY3ifw6f4TwitjTrK09uCxEZaLnWpRJEUYLxT2dhFNlNTFt+
         v3bWm1lkQBt4g4oWPEQhen/6VmEQpKjg/ZRYKxCZ/TUAMLI5RecZV+cOcxihOlpltpDp
         Ovf6bfRsJ8jJBivkzZDYmXF7mi8bvzrr84P5BdUav+/2q4OqKwlD8dEXLqBSQ+97bFWN
         9975t+qJnnOdI1Mxsdn4xntcz6DWEl2ezcSmHBD/qKOecYJvpvpiYggl7WEXn26mVS3Y
         PO9FV0kgtGseQHQPIiBDQ+FmDMXHlylZ9J1qa9awrwBmotk+JXhy7fjTh2BaJWvjhsTX
         4OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AAxY8j945f69v90NhqlHuUZ/gMyEzGE+f4u2VTugB6k=;
        b=NFovEWkIzmMbbOE6U0soWpk5iusgO1EtVpsRD50ApWmlgBV9c7BgvEHn18+X1jz4bW
         /6TjtM5F3LuP3abzloSq50k3l7mQn9gjJlt4dqZjBxSmmNNKbIRsJss73HfZIvn9cNZq
         Kv1W6RrZrb8HZYMCdCIGswF4qppnGeeClLSXmLLnoNFNQqRXk0Wi4mWFrUZeBDDzKrQq
         ndDuemU55M3phrWI9czy3TR4AZwsMTDeevOLIJz2rwUsEmx01GmEZH9E204Dm9N0veeh
         SJ/AxjXzGbQxbjszbonETte6o8vT4ufOwS8Le3CFfrJyj88xRDlUfQuV/iYhbcr1KtIQ
         fKZw==
X-Gm-Message-State: AGi0PuZXiIyc+EWcAFVg2QKdKznNXHoIpqbUpfZt/Z0E9b8C+gSU41ia
        uxEZcnnSeD4mFefrmIEq3c6fvbXs
X-Google-Smtp-Source: APiQypINsY5LVtaYBNcGhDoD5FLWnddH7Ab14PBqbB5AgjVuN/rSINypizEkS9wgIXHyJzPqvceAPw==
X-Received: by 2002:adf:f84c:: with SMTP id d12mr663080wrq.248.1589176206607;
        Sun, 10 May 2020 22:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm4382399wro.15.2020.05.10.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:05 -0700 (PDT)
Message-Id: <a67c256a598cfa8cb0bcc57fee89f16b0251a4a8.1589176202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:58 +0000
Subject: [PATCH 4/7] subtree: add git subtree map command
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

Adds an entry to the subtree cache so that subsequent split runs can skip
any commits that turn out to be problematic.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 90f92f4e949..f8ae1283cd3 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -15,6 +15,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
 git subtree split --prefix=<prefix> <commit>
+git subtree map   --prefix=<prefix> <mainline> <subtree>
 --
 h,help        show the help
 q             quiet
@@ -161,7 +162,7 @@ command="$1"
 shift
 
 case "$command" in
-add|merge|pull)
+add|merge|pull|map)
 	default=
 	;;
 split|push)
@@ -192,7 +193,8 @@ dir="$(dirname "$prefix/.")"
 
 if test "$command" != "pull" &&
 		test "$command" != "add" &&
-		test "$command" != "push"
+		test "$command" != "push" &&
+		test "$command" != "map"
 then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
@@ -795,6 +797,21 @@ cmd_add_commit () {
 	say "Added dir '$dir'"
 }
 
+cmd_map () {
+	oldrev="$1"
+	newrev="$2"
+
+	if test -z "$oldrev"
+	then
+		die "You must provide a revision to map"
+	fi
+
+	cache_setup || exit $?
+	cache_set "$oldrev" "$newrev"
+
+	say "Mapped $oldrev => $newrev"
+}
+
 cmd_split () {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
-- 
gitgitgadget

