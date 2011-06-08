From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 08/19] git-remote-testgit: only push for non-local repositories
Date: Wed,  8 Jun 2011 20:48:39 +0200
Message-ID: <1307558930-16074-9-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpK-00087c-9o
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab1FHSto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:44 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1FHStk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:40 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279690eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=tsbDkiMzBgflNKEZGEXTpbVd7vT8A3hshFodgtImPiE=;
        b=S8PftqzNPIdBCYeqLqDJbdJC84gs+y4O8zwjqGV5woRiIhCdHp1rqUwW8tJyfg4Pef
         K8eXBFoZyghevrklak8Mc7O2z2MQYkZm3hJl9X4Xszn4ki+QrvhSuXa2EnlaCX8VJTmq
         rRyl0q51XQFkchwq6vY+ZE2s0qyI8qHQl5ULc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vzzzWJpRFT8K/RpBy4zNfU+I6YY/A4fe4kXaqYersDViQA5mDNtKxBO8uj/0ljHHS3
         J8NtY5uAonUJeOE5Z9n/WeIsQ2CAn6lcB6iSLw813i2eOR/roZGtfNwcMqbRJ0jDp2p1
         Pb7rW5Id0/U7Rgj0ZbXp23o1PGn9E5V2MaPLc=
Received: by 10.213.19.78 with SMTP id z14mr2041870eba.10.1307558978879;
        Wed, 08 Jun 2011 11:49:38 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175428>

Trying to push for local repositories will fail since there is no
local checkout in .git/info/... to push from as that is only used for
non-local repositories (local repositories are pushed to directly).

This went unnoticed because the transport helper infrastructure does
not check the return value of the helper.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Moved to the front for bisectability.

 git-remote-testgit.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e4a99a3..9658355 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -147,7 +147,9 @@ def do_export(repo, args):
 
     update_local_repo(repo)
     repo.importer.do_import(repo.gitdir)
-    repo.non_local.push(repo.gitdir)
+
+    if not repo.local:
+        repo.non_local.push(repo.gitdir)
 
 
 def do_gitdir(repo, args):
-- 
1.7.5.1.292.g728120
