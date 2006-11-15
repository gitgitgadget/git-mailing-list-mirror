X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: asf@boinkor.net
Subject: [PATCH] gitweb: Make RSS feed output prettier
Date: Wed, 15 Nov 2006 01:10:36 +0100
Message-ID: <11635494363452-git-send-email-asf@boinkor.net>
NNTP-Posting-Date: Wed, 15 Nov 2006 00:10:54 +0000 (UTC)
Cc: Andreas Fuchs <asf@boinkor.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31393>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk8MU-0003HZ-Ua for gcvg-git@gmane.org; Wed, 15 Nov
 2006 01:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966511AbWKOAKj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 19:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966512AbWKOAKj
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 19:10:39 -0500
Received: from baker.boinkor.net ([86.59.21.99]:11921 "EHLO
 baker.boinkor.net") by vger.kernel.org with ESMTP id S966511AbWKOAKi (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 19:10:38 -0500
Received: by baker.boinkor.net (Postfix, from userid 1000) id 9A9189195; Wed,
 15 Nov 2006 01:10:36 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

From: Andreas Fuchs <asf@boinkor.net>

* Wrap the commit message in <pre>
* Make file names into an unordered list
* Add links (diff, conditional blame, history) to the file list.
---
 gitweb/gitweb.perl |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e54a29e..2a79895 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4134,20 +4134,30 @@ XML
 		      "<content:encoded>" .
 		      "<![CDATA[\n";
 		my $comment = $co{'comment'};
+		print "<pre>\n";
 		foreach my $line (@$comment) {
-			$line = to_utf8($line);
-			print "$line<br/>\n";
+			$line = to_utf8(esc_html($line));
+			print "$line\n";
 		}
-		print "<br/>\n";
+		print "</pre><ul>\n";
 		foreach my $line (@difftree) {
 			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
 				next;
 			}
-			my $file = esc_path(unquote($7));
+			my $file_name = unquote($7);
+			my $file = esc_html($file_name);
+			my $parent = $co{'parent'};
+			my $hash = git_get_hash_by_path($commit, $file_name);
+			my $hashparent = git_get_hash_by_path($parent, $file_name);
+
 			$file = to_utf8($file);
-			print "$file<br/>\n";
+			print "<li>$file ";
+			print "[<a href=\"". esc_html("$my_url?p=$project;a=blobdiff;f=$file;h=$hash;hp=$hashparent;hb=$commit;hpb=$parent") ."\">diff</a>] ";
+			print "[<a href=\"". esc_html("$my_url?p=$project;a=blame;f=$file;hb=$commit") ."\">blame</a>] " if gitweb_check_feature('blame');
+			print "[<a href=\"". esc_html("$my_url?p=$project;a=history;f=$file;h=$commit") ."\">history</a>] ";
+			print "</li>\n";
 		}
-		print "]]>\n" .
+		print "</ul>]]>\n" .
 		      "</content:encoded>\n" .
 		      "</item>\n";
 	}
-- 
1.4.3.2
