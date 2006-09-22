From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/6] gitweb: Link to associated tree from a particular log item in full log view
Date: Thu, 21 Sep 2006 21:18:09 -0700
Message-ID: <7vmz8s7cvy.fsf@assigned-by-dhcp.cox.net>
References: <20060922011941.15909.32671.stgit@rover>
	<20060922011948.15909.59511.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 06:18:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQcUT-0005Ki-Vq
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 06:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWIVESL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 00:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWIVESL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 00:18:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62080 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWIVESL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 00:18:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922041810.NHWF26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 00:18:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RGJC1V0041kojtg0000000
	Fri, 22 Sep 2006 00:18:12 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060922011948.15909.59511.stgit@rover> (Petr Baudis's message
	of "Fri, 22 Sep 2006 03:19:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27517>

I presume you are running this version at repo.or.cz, but

(1) go to http://repo.or.cz/?p=stgit.git;a=log
(2) pick "tree" of one of the commits
(3) go browser-back, then pick "tree" from the top navbar

The resulting tree view of (2) lacks navbar while (3) looks much
saner.

You do not have the tree object name available in git_log to
generate an URL with both h and hb, and getting to it is an
extra work.

This would fix this particular breakage.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 34ef3fc..8c0fdf3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2732,9 +2732,9 @@ sub git_tree {
 			my $base = $hash_base || $hash;
 			$hash = git_get_hash_by_path($base, $file_name, "tree");
 		}
-		if (!defined $hash_base) {
-			$hash_base = $hash;
-		}
+	}
+	if (!defined $hash_base) {
+		$hash_base = $hash;
 	}
 	$/ = "\0";
 	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
