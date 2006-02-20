From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rerere: avoid open "-|" list form for Perl 5.6
Date: Mon, 20 Feb 2006 14:12:12 -0800
Message-ID: <7vpslhaddv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:13:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBJH5-0007iL-Ex
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 23:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWBTWMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 17:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWBTWMc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 17:12:32 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:65163 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932680AbWBTWMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 17:12:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220221049.ZZRZ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 17:10:49 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16503>


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-rerere.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

46fa107ab91b25eb928a9945ce4e9143b9c36df3
diff --git a/git-rerere.perl b/git-rerere.perl
index df11951..d3664ff 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -131,7 +131,11 @@ sub record_preimage {
 sub find_conflict {
 	my $in;
 	local $/ = "\0";
-	open $in, '-|', qw(git ls-files -z -u) or die "$!: ls-files";
+	my $pid = open($in, '-|');
+	die "$!" unless defined $pid;
+	if (!$pid) {
+		exec(qw(git ls-files -z -u)) or die "$!: ls-files";
+	}
 	my %path = ();
 	my @path = ();
 	while (<$in>) {
-- 
1.2.2.g5be4ea
