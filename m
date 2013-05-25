From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 31/48] remote-hg: force remote bookmark push selectively
Date: Fri, 24 May 2013 21:29:47 -0500
Message-ID: <1369449004-17981-32-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4IR-0002Uw-AX
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab3EYCdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:20 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55931 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3EYCdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:18 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6284342obc.13
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sAmf2NX4wBx3BXQzHjaaIvDUT3lIkJy16erxU0WNSYc=;
        b=XQ6VHgPHhdBWsRz0fETvMw5GcWTK7f7dQX/fOfENbRO9HNoW4ZN/0Zacwi24iOQrYa
         Dr+3QD+WkmZIU1EfO3g7CYKxIWbeef3IWSOQmcUr2KXXVO9/VXU5GYvGjUi8R/16ymp4
         JceTx2Cdd5C0Rp9bVwBlMmNS3btbTZ4pcL0nEuQ0On7eIW4FMku1oiUy3/NQEUgTG7n0
         hlrwAjyyLMbktI+k8KtwA78u9lQAQiA+u2qhoAhZfSHRWOjzj7rghFJ3P4YAMGmiWlX1
         KlAKa8hGdqlYNns8qyXRXy/5gQVd9hRN1MYneaDr16wozrcaGIih54rggRIWE2Mg88i2
         u8gg==
X-Received: by 10.60.16.69 with SMTP id e5mr1213410oed.46.1369449198035;
        Fri, 24 May 2013 19:33:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9143688oeo.8.2013.05.24.19.33.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225445>

If we update the 'old' node, we might be updating the remote bookmark
even when our 'new' node is not related at all to what the remote has,
effectively forcing an update.

Let's do that only when forced push is configured.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 99de7c2..4d650b5 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -919,7 +919,8 @@ def do_export(parser):
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
         for ref, bmark, old, new in p_bmarks:
-            old = remote_bmarks.get(bmark, '')
+            if force_push:
+                old = remote_bmarks.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
     else:
-- 
1.8.3.rc3.312.g47657de
