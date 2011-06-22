From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Clean up code in git_search_* subroutines
Date: Wed, 22 Jun 2011 17:28:54 +0200
Message-ID: <1308756535-29701-5-git-send-email-jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:29:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPNH-0002OT-HU
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab1FVP3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:29:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385Ab1FVP33 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:29:29 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so714045fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=iejMQdckfUKskiyHwyMVIJcc4pzc/VJCC6YGQ40nqbs=;
        b=BbXsdLQuzUxMT0R35+NfQHlzsH59liSgKoFSuONEcOP7mu5BnC+ehI6J0b6VHIsvTH
         U1QuPzVx4QiovOawHjHcZshyUf0hgxYPgHviryNPhDznvKVWpwZqb39DHlE89Zp7nACa
         bdsybVC5PKGJdG/h738L9t9K8H8/KxmfVCwAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MXQhULEMmOrKopgSocKhKUNNaIGRf1s04L+AcBVBxuffLBE2SbP0OzSDqmsJG6va68
         W2M8cQLC1HeTLrwHooOxnFmNaM8Yzi++9LVrtEUhiGKa19MURJ8qadAi6iYaCjLBX2Hl
         8qdkF0KAfSFppouyGNTAm9jMVpa+OpYg6YNOo=
Received: by 10.223.94.129 with SMTP id z1mr1015161fam.144.1308756569283;
        Wed, 22 Jun 2011 08:29:29 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.27
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176243>

1. Replace sequence of

     $foo .= "bar";
     $foo .= "baz";

   with

     $foo .= "bar" .
             "baz";

2. Use href(-replay=>1, -page=>undef) for first page of a multip-page
   view.

3. Rewrap (rearrange) some lines to reduce their length. Some lines
   still have more than 80 characters, but lines are shorter now.

No functional changes.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c350c05..1c06476 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5559,16 +5559,13 @@ sub git_search_message {
 	my $paging_nav = '';
 	if ($page > 0) {
 		$paging_nav .=
-			$cgi->a({-href => href(action=>"search", hash=>$hash,
-			                       searchtext=>$searchtext,
-			                       searchtype=>$searchtype)},
-			        "first");
-		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(-replay=>1, page=>undef)},
+			        "first") .
+			" &sdot; " .
 			$cgi->a({-href => href(-replay=>1, page=>$page-1),
 			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
-		$paging_nav .= "first";
-		$paging_nav .= " &sdot; prev";
+		$paging_nav .= "first &sdot; prev";
 	}
 	my $next_link = '';
 	if ($#commitlist >= 100) {
@@ -5613,10 +5610,13 @@ sub git_search_changes {
 			if (%co) {
 				print "</td>\n" .
 				      "<td class=\"link\">" .
-				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})},
+				              "commit") .
 				      " | " .
-				      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-				print "</td>\n" .
+				      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'},
+				                             hash_base=>$co{'id'})},
+				              "tree") .
+				      "</td>\n" .
 				      "</tr>\n";
 			}
 
@@ -5650,10 +5650,13 @@ sub git_search_changes {
 	if (%co) {
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})},
+		              "commit") .
 		      " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-		print "</td>\n" .
+		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'},
+		                             hash_base=>$co{'id'})},
+		              "tree") .
+		      "</td>\n" .
 		      "</tr>\n";
 	}
 
-- 
1.7.5
