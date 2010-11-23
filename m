From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 1/6] msvc: opendir: fix malloc-failure
Date: Tue, 23 Nov 2010 19:38:24 +0100
Message-ID: <1290537509-360-2-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDMlLDnBBoE5blaZA@googlegroups.com Tue Nov 23 19:39:33 2010
Return-path: <msysgit+bncCOPdven-DxDMlLDnBBoE5blaZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDMlLDnBBoE5blaZA@googlegroups.com>)
	id 1PKxm8-0007Wc-Ea
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:32 +0100
Received: by mail-wy0-f186.google.com with SMTP id 11sf5201873wyi.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=CvIKeoaeRh1QJNFMEHWEju6OQeE2hEVU2owvVxFJ3Ps=;
        b=Gf+mmzIyv9PdVnWVigxyHQ/BcjYzDrXdizqq3Njx6rctFFxMu1bfJxF1EIXSDJpVkx
         6YXCGOH6XrATG/SljT6GLugff2VZNhUwQsOXOdbk7ehadaD7b7cBf/VB5Dyn6D7zJNjY
         mbBR7W5P+Sk02Wyj/1CugSaN7vWHx+r02hTEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=nOsz8XTpFjpin37R3UMASpSO7yrkxBMPab5h/deaPz+ahvqrfHu5xjvVlU9fy4LgtR
         CTgy8aGfMfVCXuh2EkoldQuXCdfCxxs6FhxrKpjObU+Z+fco/2+G09KUj4nlC6g0rsKV
         HDeWjC/qtTXvtqvdCbGwEh7uMrkIj/0a6MALc=
Received: by 10.217.4.79 with SMTP id t57mr800464wes.27.1290537548472;
        Tue, 23 Nov 2010 10:39:08 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.24.73 with SMTP id w49ls1426638eew.4.p; Tue, 23 Nov 2010
 10:39:07 -0800 (PST)
Received: by 10.14.127.201 with SMTP id d49mr1033236eei.25.1290537547735;
        Tue, 23 Nov 2010 10:39:07 -0800 (PST)
Received: by 10.14.127.201 with SMTP id d49mr1033235eei.25.1290537547701;
        Tue, 23 Nov 2010 10:39:07 -0800 (PST)
Received: from mail-ey0-f175.google.com (mail-ey0-f175.google.com [209.85.215.175])
        by gmr-mx.google.com with ESMTP id v14si2091852eeh.1.2010.11.23.10.39.06;
        Tue, 23 Nov 2010 10:39:06 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender) client-ip=209.85.215.175;
Received: by eya28 with SMTP id 28so4810884eya.34
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:06 -0800 (PST)
Received: by 10.213.26.15 with SMTP id b15mr4005334ebc.13.1290537546271;
        Tue, 23 Nov 2010 10:39:06 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm6069565eeh.14.2010.11.23.10.39.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:05 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162004>

Previsouly, the code checked for malloc-failure after it had accessed
the returned pointer. Move the check a bit earlier to avoid segfault.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index ac04a4c..d6096e4 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -7,16 +7,16 @@ DIR *opendir(const char *name)
 {
 	int len;
 	DIR *p;
-	p = (DIR*)malloc(sizeof(DIR));
+	p = malloc(sizeof(DIR));
+	if (!p)
+		return NULL;
+
 	memset(p, 0, sizeof(DIR));
 	strncpy(p->dd_name, name, PATH_MAX);
 	len = strlen(p->dd_name);
 	p->dd_name[len] = '/';
 	p->dd_name[len+1] = '*';
 
-	if (p == NULL)
-		return NULL;
-
 	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
 
 	if (p->dd_handle == -1) {
-- 
1.7.3.2.493.gc8738
