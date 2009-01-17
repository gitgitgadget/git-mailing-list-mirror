From: "Tomi Pakarinen" <tomi.pakarinen@gmail.com>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree merge strategy
Date: Sat, 17 Jan 2009 21:16:21 +0200
Message-ID: <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org>
	 <1223932217-4771-9-git-send-email-spearce@spearce.org>
	 <200810232314.29867.robin.rosenberg@dewire.com>
	 <200901152205.00600.robin.rosenberg@dewire.com>
	 <20090115210936.GI10179@spearce.org>
Reply-To: tomi.pakarinen@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOGgL-0005hS-5A
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763632AbZAQTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbZAQTQZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:16:25 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49171 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763632AbZAQTQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:16:23 -0500
Received: by bwz14 with SMTP id 14so6471163bwz.13
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 11:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7nr3wEYIewyi2Su8SseNEx/tNRu6Xw50uZbCfWyat9o=;
        b=M4ZjjM0PkqHBYR8074cHMMQbP5/C6Xmjl7v7fGNZqjFq2xkh+i7eLSMDqAhtLk179o
         xvQ6IlRkWEJDjtwbc9sCwCc0hYuRa7buSgjQXG9S7sMrWDmvtJr4+P2BEUlZ4L+H/LvC
         1hs/l6DyZ3+0UTdM11NY+ZEC3FRL93+5Rvr6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=d1rjnNItQEZMvoAL3n34kp45y+rp3jOrTfKSpjGkwjSDMKDfgLGVKDKYsadMjeEEY+
         tZW615jpOQD36pYFKhYsXN1//MlMFYnQIAhnxJJOpicwNNxHwID1AcY5azy3QV0gLirj
         ETt3XxH/zJrBcbuIOV1DZG937ozoI/C2t0Spo=
Received: by 10.181.149.19 with SMTP id b19mr1356973bko.67.1232219781527;
        Sat, 17 Jan 2009 11:16:21 -0800 (PST)
Received: by 10.181.56.2 with HTTP; Sat, 17 Jan 2009 11:16:21 -0800 (PST)
In-Reply-To: <20090115210936.GI10179@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106094>

testTrivialTwoWay_disjointhistories() failed because merge strategy
didn't handle missing base
version. Am'i right?

  Tomi.

>From 1ed694b55d307c640d29eeebfcd108e08681297b Mon Sep 17 00:00:00 2001
From: Tomi Pakarinen <tomi.pakarinen@iki.fi>
Date: Sat, 17 Jan 2009 20:56:04 +0200
Subject: [PATCH] If base version missing, we can merge version from
one of other trees.

Signed-off-by: Tomi Pakarinen <tomi.pakarinen@iki.fi>
---
 .../jgit/merge/StrategySimpleTwoWayInCore.java     |   28 +++++++++++++++-----
 1 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
index 893add9..eb718ab 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/merge/StrategySimpleTwoWayInCore.java
@@ -43,6 +43,7 @@
 import org.spearce.jgit.dircache.DirCacheBuilder;
 import org.spearce.jgit.dircache.DirCacheEntry;
 import org.spearce.jgit.errors.UnmergedPathException;
+import org.spearce.jgit.lib.FileMode;
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.Repository;
 import org.spearce.jgit.treewalk.AbstractTreeIterator;
@@ -119,13 +120,26 @@ protected boolean mergeImpl() throws IOException {
 				}

 				final int modeB = tw.getRawMode(T_BASE);
-				if (modeB == modeO && tw.idEqual(T_BASE, T_OURS))
-					add(T_THEIRS, DirCacheEntry.STAGE_0);
-				else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
-					add(T_OURS, DirCacheEntry.STAGE_0);
-				else {
-					conflict();
-					hasConflict = true;
+				if (!FileMode.MISSING.equals(modeB)) {
+					if (modeB == modeO && tw.idEqual(T_BASE, T_OURS))
+						add(T_THEIRS, DirCacheEntry.STAGE_0);
+					else if (modeB == modeT && tw.idEqual(T_BASE, T_THEIRS))
+						add(T_OURS, DirCacheEntry.STAGE_0);
+					else {
+						conflict();
+						hasConflict = true;
+					}
+				} else {
+					if (!FileMode.MISSING.equals(modeO)
+							&& FileMode.MISSING.equals(modeT))
+						add(T_OURS, DirCacheEntry.STAGE_0);
+					else if (FileMode.MISSING.equals(modeO)
+							&& !FileMode.MISSING.equals(modeT))
+						add(T_THEIRS, DirCacheEntry.STAGE_0);
+					else {
+						conflict();
+						hasConflict = true;
+					}
 				}
 			}
 			builder.finish();
-- 
1.6.0.4
