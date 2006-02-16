From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix revision order when XML::Simple is not loaded
Date: Thu, 16 Feb 2006 11:47:51 -0800
Message-ID: <20060216194751.GB4446@Muzzle>
References: <20060216073826.GA12055@hand.yhbt.net> <43F4A4B1.4010307@blairos.org> <20060216190426.GC12055@hand.yhbt.net> <43F4CF5E.1010700@blairos.org> <20060216194532.GA4446@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 20:48:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9p6i-00056r-3b
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 20:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWBPTr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWBPTrz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 14:47:55 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38294 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030359AbWBPTrz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 14:47:55 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by hand.yhbt.net (Postfix) with SMTP id 829322DC08D;
	Thu, 16 Feb 2006 11:47:53 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Thu, 16 Feb 2006 11:47:51 -0800
To: Emmanuel Guerin <manu.dev@blairos.org>
Content-Disposition: inline
In-Reply-To: <20060216073826.GA12055@hand.yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16311>

Thanks to Emmanuel Guerin for finding the bug.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

98de7584b4991ab9c4025e36bfbfc10eacd17b8d
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 62fc14f..ddd9579 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -523,7 +523,7 @@ sub svn_log_raw {
 
 			# if we have an empty log message, put something there:
 			if (@svn_log) {
-				$svn_log[0]->{msg} ||= "\n";
+				$svn_log[$#svn_log]->{msg} ||= "\n";
 			}
 			next;
 		}
@@ -538,7 +538,7 @@ sub svn_log_raw {
 					date => "$tz $Y-$m-$d $H:$M:$S",
 					author => $author,
 					msg => '' );
-			unshift @svn_log, \%log_msg;
+			push @svn_log, \%log_msg;
 			$state = 'msg_start';
 			next;
 		}
@@ -546,7 +546,7 @@ sub svn_log_raw {
 		if ($state eq 'msg_start' && /^$/) {
 			$state = 'msg';
 		} elsif ($state eq 'msg') {
-			$svn_log[0]->{msg} .= $_."\n";
+			$svn_log[$#svn_log]->{msg} .= $_."\n";
 		}
 	}
 	close $log_fh or croak $?;
-- 
1.2.0.gdee6
