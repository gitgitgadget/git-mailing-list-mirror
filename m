From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10/11] Document git reflog --stale-fix
Date: Sat, 16 Jun 2007 21:03:46 +0200
Message-ID: <1182020635891-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU5-0007JN-HF
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXFPS63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbXFPS62
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:8343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbXFPS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1101913ugf
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A8aZhT9gLgotV/WCHQeCeTV4IqtXAm8mJNZtyPBgZILPP9VbWuyZYdtbXB7Nlg98uSl7qepCmG8vL4LkAmM+SG0hjsaNahRX/xism9Gojldvg98GT2JSsB+9bS+FxyPgZHhAOyjmiZPncPRF/3oXFYi0cUIdEU4MkKmD5KPVT5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nXog8LlReD7PA2YsrarFG0Sh/ertFEpeQV0MasII/QzljIcdEsRh9LlTr03M6ukn2QbJBqAkWHefZBqjAu4FT6GI6vEZg0KdI0e7a7XUNNZQbn5SsZy4Zmz8IayH584Dcuzd0e9XBh+pvvBLkBem6e2XQrumCiRsfkGBEJB9GBQ=
Received: by 10.82.136.4 with SMTP id j4mr8136150bud.1182020294794;
        Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h6sm1875819nfh.2007.06.16.11.58.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3tRu004262;
	Sat, 16 Jun 2007 21:03:55 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3tIr004261;
	Sat, 16 Jun 2007 21:03:55 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50303>

Document --stale-fix, used in "git reflog expire --stale-fix --all"
to remove invalid reflog entries, to fix situation after running
non reflog-aware git-prune from an older git in the presence of
reflogs (see RelNotes-1.5.0.txt).

Based on description of commit 1389d9ddaa68a4cbf5018d88f971b9bbb7aaa3c9
  "reflog expire --fix-stale"
which introduced this option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-reflog.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index f717e1e..89bc9c5 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -39,6 +39,19 @@ the current branch. It is basically an alias for 'git log -g --abbrev-commit
 OPTIONS
 -------
 
+--stale-fix::
+	This revamps the logic -- the definition of "broken commit"
+	becomes: a commit that is not reachable from any of the refs and
+	there is a missing object among the commit, tree, or blob
+	objects reachable from it that is not reachable from any of the
+	refs.
++
+This computation involves traversing all the reachable objects, i.e. it
+has the same cost as 'git prune'.  Fortunately, once this is run, we
+should not have to ever worry about missing objects, because the current
+prune and pack-objects know about reflogs and protect objects referred by
+them.
+
 --expire=<time>::
 	Entries older than this time are pruned.  Without the
 	option it is taken from configuration `gc.reflogExpire`,
-- 
1.5.2
