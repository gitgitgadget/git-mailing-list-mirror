From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 2/4] mingw: work around irregular failures of
 unlink on windows
Date: Sun,  7 Nov 2010 15:56:25 +0100
Message-ID: <1ffbd7b91ebd56c46dc7874dae3929708e8998b8.1289139299.git.hvoigt@hvoigt.net>
References: <cover.1289139299.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChCz_NrmBBoEHjCsKA@googlegroups.com Sun Nov 07 15:57:15 2010
Return-path: <msysgit+bncCOrwtbejChCz_NrmBBoEHjCsKA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChCz_NrmBBoEHjCsKA@googlegroups.com>)
	id 1PF6gF-0002Pc-No
	for gcvm-msysgit@m.gmane.org; Sun, 07 Nov 2010 15:57:15 +0100
Received: by mail-fx0-f58.google.com with SMTP id 11sf1123881fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 07 Nov 2010 06:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=4AYv/vVOiYgzg/1ZsnhM+XoEzS5NAoxqtbbDuDQr4xc=;
        b=SArieSCfHwKtGnZYOjLZUHINA9q7N2bGbZQBYmKgQSOGx6FqlwRg+uspGBkOg6s8Z1
         s0Mp4qQ7D1tBwch7f/6PXMi9j5KAvXpQeupa4t6QK7EL1cfCcdjiddEmpjC4Pz7Hv79J
         R2D8BimxsYonxks8BGApO9i/DHIxQ6/4xmRFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=wpSko9oTd7suLo94JDgxs+zRvsO4pcLgwIOZjNKZYM/EnDuzcQ8JeWf1D0129O7LNs
         0k116a0QHvsnqgn4KQH3FktkH5eTXmr3PJZLalJqc1+6+Wi5JZKwlGdyAer+e03TBK5B
         i6vlLXncqaj4x3npodbycZ3TbLrbjcSLRsgbw=
Received: by 10.223.73.196 with SMTP id r4mr131979faj.47.1289141811826;
        Sun, 07 Nov 2010 06:56:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.99.144 with SMTP id u16ls1045768fan.2.p; Sun, 07 Nov 2010
 06:56:51 -0800 (PST)
Received: by 10.223.83.10 with SMTP id d10mr200852fal.23.1289141811079;
        Sun, 07 Nov 2010 06:56:51 -0800 (PST)
Received: by 10.223.83.10 with SMTP id d10mr200851fal.23.1289141811052;
        Sun, 07 Nov 2010 06:56:51 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id g13si946518fah.10.2010.11.07.06.56.50;
        Sun, 07 Nov 2010 06:56:51 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21214 invoked from network); 7 Nov 2010 15:56:50 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 15:56:50 +0100
X-Mailer: git-send-email 1.7.2.2.177.geec0d
In-Reply-To: <cover.1289139299.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1289139299.git.hvoigt@hvoigt.net>
References: <201009282252.25688.j6t@kdbg.org> <cover.1289139299.git.hvoigt@hvoigt.net>
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 83.133.111.250 is neither permitted nor denied by best guess record for
 domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160882>

If a file is opened by another process (e.g. indexing of an IDE) for
reading it is not allowed to be deleted. So in case unlink fails retry
after waiting for some time. This extends the workaround from 6ac6f878.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 49c594f..bf9ffb8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,6 +5,7 @@
 #include "../cache.h"
 
 unsigned int _CRT_fmode = _O_BINARY;
+static const int delay[] = { 0, 1, 10, 20, 40 };
 
 int err_win_to_posix(DWORD winerr)
 {
@@ -119,6 +120,13 @@ int err_win_to_posix(DWORD winerr)
 	return error;
 }
 
+static inline int is_file_in_use_error()
+{
+	if (GetLastError() == ERROR_SHARING_VIOLATION)
+		return 1;
+	return 0;
+}
+
 static int make_hidden(const char *path)
 {
 	DWORD attribs = GetFileAttributes(path);
@@ -158,9 +166,24 @@ int mingw_mkdir(const char *path, int mode)
 #undef unlink
 int mingw_unlink(const char *pathname)
 {
+	int ret, tries = 0;
+
 	/* read-only files cannot be removed */
 	chmod(pathname, 0666);
-	return unlink(pathname);
+	while ((ret = unlink(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+		if (!is_file_in_use_error())
+			break;
+		/*
+		 * We assume that some other process had the source or
+		 * destination file open at the wrong moment and retry.
+		 * In order to give the other process a higher chance to
+		 * complete its operation, we give up our time slice now.
+		 * If we have to retry again, we do sleep a bit.
+		 */
+		Sleep(delay[tries]);
+		tries++;
+	}
+	return ret;
 }
 
 #undef open
@@ -1279,7 +1302,6 @@ int mingw_rename(const char *pold, const char *pnew)
 {
 	DWORD attrs, gle;
 	int tries = 0;
-	static const int delay[] = { 0, 1, 10, 20, 40 };
 
 	/*
 	 * Try native rename() first to get errno right.
-- 
1.7.2.2.177.geec0d
