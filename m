From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH][gitweb] Make it possible to retrieve HEAD plain blob
Date: Tue, 6 Jun 2006 22:57:37 +0200
Message-ID: <20060606205737.GX10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 22:58:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnicf-00049m-LO
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 22:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWFFU5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWFFU5b
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 16:57:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10123 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751083AbWFFU5a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 16:57:30 -0400
Received: (qmail 5205 invoked by uid 2001); 6 Jun 2006 22:57:37 +0200
To: kay.sievers@vrfy.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21400>

Sometimes, it is useful to be able to link directly to the blob plain
version in the latest tree. This patch implements that.

Signed-off-by: Petr Baudis <pasky@suse.cz>

diff --git a/gitweb.cgi b/gitweb.cgi
index ea21fbe..abaf6ce 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -1376,7 +1376,8 @@ sub git_blob {
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash_base")}, "tree") . "<br/>\n";
 		if (defined $file_name) {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
-			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head") . "<br/>\n";
+			" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head") .
+			" (" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;hb=HEAD;f=$file_name")}, "plain") . ")<br/>\n";
 		} else {
 			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain") . "<br/>\n";
 		}
@@ -1414,6 +1415,10 @@ sub git_blob_plain {
 	my $save_as = "$hash.txt";
 	if (defined $file_name) {
 		$save_as = $file_name;
+		if (!defined $hash) {
+			my $base = $hash_base || git_read_head($project);
+			$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
+		}
 	}
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"$save_as\"");
 	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
