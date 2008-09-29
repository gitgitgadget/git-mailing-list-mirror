From: Michael Witten <mfwitten@MIT.EDU>
Subject: [RFC 7/9] send-email: Completely replace --signed-off-cc with --signed-off-by-cc
Date: Mon, 29 Sep 2008 00:08:10 -0500
Message-ID: <1222664892-55810-2-git-send-email-mfwitten@mit.edu>
References: <20080929003636.GA18552@coredump.intra.peff.net>
 <1222664892-55810-1-git-send-email-mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 07:10:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkB1I-0008KX-W9
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 07:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYI2FIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 01:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYI2FIX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 01:08:23 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54524 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751420AbYI2FIV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 01:08:21 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8T58In8015106;
	Mon, 29 Sep 2008 01:08:18 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8T58C4I019902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Sep 2008 01:08:17 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222664892-55810-1-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96995>

This breaks backwards compatibility, but so what---get off your
lazy arses and remove the cruft.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |    2 +-
 git-send-email.perl              |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0d6ac4a..8ffe525 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -87,7 +87,7 @@ The --cc option must be repeated for each user you want on the cc list.
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of 'sendemail.signedoffcc' configuration
+	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
 --smtp-encryption::
diff --git a/git-send-email.perl b/git-send-email.perl
index 3467cf1..4662d28 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -144,7 +144,7 @@ if ($@) {
 my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate);
@@ -154,7 +154,7 @@ my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, undef],
-    "signedoffcc" => [\$signed_off_cc, undef],
+    "signedoffbycc" => [\$signed_off_by_cc, undef],
     "validate" => [\$validate, 1],
 );
 
@@ -218,7 +218,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
-		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
+		    "signed-off-by-cc!" => \$signed_off_by_cc,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -294,7 +294,7 @@ if ($suppress_cc{'all'}) {
 
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-$suppress_cc{'sob'} = !$signed_off_cc if defined $signed_off_cc;
+$suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
 # Debugging, print out the suppressions.
 if (0) {
-- 
1.6.0.2.304.gdcf23.dirty
