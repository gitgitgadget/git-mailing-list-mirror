From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/8] remote-bzr: add fallback check for a partial clone
Date: Fri, 24 May 2013 21:24:26 -0500
Message-ID: <1369448666-17515-9-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Bl-0006XS-F7
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab3EYC0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:30 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:63474 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240Ab3EYC03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:29 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so6961975oah.21
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ku9yaae3vwCwSv/ou4V0VXdFpGDcoRvS6QU9ocjWtdk=;
        b=L4Um/pWSxhJU+4wK46JD82WhU7yfCUbW3my1LUUHdl8v9KKozCsrEy5kk7be22pFcp
         R2LKmYdfnD5pLqU++uJQkZRxd5TREewWasYDbj0gOKiMmbnarUQpgDdBUXY80PYADa7x
         oOSjHLpCBsdldZ7M1utTiXc21BE436cYMgN1SgR9mEIzIOROMB45dcQyO5lGgwiMaK/e
         JM2T0h/EWrTQBSZkVbuQJfl2wNdtAAIiFR90Vpt8VM+Yl3zZtV4UPTyxzxR9YENTTHAL
         mEaTbfmrVYrLQsIRi0aydzyHInPqoXBfgEWsrgOPi5yxt1jkR+fZ3EYWU5FWoB3IQNbU
         hOtw==
X-Received: by 10.60.23.9 with SMTP id i9mr13300779oef.109.1369448788572;
        Fri, 24 May 2013 19:26:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm20554782oeb.3.2013.05.24.19.26.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225413>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 3248586..3cd6572 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -766,7 +766,10 @@ def do_list(parser):
     print
 
 def clone(path, remote_branch):
-    bdir = bzrlib.bzrdir.BzrDir.create(path)
+    try:
+        bdir = bzrlib.bzrdir.BzrDir.create(path)
+    except bzrlib.errors.AlreadyControlDirError:
+        bdir = bzrlib.bzrdir.BzrDir.open(path)
     repo = bdir.find_repository()
     repo.fetch(remote_branch.repository)
     return remote_branch.sprout(bdir, repository=repo)
-- 
1.8.3.rc3.312.g47657de
