Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD9620A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLIKpQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39655 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeLIKpP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so7091804ljh.6
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XsFkuUCW0aL0n3koZogteDfhNNJyRYb5eUrMWXHiGs=;
        b=jBZ1+92/CxrNq5NmpYIs+uv9L2m6uBmP2UD7upS5iCqzAEZkVaFlfSUmQEajr76jn6
         5tGqtPGZ2O7TdYoSQ1+Y1ZP1eK7/00AIhoCuJpIejMauxpbJ4uYWijcYrrmpgLZLnsCg
         f0XEAShzMpWuRflaPH/8yFcdf5/Ic1ozeLdMRyAKEvULXJDrMHgPhLa2Q3RMHXRXErV6
         sNUyEEtN5DdxiyYAL7FhE9g8MDJ80ss9JXjE5vGPzEp8CumTlKA6D9o2oh7dQJjw17xj
         3ksD2DAtODGlvoPtV5l4rls+ReOV1p6PZ7j7VQQbYF2hnTGbHGWAMUoCFyLIMBsgOWod
         +/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XsFkuUCW0aL0n3koZogteDfhNNJyRYb5eUrMWXHiGs=;
        b=NRBltw1twDsxvM/b5AxIE/phc1cn/3AevYp0PIqe0b9oEdCN/KOL5Va5DB9uuI4m2u
         PLfsUEDd58pRm1Vzuy9C3vAGuFkURiZuDX22bNqXEi6kDZzqARX0HpdPvFpPOeXm9NQP
         E7ZGyrN5wzqdgimONApCtqp4EpZRoFNCVRh/OBhG22qzSqNRf/ukymNOg8dbO6FZTZc9
         k0BcvRJMf90dDDAsx0QBavxBkwNhMZuql3WpLWGELV7Ds5e9oJam/vt0ttDaOzSBKBFQ
         WlguGO0/VUyZmSMcBuSk9vdcrSmvwY2Jqt1glb7nrkjQUDo6/1ZFffcSZ/Q06RTAhdCD
         EKDA==
X-Gm-Message-State: AA+aEWZ9xyuIbzM+wRlWmaNc8zBMsfOhKLEa9ChiycdpV7Tgln99IhaB
        fwIX330nGXqRU2ByUHGUM1nS+lUA
X-Google-Smtp-Source: AFSGD/Webi/zkAIrtxOeZ/80cVi6kghCsib65zAkzjvEnbqpqedhO2PzwpF5WO8HxNDUja8X/KWh2g==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr5342998ljh.174.1544352310792;
        Sun, 09 Dec 2018 02:45:10 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:10 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/24] backup-log.c: add API for walking backup log
Date:   Sun,  9 Dec 2018 11:44:04 +0100
Message-Id: <20181209104419.12639-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 backup-log.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++
 backup-log.h |  21 ++++++-
 2 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/backup-log.c b/backup-log.c
index c1e805b09e..49f2ce68fe 100644
--- a/backup-log.c
+++ b/backup-log.c
@@ -44,3 +44,176 @@ int bkl_write(const char *path, struct strbuf *new_log)
 	rollback_lock_file(&lk);
 	return ret;
 }
