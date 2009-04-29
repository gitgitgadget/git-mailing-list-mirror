From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 4/6] Add explict return to end of subroutines
Date: Wed, 29 Apr 2009 09:12:21 -0400
Message-ID: <1241010743-7020-5-git-send-email-wfp5p@virginia.edu>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
 <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
Cc: gitster@pobox.com, Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 15:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz9eZ-0003wt-I4
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 15:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760191AbZD2NM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 09:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760203AbZD2NM1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 09:12:27 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:37682 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760191AbZD2NMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 09:12:25 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 0B11257054; Wed, 29 Apr 2009 09:12:24 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117882>

In perl a subroutine that ends without an explicit return will return
the value of the last expression evalutated.  This can lead to
unexpected return values.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 git-send-email.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1ed5869..c24e0df 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -160,6 +160,7 @@ my $compose_filename;
 # Handle interactive edition of files.
 my $multiedit;
 my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
+
 sub do_edit {
 	if (defined($multiedit) && !$multiedit) {
 		map {
@@ -174,6 +175,7 @@ sub do_edit {
 			die("the editor exited uncleanly, aborting everything");
 		}
 	}
+    return;
 }
 
 # Variables with corresponding config settings
@@ -304,6 +306,7 @@ sub read_config {
 			$smtp_encryption = 'ssl';
 		}
 	}
+    return;
 }
 
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
@@ -745,6 +748,7 @@ sub make_message_id
 	my $message_id_template = "<%s-git-send-email-%s>";
 	$message_id = sprintf($message_id_template, $uniq, $du_part);
 	#print "new message id = $message_id\n"; # Was useful for debugging
+    return;
 }
 
 
@@ -971,6 +975,7 @@ X-Mailer: git-send-email $gitversion
 			print "Result: OK\n";
 		}
 	}
+   return;
 }
 
 $reply_to = $initial_reply_to;
@@ -1149,6 +1154,7 @@ cleanup_compose_files();
 
 sub cleanup_compose_files {
 	unlink($compose_filename, $compose_filename . ".final") if $compose;
+        return;
 }
 
 $smtp->quit if $smtp;
-- 
1.6.0.6
