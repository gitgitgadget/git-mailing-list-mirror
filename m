From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_complete_line() for adding a newline if needed
Date: Fri, 12 Dec 2014 20:16:38 +0100
Message-ID: <548B3F16.80208@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:17:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVid-0004p8-3l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934770AbaLLTRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:17:34 -0500
Received: from mout.web.de ([212.227.15.4]:52630 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933644AbaLLTRd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:17:33 -0500
Received: from [192.168.178.27] ([79.253.155.45]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M0QlZ-1XgjHO3IVR-00ucuA; Fri, 12 Dec 2014 20:17:27
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:0vas6ZTj3+hqbxcbog0EZyWOMtp7MwqApEvDAsebv11hu0wA57e
 HT2xleupbX3C7MN/ACJe84roty9hya+vJ1+8jxM+Tmqcvv2EIpqZyJf3XhEVXJVB/rHmiQh
 3ANpefBXXaCooQ495xdz9z6sl+90UnTT+rNaBPMzpPKfobM+aoKrvx4a8N0hYAQr0mdXwQH
 NJtcy6Qy/rQyX1OJbfgcw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261359>

Call strbuf_complete_line() instead of open-coding it.  Also remove
surrounding comments indicating the intent to complete a line since
this information is already included in the function name.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fmt-merge-msg.c | 3 +--
 notes-utils.c           | 3 +--
 trace.c                 | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 37177c6..af7919e 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -216,8 +216,7 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 			strbuf_addf(out, "  : %.*s", (int)(ep - bp), bp);
 			bp = ep;
 		}
-		if (out->buf[out->len - 1] != '\n')
-			strbuf_addch(out, '\n');
+		strbuf_complete_line(out);
 	}
 	strbuf_release(&desc);
 }
diff --git a/notes-utils.c b/notes-utils.c
index b64dc1b..ccbf073 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -44,8 +44,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 
 	/* Prepare commit message and reflog message */
 	strbuf_addstr(&buf, msg);
-	if (buf.buf[buf.len - 1] != '\n')
-		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
+	strbuf_complete_line(&buf);
 
 	create_notes_commit(t, NULL, buf.buf, buf.len, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
diff --git a/trace.c b/trace.c
index 4778608..f6f9f3a 100644
--- a/trace.c
+++ b/trace.c
@@ -122,9 +122,7 @@ static int prepare_trace_line(const char *file, int line,
 
 static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
-	/* append newline if missing */
-	if (buf->len && buf->buf[buf->len - 1] != '\n')
-		strbuf_addch(buf, '\n');
+	strbuf_complete_line(buf);
 
 	write_or_whine_pipe(get_trace_fd(key), buf->buf, buf->len, err_msg);
 	strbuf_release(buf);
-- 
2.2.0
