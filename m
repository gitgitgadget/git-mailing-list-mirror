From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Mon, 30 Jul 2012 16:31:21 +0200
Message-ID: <1343658683-10713-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8R-00086y-4y
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab2G3Ojk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:40 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3Oji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:38 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859181bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UMkvAyruAhZtHQ93i9TGduVfJAVZHAbY3m7PnAIhxn8=;
        b=x9A1dcfJyU8oCqxMQnbzMNmMlu5Vy9QrAmeqfD8OZu9nxSzjuucEih1bzO2oWd4cVB
         uh9XPUdDCUUDXUgM3B5RIQYsL69+3/ZXQiEBmw4OqFd0LtDkX9VqwGw8S8wfcspiaByC
         MCqGQuG7M/3ELh4ObCpS9twZetso18gvG+pI83jSRWH18pIpS9CVhlMJkzlQ8ZNG2orz
         U+WnKi7yanVi8ADG9JvL/TzcSLRzpx2GtSMKR/uxmcTb/Do6GxkYAd9+AaR0S2ev4RqR
         +NV55QeD7YcMYGTuN5T7mjNmZTgxvYlPZJWLRm00HrNZdh4CSturz/V7PhOOuIXNVd7I
         FbQQ==
Received: by 10.205.132.12 with SMTP id hs12mr4030937bkc.47.1343659177305;
        Mon, 30 Jul 2012 07:39:37 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.35
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202557>

fast-import internally uses marks that refer to an object via its sha1.
Those marks are created during import to find previously created objects.
At exit the accumulated marks can be exported to a file and reloaded at
startup, so that the previous marks are available.
Add command line options to the fast-import command line to enable this.
The mark files are stored in info/fast-import/marks/<remote-name>.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index e10fd6b..74f9608 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -394,6 +394,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	argv_array_push(argv, "fast-import");
 	argv_array_push(argv, debug ? "--stats" : "--quiet");
 	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
+	argv_array_push(argv, "--relative-marks");
+	argv_array_pushf(argv, "--import-marks-if-exists=marks/%s", transport->remote->name);
+	argv_array_pushf(argv, "--export-marks=marks/%s", transport->remote->name);
 	fastimport->argv = argv->argv;
 	fastimport->git_cmd = 1;
 
-- 
1.7.9.5
