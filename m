From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb cleanup: Move @diff_opts declaration earlier
Date: Fri, 20 Jul 2007 02:15:09 +0200
Message-ID: <11848905093747-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 02:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBg2v-00020F-BK
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764264AbXGTAIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764165AbXGTAId
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:08:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:61179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762214AbXGTAIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:08:32 -0400
Received: by ug-out-1314.google.com with SMTP id j3so519114ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 17:08:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=p3GUw2MT2nPigysGSeTwKg0TyTxngzyRNTPFNtwSOgLziJfsRMq3JI8s2iPh1kwL7PntcgbmjUn6XcuwJ7MFrUqatu7jkl3gslZ/EhHcEaQ+jQ0HSA8taK97pkNXAJOUPRf5t1nfvV0/X+bJUVSU+wsa0TDKJx0nzB8xBXB61hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=XQbFGwtLgG+bc6KnnE/zIy0yuuzYIP+9qtP8eNeF0AyGIdlzaBBXBt/IH6plLOkroN2ZOiCdjYOkYPEx9cvHD1VrgoGjRlLckkxP6L5aFHuFXZVMRdEQYwb0uUViZCw39yYaqdmxs2LepEQ8y0CB0JMuACEYiKs6psOGxXiTlbo=
Received: by 10.66.220.17 with SMTP id s17mr1536499ugg.1184890111574;
        Thu, 19 Jul 2007 17:08:31 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTPS id z40sm4675122ikz.2007.07.19.17.08.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 17:08:29 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6K0FA6d029080;
	Fri, 20 Jul 2007 02:15:11 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6K0F9nb029079;
	Fri, 20 Jul 2007 02:15:09 +0200
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53038>

Move @diff_opts declaration earlier, so that all gitweb options are
together (and not separated by %feature hash and some subroutines),
with the exception of $GITWEB_CONFIG which must be after all option
variables including %feature hash.

While at it, in the moved comment, note that diff option '-C' implies
'-M', instead of suggesting that '-M', '-C' is required.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c8ba3a2..6754e26 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -104,6 +104,16 @@ our $mimetypes_file = undef;
 # could be even 'utf-8' for the old behavior)
 our $fallback_encoding = 'latin1';
 
+# rename detection options for git-diff and git-diff-tree
+# - default is '-M', with the cost proportional to
+#   (number of removed files) * (number of new files).
+# - more costly is '-C' (which implies '-M'), with the cost proportional to
+#   (number of changed files + number of removed files) * (number of new files)
+# - even more costly is '-C', '--find-copies-harder' with cost
+#   (number of files in the original tree) * (number of new files)
+# - one might want to include '-B' option, e.g. '-B', '-M'
+our @diff_opts = ('-M'); # taken from git_commit
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -310,16 +320,6 @@ sub check_export_ok {
 		(!$export_ok || -e "$dir/$export_ok"));
 }
 
-# rename detection options for git-diff and git-diff-tree
-# - default is '-M', with the cost proportional to
-#   (number of removed files) * (number of new files).
-# - more costly is '-C' (or '-C', '-M'), with the cost proportional to
-#   (number of changed files + number of removed files) * (number of new files)
-# - even more costly is '-C', '--find-copies-harder' with cost
-#   (number of files in the original tree) * (number of new files)
-# - one might want to include '-B' option, e.g. '-B', '-M'
-our @diff_opts = ('-M'); # taken from git_commit
-
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
-- 
1.5.2.4
