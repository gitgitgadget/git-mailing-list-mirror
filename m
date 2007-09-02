From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix file name quoting in simplified out patch detection for --cc output
Date: Sun, 2 Sep 2007 22:22:13 +0200
Message-ID: <200709022222.13865.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 01:59:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzLE-0000H8-83
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbXIBX6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbXIBX6w
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:58:52 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:18328 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbXIBX60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:58:26 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1793834mue
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 16:58:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RQZNLge65/DjhQpEFASOsJRJQSbNfNbnxQY3OHaSUJKGka94asUkLfVxhW+RSywo9zB8c1hetiSlB08381+hqO2ZaBjnJoU2J5xtXr0I38Q1qmfGKbhjv0/x6PDf+EkoIit8kmPRw50pfNF8Ttzzceb+8BkPX2dhorMH/+czhTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I7ARdkowxe0ZtpUDV872wJ9cNOQ5KYb8aLpAS3QC73KTr0hwpDZLd3APRMQzG56fSQfPdvd5dctZUOt8vTccuATv+e2n22JlSAOH5yrgK5D3oEbK7JCgnqBRT8i7ZB30IAbiuXCEFDnqrSk0W2BPO3lImiVxVctogKZ56aTVtrs=
Received: by 10.86.26.11 with SMTP id 11mr2936683fgz.1188777504420;
        Sun, 02 Sep 2007 16:58:24 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm4707846fkf.2007.09.02.16.58.21
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Sep 2007 16:58:23 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57405>

For the --cc (compressed combined) diff output there can be patches
which are simple and got simplified out, so there is no patch
corresponding to raw output line.

Fix detection of of such simplified out patches: file name in git diff
header for --cc diff can be quoted; unquote it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch depends _textually_ on the just send
  "gitweb: Fix and simplify "split patch" detection"
patch, although it is _conceptually_ independent.

The commit message could be better...

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8c1e02c..5d424e5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3140,8 +3140,8 @@ sub git_patchset_body {
 			# compact combined diff output can have some patches skipped
 			# find which patch (using pathname of result) we are at now
 			my $to_name;
-			if ($patch_line =~ m!^diff --cc "?(.*)"?$!) {
-				$to_name = $1;
+			if ($patch_line =~ m!^diff --cc ("?.*"?)$!) {
+				$to_name = unquote($1);
 			}
 
 			do {
-- 
1.5.2.5
