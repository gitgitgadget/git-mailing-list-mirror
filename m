From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2 4/4] mingw: add fallback for rmdir in case
 directory is in use
Date: Sun,  7 Nov 2010 15:56:27 +0100
Message-ID: <2497be75bac8877a06bef1d8c702f0c714fbc588.1289139299.git.hvoigt@hvoigt.net>
References: <cover.1289139299.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChC7_NrmBBoE5ERWdA@googlegroups.com Sun Nov 07 15:57:23 2010
Return-path: <msysgit+bncCOrwtbejChC7_NrmBBoE5ERWdA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChC7_NrmBBoE5ERWdA@googlegroups.com>)
	id 1PF6gM-0002Pc-Tm
	for gcvm-msysgit@m.gmane.org; Sun, 07 Nov 2010 15:57:22 +0100
Received: by mail-fx0-f58.google.com with SMTP id 11sf1123881fxm.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 07 Nov 2010 06:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:from:to
         :cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=MlORa/kYR+TI8Nmu3sMOnsDZu4S/X4yTqqg1l1jZj1Q=;
        b=FKubDo8rWUVb6NodpnSrGLoBrb9QCwNSoasQ35oym8nG0SjhvoAZeVkdl1LA0HwYU+
         Qga6INbouwZmuPHCvtJOA03ADzh28NPjl5kucenOA8XtjAKaNh+KoevSXYC+OaSPb08F
         9pXXFb+pjAH3Ci78U5OJGDF7m1z9k52f+yXvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=UnRrSRU6uOZSQo++ZyAk6Dbc8kB0ZG8wA1XvFXwnWlRX8I0rwNMCPSM8T5uAUplyRs
         ewb9iA5y7mTkckilCIu7+CouyJeQYlmg/+04kVTGUO9injc7f6DQKNTwJm4wOhX8nLKC
         Ss71sEkX7DOEeT2/SgARiHmIV+mqhqmlySfsM=
Received: by 10.223.83.8 with SMTP id d8mr127818fal.27.1289141819152;
        Sun, 07 Nov 2010 06:56:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.145.130 with SMTP id d2ls1045514fav.1.p; Sun, 07 Nov 2010
 06:56:58 -0800 (PST)
Received: by 10.223.87.6 with SMTP id u6mr231655fal.25.1289141818539;
        Sun, 07 Nov 2010 06:56:58 -0800 (PST)
Received: by 10.223.87.6 with SMTP id u6mr231654fal.25.1289141818521;
        Sun, 07 Nov 2010 06:56:58 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id 28si946203fas.11.2010.11.07.06.56.58;
        Sun, 07 Nov 2010 06:56:58 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21234 invoked from network); 7 Nov 2010 15:56:57 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Nov 2010 15:56:57 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160884>

From: Heiko Voigt <heiko.voigt@mahr.de>

The same logic as for unlink and rename also applies to rmdir. For
example in case you have a shell open in a git controlled folder. This
will easily fail. So lets be nice for such cases as well.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 compat/mingw.c |   25 +++++++++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b66bf89..8e4f1e2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -263,6 +263,31 @@ int mingw_unlink(const char *pathname)
 	return ret;
 }
 
+#undef rmdir
+int mingw_rmdir(const char *pathname)
+{
+    int ret, tries = 0;
+
+	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
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
+	while (ret == -1 && is_file_in_use_error() &&
+	       ask_user_yes_no("Deletion of directory '%s' failed. "
+			"Should I try again?", pathname))
+	       ret = rmdir(pathname);
+	return ret;
+}
+
 #undef open
 int mingw_open (const char *filename, int oflags, ...)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 220ae90..cf69d39 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -172,6 +172,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_unlink(const char *pathname);
 #define unlink mingw_unlink
 
+int mingw_rmdir(const char *path);
+#define rmdir mingw_rmdir
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.2.2.177.geec0d
