From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/1 (amend)] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 11:04:18 +0200
Message-ID: <200610241104.18517.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com> <200610240008.08325.jnareb@gmail.com> <20061023232117.GV20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:04:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIDH-0006Go-Jq
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWJXJD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWJXJD4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:03:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61484 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030243AbWJXJDz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 05:03:55 -0400
Received: by ug-out-1314.google.com with SMTP id 32so150640ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 02:03:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sxvc8TYsr3SkaI3RqpnLZeBTh8lsmiRHx7zNKKedFBggbqmnirA0XC8IhGra+3MtApm+KEWKv/qiuaWfhVsg/u4hlklWiGMZXAEewobPcjULPW4IVtxSb3FA6t4bCkMsDoFkSlj+03QxWnb0w2ZvqSprGwz/UNaldZMl0szqEF8=
Received: by 10.66.244.10 with SMTP id r10mr8468763ugh;
        Tue, 24 Oct 2006 02:03:52 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e33sm377322ugd.2006.10.24.02.03.52;
        Tue, 24 Oct 2006 02:03:52 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061023232117.GV20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29949>

Use fixed string instead of shortened SHA1 identifier of commit
as a name for "mext" link in commitdiff view.

While at it make sure that we don't mistake option for a second
commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4241d5c..9c81214 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3289,17 +3289,14 @@ sub git_commitdiff {
 			                       hash=>$hash, hash_parent=>$hash_parent)},
 			        "raw");
 
-		if (defined $hash_parent) {
+		if (defined $hash_parent && $hash_parent !~ m/^-/) {
 			# commitdiff with two commits given
-			my $hash_parent_short = $hash_parent;
-			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-				$hash_parent_short = substr($hash_parent, 0, 7);
-			}
+			# second "commit" is not in fact diff option
 			$formats_nav .=
-				' (from: ' .
+				' (' .
 				$cgi->a({-href => href(action=>"commitdiff",
 				                       hash=>$hash_parent)},
-				        esc_html($hash_parent_short)) .
+				        'from') .
 				')';
 		} elsif (!$co{'parent'}) {
 			# --root commitdiff
@@ -3307,10 +3304,10 @@ sub git_commitdiff {
 		} elsif (scalar @{$co{'parents'}} == 1) {
 			# single parent commit
 			$formats_nav .=
-				' (parent: ' .
+				' (' .
 				$cgi->a({-href => href(action=>"commitdiff",
 				                       hash=>$co{'parent'})},
-				        esc_html(substr($co{'parent'}, 0, 7))) .
+				        'parent') .
 				')';
 		} else {
 			# merge commit
@@ -3319,7 +3316,7 @@ sub git_commitdiff {
 				join(' ', map {
 					$cgi->a({-href => href(action=>"commitdiff",
 					                       hash=>$_)},
-					        esc_html(substr($_, 0, 7)));
+					        'parent');
 				} @{$co{'parents'}} ) .
 				')';
 		}
-- 
1.4.2.1
