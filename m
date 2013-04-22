From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/16] remote-hg: strip extra newline
Date: Mon, 22 Apr 2013 16:55:24 -0500
Message-ID: <1366667724-567-17-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 00:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOnI-00074F-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab3DVWA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:00:59 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:56604 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3DVWA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:00:58 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so6425570oag.41
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uy23ZhHlb+DjbuVjOka045ebEc8MeNY5qpVWRsElFbI=;
        b=MHmKUL7HVnD6YM2rfyxmHSPy4ma5RGqrp+QBtaH72c/JQoggpqfIk5eGyAZ22ISlJP
         qRCxfoPiXQWq2EI9S5eGLvRfRoqCM1wTGcYagXnLu7EknDUIOy9K5kyi4nj6+z6Wr6oh
         mG/e2p1mg8tISNcRwiqBYPprgLP1d1GUqfGYg2XANYslYIFzXPM8Bmtm0vqsvkvB+evg
         7Ivp/IhNYatmoJc04b9udEk/nlh5BzDSA2z7G9J0rv9H+XEvGFpgqgxi3388OOz6atdy
         ireA34bFcalQQ6duJQe7wvVFw9huxUnKVJjQco/eUasSgJKm6K5wCN2Xx/FEt10kFiDq
         J8Og==
X-Received: by 10.182.126.162 with SMTP id mz2mr15239477obb.30.1366668058503;
        Mon, 22 Apr 2013 15:00:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ka6sm20076116obb.3.2013.04.22.15.00.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 15:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222114>

There's no functional change since mercurial commit operation strips
that anyway, but that's no excuse for us not to do the right thing. So
let's be explicit about it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d0e552c..fda4199 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -652,6 +652,10 @@ def parse_commit(parser):
         if parser.check('merge'):
             die('octopus merges are not supported yet')
 
+    # fast-export adds an extra newline
+    if data[-1] == '\n':
+        data = data[:-1]
+
     files = {}
 
     for line in parser:
-- 
1.8.2.1.790.g4588561
