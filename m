From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 13/13] git-remote-testgit: fix error handling
Date: Sat, 28 Aug 2010 22:45:40 -0500
Message-ID: <1283053540-27042-14-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrQ-0006pV-5T
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab0H2Dq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0H2Dqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:55 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hN5cSomTjow8Hst8Ud2sRVkD0h2FkP13NXK8MwxKkOA=;
        b=JY9yfOO+0jr7SC5gnMlRa+IYYfDjTtZLVFeLfCoSBodwpsVxNFr4xZNVuDsuMDElKt
         S6YuCXywhx3+L3BaPyxfzGXrFL0GjJ06Ty/MT1sDzAl4oFBOtMfuVF/bfrFtKsp7nvV+
         Q4wWXnblcepyBvFlZotBa0PRyvwkrPSwcMU+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l54etU4IE/iHOEP2R5p23Tc0Iz8ayxycBzUXVfsSkVOE9W5hbUQdgBa9cTWuMuH23v
         A6fxPNAF0ptajkYIS8KBvQSbyGPFEKIYKSqLsHxXKPyxrBU6GDoW7AwOkfekjsJ5EzdS
         Tci+NKGi2b1UqlI81db27AJX+pcF6QKQMAQlg=
Received: by 10.231.157.143 with SMTP id b15mr3269251ibx.113.1283053614638;
        Sat, 28 Aug 2010 20:46:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154675>

If fast-export did not complete successfully the error handling code
itself would error out.
---

  *brown paper bag*

 git_remote_helpers/git/importer.py |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index 70a7127..d938611 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -36,5 +36,6 @@ class GitImporter(object):
             args.append("--import-marks=" + path)
 
         child = subprocess.Popen(args)
-        if child.wait() != 0:
-            raise CalledProcessError
+        ret = child.wait()
+        if ret != 0:
+            raise subprocess.CalledProcessError(ret, args)
-- 
1.7.2.1.240.g6a95c3
