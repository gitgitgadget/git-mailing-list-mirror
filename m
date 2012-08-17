From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 12/16] remote-svn: Activate import/export-marks for fast-import.
Date: Fri, 17 Aug 2012 22:25:53 +0200
Message-ID: <1345235157-702-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345235157-702-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T8t-0006N3-V5
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab2HQU1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:27:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58829 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab2HQU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:27:07 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2687136wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+8nRTAe1fgRadd/QEIGhhmJokUcM3gN/zO3MGv0NRgE=;
        b=m6v19CKP/4Urdu51FHeLd3SeFRLO9JnujYnZnYNMNKj2RQr+ntr+nR8hGfcmAid5iS
         FIYmisUFO2TepnG0cSAUrwCDQLBYDVxEgf5kZrROwXQEkbrkvU0gyrx9qLBNqUTZmvLy
         AXqlyIBmHSklKP3vmGxkvJUyEthjERTd7A4v/FT+4M+5FcJxsycrOpo9Mw9Pult429p1
         g7Ct926mJ+ICfsZqY3GYgFM2+VNoa51NPCDpzeAPiE9okwcv3+HZ3bHJgyBF+b2EW8O/
         YZ45ck6VoYTOeUOh4fTmSGH1gPmMUr6Kk5rjQ4De5CaNT6C9oysgk4mqoamR6kUcZBMH
         /PvA==
Received: by 10.180.86.3 with SMTP id l3mr7648942wiz.16.1345235226521;
        Fri, 17 Aug 2012 13:27:06 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.27.02
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:27:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345235157-702-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203654>

Enable import and export of a marks file by sending the appropriate
feature commands to fast-import before sending data.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 contrib/svn-fe/remote-svn.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/svn-fe/remote-svn.c b/contrib/svn-fe/remote-svn.c
index 80a089a..0643a4c 100644
--- a/contrib/svn-fe/remote-svn.c
+++ b/contrib/svn-fe/remote-svn.c
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
