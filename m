From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/13] remote-hg: add support for fake remote
Date: Sun, 28 Oct 2012 04:54:11 +0100
Message-ID: <1351396453-29042-12-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyX-0003dM-EP
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab2J1Dzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:37 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab2J1Dzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:36 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0YLa+txhzCLn9iqr/3sVC5J8TIvt5nvyvsIbWY4VQRk=;
        b=BCsbhxnZZBnNj5vFkV3RNkVa9GYd7k8Cz7uwXWryIQOM7Af5AzupvsRy3KrkO2KpQn
         jzoPAbqImE5NfscfA5ve+ZHqpEI2Gkq8dRuXM2l1yFdAESXhk1jOHLdjcZDmM9/ke8NG
         aX/joubKOvp9eG2HrpWswU07tpoeLa8DJOkvLL8xLJAkuswg9j4mZBh/kXF6Gh+VRx8u
         bXSt0RHW4ht+WwXJPUC290D++UmKOcBOLgdw11zvlWgLsE8R1bhSvkt0A9pZaFVDHIA2
         QvRnzIVrSThwctX5bl+NfnKVaUqXVoB9bS8A5MMn12hf4wPBaaLUq+901ev19QlaJ/EF
         fmbQ==
Received: by 10.14.179.136 with SMTP id h8mr35772555eem.7.1351396535553;
        Sat, 27 Oct 2012 20:55:35 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id g47sm13232145eeo.6.2012.10.27.20.55.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208529>

Helpful while testing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index e8e3791..092020f 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -245,7 +245,13 @@ def get_repo(url, alias):
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
 
-    if hg.islocal(url):
+    if url.startswith("remote://"):
+        remote = True
+        url = "file://%s" % url[9:]
+    else:
+        remote = False
+
+    if hg.islocal(url) and not remote:
         repo = hg.repository(myui, url)
     else:
         local_path = os.path.join(dirname, 'clone')
-- 
1.8.0
