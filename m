From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Fri, 29 Sep 2006 09:57:43 -0700 (PDT)
Message-ID: <20060929165743.2810.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-155651327-1159549063=:998"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 18:58:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTLgM-000700-7T
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 18:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWI2Q5r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWI2Q5r
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 12:57:47 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:5740 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161289AbWI2Q5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 12:57:46 -0400
Received: (qmail 2812 invoked by uid 60001); 29 Sep 2006 16:57:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LMYUWDZrp4VUJnXy+x/5aH2Rnfa0h6iWXib9wpkaFZI/go/Lg1Fxocviu1ceEHnRu20CMm33SZb5i2knu+FCXIUIgYm6jjF+VdnPJaO7f8HfqOwJfQ0AJhPAYjoLfq0yY5CxliEQvZbThy0qmA6ib82Im+jkTuG4Pyw82fs1Huc=  ;
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Fri, 29 Sep 2006 09:57:43 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28114>

--0-155651327-1159549063=:998
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

In tree view, by default, hash_base is HEAD and hash is the
entry equivalent.  Else the user had selected a hash_base or
hash, say by clicking on a revision or commit, in which case
those values are used.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--0-155651327-1159549063=:998
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index be336f6..44991b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1672,9 +1672,9 @@ sub git_print_tree_entry {
 			              "history");
 		}
 		print " | " .
-		      $cgi->a({-href => href(action=>"blob_plain",
-		                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
-		              "raw");
+			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
+					       file_name=>"$basedir$t->{'name'}")},
+				"raw");
 		print "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
@@ -2745,14 +2745,14 @@ sub git_blob {
 sub git_tree {
 	my $have_snapshot = gitweb_have_snapshot();
 
+	if (!defined $hash_base) {
+		$hash_base = "HEAD";
+	}
 	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
 		if (defined $file_name) {
-			my $base = $hash_base || $hash;
-			$hash = git_get_hash_by_path($base, $file_name, "tree");
-		}
-		if (!defined $hash_base) {
-			$hash_base = $hash;
+			$hash = git_get_hash_by_path($hash_base, $file_name, "tree");
+		} else {
+			$hash = $hash_base;
 		}
 	}
 	$/ = "\0";

--0-155651327-1159549063=:998--
