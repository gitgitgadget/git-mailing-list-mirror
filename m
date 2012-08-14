From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 11/16] When debug==1, start fast-import with "--stats" instead of "--quiet".
Date: Tue, 14 Aug 2012 21:13:13 +0200
Message-ID: <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1McW-0003mj-71
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab2HNTRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab2HNTR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SEu8szbem9+eWJHWH5ET3e5E4DkVsptGyVlf4Mg4qZA=;
        b=TnRRfnHFQkdZeGMaZiTZq2/FEflpw8xV00EbXn2sCLnt9jQ2mnqJgP5XZVr93QQbqA
         8ovZfowieUbxl0sRmsCHlV+kujwYqfp6w0320eqrdw/nFC/eGEeLcYpWVIZJRJW9FeN2
         /+tJIsG9OAFUNBXFIyZ/I3ZH4zQP2Wo1JZCwjfnCfclk4R8O4w5YRAwYzTbgTRJt9Fme
         5bwu2PL0Xq89rv5Dt1WHozP+cRe7JCS7XH60y7RTldj1V2vxDi28NI1YYubckRPS5joB
         nfRvBzmhQ3auZLvCJ9Ih7kUIL/lswmrwowzwNX9wTzAZaGTudEEw9S9jEMhHownHifGl
         Lotw==
Received: by 10.204.152.145 with SMTP id g17mr6692330bkw.120.1344971848290;
        Tue, 14 Aug 2012 12:17:28 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.25
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203435>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 257274b..7fb52d4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -386,7 +386,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
-	argv_array_push(&argv, "--quiet");
+	argv_array_push(&argv, debug ? "--stats" : "--quiet");
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
