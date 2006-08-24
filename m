From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9] gitweb: Use git_get_name_rev_tags for commitdiff_plain X-Git-Tag: header
Date: Thu, 24 Aug 2006 19:45:30 +0200
Message-ID: <200608241945.30553.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHS-000163-2u
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWHXRqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 13:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWHXRqE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:46:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29778 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030432AbWHXRqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:46:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638006nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YS0Vd7ixD3r2bTSirGMC9D5z8fNLhUeoIRyE8L9CngjeeREJNLdgbaAONOvNQQxz4I6E6zii8ImE82p9m+uEGx+2I7Xq1+9KLfdoCXHMV/Hu7vyLgdxosxHmMrvgdTpyTtwLdG6H3NgU5LbsrEyK+uhhV8gAl7X4Na9Bj+zBLHE=
Received: by 10.49.75.2 with SMTP id c2mr4038491nfl;
        Thu, 24 Aug 2006 10:45:59 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.58;
        Thu, 24 Aug 2006 10:45:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25968>

Use git_get_rev_name_tags function for X-Git-Tag: header in
git_commitdiff('plain'), i.e. for commitdiff_plain action.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For example, commitdiff_plain for 6c7f4cebdb40c0d95c63d59538fd235dcf978029
commit -- the following query string:
   a=commitdiff_plain;p=git.git;h=6c7f4cebdb40c0d95c63d59538fd235dcf978029
outputs the following X-Git-Tag: header:
   X-Git-Tag: v1.4.2^0~2

 gitweb/gitweb.perl |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3bc3ff3..b2e8259 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2840,10 +2840,7 @@ sub git_commitdiff {
 
 	} elsif ($format eq 'plain') {
 		my $refs = git_get_references("tags");
-		my @tagnames;
-		if (exists $refs->{$hash}) {
-			@tagnames = map { s|^tags/|| } $refs->{$hash};
-		}
+		my $tagname = git_get_rev_name_tags($hash);
 		my $filename = basename($project) . "-$hash.patch";
 
 		print $cgi->header(
@@ -2857,10 +2854,9 @@ From: $co{'author'}
 Date: $ad{'rfc2822'} ($ad{'tz_local'})
 Subject: $co{'title'}
 TEXT
-		foreach my $tag (@tagnames) {
-			print "X-Git-Tag: $tag\n";
-		}
+		print "X-Git-Tag: $tagname\n" if $tagname;
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+
 		foreach my $line (@{$co{'comment'}}) {
 			print "$line\n";
 		}
-- 
1.4.1.1
