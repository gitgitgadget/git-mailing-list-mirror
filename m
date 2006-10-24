From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Get rid of git_print_simplified_log
Date: Tue, 24 Oct 2006 13:52:46 +0200
Message-ID: <200610241352.46422.jnareb@gmail.com>
References: <200610241349.54685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 13:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKsV-0005Jy-Do
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWJXLz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWJXLz2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:55:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:13924 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030392AbWJXLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 07:55:24 -0400
Received: by ug-out-1314.google.com with SMTP id 32so174704ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 04:55:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=p9JaG3EJqKn3tdrGWIYyi3+iWrUmVJpZ4E1W/9oqYRsImI91fBpuxkLDpbf1t/GYNLRGqdWiZWSyXUqtWhK8/BSgYZRcyWC0K3k8VUaJdS4KQp+wMu4e2RSApJiGsSFd0ZMji6RIXMi0O5SgqDXGukAspWrFyYdCbUxYjjOsZjM=
Received: by 10.67.27.3 with SMTP id e3mr8666951ugj;
        Tue, 24 Oct 2006 04:55:13 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b35sm582575ugd.2006.10.24.04.55.13;
        Tue, 24 Oct 2006 04:55:13 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610241349.54685.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29970>

Replace calls to git_print_simplified_log with its expansion,
i.e. with calling git_print_log with appropriate options.

Remove no longer used git_print_simplified_log subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0a7d65c..8ac60be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1697,15 +1697,6 @@ sub git_print_log ($;%) {
 	}
 }
 
-sub git_print_simplified_log {
-	my $log = shift;
-	my $remove_title = shift;
-
-	git_print_log($log,
-		-final_empty_line=> 1,
-		-remove_title => $remove_title);
-}
-
 # print tree entry (row of git_tree), but without encompassing <tr> element
 sub git_print_tree_entry {
 	my ($t, $basedir, $hash_base, $have_blame) = @_;
@@ -2995,7 +2986,7 @@ sub git_log {
 		      "</div>\n";
 
 		print "<div class=\"log_body\">\n";
-		git_print_simplified_log($co{'comment'});
+		git_print_log($co{'comment'}, -final_empty_line=> 1);
 		print "</div>\n";
 	}
 	git_footer_html();
@@ -3365,7 +3356,7 @@ sub git_commitdiff {
 		git_print_authorship(\%co);
 		print "<div class=\"page_body\">\n";
 		print "<div class=\"log\">\n";
-		git_print_simplified_log($co{'comment'}, 1); # skip title
+		git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
 		print "</div>\n"; # class="log"
 
 	} elsif ($format eq 'plain') {
-- 
1.4.2.1
