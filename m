From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: fix commitdiff for root commits
Date: Sun, 6 Aug 2006 16:14:25 +0200
Message-ID: <200608061614.25763.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 16:14:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9jOj-0005fE-Ek
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 16:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWHFOOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 10:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHFOOa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 10:14:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:63138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751243AbWHFOO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 10:14:29 -0400
Received: by nf-out-0910.google.com with SMTP id p46so160934nfa
        for <git@vger.kernel.org>; Sun, 06 Aug 2006 07:14:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e4llcA0Sl4uPlQFXdBW9LFm5WNvgBMDkdvxGn2c3LYHXZL95JwcQ9CgdfxrQ0TLl+31JWCiMjYHImEG8tKFOzuXKSgRnOtm2brFtokLWT2s9j1DHexQFalKHGP4r5ylh6Z+andZ2TahPTSCvWDc/wm9f9TD0BHd/QwFGMSMg+vw=
Received: by 10.49.91.6 with SMTP id t6mr7460231nfl;
        Sun, 06 Aug 2006 07:14:28 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id l27sm4839341nfa.2006.08.06.07.14.27;
        Sun, 06 Aug 2006 07:14:28 -0700 (PDT)
To: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24978>

After changing all "-|" open invocations to list form, commitdiff for
initial commit (without parent) got broken; it returned incorrectly
empty patch earlier.  Use '--root' option to git-diff-tree for initial
(root) commit.

No checking for empty $hash_parent in git_commitdiff_plain -- we rely
on gitweb to give correct parameters for commitdiff_plain action.

Noticed by Matthias Lederhofer (matled).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Patch based on 'next' branch (234416bff6c426a9abaaacef80ba3679c0ce8f39)

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d0672cd..bbea21a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2109,7 +2109,7 @@ sub git_commitdiff {
 		die_error(undef, "Unknown commit object");
 	}
 	if (!defined $hash_parent) {
-		$hash_parent = $co{'parent'};
+		$hash_parent = $co{'parent'} || '--root';
 	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
-- 
1.4.1.1
