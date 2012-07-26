From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Thu, 26 Jul 2012 09:32:35 +0200
Message-ID: <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
 <1343287957-22040-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuIbG-0005DO-I2
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 09:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929Ab2GZHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 03:34:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58737 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab2GZHew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 03:34:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1067267bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UMkvAyruAhZtHQ93i9TGduVfJAVZHAbY3m7PnAIhxn8=;
        b=laQFbRbib2PuYvgAB/YQ15qrgDWjhgBxESGzK5XgVSg4ZIV8DCVhRRpNJxfo9hBvHJ
         RQtUb/0FHEHTL+UNKSRJmXhJeNzpjm1Ruj3oM9TE++T86/WJBBvOVlWbgm0kYYHoKyMU
         n4vOAva6y0T9gNT0RbtLl2210wjHrYkZVl0s5ZdFJHq68Bxw6RsYP9JqIry3nDblYwCK
         t6WpxTPIgU4MtnpLAyYHAlHFxlECkBlgnyTp1haTWVbN5CENpp2VdgfW370gVrz9d9Sb
         k9JEhkFZAGV3DBNgoH3ax/3tJsjPUOFEyVb39U8jgjvAmSU6CZIzs3Eo4Hj1G0qBEAvd
         /bFw==
Received: by 10.205.117.141 with SMTP id fm13mr13571506bkc.125.1343288091961;
        Thu, 26 Jul 2012 00:34:51 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id n5sm13880348bkv.14.2012.07.26.00.34.50
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 00:34:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202246>

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
