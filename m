From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 13/13] send-email: --compose always includes a 'GIT: ' prefixed list of patch subjects
Date: Mon, 13 Apr 2009 13:23:57 -0500
Message-ID: <1239647037-15381-14-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-12-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-13-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtR3q-0005X3-4o
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbZDMShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbZDMShj
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:37:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:12736 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbZDMShi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:37:38 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2243661wff.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UzFsml96q6bXObK3Dmtx6Y4LO3fecWvC9Xt8rWbXA+o=;
        b=NRr0wyxWhUnbQYA58/EFRZ14I4qph35GO0zxQv5dygxeZebtyNsB8M9BpGxMuxpqAZ
         8pDRMgMX4eOwm9PJmbkynVV7KxYZWRWyRQDEHEqk0208kKRF9p8wpPei9aRp7dFZIHKp
         nT1/Ar7XiPirypx3rGRG5KMsTva2KUtiDHLuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=o6RgyvoqEUJEGuBUC5Yj11DZ5jytAfs0Mpf1+UKB4j+5TtIOEVaGam9QsFjrUsimUa
         rQvfjVqAbzqfYDaLjiN53TcPbI3GXnJG+PsGYDtc23cRakeua+QD06CpU4Wdx3AshM2o
         P9PcyDOXDzfoul3RNwKBMl6OFgBnlh1Ykj8o8=
Received: by 10.114.181.6 with SMTP id d6mr3303346waf.8.1239647858029;
        Mon, 13 Apr 2009 11:37:38 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.37.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:37:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-13-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116474>

I've found that having a list of the patch subjects appended to
the end of an existing --compose email is quite useful.

I've tried to make appending smart enough not to alter existing
lines beyond the addition of some kind of newline.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    3 ++-
 git-send-email.perl              |   20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 5ef8b12..6edef52 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -61,7 +61,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	`$GIT_EDITOR`, 'core.editor', `$VISUAL`, `$EDITOR`, or `vi`.
 +
 A path for the composition may be given. If the path exists, then
-the file at the path is opened for editing as-is. If the path
+the file at the path is opened for editing with the list of patch
+subjects (prefixed with 'GIT: ') appended to the end. If the path
 doesn't exist, a file with default content is created at the path
 and opened for editing. If no path is specified, a new temporary
 file with default content is created and opened for editing.
diff --git a/git-send-email.perl b/git-send-email.perl
index 2ab76c6..696b132 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -644,9 +644,25 @@ if (defined $compose) {
 		print "GIT: This is the first line of the <body>:\n";
 		print "\n";
 
-		for my $f (@files) {
-			print get_patch_subject($f);
+		print get_patch_subject($_) for (@files);
+
+	} else {
+
+		# Supply a listing of the patch subjects, in case
+		# it might be useful to the user:
+
+		open $compose_path_filehandle, "+<", $compose_path
+			or die "--compose: Could not open '$compose_path' for appending listing: $!\n";
+
+		# Figure out whether we should begin a new line
+		# (we don't want to append to an existing line):
+
+		if (seek $compose_path_filehandle, -1, 2) {
+			read $compose_path_filehandle, my $c, 1;
+			$c !~ /\n|\r/ and print $compose_path_filehandle "\n";
 		}
+
+		print $compose_path_filehandle get_patch_subject($_) for (@files);
 	}
 
 	# Do the editing:
-- 
1.6.2.2.479.g2aec
