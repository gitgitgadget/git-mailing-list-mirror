From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 09/20] git-remote-testgit: only push for non-local repositories
Date: Sun, 19 Jun 2011 17:18:34 +0200
Message-ID: <1308496725-22329-10-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn4-0003jn-3x
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1FSPTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab1FSPTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=7A+/Z79XCwrGMGgnXjLCS4SKEZKLlqGey1UvFM/Wtc8=;
        b=SwkAeoNyow+KB2T/is965r/ox59fgXioojpNKqwZvJi+iZPHqcLMvBliSnGDwBNqR5
         8djIBnrbriBL5/dRACGCNuMuyKGO4ZueHTvv6zjsBaTDGS5BBa9JPU3hGSNy0cvPrJEz
         ojsez3r9Vw4iSna1Wz3K2A0/kNHiYgNJO+92Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LmJGXDCbV3agHqFPh+tVguYXzsetweZQGevzu/UodzbXD3XgG1VxkwdTahM/0zuvtc
         Kh9lEEMNBcMbcBhOTi0wKW60QSkW7CuzikYcPdf8gKIHagnWV5EzvmiRVffj/0cOGTwq
         Gx/4HnsGr2wjsyYl+7NuE9FXiVD2bH3h6s8u0=
Received: by 10.213.19.143 with SMTP id a15mr1704573ebb.2.1308496786984;
        Sun, 19 Jun 2011 08:19:46 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176010>

Trying to push for local repositories will fail since there is no
local checkout in .git/info/... to push from as that is only used for
non-local repositories (local repositories are pushed to directly).

This went unnoticed because the transport helper infrastructure does
not check the return value of the helper.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

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
