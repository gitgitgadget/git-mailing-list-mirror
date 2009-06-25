From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 9/8] gitweb: put signoff lines in a table
Date: Thu, 25 Jun 2009 15:21:37 +0200
Message-ID: <1245936097-29538-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJotf-00048v-4z
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZFYNVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbZFYNVg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:21:36 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42181 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZFYNVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 09:21:35 -0400
Received: by fxm9 with SMTP id 9so1442633fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0oYiERZpmx5sxTc15Il21H1v1QyajdA2Am549gZ6ry0=;
        b=MmL3dJPMUuYcKb/nCus+uhNqW1Cd/I+rN+uAPahc1yuLp6DJP+SfPscD0TCtHMxkH+
         QoiCGBOZjL3womXGWq0xMRIvrQ/dcyJGMf0L+zdpuhuZ/MX9rFboYIFSw1qONrAxvOfp
         A3tjjft5h6K/8f07r826S6mdyQDv26v/+HmwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HcpNGK6jY3s1pCQog0XqDW0FhN3zU7fezKove0ngIZC49nUy55NazHau849UfFgxVP
         PXSn0xU/MV2XWIDoogpKxyKYhplG7H5M/ClcZQQKpThOoQYucijxhsFvWgGWCbpD+BfT
         eB3QS2k3d3fOeHAF14kdj0/I5u5Fxh0yJIwHI=
Received: by 10.103.241.5 with SMTP id t5mr1530265mur.123.1245936096894;
        Thu, 25 Jun 2009 06:21:36 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 25sm11391651mul.50.2009.06.25.06.21.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 06:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122209>

This allows us to give better alignments to the components.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Better, but still far from perfect.

 gitweb/gitweb.css  |    6 +++++-
 gitweb/gitweb.perl |   47 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index ad82f86..21c24fa 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -115,10 +115,14 @@ span.age {
 	font-style: italic;
 }
 
-span.signoff {
+.signoff {
 	color: #888888;
 }
 
+table.signoff td:first-child {
+	text-align: right;
+}
+
 div.log_link {
 	padding: 0px 8px;
 	font-size: 70%;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d385f55..53b8817 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3402,15 +3402,31 @@ sub git_print_log {
 	# print log
 	my $signoff = 0;
 	my $empty = 0;
+	my $signoff_table = 0;
 	foreach my $line (@$log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
+		if ($line =~ s/^ *(signed[ \-]off[ \-]by|(?:trivially[ \-])?acked[ \-]by|cc|looks[ \-]right[ \-]to[ \-]me[ \-]by)[ :]//i) {
+			$signoff = $1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
-				my ($email) = $line =~ /<(\S+@\S+)>/;
-				print "<span class=\"signoff\">" . esc_html($line) . "</span>";
-				print git_get_avatar($email, 'pad_before' => 1) if $email;
-				print "<br/>\n";
+				if (!$signoff_table) {
+					print "<table class=\"signoff\">\n";
+					$signoff_table = 1;
+				}
+				my $email;
+				if ($line =~ s/\s*<(\S+@\S+)>//) {
+					$email = $1;
+				}
+				print "<tr>";
+				print "<td>$signoff</td>";
+				print "<td>" . esc_html($line) . "</td>";
+				if ($email && $git_avatar) {
+					print "<td>";
+					print git_get_avatar($email);
+					print "</td>";
+				} else {
+					print "<td>" . esc_html("<$email>") . "</td>";
+				}
+				print "</tr>\n";
 				next;
 			} else {
 				# remove signoff lines
@@ -3429,7 +3445,26 @@ sub git_print_log {
 			$empty = 0;
 		}
 
+		# if we're in a signoff block, empty lines
+		# are empty rows, other lines terminate
+		# the block
+		if ($signoff_table) {
+			if ($empty) {
+				print "<tr />\n";
+				next;
+			}
+			print "</table>\n";
+			$signoff_table = 0;
+		}
+
 		print format_log_line_html($line) . "<br/>\n";
+
+	}
+
+	# close the signoff table if it's still open
+	if ($signoff_table) {
+		print "</table>\n";
+		$signoff_table = 0;
 	}
 
 	if ($opts{'-final_empty_line'}) {
-- 
1.6.3.rc1.192.gdbfcb
