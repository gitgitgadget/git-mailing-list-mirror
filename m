From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_feed
Date: Sat, 19 May 2007 02:47:51 +0200
Message-ID: <1179535671566-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 02:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpD6z-0007Hf-5k
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXESArw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXESArw
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:47:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:60836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbXESArv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:47:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so627908uga
        for <git@vger.kernel.org>; Fri, 18 May 2007 17:47:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=VLmsPdnWr7YOB+arK854ZvtsxLV7hK5AePX7wllazZJyOw1sxk0HlIzMUg0dnot3i+v6TUNVUUYdcNtmIXw4US+2vE9rT9wATSnjBiq7Nclgae2n0ugWPcRUHnWnrFSd3O7oNvSfyCxRJ3YCAB50CVBEEgYk26WsLUMyH1GlHis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=n7vJx6IS0UhB2Kq5VQdA1t2TkD1VSaja1Lm6IzkBGVXOht6hLCnPLIpQzV24sXQEtl+KTC1dwmDZBUneoWyP3apR7wU+eYW4i3e813z/Ma/W58UCTapQ3dBkaQ0E+x5jKMe8FYmW7sn7WMbxsuRQaP/itXlVRhEo0WC9v79Y3oM=
Received: by 10.66.252.18 with SMTP id z18mr1452865ugh.1179535669796;
        Fri, 18 May 2007 17:47:49 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm8131480mue.2007.05.18.17.47.48;
        Fri, 18 May 2007 17:47:49 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4J0lpMc008418;
	Sat, 19 May 2007 02:47:51 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4J0lpQC008417;
	Sat, 19 May 2007 02:47:51 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47699>

Initial (root) commit has no parents, and $co{'parent'} is
undefined. Use '--root' for initial commit.

This fixes "Use of uninitialized value in open at gitweb/gitweb.perl
line 4925." warning.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa8cc02..091cf9c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4923,7 +4923,8 @@ XML
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'}, $co{'id'}, "--", (defined $file_name ? $file_name : ())
+			$co{'parent'} || "--root",
+			$co{'id'}, "--", (defined $file_name ? $file_name : ())
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd
-- 
1.5.1.4
