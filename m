From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6] gitweb: Correct error from changing "-|" open to list form in git_commit
Date: Sun, 30 Jul 2006 04:11:10 +0200
Message-ID: <200607300411.12766.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 04:11:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G70ll-0006iU-RI
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 04:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWG3CLC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 22:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWG3CLC
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 22:11:02 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:52444 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWG3CLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 22:11:00 -0400
Received: by ug-out-1314.google.com with SMTP id m3so255539ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 19:10:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C/eJn/t1bALSKuUCI1QhOODMJXo+0jd3TAZzUw5k5i6CxHcdL3/PFkTEkxFXLxruGQEBucusFJu3r8jRUHfUp4ZJmf1X+ME+3Vtu9wmheRWu7bw/gLrkdrXCAocTAJtx1MtG/F3qcG+Fck13Ggli2TRzVNaTvml5STvaZJtJDb0=
Received: by 10.66.222.9 with SMTP id u9mr1121771ugg;
        Sat, 29 Jul 2006 19:10:59 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id o1sm3263412uge.2006.07.29.19.10.58;
        Sat, 29 Jul 2006 19:10:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24446>

Correct error in moving to list form of open for running git commands
and reading their output through pipe (PATCH 2 in series) in
git_commit subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It also simplifies git_commit a tiny bit.

 gitweb/gitweb.cgi |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e1f0e26..86b9547 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1984,16 +1984,14 @@ sub git_commit {
 	my %cd = date_str($co{'committer_epoch'}, $co{'committer_tz'});
 
 	my @difftree;
-	my $root = "";
 	my $parent = $co{'parent'};
 	if (!defined $parent) {
-		$root = " --root";
-		$parent = "";
+		$parent = "--root";
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $root, $parent, $hash 
+	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $hash 
 		or die_error(undef, "Open git-diff-tree failed.");
 	@difftree = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading diff-tree failed.");
+	close $fd or die_error(undef, "Reading git-diff-tree failed.");
 
 	# non-textual hash id's can be cached
 	my $expires;
-- 
1.4.0
