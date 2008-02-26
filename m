From: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
Subject: [PATCH] filter-branch documentation: non-zero exit status in command abort the filter
Date: Mon, 25 Feb 2008 23:14:31 -0300
Message-ID: <1203992071-957-1-git-send-email-cmarcelo@gmail.com>
Cc: Johannes.Schindelin@gmx.de,
	Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 03:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTpSt-0003NO-9z
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 03:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbYBZCWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 21:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbYBZCWF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 21:22:05 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:14445 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbYBZCWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 21:22:02 -0500
Received: by an-out-0708.google.com with SMTP id d31so442815and.103
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 18:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=UbYP6xq4ti9R7Wl9ovDF4LX6r9GPsMUbHEYu2pKyco4=;
        b=k618/NXwuO6JVEPvMlPXCwW4Fj+0qi6v6PXWbbt9WCiCGO2T+oAsvvmCR0QplqktKsl9ZA2/JWxgNyCpu9wetWZ4wG3Zwi7QPM66OuIVZlywXQChi8FL7l30BUauEQCuFUG1wOdW86FDkWMSB7c199QkwwPEs7h14z41BvPgJGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JAnT4bJlxhv8hIV4tkvF/jglLyj9To65r8FvqZo3YXJlJlWvlpmEmhPx+qM7uFGhlED/YaYi+hyJhvQDpZ9NjYhP/muCKtz5WIE5REbsmRREgXPfhfkX4rdxvXHRM5Sow3Lw4OwNhUrfcTeP16zHp1xEs+c1lI10i2QYD/26xt4=
Received: by 10.100.165.13 with SMTP id n13mr8666631ane.77.1203992521627;
        Mon, 25 Feb 2008 18:22:01 -0800 (PST)
Received: from localhost.localdomain ( [189.70.51.45])
        by mx.google.com with ESMTPS id 7sm5510053agd.25.2008.02.25.18.21.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Feb 2008 18:22:00 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.221.g350ae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75102>

Since commit 8c1ce0f46b85d40f215084eed7313896300082df filter-branch fails
when a <command> has a non-zero exit status. This commit makes it clear
in the documentation and also fixes the parent-filter example, that was
incorrectly returning non-zero when the commit being tested wasn't the
one to be rewritten.

Signed-off-by: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
---
 Documentation/git-filter-branch.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e22dfa5..9cb01ca 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -56,7 +56,9 @@ notable exception of the commit filter, for technical reasons).
 Prior to that, the $GIT_COMMIT environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-and GIT_COMMITTER_DATE are set according to the current commit.
+and GIT_COMMITTER_DATE are set according to the current commit. If any
+evaluation of <command> returns a non-zero exit status, the whole operation
+will be aborted.
 
 A 'map' function is available that takes an "original sha1 id" argument
 and outputs a "rewritten sha1 id" if the commit has been already
@@ -195,10 +197,10 @@ the initial commit - add graftcommit as a parent).  Note that this assumes
 history with a single root (that is, no merge without common ancestors
 happened).  If this is not the case, use:
 
---------------------------------------------------------------------------
+----------------------------------------------------------------------------
 git filter-branch --parent-filter \
-	'cat; test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>"' HEAD
---------------------------------------------------------------------------
+	'test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>" || cat' HEAD
+----------------------------------------------------------------------------
 
 or even simpler:
 
-- 
1.5.4.3.221.g350ae