+
+int bkl_parse_entry(struct strbuf *sb, struct bkl_entry *re)
+{
+	char *email_end, *message;
+	const char *p = sb->buf;
+
+	/* old SP new SP name <email> SP time TAB msg LF */
+	if (!sb->len || sb->buf[sb->len - 1] != '\n' ||
+	    parse_oid_hex(p, &re->old_oid, &p) || *p++ != ' ' ||
+	    parse_oid_hex(p, &re->new_oid, &p) || *p++ != ' ' ||
+	    !(email_end = strchr(p, '>')) ||
+	    email_end[1] != ' ')
+		return -1;	/* corrupt? */
+	re->email = p;
+	re->timestamp = parse_timestamp(email_end + 2, &message, 10);
+	if (!re->timestamp ||
+	    !message || message[0] != ' ' ||
+	    (message[1] != '+' && message[1] != '-') ||
+	    !isdigit(message[2]) || !isdigit(message[3]) ||
+	    !isdigit(message[4]) || !isdigit(message[5]))
+		return -1; /* corrupt? */
+	email_end[1] = '\0';
+	re->tz = strtol(message + 1, NULL, 10);
+	if (message[6] != '\t')
+		message += 6;
+	else
+		message += 7;
+	sb->buf[sb->len - 1] = '\0'; /* no LF */
+	re->path = message;
+	return 0;
+}
+
+static char *find_beginning_of_line(char *bob, char *scan)
+{
+	while (bob < scan && *(--scan) != '\n')
+		; /* keep scanning backwards */
+	/*
+	 * Return either beginning of the buffer, or LF at the end of
+	 * the previous line.
+	 */
+	return scan;
+}
+
+int bkl_parse_file_reverse(const char *path,
+			   int (*parse)(struct strbuf *line, void *data),
+			   void *data)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *logfp;
+	long pos;
+	int ret = 0, at_tail = 1;
+
+	logfp = fopen(path, "r");
+	if (!logfp) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0;
+		return -1;
+	}
+
+	/* Jump to the end */
+	if (fseek(logfp, 0, SEEK_END) < 0)
+		ret = error_errno(_("cannot seek back in %s"), path);
+	pos = ftell(logfp);
+	while (!ret && 0 < pos) {
+		int cnt;
+		size_t nread;
+		char buf[BUFSIZ];
+		char *endp, *scanp;
+
+		/* Fill next block from the end */
+		cnt = (sizeof(buf) < pos) ? sizeof(buf) : pos;
+		if (fseek(logfp, pos - cnt, SEEK_SET)) {
+			ret = error_errno(_("cannot seek back in %s"), path);
+			break;
+		}
+		nread = fread(buf, cnt, 1, logfp);
+		if (nread != 1) {
+			ret = error_errno(_("cannot read %d bytes from %s"),
+					  cnt, path);
+			break;
+		}
+		pos -= cnt;
+
+		scanp = endp = buf + cnt;
+		if (at_tail && scanp[-1] == '\n')
+			/* Looking at the final LF at the end of the file */
+			scanp--;
+		at_tail = 0;
+
+		while (buf < scanp) {
+			/*
+			 * terminating LF of the previous line, or the beginning
+			 * of the buffer.
+			 */
+			char *bp;
+
+			bp = find_beginning_of_line(buf, scanp);
+
+			if (*bp == '\n') {
+				/*
+				 * The newline is the end of the previous line,
+				 * so we know we have complete line starting
+				 * at (bp + 1). Prefix it onto any prior data
+				 * we collected for the line and process it.
+				 */
+				strbuf_splice(&sb, 0, 0, bp + 1, endp - (bp + 1));
+				scanp = bp;
+				endp = bp + 1;
+				ret = parse(&sb, data);
+				strbuf_reset(&sb);
+				if (ret)
+					break;
+			} else if (!pos) {
+				/*
+				 * We are at the start of the buffer, and the
+				 * start of the file; there is no previous
+				 * line, and we have everything for this one.
+				 * Process it, and we can end the loop.
+				 */
+				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				ret = parse(&sb, data);
+				strbuf_reset(&sb);
+				break;
+			}
+
+			if (bp == buf) {
+				/*
+				 * We are at the start of the buffer, and there
+				 * is more file to read backwards. Which means
+				 * we are in the middle of a line. Note that we
+				 * may get here even if *bp was a newline; that
+				 * just means we are at the exact end of the
+				 * previous line, rather than some spot in the
+				 * middle.
+				 *
+				 * Save away what we have to be combined with
+				 * the data from the next read.
+				 */
+				strbuf_splice(&sb, 0, 0, buf, endp - buf);
+				break;
+			}
+		}
+
+	}
+	if (!ret && sb.len)
+		BUG("reverse reflog parser had leftover data");
+
+	fclose(logfp);
+	strbuf_release(&sb);
+	return ret;
+}
+
+int bkl_parse_file(const char *path,
+		   int (*parse)(struct strbuf *line, void *data),
+		   void *data)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *logfp;
+	int ret = 0;
+
+	logfp = fopen(path, "r");
+	if (!logfp) {
+		if (errno == ENOENT || errno == ENOTDIR)
+			return 0;
+		return -1;
+	}
+
+	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+		ret = parse(&sb, data);
+	fclose(logfp);
+	strbuf_release(&sb);
+	return ret;
+}
diff --git a/backup-log.h b/backup-log.h
index 5e475d6f35..c9de9c687c 100644
--- a/backup-log.h
+++ b/backup-log.h
@@ -1,13 +1,32 @@
 #ifndef __BACKUP_LOG_H__
 #define __BACKUP_LOG_H__
 
-struct object_id;
+#include "cache.h"
+
 struct strbuf;
 
+struct bkl_entry
+{
+	struct object_id old_oid;
+	struct object_id new_oid;
+	const char *email;
+	timestamp_t timestamp;
+	int tz;
+	const char *path;
+};
+
 void bkl_append(struct strbuf *output, const char *path,
 		const struct object_id *from,
 		const struct object_id *to);
 
 int bkl_write(const char *path, struct strbuf *new_log);
 
+int bkl_parse_entry(struct strbuf *sb, struct bkl_entry *re);
+int bkl_parse_file_reverse(const char *path,
+			   int (*parse)(struct strbuf *line, void *data),
+			   void *data);
+int bkl_parse_file(const char *path,
+		   int (*parse)(struct strbuf *line, void *data),
+		   void *data);
+
 #endif
-- 
2.20.0.rc2.486.g9832c05c3d

