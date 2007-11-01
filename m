From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Use href(-replay=>1, action=>...) to generate alternate views
Date: Thu,  1 Nov 2007 13:06:29 +0100
Message-ID: <1193918789-16421-5-git-send-email-jnareb@gmail.com>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:04:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYmm-0008UE-JS
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbXKAMEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbXKAMEM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:04:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34286 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbXKAMEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:04:02 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453896ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oNpr9OVaEY3JgvYlnnkt73X4hL4/YM28ajKr+U5oqPU=;
        b=Sf0+xungl1GfXezIiZThgE58hGJCMxlKq8ewnogF1JSEMdZ4Vfud9z++l0U3F4blG556vZv5lYOHcURwilodtHukF92rtxNKcbvg/tdZp1kxT3gvVX83CJCGVroIZ85H5oBYTtj8+3pgFqE72mpvpipKz7pmQgKKCQ4MiCio0wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eTejFWzQi1JQKNKqKoTH7RKthx7XoxuTbLMvV/xP7y33TEEDnAfk9FZXUHSPVrxldwd9Y3lfuVFhaEKWfG9s/XOJ6ip9UNYRG4MXenWaAiYqHTEvypajfWwJQABPgGSXbqRBaazcE/mmftuqZrX5KPVYll+bhZmJIKSjS+CyUQs=
Received: by 10.66.249.16 with SMTP id w16mr1342270ugh.1193918640988;
        Thu, 01 Nov 2007 05:04:00 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id q40sm5726063ugc.2007.11.01.05.03.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:04:00 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1C6WF0016542;
	Thu, 1 Nov 2007 13:06:32 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1C6WOG016541;
	Thu, 1 Nov 2007 13:06:32 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62943>

Use href(action=>..., -replay=>1) to generate links to alternate views
of current page in the $formats_nav (bottom) part of page_nav
navigation bar.  This form is used only when all parameters are
repeated, and when the replay form is shorter.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 20d4009..827f977 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3911,11 +3911,11 @@ sub git_blame2 {
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
-		$cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
+		$cgi->a({-href => href(action=>"blob", -replay=>1)},
 		        "blob") .
 		" | " .
-		$cgi->a({-href => href(action=>"history", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)},
-			"history") .
+		$cgi->a({-href => href(action=>"history", -replay=>1)},
+		        "history") .
 		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
 		        "HEAD");
@@ -4191,18 +4191,15 @@ sub git_blob {
 		if (defined $file_name) {
 			if ($have_blame) {
 				$formats_nav .=
-					$cgi->a({-href => href(action=>"blame", hash_base=>$hash_base,
-					                       hash=>$hash, file_name=>$file_name)},
+					$cgi->a({-href => href(action=>"blame", -replay=>1)},
 					        "blame") .
 					" | ";
 			}
 			$formats_nav .=
-				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-				                       hash=>$hash, file_name=>$file_name)},
+				$cgi->a({-href => href(action=>"history", -replay=>1)},
 				        "history") .
 				" | " .
-				$cgi->a({-href => href(action=>"blob_plain",
-				                       hash=>$hash, file_name=>$file_name)},
+				$cgi->a({-href => href(action=>"blob_plain", -replay=>1)},
 				        "raw") .
 				" | " .
 				$cgi->a({-href => href(action=>"blob",
@@ -4210,7 +4207,8 @@ sub git_blob {
 				        "HEAD");
 		} else {
 			$formats_nav .=
-				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "raw");
+				$cgi->a({-href => href(action=>"blob_plain", -replay=>1)},
+				        "raw");
 		}
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -4273,8 +4271,7 @@ sub git_tree {
 		my @views_nav = ();
 		if (defined $file_name) {
 			push @views_nav,
-				$cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
-				                       hash=>$hash, file_name=>$file_name)},
+				$cgi->a({-href => href(action=>"history", -replay=>1)},
 				        "history"),
 				$cgi->a({-href => href(action=>"tree",
 				                       hash_base=>"HEAD", file_name=>$file_name)},
@@ -4742,10 +4739,7 @@ sub git_blobdiff {
 	# header
 	if ($format eq 'html') {
 		my $formats_nav =
-			$cgi->a({-href => href(action=>"blobdiff_plain",
-			                       hash=>$hash, hash_parent=>$hash_parent,
-			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
-			                       file_name=>$file_name, file_parent=>$file_parent)},
+			$cgi->a({-href => href(action=>"blobdiff_plain", -replay=>1)},
 			        "raw");
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
@@ -4819,8 +4813,7 @@ sub git_commitdiff {
 	my $formats_nav;
 	if ($format eq 'html') {
 		$formats_nav =
-			$cgi->a({-href => href(action=>"commitdiff_plain",
-			                       hash=>$hash, hash_parent=>$hash_parent)},
+			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
 
 		if (defined $hash_parent &&
-- 
1.5.3.4
