From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] add -p: print errors in help colors
Date: Mon,  2 Feb 2009 22:46:31 +0100
Message-ID: <1233611191-18590-5-git-send-email-trast@student.ethz.ch>
References: <1233611191-18590-1-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-2-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-3-git-send-email-trast@student.ethz.ch>
 <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>, Jeff King <peff@peff.net>,
	Suraj Kurapati <sunaku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU6fP-0001pu-Lh
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864AbZBBVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbZBBVq7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:46:59 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9370 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291AbZBBVqy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:46:54 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:45 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <1233611191-18590-4-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Feb 2009 21:46:45.0221 (UTC) FILETIME=[BE068950:01C9857F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108128>

Print the error messages that go to STDERR in color.interactive.help.
While it's not really help text, the command help also pops up if an
unknown command was entered (which is an error), and it lets them
stand out nicely.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3aa21db..fe8f364 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -908,6 +908,10 @@ sub display_hunks {
 	return $i;
 }
 
+sub help_msg {
+	print STDERR colored $help_color, @_;
+}
+
 sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
@@ -1029,11 +1033,11 @@ sub patch_update_file {
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-					print STDERR "Invalid number: '$response'\n";
+					help_msg "Invalid number: '$response'\n";
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					print STDERR "Sorry, only $num hunks available.\n";
+					help_msg "Sorry, only $num hunks available.\n";
 				}
 				next;
 			}
@@ -1062,7 +1066,7 @@ sub patch_update_file {
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
 					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					print STDERR "Malformed search regexp $exp: $err\n";
+					help_msg "Malformed search regexp $exp: $err\n";
 					next;
 				}
 				my $iy = $ix;
@@ -1072,7 +1076,7 @@ sub patch_update_file {
 					$iy++;
 					$iy = 0 if ($iy >= $num);
 					if ($ix == $iy) {
-						print STDERR "No hunk matches the given pattern\n";
+						help_msg "No hunk matches the given pattern\n";
 						last;
 					}
 				}
@@ -1084,7 +1088,7 @@ sub patch_update_file {
 					$ix--;
 				}
 				else {
-					print STDERR "No previous hunk\n";
+					help_msg "No previous hunk\n";
 				}
 				next;
 			}
@@ -1093,7 +1097,7 @@ sub patch_update_file {
 					$ix++;
 				}
 				else {
-					print STDERR "No next hunk\n";
+					help_msg "No next hunk\n";
 				}
 				next;
 			}
@@ -1106,13 +1110,13 @@ sub patch_update_file {
 					}
 				}
 				else {
-					print STDERR "No previous hunk\n";
+					help_msg "No previous hunk\n";
 				}
 				next;
 			}
 			elsif ($line =~ /^j/) {
 				if ($other !~ /j/) {
-					print STDERR "No next hunk\n";
+					help_msg "No next hunk\n";
 					next;
 				}
 			}
-- 
1.6.1.2.513.g04677
