From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v4 6/8] mingw: wrap SSL_set_(w|r)fd to call
 _get_osfhandle
Date: Mon, 19 Oct 2009 17:42:07 +0200
Message-ID: <1255966929-1280-7-git-send-email-kusmabite@gmail.com>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-2-git-send-email-kusmabite@gmail.com> <1255966929-1280-3-git-send-email-kusmabite@gmail.com> <1255966929-1280-4-git-send-email-kusmabite@gmail.com> <1255966929-1280-5-git-send-email-kusmabite@gmail.com> <1255966929-1280-6-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 19 17:43:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f143.google.com ([209.85.210.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuOg-0006YP-3B
	for gcvm-msysgit@m.gmane.org; Mon, 19 Oct 2009 17:43:46 +0200
Received: by yxe7 with SMTP id 7so3873005yxe.25
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 Oct 2009 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8ENZDQ0IUP/D9uw2oRo3tfJURUjpYqwZL5maMTWszAY=;
        b=xXiyyir/6WQsLvTiLj/hyNpIRl26bmUZ/Jegyt+2iNnO3QGr2H/IWivG0OR/CPGZpW
         ezEqZqOLsq7CbJ8AW6YxZPmChp1Dsl+U5pRurcm+LfbbFe4/5Gyf/Or0Dmb+PvrG8ce5
         9QQ0fQlXs5cZEC7g0ugd24Ko7ciWiWZIDynrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=rivABorbBgRCNT1IcWpeM033apWZ2S8ewmo92ZtoFAnKYk5t2u8+3RaBwRKIR7uk1/
         sWYaiqtq/OenaewxvAASHPKLLhNDGj4YMJFOasUblhFHG3wBnVZuUzkYm2vCmX+mKWH7
         gjm+s74lm+anOdXimaHpParJrgkxC6bmkeA1A=
Received: by 10.90.206.14 with SMTP id d14mr280063agg.16.1255967018712;
        Mon, 19 Oct 2009 08:43:38 -0700 (PDT)
Received: by 10.176.133.2 with SMTP id g2gr7452yqd.0;
	Mon, 19 Oct 2009 08:43:31 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.7.23 with SMTP id 23mr278623ebg.4.1255967010092; Mon, 19 Oct 2009 08:43:30 -0700 (PDT)
Received: by 10.210.7.23 with SMTP id 23mr278622ebg.4.1255967010072; Mon, 19 Oct 2009 08:43:30 -0700 (PDT)
Received: from mail-ew0-f210.google.com (mail-ew0-f210.google.com [209.85.219.210]) by gmr-mx.google.com with ESMTP id 14si906168ewy.1.2009.10.19.08.43.29; Mon, 19 Oct 2009 08:43:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.210 as permitted sender) client-ip=209.85.219.210;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.210 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ewy6 with SMTP id 6so1227076ewy.30 for <msysgit@googlegroups.com>; Mon, 19 Oct 2009 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=5p80m1AlZD5siE5sZF7pgHsaFMUcrdzCSx232oTDU6g=; b=IyOThw49bscS7AksC1tmlVAvWQzuxO3ikWaacC+kTG4xmNBUuKyplNtuOodc9b31TJ 2HgzReG1RPKvKqAK9ebUhOf7d+2msXUQEPdhT/e8eY9AbvwHxtq3r/umlbflS1rPFRMU ODlEo22IalV0cHhq32s8+GmH0pxaGxReHwWpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=BFwcGqqlvb9pQJKUxTiFhB1TehjbvBUmc7Me9R6Ubdacjv3zspS8Q5pIz7a4bFP5Q/ TBi8KdY4MwemX1ZahNnq+MnPeRfS90VulIg1IC7q4YO2Bir5wYkH4epAQhuETxZeyKyT kch7OozY91GhmWsQDXsx+l8QFtwQd3FnUsvcA=
Received: by 10.211.160.4 with SMTP id m4mr5788346ebo.24.1255967008976; Mon, 19 Oct 2009 08:43:28 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 5sm792952eyh.1.2009.10.19.08.43.27 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 19 Oct 2009 08:43:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255966929-1280-6-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130704>


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
1.6.5.15.g5f078
