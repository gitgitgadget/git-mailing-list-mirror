From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use describe to come up with the closest tag.
Date: Wed, 08 Feb 2006 16:01:11 -0800
Message-ID: <7vmzh1mmd4.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<7vu0b9mmij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 01:01:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zFQ-0001fF-71
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWBIABR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWBIABQ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:01:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15289 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422671AbWBIABQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:01:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208235853.FAAE17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 18:58:53 -0500
To: Kay Sievers <kay.sievers@suse.de>
In-Reply-To: <7vu0b9mmij.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Feb 2006 15:57:56 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15768>

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This gives saner output than what is currently there.  It
   does not have direct relation to the diff-tree --cc patch,
   but over there I already use describe so this patch is to
   make things consistent.

 gitweb.cgi |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

3fb28888448edc8b2d4aeab55bc13d78746e5a45
diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..3c43695 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -2051,20 +2051,11 @@ sub git_commitdiff_plain {
 	close $fd or die_error(undef, "Reading diff-tree failed.");
 
 	# try to figure out the next tag after this commit
-	my $tagname;
 	my $refs = read_info_ref("tags");
-	open $fd, "-|", "$gitbin/git-rev-list HEAD";
-	chomp (my (@commits) = <$fd>);
+	open $fd, "-|", "$gitbin/git-describe $hash";
+	my ($tagname) = <$fd>;
+	chomp($tagname);
 	close $fd;
-	foreach my $commit (@commits) {
-		if (defined $refs->{$commit}) {
-			$tagname = $refs->{$commit}
-		}
-		if ($commit eq $hash) {
-			last;
-		}
-	}
-
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
 	my %co = git_read_commit($hash);
 	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
-- 
1.1.6.gbb042
