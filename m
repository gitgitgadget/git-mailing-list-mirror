From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 12/16] remote-svn: Activate import/export-marks for fast-import
Date: Tue, 28 Aug 2012 10:49:46 +0200
Message-ID: <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:51:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWN-00022f-3O
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab2H1Ive (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51578 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab2H1IvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:25 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1533185bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QrTLSDllwR82ZEfJGuqrjFdvgS8wHb6Tvr2O+W9UZgo=;
        b=Vm4yUeNQy8jgOSmWDvRHtsMiAWuETX4+8WmWc7gqWV30G0fv7Z5iRos83pTRaJEtv7
         9vf5xMUQ7iyf3Lii2ADwGVgKIXI8y4FY4ob46KOhqjhzxNb5/IwqPzh59M2atIimoezm
         gW79PMzTsZVTk9RAzk5mDmscmxiTpSfO+TTNROCBmfbVbtNmfgiaaXESd1OMLy0Kn6PF
         4hq5lqyWUUmDAH643dxMD9wvpSQSQECf94xI49fhhlM8vDkx/nF+kDJtFVqHdkLLgEF2
         SASOSMPIJyL6zGQK2nvUxaKiT6KN4JuIlp9mnV2j4bv6YuwD7BPbErbCKHLj8i3GGqb/
         jdxg==
Received: by 10.204.152.137 with SMTP id g9mr4698492bkw.106.1346143885143;
        Tue, 28 Aug 2012 01:51:25 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.23
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204405>

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
