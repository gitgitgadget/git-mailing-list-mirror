From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 25 Sep 2006 22:38:16 -0700 (PDT)
Message-ID: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-348614414-1159249096=:54765"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 26 07:39:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5ef-00047n-Ef
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWIZFig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWIZFig
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:38:36 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:22452 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751298AbWIZFiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:16 -0400
Received: (qmail 54953 invoked by uid 60001); 26 Sep 2006 05:38:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=p1Ddny7SVKmkaYUUANPX2Z0JED69CQZ5lt882QF/MPj+njxMN0FwdBW7851Db4ZgnuryAjn3iqFljqGGhnID3r+ToGXPW/jriSvNg2CaCEYXN6tyBN5PKf08Hn6doAEtmKpNWXNsitihStr2l75DGHnsF6WNzEjwZ4GnDdpw5iE=  ;
Received: from [71.80.233.118] by web31815.mail.mud.yahoo.com via HTTP; Mon, 25 Sep 2006 22:38:16 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27777>

--0-348614414-1159249096=:54765
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Binary and non-binary blobs:

The "list" table element of tree view is identical
to the "blob" link part of the link table element.
I.e. clicking on "blob" is identical to clicking on
the entry itself.

Thus, eliminate "blob" from being shown -- the user
can get identical result by simply clicking on the
entry itself.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)
--0-348614414-1159249096=:54765
Content-Type: text/inline; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: name="p1.txt"; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 66be619..c7ab3b6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1600,34 +1600,35 @@ sub git_print_tree_entry {
 	my %base_key = ();
 	$base_key{hash_base} = $hash_base if defined $hash_base;
 
+	# The format of a table row is: mode list link.  Where mode is
+	# the mode of the entry, list is the name of the entry, an href,
+	# and link is the action links of the entry.
+
 	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
-		      $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key),
-		              -class => "list"}, esc_html($t->{'name'})) .
-		      "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              "blob");
+			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+					       file_name=>"$basedir$t->{'name'}", %base_key),
+				 -class => "list"}, esc_html($t->{'name'})) . "</td>\n";
+		print "<td class=\"link\">";
 		if ($have_blame) {
-			print " | " .
-				$cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
-				                       file_name=>"$basedir$t->{'name'}", %base_key)},
-				        "blame");
+			print $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
+						     file_name=>"$basedir$t->{'name'}", %base_key)},
+				      "blame");
 		}
 		if (defined $hash_base) {
-			print " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
+			if ($have_blame) {
+				print " | ";
+			}
+			print $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
 		print " | " .
 		      $cgi->a({-href => href(action=>"blob_plain",
 		                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
-		              "raw") .
-		      "</td>\n";
+		              "raw");
+		print "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
 		print "<td class=\"list\">" .
-- 
1.4.2.1.gdbbb

--0-348614414-1159249096=:54765--
