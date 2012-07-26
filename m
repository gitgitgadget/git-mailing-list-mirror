From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 10/16] When debug==1, start fast-import with "--stats" instead of "--quiet".
Date: Thu, 26 Jul 2012 09:32:31 +0200
Message-ID: <1343287957-22040-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbD-0005DO-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab2GZHen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2GZHem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2HjI6bwfqbJ+nPKlDNuBmSiR7ygcPPDNYRkmKUnM/w8=;
        b=LOLQhbg64Pp+78S2HXMVZNWNUmp1oiN7+bVFBR91N5Bodw7TORtv6vbs4tPZub5rER
         pFAHDIpJdzO8C0PCvHNDWYBJ6rbkiS9gBOJXhwvsj8rtr+xNCKV+SsGSsKYJEAIifW4U
         CXIjn4hmmVG7gmXbacPgs0fvqLdg1auecoWXPMsDsk/3nBOfxUSTnK+BS0BfIIk7/4XU
         bxFFRpBkBP/jUW3ajnN6vMhWOCVhnjEQju879w4y0Js8pp2FKIgN17Go71nia5UMSMO1
         4CTmWq+JAY6YSXke3zZ69rq7/RqHi9Eg6QWn4KGcsVgBLft4PNQuX8D53RPgWfzrlI7J
         I7WQ==
Received: by 10.204.154.214 with SMTP id p22mr13580050bkw.111.1343288081678;
        Thu, 26 Jul 2012 00:34:41 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.39
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202241>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 616db91..d6daad5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -392,7 +392,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(argv, "fast-import");
-	argv_array_push(argv, "--quiet");
+	argv_array_push(argv, debug ? "--stats" : "--quiet");
 	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
 	fastimport->argv = argv->argv;
 	fastimport->git_cmd = 1;
-- 
1.7.9.5
