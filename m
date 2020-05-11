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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD6C54E8F
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B392720735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9OuXmsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgEKFuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728425AbgEKFuG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493CC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so9267614wrt.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GQAD/MDmXct+4RitGAO6I+mOATR/q3PVb4N4vqgRQp4=;
        b=F9OuXmsncwDRCgTt/L1vCz4BRKlGrbdyol0EFG7OslA0WAScvSqy0URzC7GjPJGds5
         SXsEnVzVXvJUEeHwtn6Tv7XntHNmKjrkRiSnf0ANnaAUQ9zjypfPDrrf7heoC9X3kAMI
         2ksSyXgBQPq+QleDmiGQOVbmCX+kmLhOnhFVu0WUByJtv75DpfA2c9MTyUnn4P89PdH9
         AUJxl5DANtFgHHwoTw7WJQstumlTX2z2aJjYygpM7mHX3NXO9U2poHF05oPfPRO7XBcc
         IXsAq84N/Fa5HRZ4MEbWpEZ7GLvkvXncxpHQCn2L2nWQplQH0vB4EYuYQot15+0j5Gei
         FLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GQAD/MDmXct+4RitGAO6I+mOATR/q3PVb4N4vqgRQp4=;
        b=cEjrqAJRg+/2wyc2hgmn27+HWUAAeB9SA9K+4rhrkriZ9Y7V+m4WPOS4iZhhR4CzC9
         if6MkwN3fRsHJLloGSH4PsTkqnYCpdNYk6XzWDRh8PkKsKu5PfCNmEJfoEJNNDJ6qJy5
         kQmJ59mSbBr/uzJfbWZrJ1mzj3609QNOjDc3DhtrLbio8+hVYUt/cftNPEYZ+FapOKbl
         p/jIN0BkjJJ5bqY2BxKGNl5wEhvuzDqAkiiY38TVFD097Q0l8C+BVeeTl5u3LcfYR/L/
         s9FRCYc+4Sfg8hxZoEZCkT+ezBc7ScVNwHKFtZIU3Hx0qWr8RFx6EXVFZ6dqFnqlcrSI
         3otQ==
X-Gm-Message-State: AGi0PublOyYiw1HuN8CJS714SxMUTnwpaHn2iexQggWBSJR6Yn105x7P
        +vu2gk+rYjiGkGcKhexNUkFxFi69
X-Google-Smtp-Source: APiQypIhP4mijoZgCXc6Ej4aJ4xoV9nSlPBvvNkG9kbR2lnvVkwcVl5REthszoGe6e8W/VuluJ0Cig==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr16563135wrc.367.1589176204553;
        Sun, 10 May 2020 22:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm14238799wrh.20.2020.05.10.22.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:04 -0700 (PDT)
Message-Id: <87af5a316a2ca75e28fda466a04c27bdb02b96b2.1589176201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:56 +0000
Subject: [PATCH 2/7] subtree: exclude commits predating add from recursive
 processing
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

Include recursion depth in debug logs so we can see when the recursion is
getting out of hand.

Making the cache handle null mappings correctly and adding older commits
to the cache allows the recursive algorithm to terminate at any point on
mainline rather than needing to reach either the add point or the initial
commit.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9867718503c..da0eede6979 100755
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
@@ -392,6 +392,26 @@ find_existing_splits () {
 	done
 }
 
+find_mainline_ref () {
+	debug "Looking for first split..."
+	dir="$1"
+	revs="$2"
+	main=
+	sub=
+	local grep_format="^git-subtree-dir: $dir/*\$"
+	git log --reverse --grep="$grep_format" \
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
@@ -646,9 +666,9 @@ process_split_commit () {
 
 	progress "$revcount/$revmax ($createcount) [$extracount]"
 
-	debug "Processing commit: $rev"
+	debug "Processing commit: $rev ($indent)"
 	exists=$(cache_get "$rev")
-	if test -n "$exists"
+	if test -z "$(cache_miss "$rev")"
 	then
 		debug "  prior: $exists"
 		return
@@ -773,6 +793,17 @@ cmd_split () {
 
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

