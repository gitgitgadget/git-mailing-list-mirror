From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 3/3] Report symlink failures in merge-recursive
Date: Fri, 5 Dec 2008 01:39:14 +0100
Message-ID: <20081205003914.GC7294@blimp.localdomain>
References: <20081205003546.GA7294@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 01:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8OkE-0001OD-HC
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 01:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYLEAjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYLEAjR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 19:39:17 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:20807 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYLEAjR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 19:39:17 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8Ak82pR9a
Received: from tigra.home (Fadd1.f.strato-dslnet.de [195.4.173.209])
	by post.strato.de (klopstock mo55) (RZmta 17.20)
	with ESMTP id y05231kB4Nj3qD ; Fri, 5 Dec 2008 01:39:15 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id AFA50277C8;
	Fri,  5 Dec 2008 01:39:14 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 8B23E36D27; Fri,  5 Dec 2008 01:39:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081205003546.GA7294@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102383>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I don't check for unlink success in the line above, because symlink
will fail if unlink failed to cleanup the new path.

 merge-recursive.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0e988f2..a0c804c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -525,7 +525,8 @@ static void update_file_flags(struct merge_options *o,
 			char *lnk = xmemdupz(buf, size);
 			safe_create_leading_directories_const(path);
 			unlink(path);
-			symlink(lnk, path);
+			if (symlink(lnk, path))
+				die("failed to symlink %s: %s", path, strerror(errno));
 			free(lnk);
 		} else
 			die("do not know what to do with %06o %s '%s'",
-- 
1.6.1.rc1.29.gb140
