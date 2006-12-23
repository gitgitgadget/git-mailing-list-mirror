From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/17] Use off_t for index and pack file lengths.
Date: Sat, 23 Dec 2006 02:33:47 -0500
Message-ID: <20061223073347.GE9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:33:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1OH-0001oD-Ls
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWLWHdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbWLWHdv
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38752 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbWLWHdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Nl-00036m-7w; Sat, 23 Dec 2006 02:33:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E3BB620FB65; Sat, 23 Dec 2006 02:33:47 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35284>

Since the index_size and pack_size members of struct packed_git
are the lengths of those corresponding files we should use the
off_t size of the operating system to store these file lengths,
rather than an unsigned long.  This would help in the future should
we ever resurrect Junio's 64 bit index implementation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index bf1d776..936555c 100644
--- a/cache.h
+++ b/cache.h
@@ -347,10 +347,10 @@ struct pack_window {
 
 extern struct packed_git {
 	struct packed_git *next;
-	unsigned long index_size;
-	unsigned long pack_size;
 	struct pack_window *windows;
 	unsigned int *index_base;
+	off_t index_size;
+	off_t pack_size;
 	int pack_local;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
-- 
1.4.4.3.g87d8
