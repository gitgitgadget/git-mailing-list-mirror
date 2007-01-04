From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Remove shadowing variable from traverse_trees()
Date: Thu, 04 Jan 2007 19:33:36 +0100
Message-ID: <459D4880.9070804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 19:58:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2XnU-0003GS-M2
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 19:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbXADS5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 13:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXADS5H
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 13:57:07 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58744
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932261AbXADS5F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jan 2007 13:57:05 -0500
X-Greylist: delayed 1398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 13:57:05 EST
Received: from [10.0.1.3] (p508E5B47.dip.t-dialin.net [80.142.91.71])
	by neapel230.server4you.de (Postfix) with ESMTP id F0B8E1221A;
	Thu,  4 Jan 2007 19:33:45 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35947>

The variable named entry is allocated using malloc() and then
forgotten, it being shadowed by an automatic variable of the
same name.  Fixing the array size at 3 worked so far because
the only caller of traverse_trees() needed only as much
entries.  Simply remove the shadowing varaible and we're able
to traverse more than three trees and save stack space at the
same time!

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 tree-walk.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 14cc5ae..22f4550 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -113,7 +113,6 @@ void traverse_trees(int n, struct tree_desc *t, const char *base, traverse_callb
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 
 	for (;;) {
-		struct name_entry entry[3];
 		unsigned long mask = 0;
 		int i, last;
 
