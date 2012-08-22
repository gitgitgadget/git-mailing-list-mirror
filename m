From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v6 10/16] vcs-svn: add fast_export_note to create notes
Date: Wed, 22 Aug 2012 21:15:55 +0200
Message-ID: <1345662961-9587-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4GQR-0001jV-9N
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065Ab2HVTRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:17:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59577 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049Ab2HVTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:16:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so449742bkw.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=b5rwxbmDnvjj9sM2k/++fnhbF1D0Yv6mpB3mzeQMoa4=;
        b=n6scRqGzZkFqdDuXGfDGLFKVTpTZkIRt+rKnT2grTzK8dMgV8luOkgb3/TUjLnqDys
         bLnWN8lCn4MsZmCQQ/HK7cwUM4clrzx0BmEcQyH7VAjBAamZTOnPL2d7yzq6Ax/HlORS
         K5HP7IXZ8BBWKvW7TLwDcNzrKGUsgSX69fFFjs2ePn3rnrdKtA1Sysh/EEY9cxNySX2/
         cQvpAtMf2dtbLFpQlxoOmnwVnuGyujcwETvcbfWvXxztd8IJtQ/FltAQsTso4uzT+jIf
         xj6j16vCXvTK3q6EHDHP+KajnJRK4QQm7d4++Rz1N/p7r3dotz3JIwszkhhbY9kx9UjY
         Uluw==
Received: by 10.204.157.10 with SMTP id z10mr7107256bkw.63.1345663008488;
        Wed, 22 Aug 2012 12:16:48 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id ht18sm3346763bkc.16.2012.08.22.12.16.46
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 12:16:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345662961-9587-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204078>

From: Dmitry Ivankov <divanorama@gmail.com>

fast_export lacked a method to writes notes to fast-import stream.
Add two new functions fast_export_note which is similar to
fast_export_modify. And also add fast_export_buf_to_data to be able to
write inline blobs that don't come from a line_buffer or from delta
application.

To be used like this:

  fast_export_begin_commit("refs/notes/somenotes", ...)
  fast_export_note("refs/heads/master", "inline")
  fast_export_buf_to_data(&data)

or maybe

  fast_export_note("refs/heads/master", sha1)

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 vcs-svn/fast_export.c |   12 ++++++++++++
 vcs-svn/fast_export.h |    2 ++
 2 files changed, 14 insertions(+)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 11f8f94..1ecae4b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,6 +68,11 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
+void fast_export_note(const char *committish, const char *dataref)
+{
+	printf("N %s %s\n", dataref, committish);
+}
+
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
@@ -222,6 +227,13 @@ static long apply_delta(off_t len, struct line_buffer *input,
 	return ret;
 }
 
+void fast_export_buf_to_data(const struct strbuf *data)
+{
+	printf("data %"PRIuMAX"\n", (uintmax_t)data->len);
+	fwrite(data->buf, data->len, 1, stdout);
+	fputc('\n', stdout);
+}
+
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 {
 	assert(len >= 0);
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 17eb13b..9b32f1e 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -9,11 +9,13 @@ void fast_export_deinit(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
+void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,
 			const char *url, unsigned long timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
+void fast_export_buf_to_data(const struct strbuf *data);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
 			off_t len, struct line_buffer *input);
-- 
1.7.9.5
