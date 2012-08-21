From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git svn: handle errors and concurrent commits in
 dcommit
Date: Tue, 21 Aug 2012 22:01:25 +0000
Message-ID: <20120821220125.GA2040@dcvr.yhbt.net>
References: <1343856397-6536-1-git-send-email-robert@debian.org>
 <20120802104421.GA13271@dcvr.yhbt.net>
 <5021F9D4.1010700@debian.org>
 <20120808230754.GB24956@dcvr.yhbt.net>
 <7v1ujgot8h.fsf@alter.siamese.dyndns.org>
 <20120810195133.GA16423@dcvr.yhbt.net>
 <50316C07.30907@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Luberda <robert@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:01:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wVw-0007nA-VY
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661Ab2HUWB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:01:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40602 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421Ab2HUWB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:01:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4B0335BB;
	Tue, 21 Aug 2012 22:01:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50316C07.30907@debian.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203996>

Robert Luberda <robert@debian.org> wrote:
> While working on my next patch, I've accidentally discovered that bash gives
> the following errors in the test file introduced in my commit :
> 
> ./t9164-git-svn-dcommit-concrrent.sh: line 65: $hook: ambiguous redirect
> ./t9164-git-svn-dcommit-concrrent.sh: line 66: $hook: ambiguous redirect
> 
> (The test succeeds, even though assignments of the PATH and svnconf
> variables is missing; is seems svn treats an empty value of --config-dir
> as the current dir.)
> 
> 
> Sorry about not noticing this before, dash is used as default /bin/sh on
> my system. A simple patch for this issue is included below.
> 
> There is also a typo in the test file name: `concrrent' instead of
> `concurrent', but it most probably doesn't make any sense to make a
> patch for it.

Oops, I'll push the following out since Junio already merged your
original:

(your original patch was also whitespace-mangled)

>From 209b4ac46d70aa6f29d51c2fbefa53509513362c Mon Sep 17 00:00:00 2001
From: Robert Luberda <robert@debian.org>
Date: Mon, 20 Aug 2012 00:43:19 +0200
Subject: [PATCH] t9164: Add missing quotes in test

This fixes `ambiguous redirect' error given by bash.

[ew: fix misspelled test name,
     also eliminate space after ">>" to conform to guidelines]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 ...n-dcommit-concrrent.sh => t9164-git-svn-dcommit-concurrent.sh} | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
 rename t/{t9164-git-svn-dcommit-concrrent.sh => t9164-git-svn-dcommit-concurrent.sh} (97%)

diff --git a/t/t9164-git-svn-dcommit-concrrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
similarity index 97%
rename from t/t9164-git-svn-dcommit-concrrent.sh
rename to t/t9164-git-svn-dcommit-concurrent.sh
index aac2dda..d8464d4 100755
--- a/t/t9164-git-svn-dcommit-concrrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -60,11 +60,11 @@ setup_hook()
 		[ "$cnt" = "0" ] || exit 0
 EOF1
 	if [ "$hook_type" = "pre-commit" ]; then
-		echo "echo 'commit disallowed' >&2; exit 1" >> "$hook"
+		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
 	else
-		echo "PATH=\"$PATH\"; export PATH" >> $hook
-		echo "svnconf=\"$svnconf\"" >> $hook
-		cat >> "$hook" <<- 'EOF2'
+		echo "PATH=\"$PATH\"; export PATH" >>"$hook"
+		echo "svnconf=\"$svnconf\"" >>"$hook"
+		cat >>"$hook" <<- 'EOF2'
 			cd work-auto-commits.svn
 			svn up --config-dir "$svnconf"
 			echo "$$" >> auto_updated_file
-- 
Eric Wong
