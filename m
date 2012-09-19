From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 12/16] remote-svn: Activate import/export-marks for fast-import
Date: Wed, 19 Sep 2012 17:21:26 +0200
Message-ID: <1348068090-31988-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7h-0006Jl-EM
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab2ISPW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:22:59 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab2ISPW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:22:56 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EHoMbG9BELwOQ/f0yNcLT7LWgeprjFpNQQNI0S5xazc=;
        b=cTUXkGit3lcpR6kAF4deGq5oZe8EDBvH4Z/Yr8QcuTIwAxs4vduuAyKR+SK+v4L3r4
         9K8CrnXdo01bG7wJNiYwXGmIQJAz++zitU9rA8EQAZzIhkllTc4lLY8axYBQMjALl1Sr
         6SMOK0+jrdwpNl61wVzjDLnl3Q2B/G/39nC0dn4MD1dc+w4TQ+rR3o7k2ch8LddcOn+Y
         4HK8wqqlNghktAlieLItdbgHu9hHMDfPCnd4U3092jZ3f1/3yNaAdbFELfEe6VWSDUma
         8Aw4mLOu5sI5dvRWdqaxneS0Wk/fCaJqBmogLXYyc7v1VMlUKFvgo7Trh2kosNvfQ9r0
         MLBw==
Received: by 10.204.130.198 with SMTP id u6mr1444174bks.26.1348068175983;
        Wed, 19 Sep 2012 08:22:55 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.22.52
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:22:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205938>

Enable import and export of a marks file by sending the appropriate
feature commands to fast-import before sending data.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff:
- seperate strbufs in main
 remote-testsvn.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 67466a9..45eba9f 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -12,6 +12,7 @@ static const char *url;
 static int dump_from_file;
 static const char *private_ref;
 static const char *remote_ref = "refs/heads/master";
+static const char *marksfilename;
 
 static int cmd_capabilities(const char *line);
 static int cmd_import(const char *line);
@@ -73,6 +74,10 @@ static int cmd_import(const char *line)
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
@@ -145,7 +150,7 @@ static int do_command(struct strbuf *line)
 int main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
-			private_ref_sb = STRBUF_INIT;
+			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT;
 	static struct remote *remote;
 	const char *url_in;
 
@@ -171,6 +176,10 @@ int main(int argc, const char **argv)
 	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
 	private_ref = private_ref_sb.buf;
 
+	strbuf_addf(&marksfilename_sb, "%s/info/fast-import/remote-svn/%s.marks",
+		get_git_dir(), remote->name);
+	marksfilename = marksfilename_sb.buf;
+
 	while (1) {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
@@ -186,5 +195,6 @@ int main(int argc, const char **argv)
 	strbuf_release(&buf);
 	strbuf_release(&url_sb);
 	strbuf_release(&private_ref_sb);
+	strbuf_release(&marksfilename_sb);
 	return 0;
 }
-- 
1.7.9.5
