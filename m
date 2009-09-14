From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 06/17] mingw.c: Use the O_BINARY flag to open files
Date: Mon, 14 Sep 2009 15:11:19 +0200
Message-ID: <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:02 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMb-0004Dd-BY
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:01 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so3476534qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=eI15ImytClcwdFTKh29SBj5pll3+R42vzX3j8eZSAiY=;
        b=AMaVWKG0AbigNnw614/JNgblC4nZyfD1ZPZv854C5w7tYEjOFiaqZz4dBnkncO4b5c
         vRD3igWVDFvXOq6gBnl5QMjq2y0Wgp9SSkhtdLOR8NYKIKy1tXiPY6Qi0YeQEnIwPhpS
         he/8/PvH4ABru/utASxxZ6J3+/o3pYfDa7zIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=n7mG58XBKZSogzw49vr2yRHpaFKtXuDnlRpk1WSwPsIQ6CnXtYTCT0zEO5G62x/YDU
         G1ypQ7LrUl5sgHP2sanSxvdkClmJD/HqtwD11kFO377CRwqmSoyIKZU4ueOSXG4vvHms
         Z0oQskDE1LFIXYrfSJ4KO2jf4Dc7siMz2rfIM=
Received: by 10.229.111.101 with SMTP id r37mr506206qcp.14.1252933974922;
        Mon, 14 Sep 2009 06:12:54 -0700 (PDT)
Received: by 10.176.168.4 with SMTP id q4gr6964yqe.0;
	Mon, 14 Sep 2009 06:12:44 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.21 with SMTP id 21mr509203ebf.9.1252933963883; Mon, 14 Sep 2009 06:12:43 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr509202ebf.9.1252933963856; Mon, 14 Sep 2009 06:12:43 -0700 (PDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146]) by gmr-mx.google.com with ESMTP id 13si1275036ewy.6.2009.09.14.06.12.42; Mon, 14 Sep 2009 06:12:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.146 as permitted sender) client-ip=74.125.78.146;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.146 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-1920.google.com with SMTP id 5so656016eyb.0 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=JcJfbWSq17hmz43tnRt70TmEwxEn8E4aqTUGkK4pVz8=; b=Yk8/3ZCSVGBLAIVbNJiZ1usvK/qUkvJcUxL3I603Cr91bqyyCXl+pA7XX0sCcMDqR4 zhaUSfipWbRpnyzF8wbFQL6oZr4m4XA0r8YjkWkB4pQ64OCGEGv26JoEQRV6wdKCXQpn +TyZahsJzthQtyvLCWJY3c+vv/lRM7a1GF2B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=gGdzayoZUwmSoWj+/6d5SLu0+sT/mZOUryQ63BKHcnyi2JPMWMxkU10jjrTmitmYZo W0GAXY+jSW/9LT8MpCn5srK1jpODjSdejdsjqvV0fAG1PWHHnQwg4CC7SNg5IwZ8RfRx 2hGksy0AXkcJJBC3XqAQg4vaho3PgsC6yYxcc=
Received: by 10.210.9.7 with SMTP id 7mr6894174ebi.5.1252933962735; Mon, 14 Sep 2009 06:12:42 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.38 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128464>


From: Frank Li <lznuaa@gmail.com>

On Windows, binary files must be opened using the O_BINARY flag for
untranslated mode. MinGW does this for us automatically, but Microsoft
Visual C++ does not.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5478b74..12db9a6 100644
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
1.6.2.1.418.g33d56.dirty
