From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 5/6] Remove mix of high and low-precedence booleans
Date: Wed, 29 Apr 2009 09:12:22 -0400
Message-ID: <1241010743-7020-6-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9ec-0003wt-Il
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760224AbZD2NMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760197AbZD2NMc
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:32 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37684 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757814AbZD2NM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:28 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 2873A57162; Wed, 29 Apr 2009 09:12:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117887>

Booleans such as &&, ||, ! have higher precedence than and, or, not.
They should not be mixed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c24e0df..5e7295d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -471,14 +471,14 @@ while (defined(my $f = shift @ARGV)) {
 	if ($f eq "--") {
 		push @rev_list_opts, "--", @ARGV;
 		@ARGV = ();
-	} elsif (-d $f and !check_file_rev_conflict($f)) {
+	} elsif (-d $f && !check_file_rev_conflict($f)) {
 		opendir(DH,$f)
 			or die "Failed to opendir $f: $!";
 
 		push @files, grep { -f $_ } map { +$f . "/" . $_ }
 				sort readdir(DH);
 		closedir(DH);
-	} elsif ((-f $f or -p $f) and !check_file_rev_conflict($f)) {
+	} elsif ((-f $f || -p $f) && !check_file_rev_conflict($f)) {
 		push @files, $f;
 	} else {
 		push @rev_list_opts, $f;
@@ -632,7 +632,7 @@ sub ask {
 		if ($resp eq '' and defined $default) {
 			return $default;
 		}
-		if (!defined $valid_re or $resp =~ /$valid_re/) {
+		if (!defined $valid_re || $resp =~ /$valid_re/) {
 			return $resp;
 		}
 	}
-- 
1.6.0.6
