From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v3 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Tue, 14 Aug 2012 21:13:16 +0200
Message-ID: <1344971598-8213-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
 <1344971598-8213-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1344971598-8213-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 21:18:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Mcq-0004JY-CL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 21:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab2HNTRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 15:17:44 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab2HNTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 15:17:39 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so265503bkw.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kSpKcUexTDfAsPKp+BnEZFO2MRXaa7Bwb5pbVo4jgmk=;
        b=guCGl0DsqFHnp3Bt6kR6zufu+zRs0Ur6ffzHNyGCaAWTlhzhrr7nFCRwx5LCYnILoz
         +C9tq71Pmteg1Zyh6N68tg4eozB2D0ZKQT8v+k9g8/McQJwiu2sy3oOHqYkfAqwWmcOu
         fCYq9w5mGqXeu5OFmn2V6Ujs6IV2Mr2FZgsHDG39Lw2JyixtdfAylwO6UmA7MuvgrlNW
         WoNBlqzy6nSu4E0/cTRDPf9xLpxOuWR9fFtx4A6KzerBvqyu7Z1rf6fTPFHO6DFVl0Od
         PWkOFKrY+fyXSZQLjcwAY88nkDv5QHQdeAQJHc8TpkwqrYCApd1JUHRtTxSUTKIVemql
         MVXQ==
Received: by 10.204.154.66 with SMTP id n2mr6713059bkw.138.1344971859090;
        Tue, 14 Aug 2012 12:17:39 -0700 (PDT)
Received: from localhost.localdomain (089144206125.atnat0015.highway.a1.net. [89.144.206.125])
        by mx.google.com with ESMTPS id fu8sm1681583bkc.5.2012.08.14.12.17.35
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 12:17:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1344971598-8213-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203439>

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
index 7fb52d4..47db055 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -387,6 +387,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	fastimport->in = helper->out;
 	argv_array_push(&argv, "fast-import");
 	argv_array_push(&argv, debug ? "--stats" : "--quiet");
+	argv_array_push(&argv, "--relative-marks");
+	argv_array_pushf(&argv, "--import-marks-if-exists=marks/%s", transport->remote->name);
+	argv_array_pushf(&argv, "--export-marks=marks/%s", transport->remote->name);
 
 	if (data->bidi_import) {
 		cat_blob_fd = xdup(helper->in);
-- 
1.7.9.5
