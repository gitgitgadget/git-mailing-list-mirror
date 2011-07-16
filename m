From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 10/23] git-remote-testgit: only push for non-local repositories
Date: Sat, 16 Jul 2011 15:03:30 +0200
Message-ID: <1310821424-4750-11-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Y8-0005EN-F7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab1GPNEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab1GPNEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:43 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mj7xYl9OBAqjA2bwDrieFlwlH89zhH2FBS/RhNzxmhc=;
        b=wHXFpHB2Z5tvBtkC/EGA8ooTnpETgpZD58PZHOR+Y9CiaC0crdhJZvy+SudjYxepXz
         XfejpYwqAEHlZWC26Rtoo33+77nQdgVNGAPM96Gj+gcf1Acn7NHn22qQ00V13emS6VdN
         ip309qxcKAH+FjQ8Y7qwctJ/kwYpFnmc1wQT8=
Received: by 10.213.3.146 with SMTP id 18mr1618479ebn.94.1310821482587;
        Sat, 16 Jul 2011 06:04:42 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177258>

Trying to push for local repositories will fail since there is no
local checkout in .git/info/... to push from as that is only used for
non-local repositories (local repositories are pushed to directly).

This went unnoticed because the transport helper infrastructure does
not check the return value of the helper.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 git-remote-testgit.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index b0c1e9b..cdbc494 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -146,7 +146,9 @@ def do_export(repo, args):
 
     update_local_repo(repo)
     repo.importer.do_import(repo.gitdir)
-    repo.non_local.push(repo.gitdir)
+
+    if not repo.local:
+        repo.non_local.push(repo.gitdir)
 
 
 COMMANDS = {
-- 
1.7.5.1.292.g728120
