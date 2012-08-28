From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 15/16] remote-svn: add marks-file regeneration
Date: Tue, 28 Aug 2012 10:49:49 +0200
Message-ID: <1346143790-23491-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
 <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:52:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWs-0002Rb-2I
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab2H1Ivr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:47 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42001 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2H1Ivd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:33 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1532823bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S4H+oatE+Yf3Xfo0OMuvl+fj2C4ez6g7aOK5Bg5Vh34=;
        b=ogmosFPq3zJYB2tb+E+twIARYt1AxsXtx8K4rsCEIhuZHMtKbjJCYLmtaJ8EPP8XBW
         VaP8tpQT0/6LVuRFHUWRiTQzdhMu5P0zvK1VYarTRQI7RlZEFg6Kj/KPiW18VkOr9Gvv
         sghNYY2zwCqDATOEkLdWYRFWl7li5bOJ0TTDxkYGMmwOjvvQkaU6ZMJAVI3qcXhKAT0i
         I4czBQ8BqbJzZedv998P1chRgARf8+hr61NT8zb9x8O4T12/3v3QhiA3ucWIbN3AtABF
         I8B7Yfr+0bxxVwcGnqWHgDLYfGenuRkmHR7pGvDsWAIwn5oN94pb57Xthu7Av7M8Bhnu
         c4TA==
Received: by 10.205.118.5 with SMTP id fo5mr4684998bkc.124.1346143892596;
        Tue, 28 Aug 2012 01:51:32 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.30
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204416>

fast-import mark files are stored outside the object database and are
therefore not fetched and can be lost somehow else.  marks provide a
svn revision --> git sha1 mapping, while the notes that are attached
to each commit when it is imported provide a git sha1 --> svn revision
mapping.

If the marks file is not available or not plausible, regenerate it by
walking through the notes tree.  , i.e.  The plausibility check tests
if the highest revision in the marks file matches the revision of the
top ref. It doesn't ensure that the mark file is completely correct.
This could only be done with an effort equal to unconditional
regeneration.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-testsvn.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index e90d221..d0b81d5 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -86,6 +86,73 @@ static int parse_rev_note(const char *msg, struct rev_note *res) {
 	return 0;
 }
 
+static int note2mark_cb(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data) {
+	FILE *file = (FILE *)cb_data;
+	char *msg;
+	unsigned long msglen;
+	enum object_type type;
+	struct rev_note note;
+	if (!(msg = read_sha1_file(note_sha1, &type, &msglen)) ||
+			!msglen || type != OBJ_BLOB) {
+		free(msg);
+		return 1;
+	}
+	if (parse_rev_note(msg, &note))
+		return 2;
+	if (fprintf(file, ":%d %s\n", note.rev_nr, sha1_to_hex(object_sha1)) < 1)
+		return 3;
+	return 0;
+}
+
+static void regenerate_marks(void)
+{
+	int ret;
+	FILE *marksfile;
+	marksfile = fopen(marksfilename, "w+");
+	if (!marksfile)
+		die_errno("Couldn't create mark file %s.", marksfilename);
+	ret = for_each_note(NULL, 0, note2mark_cb, marksfile);
+	if (ret)
+		die("Regeneration of marks failed, returned %d.", ret);
+	fclose(marksfile);
+}
+
+static void check_or_regenerate_marks(int latestrev) {
+	FILE *marksfile;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int found = 0;
+
+	if (latestrev < 1)
+		return;
+
+	init_notes(NULL, notes_ref, NULL, 0);
+	marksfile = fopen(marksfilename, "r");
+	if (!marksfile) {
+		regenerate_marks();
+		marksfile = fopen(marksfilename, "r");
+		if (!marksfile)
+			die_errno("cannot read marks file %s!", marksfilename);
+		fclose(marksfile);
+	} else {
+		strbuf_addf(&sb, ":%d ", latestrev);
+		while (strbuf_getline(&line, marksfile, '\n') != EOF) {
+			if (!prefixcmp(line.buf, sb.buf)) {
+				found++;
+				break;
+			}
+		}
+		fclose(marksfile);
+		if (!found)
+			regenerate_marks();
+	}
+	free_notes(NULL);
+	strbuf_release(&sb);
+	strbuf_release(&line);
+}
+
 static int cmd_import(const char *line)
 {
 	int code;
@@ -111,6 +178,7 @@ static int cmd_import(const char *line)
 			free(note_msg);
 		}
 	}
+	check_or_regenerate_marks(startrev - 1);
 
 	if (dump_from_file) {
 		dumpin_fd = open(url, O_RDONLY);
-- 
1.7.9.5
