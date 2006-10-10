From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Understand the meaning of commas in git-send-email
Date: Tue, 10 Oct 2006 08:59:36 -0600
Message-ID: <20061010145936.GC8993@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 10 17:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXJ56-0008QY-0h
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 16:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWJJO7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJJO7i
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 10:59:38 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:55466 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932141AbWJJO7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 10:59:37 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id C7756494009; Tue, 10 Oct 2006 08:59:36 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28633>


I made the mistake of adding one Cc: line with two email addresses on
it, instead of two Cc: lines with one email address each.  Extending
git-send-email to parse that case turns out to not be too much work.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

--- /usr/bin/git-send-email	2006-07-29 09:52:13.000000000 -0600
+++ ./git-send-email.perl	2006-10-10 08:46:13.000000000 -0600
@@ -537,13 +542,15 @@
 	my @emails;
 
 	foreach my $entry (@_) {
-		if (my $clean = extract_valid_address($entry)) {
-			$seen{$clean} ||= 0;
-			next if $seen{$clean}++;
-			push @emails, $entry;
-		} else {
-			print STDERR "W: unable to extract a valid address",
-					" from: $entry\n";
+		foreach my $addr (split(/, */, $entry)) {
+			if (my $clean = extract_valid_address($addr)) {
+				$seen{$clean} ||= 0;
+				next if $seen{$clean}++;
+				push @emails, $addr;
+			} else {
+				print STDERR "W: unable to extract a valid",
+					" address from: $entry\n";
+			}
 		}
 	}
 	return @emails;
