From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Make git-send-email aware of Cc: lines.
Date: Sun, 18 Mar 2007 21:37:53 -0400
Message-ID: <20070319013753.GA23545@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6p9-0003YR-Ez
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXCSBh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933572AbXCSBh4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:37:56 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56352 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932887AbXCSBhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 21:37:55 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT6os-0007rx-1G; Sun, 18 Mar 2007 21:37:54 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42557>

In the Linux kernel, for example, it's common to include Cc: lines
for cases when you want to remember to cc someone on a patch without
necessarily claiming they signed off on it.  Make git-send-email
aware of these.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-send-email.txt |    3 ++-
 git-send-email.perl              |    8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 35b0104..ba5f3ef 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -59,7 +59,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	is not set, this will be prompted for.
 
 --no-signed-off-by-cc::
-	Do not add emails found in Signed-off-by: lines to the cc list.
+	Do not add emails found in Signed-off-by: or Cc: lines to the
+	cc list.
 
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
diff --git a/git-send-email.perl b/git-send-email.perl
index a71a192..e6d81f9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -65,8 +65,8 @@ Options:
                   Defaults to on.
 
    --no-signed-off-cc Suppress the automatic addition of email addresses
-                 that appear in a Signed-off-by: line, to the cc: list.
-		 Note: Using this option is not recommended.
+                 that appear in Signed-off-by: or Cc: lines to the cc:
+                 list.  Note: Using this option is not recommended.
 
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
@@ -562,8 +562,8 @@ foreach my $t (@files) {
 			}
 		} else {
 			$message .=  $_;
-			if (/^Signed-off-by: (.*)$/i && !$no_signed_off_cc) {
-				my $c = $1;
+			if (/^(Signed-off-by|Cc): (.*)$/i && !$no_signed_off_cc) {
+				my $c = $2;
 				chomp $c;
 				push @cc, $c;
 				printf("(sob) Adding cc: %s from line '%s'\n",
-- 
1.5.0.3.31.ge47c
