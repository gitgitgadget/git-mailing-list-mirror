From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 06/13] transport-helper: update ref status after push with export
Date: Sat, 28 Aug 2010 22:45:33 -0500
Message-ID: <1283053540-27042-7-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrN-0006pV-0D
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab0H2Dqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0H2Dql (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:41 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/KREKTkAtHuYkLuFrQP/erI7COKh5yApedilArhMTeE=;
        b=iBFTS8vp8MfHu7/HhNNRRzE5CoxvTUAiotb1pSgBt5SRXm8WRSsn39ZWybwctFbp0D
         fAvRVPgUaYvm0l8SnMgl/RhgxaEbFO3MYhezoay5FkmtTebpenaB6xdVTXEj+LUbUDKk
         F2M2jwPPWJie9MhAOCYB6LNKsBUq7aX8mhdT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E6KPhrHYcOv9kQbXAJZsL5opVHjBDqwwIPLwcP+GVJFuCYUmEGthK67tpo2tl+Ebz/
         TNXTXTPKPulG/jYt9flLE4+KT+yJe9cSz/1QlnNMbA2VF1O09CDCYf4pDRwyW2xpqEf5
         oK73GXtOsTB0dd/999R++09E5Tr5u/vsRC6LY=
Received: by 10.231.190.75 with SMTP id dh11mr3161045ibb.189.1283053601188;
        Sat, 28 Aug 2010 20:46:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154677>

---

  Obviously the testgit helper shouldn't just print 'ok' for master,
  but it demonstrates the idea.

 git-remote-testgit.py |    3 +++
 transport-helper.c    |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 612cb5a..342a05d 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -151,6 +151,9 @@ def do_export(repo, args):
     repo.importer.do_import(repo.gitdir)
     repo.non_local.push(repo.gitdir)
 
+    print "ok refs/heads/master"
+    print
+
 
 def do_gitdir(repo, args):
     """Stores the location of the gitdir.
diff --git a/transport-helper.c b/transport-helper.c
index 5647595..ecaea25 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -756,6 +756,7 @@ static int push_refs_with_export(struct transport *transport,
 	data->no_disconnect_req = 1;
 	if(finish_command(&exporter))
 		die("Error while running fast-export");
+	push_update_refs_status(data, remote_refs);
 	return 0;
 }
 
-- 
1.7.2.1.240.g6a95c3
