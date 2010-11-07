From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 1/4] mingw: move unlink wrapper to mingw.c
Date: Sun,  7 Nov 2010 15:56:24 +0100
Message-ID: <f86ceeafb62433b157e18db7488ec72bba75b573.1289139299.git.hvoigt@hvoigt.net>
References: <cover.1289139299.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChCx_NrmBBoEITcN8g@googlegroups.com Sun Nov 07 15:57:13 2010
Return-path: <msysgit+bncCOrwtbejChCx_NrmBBoEITcN8g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChCx_NrmBBoEITcN8g@googlegroups.com>)
	id 1PF6gD-0002Pc-Kk
	for gcvm-msysgit@m.gmane.org; Sun, 07 Nov 2010 15:57:13 +0100
Received: by mail-fx0-f58.google.com with SMTP id 11sf1123881fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 07 Nov 2010 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Nj/D9cPh+N8h5rHA31tWXoOn8QBAOO3/ghtlFeMHy5Q=;
        b=eP1AyPXt/+Kkm7V5OVu9Y5JPYbApKqrxgbCE5zF1SFZ0g0P5wZa3Qt+545/rjRFnPs
         thO3RCFJ12kPlWx+kGtMOosiySLdwzzANEThlKIhZIlewYzrk/6MpHZ1rMAVM4I9eGEG
         1W63+OR2yR2x2d4NWeXo5Y5bixXhzH6OlIHG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=4GnG9vTtWXr9MxgWocKH8fVli8b3xY+8OayksuN0XEjgwn5Zxgsp3OhDgPhoLnGIb+
         OAKschXVRozUiy2gwon9yKlnc7hzGYtcOyqrv78o0oyEDAJiPoBMHlgPp8GfUftvNxh/
         /JrByXqtPj9vCP0qjQZ/pIEK4veS1vYjzOveY=
Received: by 10.223.96.3 with SMTP id f3mr133108fan.25.1289141809905;
        Sun, 07 Nov 2010 06:56:49 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.145.130 with SMTP id d2ls1045502fav.1.p; Sun, 07 Nov 2010
 06:56:48 -0800 (PST)
Received: by 10.223.70.205 with SMTP id e13mr216229faj.3.1289141808883;
        Sun, 07 Nov 2010 06:56:48 -0800 (PST)
Received: by 10.223.70.205 with SMTP id e13mr216228faj.3.1289141808866;
        Sun, 07 Nov 2010 06:56:48 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id b12si946078fah.13.2010.11.07.06.56.48;
        Sun, 07 Nov 2010 06:56:48 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21204 invoked from network); 7 Nov 2010 15:56:48 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 15:56:48 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160881>

The next patch implements a workaround in case unlink fails on Windows.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |    8 ++++++++
 compat/mingw.h |   11 +++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 98163da..49c594f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -155,6 +155,14 @@ int mingw_mkdir(const char *path, int mode)
 	return ret;
 }
 
+#undef unlink
+int mingw_unlink(const char *pathname)
+{
+	/* read-only files cannot be removed */
+	chmod(pathname, 0666);
+	return unlink(pathname);
+}
+
 #undef open
 int mingw_open (const char *filename, int oflags, ...)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 56e58ba..220ae90 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -119,14 +119,6 @@ static inline int fcntl(int fd, int cmd, ...)
 int mingw_mkdir(const char *path, int mode);
 #define mkdir mingw_mkdir
 
-static inline int mingw_unlink(const char *pathname)
-{
-	/* read-only files cannot be removed */
-	chmod(pathname, 0666);
-	return unlink(pathname);
-}
-#define unlink mingw_unlink
-
 static inline pid_t waitpid(pid_t pid, int *status, unsigned options)
 {
 	if (options == 0)
@@ -177,6 +169,9 @@ int link(const char *oldpath, const char *newpath);
  * replacements of existing functions
  */
 
+int mingw_unlink(const char *pathname);
+#define unlink mingw_unlink
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.2.2.177.geec0d
