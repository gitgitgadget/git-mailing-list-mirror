From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 14/17] Improve error message when packfile mmap fails.
Date: Sat, 23 Dec 2006 02:34:41 -0500
Message-ID: <20061223073441.GO9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1P5-0001ux-0f
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbWLWHep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbWLWHep
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38820 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbWLWHeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Oc-0003DN-UI; Sat, 23 Dec 2006 02:34:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9378220FB65; Sat, 23 Dec 2006 02:34:41 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35293>

If we are unable to mmap the a region of the packfile with the mmap()
system call there may be a good reason why, such as a closed file
descriptor or out of address space.  Reporting the system level
error message can help to debug such problems.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fab2ab0..7872c2d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -590,7 +590,9 @@ unsigned char* use_pack(struct packed_git *p,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base == MAP_FAILED)
-				die("packfile %s cannot be mapped.", p->pack_name);
+				die("packfile %s cannot be mapped: %s",
+					p->pack_name,
+					strerror(errno));
 			win->next = p->windows;
 			p->windows = win;
 		}
-- 
1.4.4.3.g87d8
