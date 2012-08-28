From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 07/16] When debug==1, start fast-import with "--stats" instead of "--quiet"
Date: Tue, 28 Aug 2012 10:49:41 +0200
Message-ID: <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWK-00022f-NC
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab2H1IvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2H1IvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:14 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SHYBBb9eJVC6ubjii3SRbkaozBrchg0+ExQYaICg+UU=;
        b=WseiPWpmpdkPcrba6VQXcfxnACJPa404QD9sHnR9W+TfWmO7s3isciko51zx9yoohU
         NrrRCJTplMxFkc2gB/qBr8LQflYz75dwfvuqEmEmw8vE+O0Y+H3HnSC5Qh/Jt/u2Jp2z
         l2j7idGyIgYjl8WY0CXxPmG63Znd4arkg2xJEAXJ0MSvYvkhHWqdMneqReZ6SOuB8HEs
         W7Ir1sSLDUQbNJ9VFYpWTvsqe3Sl8k2FJ07OWdtq9Gbuc8YzwrVO7fZBoprXOB5KX8fi
         WJkhplj6wPxG6FTHRhfOv5SrriN9tXRefAe9Fan5jDPW2ghi5s8qeqV42KsVv9t0FEel
         K3+A==
Received: by 10.204.154.141 with SMTP id o13mr4511670bkw.72.1346143872963;
        Tue, 28 Aug 2012 01:51:12 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.10
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204402>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 3523f1f..4713b69 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -385,7 +385,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, "--quiet");
+	argv_array_push(&argv, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
