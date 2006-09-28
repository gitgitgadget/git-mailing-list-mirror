From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Revert "gitweb: extend blame to show links to diff and previous"
Date: Wed, 27 Sep 2006 17:22:03 -0700 (PDT)
Message-ID: <20060928002203.56985.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-799634780-1159402923=:54937"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 28 02:22:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjfG-0003p3-Vj
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031281AbWI1AWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWI1AWH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:22:07 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:2650 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965171AbWI1AWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:22:04 -0400
Received: (qmail 56987 invoked by uid 60001); 28 Sep 2006 00:22:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l5TOzQH0X4nlqci24gPZZW5n7O2FUn+DZUoOpZSPooKmao2OnQfZtITNymVWkcGDF0OAu+8g+VSqZBUixpekpkJBk8zbuMcrkd0OiKd3G21QskjXkILnOo2HLuimddLfcbJDjHNRr4AQgdPzVKPLOP7dBVJ4JlbGYTiTNzTdT7I=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Wed, 27 Sep 2006 17:22:03 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27953>

--0-799634780-1159402923=:54937
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This concept is very fine, but it makes blame slow
across renames and across branches, so revert it.
There is a better way to do this.

This reverts commit 03d06a8e26f4fbd37800d1e1125c6ecf4c104466.
---
 gitweb/gitweb.perl |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

--0-799634780-1159402923=:54937
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d2519f0..56638f2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2439,7 +2439,7 @@ sub git_blame2 {
 	print <<HTML;
 <div class="page_body">
 <table class="blame">
-<tr><th>Prev</th><th>Diff</th><th>Commit</th><th>Line</th><th>Data</th></tr>
+<tr><th>Commit</th><th>Line</th><th>Data</th></tr>
 HTML
 	while (<$fd>) {
 		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
@@ -2447,8 +2447,6 @@ HTML
 		my $rev = substr($full_rev, 0, 8);
 		my $lineno = $2;
 		my $data = $3;
-		my %pco = parse_commit($full_rev);
-		my $parent = $pco{'parent'};
 
 		if (!defined $last_rev) {
 			$last_rev = $full_rev;
@@ -2457,25 +2455,11 @@ HTML
 			$current_color = ++$current_color % $num_colors;
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
-		# Print the Prev link
-		print "<td class=\"sha1\">";
-		print $cgi->a({-href => href(action=>"blame", hash_base=>$parent, file_name=>$file_name)},
-			      esc_html(substr($parent, 0, 8)));
-		print "</td>\n";
-		# Print the Diff (blobdiff) link
-		print "<td>";
-		print $cgi->a({-href => href(action=>"blobdiff", file_name=>$file_name, hash_parent_base=>$parent,
-					     hash_base=>$full_rev)},
-			      esc_html("Diff"));
-		print "</td>\n";
-		# Print the Commit link
 		print "<td class=\"sha1\">" .
 			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
 			        esc_html($rev)) . "</td>\n";
-		# Print the Line number
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
 		      esc_html($lineno) . "</a></td>\n";
-		# Print the Data
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
 	}
-- 
1.4.2.1.g271e


--0-799634780-1159402923=:54937--
