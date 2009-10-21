From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 6/8] mingw: wrap SSL_set_(w|r)fd to call
 _get_osfhandle
Date: Wed, 21 Oct 2009 19:04:49 +0200
Message-ID: <1256144691-2908-7-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <1256144691-2908-2-git-send-email-kusmabite@gmail.com> <1256144691-2908-3-git-send-email-kusmabite@gmail.com> <1256144691-2908-4-git-send-email-kusmabite@gmail.com> <1256144691-2908-5-git-send-email-kusmabite@gmail.com> <1256144691-2908-6-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:05:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f156.google.com ([209.85.212.156])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edJ-0007iA-O8
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:05:57 +0200
Received: by mail-vw0-f156.google.com with SMTP id 28so7316377vws.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=wUSN2/iYFvRRdnx+q6iNdnT+hFyZu3zDGd7fnl3CV8Q=;
        b=om8zRi1HdF0c/NRQlCP4SkPG3NGWXZsVCgpmUj9CwH6hRN/u2KY/WzxaiPhb9Uv+Kw
         hrrKjBJlzNsMCuvTLd6QP0qevAAlHF+9bSVt6g0x1UnpxtByy/VgirMLgncepCmgUGp7
         EOOga6Er8j00SY/O0AUY8tidknp/crc7KhI8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=D+f8IKvX6Qf6KH8RgXRJLCxlQ5k5gVAOOrUZxP1BG/FZLddrYM5cQyXrWA4rYIrKLT
         TxtTw7Jreoy9Am9lWDrjLCg7oWFWJsbyK51nEsrPssvjdukwnu/T/wlFmiWBlT2nz3dY
         XaGE7VMB4t8X4SLOPIpkQLeAVapB0TRkA0Q6U=
Received: by 10.220.68.68 with SMTP id u4mr3592vci.25.1256144750886;
        Wed, 21 Oct 2009 10:05:50 -0700 (PDT)
Received: by 10.177.52.5 with SMTP id e5gr7480yqk.0;
	Wed, 21 Oct 2009 10:05:37 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.32.6 with SMTP id f6mr721301ebf.11.1256144736631; Wed, 21 Oct 2009 10:05:36 -0700 (PDT)
Received: by 10.210.32.6 with SMTP id f6mr721300ebf.11.1256144736603; Wed, 21 Oct 2009 10:05:36 -0700 (PDT)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214]) by gmr-mx.google.com with ESMTP id 15si39764ewy.0.2009.10.21.10.05.35; Wed, 21 Oct 2009 10:05:35 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f214.google.com with SMTP id 10so6779634ewy.9 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=7rYLRkM+g1qAlUw0xILGXUmM+3bJAEs1uOI0FSwwvT4=; b=QQI+ty4y3otsTYWXNlIkTzwn9jzS/UtecTx/nubtb5VX16gUO0oI9ojFh2u07lFfFE 1zcB2IIX91bVaieQWrQBIW9KPvo4qfjTpbg2DHivXjgSdRKGB4llm9UAfAz0j09QCLQe HMh+O10TDpoP7nfwj7rPsGxz0srL4y4YxOE+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=bx8PQNlt2tvpxAFujjXFPBU89rtw3Qa13U1RNHKHlCMUL/gGXnh/9MfjPSiwRTmKX7 5WbXmsmCoiXIgzdiMPaSh5oRmbw0Zu8jPA3Js0uJ8c6UmCN57JDyIB2TNOsUOCcc4Me9 2R0pxC9AjAD5FFN7Ht9DeU499j+7D8QxBq9Ds=
Received: by 10.211.147.25 with SMTP id z25mr3138406ebn.84.1256144735509; Wed, 21 Oct 2009 10:05:35 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 5sm72497eyf.22.2009.10.21.10.05.34 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-6-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130934>


SSL_set_fd (and friends) expects a OS file handle on Windows, not
a file descriptor as on UNIX(-ish).

This patch makes the Windows version of SSL_set_fd behave like the
UNIX versions, by calling _get_osfhandle on it's input.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..6907345 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -124,6 +124,27 @@ static inline int waitpid(pid_t pid, int *status, unsigned options)
 	return -1;
 }
 
+#ifndef NO_OPENSSL
+#include <openssl/ssl.h>
+static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
+{
+	return SSL_set_fd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_fd mingw_SSL_set_fd
+
+static inline int mingw_SSL_set_rfd(SSL *ssl, int fd)
+{
+	return SSL_set_rfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_rfd mingw_SSL_set_rfd
+
+static inline int mingw_SSL_set_wfd(SSL *ssl, int fd)
+{
+	return SSL_set_wfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_wfd mingw_SSL_set_wfd
+#endif
+
 /*
  * implementations of missing functions
  */
-- 
1.6.4.msysgit.0
