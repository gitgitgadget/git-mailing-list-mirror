From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 11/14] remote-hg: add support for fake remote
Date: Tue, 30 Oct 2012 05:35:33 +0100
Message-ID: <1351571736-4682-12-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3ZM-0006S1-EK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab2J3Egm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:42 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2J3Egl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/uWTFAT1eq15nZUmHCYvJmqkAYc6hWQA02ETWLD8su0=;
        b=Gr+wP4Ubao2cOwx3HXL0bISsYdgEhyU6z+Yc/mC1ZTFKcdDu+rx5g6YPg30xxiXPx8
         4Sg2HJ2syZ7k+w8fovnpp0oWKF51O7EIZNpkYtTZT4U8jEQRkGr5B+9r2JlSx/331gwW
         GzMGgvf8SGEtqH77JSUIxfoWRHquBK8MKPhzKUh6cGICkZJ/8CfrMl3yontRlzfOmool
         kbh0VJYl3KiQV2gasrvGrPHqzO/oWE+35D1ODSSNLUl9m9A2gPxd3bI6irmh8jPsrjYM
         5rOyZ8GwaMmXCkbaunDf/cZdhY9nqkrc0ZfvlQgEIpeyOOb+C2QW34sARZfjtOKJnkYt
         5rZQ==
Received: by 10.204.11.213 with SMTP id u21mr9654926bku.42.1351571800491;
        Mon, 29 Oct 2012 21:36:40 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id gy18sm5162092bkc.4.2012.10.29.21.36.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208673>

Helpful while testing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index c41ec95..61c1072 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -248,7 +248,13 @@ def get_repo(url, alias):
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
