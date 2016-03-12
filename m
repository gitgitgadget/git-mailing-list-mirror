From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 15/17] wrapper: implement append_file()
Date: Sat, 12 Mar 2016 18:46:35 +0800
Message-ID: <1457779597-6918-16-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5L-0006B3-9S
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcCLKrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:48 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35215 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcCLKrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:42 -0500
Received: by mail-pa0-f52.google.com with SMTP id td3so92372314pab.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWxkZCeHvnofY5rw/lcEXVyo4LPIa6uqKFVVMXhx2Wc=;
        b=D31gJxZsCz84Ewb2HEmddeZ/m9cRaYMWRBYG6sUs6FX+IM02rCIvqjNj0wHpU+bNIC
         maA4+uQnLOKOPyQj2VCAUB0uFDpPdxSacWWqwtsCl07AirvPzem6d5aBz2YOsD46KSEx
         /VYnczDJI0VbZC0OisI0JFaawxckapZoVI07wYO/KvNOzrg3XxKAwWqZrE/QGVr4KwZR
         O77EmhYaEXmPvTlhPgPLrZTBl6KfbyRuuWrtKId/WW69N0tH0vbMvs+DZFEVO0LjtDlH
         AwyjpaqExXco8ydFlg82d9wUN8CB/aRW3vo5g6ZBkThhuvVb6LXbEasgXfVaEnewEONp
         4qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWxkZCeHvnofY5rw/lcEXVyo4LPIa6uqKFVVMXhx2Wc=;
        b=O696e1s/7VgoAVoSub9ru/EwGabCz//YB48oFu54YHf0dpvW9MIWHKFdhvlhAJr06T
         mdMdWLwVMefpt0cbumFYhzwbMhVsw9pTwS/B9+5pPKU4E5ZBORorKvfsx+kFQbjgP6DT
         okHfCnnXbmsKbuf8T0bPdhKbD6FbwVtFjThfypFHzxZ5sNF3sqCLaaWvJefbtxmX5L50
         elACGRDpdZR/mNa1f3UaYA8p3j9L2C9RSa8bE94ll0HFMAYp6h/rAn2lXNys7cKVi9p6
         kKB+ETpd9ixV5Ns2ZPwJL/2+x8Kpahd3mlcneTrf90Z0cLfq43eDfXUsHl5B2Bng8s3r
         vXvw==
X-Gm-Message-State: AD7BkJJ+a2V5r/sSEpOBIEzd3m0Aw/UVmxSsKuuhIq8ywsTnvBPK6sQFNyFDYnK+B2/i1A==
X-Received: by 10.66.141.42 with SMTP id rl10mr23052279pab.48.1457779661722;
        Sat, 12 Mar 2016 02:47:41 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:40 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288743>

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache.h   |  1 +
 wrapper.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/cache.h b/cache.h
index 55d443e..aa5e97c 100644
--- a/cache.h
+++ b/cache.h
@@ -1700,6 +1700,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
 
 extern int write_file(const char *path, const char *fmt, ...);
 extern int write_file_gently(const char *path, const char *fmt, ...);
+extern void append_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/wrapper.c b/wrapper.c
index 9afc1a0..cd77e94 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -709,6 +709,29 @@ int write_file_gently(const char *path, const char *fmt, ...)
 	return status;
 }
 
+void append_file(const char *path, const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int fd = open(path, O_WRONLY | O_CREAT | O_APPEND, 0666);
+	va_list params;
+	if (fd < 0)
+		die_errno(_("could not open %s for appending"), path);
+	va_start(params, fmt);
+	strbuf_vaddf(&sb, fmt, params);
+	va_end(params);
+	strbuf_complete_line(&sb);
+	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
+		int err = errno;
+		close(fd);
+		strbuf_release(&sb);
+		errno = err;
+		die_errno(_("could not write to %s"), path);
+	}
+	strbuf_release(&sb);
+	if (close(fd))
+		die_errno(_("could not close %s"), path);
+}
+
 void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
-- 
2.7.0
