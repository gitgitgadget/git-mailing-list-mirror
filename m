From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 2/3] specify explicit "--pretty=medium" with `git log/show/whatchanged`
Date: Sun,  2 Mar 2008 17:05:52 +0800
Message-ID: <1204448753-4471-2-git-send-email-crquan@gmail.com>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
 <1204448753-4471-1-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVk9w-0000KL-CW
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYCBJGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYCBJGR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:06:17 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:16954 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbYCBJGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:06:13 -0500
Received: by el-out-1112.google.com with SMTP id v27so982375ele.17
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=N7TNNJMuwsyA9MyNguTIeBgXWu1omBPcGc5R/U93Ofg=;
        b=iZjyu4E6eegSEJMoKaPoygeOGiWh0xdWEo/vqFgvtcQXKxWco2ZN97fmuTD4vOkARuQMXbtjELdtGaM8bUACjssepvG9WH3ahVALvny5LJ8vUjCE84jV2S0aq5UvlKYhClIa/DMrivvDvcaUsSV5ZOBcS3TfteenR61vHiSa/Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wHVZKGLb4ATLC8ZR0L4nc/cqPxu5C3yW65p5AEGWSdoP7rQuOZ5aSeQWoVaKM6XQcWVMMBv+wBfLmO8bxXR7XBzsqCIM+LeXfPyiB3rrQrBP+Ga04Epw43jYTEkPMqD0po0g+LECD+CS2gPtvoVtNZ7Q/MJGQ0a1tVfOZtiqaag=
Received: by 10.114.178.1 with SMTP id a1mr1866005waf.135.1204448771120;
        Sun, 02 Mar 2008 01:06:11 -0800 (PST)
Received: from tux ( [121.34.60.168])
        by mx.google.com with ESMTPS id n32sm23057461wag.13.2008.03.02.01.06.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 01:06:10 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:06:03 +0800
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1204448753-4471-1-git-send-email-crquan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75751>

The following patch will introduce a new configuration variable,
"format.pretty", from then on the pretty format without specifying
"--pretty" might not be the default "--pretty=medium", it depends on
the user's config. So all kinds of Shell/Perl/Emacs scripts that needs
the default medium pretty format must specify it explicitly.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 contrib/emacs/git.el             |    2 +-
 contrib/hooks/post-receive-email |    2 +-
 git-cvsserver.perl               |    2 +-
 git-merge.sh                     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c926823..4fa853f 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1299,7 +1299,7 @@ Return the list of files that haven't been handled."
   (let (author-name author-email subject date msg)
     (with-temp-buffer
       (let ((coding-system (git-get-logoutput-coding-system)))
-        (git-call-process-env t nil "log" "-1" commit)
+        (git-call-process-env t nil "log" "-1" "--pretty=medium" commit)
         (goto-char (point-min))
         (when (re-search-forward "^Author: *\\(.*\\) <\\(.*\\)>$" nil t)
           (setq author-name (match-string 1))
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 77c88eb..62a740c 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -567,7 +567,7 @@ generate_general_email()
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
 		echo $LOGBEGIN
-		git show --no-color --root -s $newrev
+		git show --no-color --root -s --pretty=medium $newrev
 		echo $LOGEND
 	else
 		# What can we do here?  The tag marks an object that is not
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index afe3d0b..7f632af 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2556,7 +2556,7 @@ sub update
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
-                        open(GITLOG, '-|', 'git-log', "$base..$parent")
+                        open(GITLOG, '-|', 'git-log', '--pretty=medium', "$base..$parent")
 			  or die "Cannot call git-log: $!";
                         my $mergedhash;
                         while (<GITLOG>) {
diff --git a/git-merge.sh b/git-merge.sh
index 1c123a3..39aa5f5 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -70,7 +70,7 @@ finish_up_to_date () {
 squash_message () {
 	echo Squashed commit of the following:
 	echo
-	git log --no-merges ^"$head" $remoteheads
+	git log --no-merges --pretty=medium ^"$head" $remoteheads
 }
 
 finish () {
-- 
1.5.4.3.368.g2bb0a

