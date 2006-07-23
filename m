From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] show-branch: Fix another performance problem.
Date: Sun, 23 Jul 2006 19:51:04 +0200
Message-ID: <87mzb0fbw7.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 23 19:51:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4i77-0007kX-OM
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 19:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWGWRvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Jul 2006 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGWRvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Jul 2006 13:51:09 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:42474 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751080AbWGWRvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jul 2006 13:51:08 -0400
Received: from adsl-84-226-106-39.adslplus.ch ([84.226.106.39] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G4i6d-0001OT-6q
	for git@vger.kernel.org; Sun, 23 Jul 2006 12:51:07 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 9E4E44F904; Sun, 23 Jul 2006 19:51:04 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24099>

When naming commits, stop walking the parent chain as soon as we find
a commit that already has a name. The parent chain of that commit will
be walked later on in any case (or may even have been walked already).
This avoids O(n^2) behavior; on a tree where show-branch displays 6800
commits, the total run time drops from 77 seconds to 5 seconds.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-show-branch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3d240ca..82f75b7 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -89,6 +89,8 @@ static int name_first_parent_chain(struc
 			name_parent(c, p);
 			i++;
 		}
+		else
+			break;
 		c = p;
 	}
 	return i;
-- 
1.4.2.rc1.ge7a0

-- 
Alexandre Julliard
julliard@winehq.org
