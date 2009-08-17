From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 07/11] Add  O_BINARY flag to open flag at mingw.c
Date: Tue, 18 Aug 2009 00:04:58 +0800
Message-ID: <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4ib-0005NH-Cn
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbZHQQFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756627AbZHQQFo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:05:44 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:45112 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbZHQQFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:05:43 -0400
Received: by mail-px0-f196.google.com with SMTP id 34so1252367pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Gptoswal59/sJA28oBB4jF2DXsOVh1OKs2W4ncQ4F5g=;
        b=SlPCqypN1JHOow+vYmQHhBr7rHXKWL7Qgn/doER7hswMeZ95nWrRpIqd3bJpDLoRPu
         Gdgy0m1eJq3+a1x2zRMvHuYnz634CCu+Oc09Au8pbKVMocsE6v7NOepNQOQkiflFkcOh
         QKzPY2yT6QTqH+APU/cNrKja55p7ni1ohlCg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XfNo/WWnwY71m/mLKxqMlzM+tX4mfNJAVkcIF0XGB5j7Zfj8AkhIP0MWLJlg0D4LHp
         VQ5UWtVZ/9dF2hDNptkEkJ0VCKFMvqI5WjHEyeD3flJGJZWGR3AKT2jwU3XJDfjlx4Gm
         GOOxtwIQpbAphkYPIdK7YNJQ5UsqpxJijt4/8=
Received: by 10.115.87.7 with SMTP id p7mr4977912wal.161.1250525145342;
        Mon, 17 Aug 2009 09:05:45 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id k37sm3526947waf.42.2009.08.17.09.05.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:05:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126207>

Windows will convert CR\LF and union code at text mode.
Git doesn't like this. Add O_BINARY flag to open function

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 75c74b1..d5fa0ed 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -132,7 +132,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	if (!strcmp(filename, "/dev/null"))
 		filename = "nul";
 
-	fd = open(filename, oflags, mode);
+	fd = open(filename, oflags | O_BINARY, mode);
 
 	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
 		DWORD attrs = GetFileAttributes(filename);
@@ -278,7 +278,7 @@ int mkstemp(char *template)
 	char *filename = mktemp(template);
 	if (filename == NULL)
 		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return open(filename, O_RDWR | O_CREAT | O_BINARY, 0600);
 }
 
 int gettimeofday(struct timeval *tv, void *tz)
-- 
1.6.4.msysgit.0
