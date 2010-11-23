From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 18:30:39 +0100
Message-ID: <1290533444-3404-2-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiL-0003bQ-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab0KWRbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0KWRbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:21 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BoJxrNwmyqtRF6sHwSkoVIVLIP6Tp6ldBf1u8o3LgVM=;
        b=AcdyokKM3OeDEh+b8Hq0XmVtlWFzBW/oeHna6WkrxACuUWP9taf4C18FaMwJ8kr5iD
         tzZL+2iOaFUbYHjIRF/LPnnw0aIXYryR6Iq2e1YA/JLNbymEqXdJrOqL664NhxfmmP9n
         Dqm4LerGWf9zrSukm+hvpdXSdyu9ScPkL7B7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z72I5QL7Rl876r6rGLG9sjzStwwcICfR0kuHp2B8ZdkJubb6+mSKUavrovD7PAq2cS
         xv9ilYFr33EykJ/BFO23jygtQN/6ntpU8T/Y0DqWoGhLFKJA1Yb8CJ/S5uw+BcHFgPME
         mfr0vZmIm056qvp5R5DGAZD+ylaIIxaUOTO/Q=
Received: by 10.213.105.197 with SMTP id u5mr1974602ebo.36.1290533480804;
        Tue, 23 Nov 2010 09:31:20 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v51sm6012831eeh.22.2010.11.23.09.31.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:20 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161985>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index ac04a4c..db3df51 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -7,16 +7,13 @@ DIR *opendir(const char *name)
 {
 	int len;
 	DIR *p;
-	p = (DIR*)malloc(sizeof(DIR));
+	p = xmalloc(sizeof(DIR));
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
1.7.3.2.493.ge4bf7
