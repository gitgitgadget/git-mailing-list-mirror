From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 12/16] remote-svn: Activate import/export-marks for fast-import
Date: Wed, 22 Aug 2012 21:15:57 +0200
Message-ID: <1345662961-9587-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345662961-9587-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345662961-9587-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQQ-0001jV-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067Ab2HVTRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:17:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055Ab2HVTQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:53 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449679bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QrTLSDllwR82ZEfJGuqrjFdvgS8wHb6Tvr2O+W9UZgo=;
        b=aZdg8FReQ1S5rU+GGUOn3V1ngzsqZjeaUyJKDbbYyWAiIL8XHMRUaSt0NGr+PcULLn
         hujL1SmBPs3+VnXIBy2mPOsNOMtR9wh0+JsJsvyryxlbPz3rRN6AkbeKWT8EH73ARYY4
         ZUUzRBO3earZReU6zmdqllLJlBbLexDdR0kFO6i9l7KBm8ErmKqQZhVMIIgzuy6wk81s
         3S9HkQTctO1W+bXmL6/Dgn2qy6xciy6nXBKJSxu9Cc9VTso8CbmVT5qF6SliNf+KTNeZ
         2XSaKdy9INnqp4J9feNPVy5Za4f0JCJsUdoMZLrsA9aQCstYo9G8lXWZ34tQkR3HPNb1
         kKtg==
Received: by 10.204.148.82 with SMTP id o18mr6924078bkv.41.1345663012883;
        Wed, 22 Aug 2012 12:16:52 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.50
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204077>

Enable import and export of a marks file by sending the appropriate
feature commands to fast-import before sending data.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-testsvn.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 2b9d151..b6e7968 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -12,6 +12,7 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
+static const char *marksfilename;
 
 static int cmd_capabilities(const char *line);
 static int cmd_import(const char *line);
@@ -74,6 +75,10 @@ static int cmd_import(const char *line)
 			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
 		dumpin_fd = svndump_proc.out;
 	}
+	/* setup marks file import/export */
+	printf("feature import-marks-if-exists=%s\n"
+			"feature export-marks=%s\n", marksfilename, marksfilename);
+
 	svndump_init_fd(dumpin_fd, STDIN_FILENO);
 	svndump_read(url, private_ref);
 	svndump_deinit();
@@ -172,6 +177,10 @@ int main(int argc, const char **argv)
 	strbuf_addf(&buf, "refs/svn/%s/master", remote->name);
 	private_ref = strbuf_detach(&buf, NULL);
 
+	strbuf_addf(&buf, "%s/info/fast-import/remote-svn/%s.marks",
+		get_git_dir(), remote->name);
+	marksfilename = strbuf_detach(&buf, NULL);
+
 	while(1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -187,5 +196,6 @@ int main(int argc, const char **argv)
 	strbuf_release(&buf);
 	free((void*)url);
 	free((void*)private_ref);
+	free((void*)marksfilename);
 	return 0;
 }
-- 
1.7.9.5
