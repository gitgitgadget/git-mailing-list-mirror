From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] strbuf: Introduce strbuf_fwrite corresponding to strbuf_fread
Date: Tue, 29 Mar 2011 23:43:10 +0530
Message-ID: <1301422392-21177-4-git-send-email-artagnon@gmail.com>
References: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Cc: Peter Baumann <waste.manager@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:15:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dRZ-0000aE-1L
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab1C2SOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:14:55 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54147 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1C2SOy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:14:54 -0400
Received: by yia27 with SMTP id 27so191120yia.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=WQX5oEVoUIThvRTLD5Q90j0CiT/Ht9RneDm8ggjAGf8=;
        b=k33Xw8i3MNuCgY0ziU8NO1LmLuSpfM1cDu7ev00to15EOdjvQlmFnIvYvE5bMmr6+y
         Pcw4MAj0FyJo5ySf2e03uMWOPD9MoCn6rk8ycFeCDLrU13xLuvCdJTYoDwUEeYgvC7/g
         F069XLv8zElxjUNSFK2ZlfneT6MeDG4Zof2FM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=porHcltrByyMvmCfMbR5udxInbvpO8TZj2lXbaN4QeC+8c4jN48VjFQjODcHcPwydF
         ujinOGHVlSLyy01HuVC/Ow974eoG6+X5aq8wCAbvFuUyDtSOU3hv22EDtwwphjRV5FD0
         9jaL9Dke07AKH2Zw/MVFJC0PNdgPBtHNM9/co=
Received: by 10.150.114.18 with SMTP id m18mr416143ybc.308.1301422493658;
        Tue, 29 Mar 2011 11:14:53 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id o2sm1971669ybn.21.2011.03.29.11.14.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:14:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301422392-21177-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170293>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 strbuf.c |   11 +++++++++++
 strbuf.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 77444a9..bdfd0d0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -290,6 +290,17 @@ size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 	return res;
 }
 
+size_t strbuf_fwrite(struct strbuf *sb, size_t size, FILE *f)
+{
+	size_t res;
+
+	if (size > sb->len)
+		res = fwrite(sb->buf, 1, sb->len, f);
+	else 
+		res = fwrite(sb->buf, 1, size, f);
+	return res;
+}
+
 ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 {
 	size_t oldlen = sb->len;
diff --git a/strbuf.h b/strbuf.h
index f722331..c68361c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -124,6 +124,7 @@ __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+extern size_t strbuf_fwrite(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
-- 
1.7.4.rc1.7.g2cf08.dirty
