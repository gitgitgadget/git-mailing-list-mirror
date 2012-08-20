From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 12/16] remote-svn: Activate import/export-marks for fast-import
Date: Mon, 20 Aug 2012 23:52:18 +0200
Message-ID: <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zuw-0008V9-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab2HTVxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34487 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab2HTVx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:27 -0400
Received: by weyx8 with SMTP id x8so4177486wey.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QrTLSDllwR82ZEfJGuqrjFdvgS8wHb6Tvr2O+W9UZgo=;
        b=DdMc1SVFrHiw74bOglqlrqjRS0tqSAR6taCS2D0ox3iDsLiUHMVC07PaLlp+UgbqtU
         tzBYvFlF3NDhdKqAokZVjV++tuvE/NALIaOrSmNtPBceJmhUDzv0t4wHFp3PYiKUAY7+
         /hMX9EZqVr9W6L1b1325a4E4E9k0FAE1jpLTfM4glrV+72k+Bdcks7zZGQH4lq1Llw9W
         vsjiOQcnVP4luuB9AlVC8l/VwuuhlxVkGp6T4YmxNLBGl4YpIzYy3ZQNsa0FsYus+abH
         ZOY14M/fMJ4aSF9P1yO7I126q1XXOpeNOrDYtBN5ZmNMx99rSpJ2YdywRAPXTqSBDO0t
         BzAw==
Received: by 10.180.78.135 with SMTP id b7mr32169958wix.11.1345499606457;
        Mon, 20 Aug 2012 14:53:26 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.24
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203886>

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
