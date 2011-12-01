From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] git-svn.perl: close the edit for propedits even with no mods
Date: Wed, 30 Nov 2011 21:37:27 -0500
Message-ID: <1322707047-24227-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: rmalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 03:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVwWx-0001we-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 03:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab1LAChn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 21:37:43 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50030 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab1LAChm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 21:37:42 -0500
Received: by ghrr1 with SMTP id r1so1346755ghr.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ePXYZAmf3OOUIwXBJendCB9vmAZ1GuZPWaC4LbikMaw=;
        b=jQvaYN3dNpL9U4QUQTX1NWj1EiwQY7j0g5ItnGo/nTZxngnnUfKOdp1G5Wh5APuKo4
         GPaEyWGJj3aML365noh0xvIqU9wzl/9ZcbYRbvPQFG57D424wIv8PNCeJjqJLqI2L16x
         3mObFtUjSPX+vCZYs7fA20oiJsVKcKkO1ndVY=
Received: by 10.236.136.167 with SMTP id w27mr8332053yhi.65.1322707062098;
        Wed, 30 Nov 2011 18:37:42 -0800 (PST)
Received: from brock (adsl-184-43-39-253.bgk.bellsouth.net. [184.43.39.253])
        by mx.google.com with ESMTPS id a11sm11048781anc.11.2011.11.30.18.37.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 18:37:40 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1RVwWo-0006JJ-P4; Wed, 30 Nov 2011 21:37:38 -0500
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186159>

It's legitimate to update the mergeinfo property without
actually changing any files.  This can happen when changes are
backported to a branch, and then that branch is merged back
into mainline.  We still want to record the updated mergeinfo
for book-keeping.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 177dd25..cd64659 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4867,7 +4867,7 @@ sub apply_diff {
 			               $self->{mergeinfo});
 	}
 	$self->rmdirs if $_rmdir;
-	if (@$mods == 0) {
+	if (@$mods == 0 && !defined($self->{mergeinfo})) {
 		$self->abort_edit;
 	} else {
 		$self->close_edit;
-- 
1.7.5.4
