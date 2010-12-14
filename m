From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 4/5] mingw: add fallback for rmdir in case
 directory is in use
Date: Tue, 14 Dec 2010 23:25:29 +0100
Message-ID: <20101214222528.GE4084@sandbox>
References: <20101214220604.GA4084@sandbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, msysgit@googlegroups.com,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOrwtbejChDd3Z_oBBoEURgbCA@googlegroups.com Tue Dec 14 23:26:11 2010
Return-path: <msysgit+bncCOrwtbejChDd3Z_oBBoEURgbCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fx0-f58.google.com ([209.85.161.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOrwtbejChDd3Z_oBBoEURgbCA@googlegroups.com>)
	id 1PSdJu-00056Z-IV
	for gcvm-msysgit@m.gmane.org; Tue, 14 Dec 2010 23:26:06 +0100
Received: by fxm13 with SMTP id 13sf320859fxm.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 14 Dec 2010 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:in-reply-to:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=9GnBQaqfQk2QIHNOhWwYkl1N5Ain1QxlAdtYwHLpy8g=;
        b=RwPT5aiS+zhMUYOoMFCYjDyKsGEw5vb91dgtcK9A8MfplwqVZnJ0YaUFDWGkAbfaM9
         BRQYZ2dAyBaU7lCcpXb5mgq0qOxNnC/4vuTSfqVAL6lzXO7cb1g1EelzM6f+PkADqegT
         q2+QK97Z0JE+pBoUcJhmAqjE80vj83hk/si04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        b=rM47dGm/wDDKzdJy7/fHcTckDoiiyttv6JBzFMCZDWkHiGyZ+QXIdRErT/UasmEg4T
         wM8aSflrXKl5hWb5fBeKfEgX2v6DX4vmP3zS9Y7q4fmctlBMX0sJAuzOmFTNvCki8JvL
         g1KjjXQhh16KFUBCwI6ze3lKmQ3uoHlfnmMhk=
Received: by 10.223.73.196 with SMTP id r4mr544976faj.47.1292365533584;
        Tue, 14 Dec 2010 14:25:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.49.147 with SMTP id v19ls613394bkf.1.p; Tue, 14 Dec 2010
 14:25:32 -0800 (PST)
Received: by 10.204.35.73 with SMTP id o9mr488177bkd.10.1292365532525;
        Tue, 14 Dec 2010 14:25:32 -0800 (PST)
Received: by 10.204.35.73 with SMTP id o9mr488176bkd.10.1292365532499;
        Tue, 14 Dec 2010 14:25:32 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id n19si37819bks.5.2010.12.14.14.25.32;
        Tue, 14 Dec 2010 14:25:32 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 21673 invoked from network); 14 Dec 2010 23:25:31 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:25:31 +0100
In-Reply-To: <20101214220604.GA4084@sandbox>
User-Agent: Mutt/1.5.20 (2009-12-10)
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163698>

The same logic as for unlink and rename also applies to rmdir. For
example in case you have a shell open in a git controlled folder. This
will easily fail. So lets be nice for such cases as well.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
I just realized that there was a wrong patch count in the subject. It
should have been 5 instead of 8 all the time.

 compat/mingw.c |   25 +++++++++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ac9fb4a..b920644 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -229,6 +229,31 @@ int mingw_unlink(const char *pathname)
 	return ret;
 }
 
+#undef rmdir
+int mingw_rmdir(const char *pathname)
+{
+	int ret, tries = 0;
+
+	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+		if (!is_file_in_use_error(GetLastError()))
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
+	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
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
index 8316938..8b159c4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -175,6 +175,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_unlink(const char *pathname);
 #define unlink mingw_unlink
 
+int mingw_rmdir(const char *path);
+#define rmdir mingw_rmdir
+
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-- 
1.7.3.3.566.gf422f
