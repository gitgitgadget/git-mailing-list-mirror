From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 10/16] vcs-svn: add fast_export_note to create notes
Date: Mon, 20 Aug 2012 23:52:16 +0200
Message-ID: <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
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
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zuw-0008V9-71
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab2HTVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:33 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60643 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab2HTVxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:23 -0400
Received: by mail-wi0-f170.google.com with SMTP id hq12so3844314wib.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=b5rwxbmDnvjj9sM2k/++fnhbF1D0Yv6mpB3mzeQMoa4=;
        b=JN5rUarUcOOfiLLCev9oLa7VnJ0k5MOv1En9JQz/fKd6oO3/soTIS8t1krKtuHH/NO
         +OcuDVew5vVyq/c/ej7MlcDMBH9SScV89s2i3mrUCS60L6lq5LQXX8/jqAaiRNw02fpf
         wbDrClknCC9NM175WxnBDS2G+r5DINbEAVdsBOZCtFWTa/VpucwtvoTp/BYw1Luz7sNP
         PLxgfPP9EhiIh9uBL0eVUCIZ1vwq0ZWuDh00Fw0NYA2l5NfMEjrsL6nVRx/MMaOVOmWb
         G1DFShdJgSRewO/UMJPeTBhJ5g2I6p59XsBzEu1G/hurBeUv3Lt6Gn9E77HnSHcs4yJG
         grFg==
Received: by 10.180.78.170 with SMTP id c10mr30908698wix.3.1345499603000;
        Mon, 20 Aug 2012 14:53:23 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.19
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203888>

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
