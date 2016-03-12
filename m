From: Senorsen <senorsen.zhang@gmail.com>
Subject: [PATCH] diff: handle "-" as abbreviation of '@{-1}'
Date: Sat, 12 Mar 2016 10:11:50 +0800
Message-ID: <1457748710-79370-1-git-send-email-senorsen.zhang@gmail.com>
Cc: Senorsen <senorsen.zhang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 12 03:16:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeZ6i-0005ud-Qb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 03:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbcCLCL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 21:11:59 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36552 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbcCLCL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 21:11:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id tt10so113198421pab.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 18:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kBg04Hc77sEPIEFaEWopkjPB/m5kdXdaZFlfDZZTnnA=;
        b=FbYvbtEX8Im+2xJVRtN1ju0rECpQ/mK0KJZKvoOCUBf1a2L46rq5d81GJ9RduOKLoJ
         zM++8cScHUFQXPgZsDOfYiT81yHSrMwxwNSTORcdOIQ3jHaL9zuWNOw6xqykLSTdOJtS
         2aJhQzEj7LSUGlachlEKugM5SZSaT+OWzblbdhLxlGQuNdB1QvKUN99gGSW4ay9PqmK5
         4dazj/HR7Hi0eo5ER+2+kYyoSNg5pyV1MjK/YWSl04ZGsUX3SUrZoGLSIfwvX3IoC7ln
         NJjQguFbZOwz1jJ+0tHR1MFrLeuNXn5Y8cRYsWN8CW0Hq+gMFUsduIEkQ+NSMMd5VxbA
         MrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kBg04Hc77sEPIEFaEWopkjPB/m5kdXdaZFlfDZZTnnA=;
        b=DPB3OKWQfYtraBvX/2gA5QqbeTF+Fwhf/U+6uLaKKdY/PT/YV6Xbv9y9shjQq+atWK
         2K6WMAmG30mb6q9Wxx82ijQOiqn0mKcWDjIofYD1Ixba8aHEc+xjMHX4dMFGyl0ZhcnO
         icFo3Mlc7J7uML4S2FrsthpSlllkH/SH55zygvWMId8X2FMWB6/u9/OcdnvRD1b+ScNT
         9HTIMe7LXxM4D6/aTkMaOqJAU0dT6BgPALrgdgn7gh9+FqIDA+0ntQHek062Hsm6bivV
         akZKbG+H5tAEf0ak+rkIYOT1h0mtxvRG8OM2WvDkJnSJnBsRfLWRCLPbh7T5xv3pAmzO
         vcKQ==
X-Gm-Message-State: AD7BkJJriFzMiMynmtFCaO3e/blfFgxcpszI15J6rq7U3+flt28qupsTEsKuOz0BXW+yVw==
X-Received: by 10.66.97.8 with SMTP id dw8mr20680464pab.28.1457748718243;
        Fri, 11 Mar 2016 18:11:58 -0800 (PST)
Received: from localhost.localdomain (fq2.senorsen.com. [45.55.9.226])
        by smtp.gmail.com with ESMTPSA id t76sm15804010pfi.7.2016.03.11.18.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Mar 2016 18:11:57 -0800 (PST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288724>

Currently it just replace "-" in argv[] into "@{-1}".

For example,

    git diff -

equals to

    git diff @{-1}

Signed-off-by: Senorsen <senorsen.zhang@gmail.com>
---
Notes:
    Hello everyone, I'm Zhang Sen, a college student from Zhejiang University 
    in China, and this is a patch for the microproject of GSoC 2016. I'm 
    looking forward to contributing to Git and participating in GSoC 2016.

    I have learnt some rules and guides from the documents, and carefully 
    wrote this small patch, according to other code from git.

    Thanks a lot!

 builtin/diff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..c110141 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -389,6 +389,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "-"))
+			argv[i] = "@{-1}";
+	}
+
 	for (i = 0; i < rev.pending.nr; i++) {
 		struct object_array_entry *entry = &rev.pending.objects[i];
 		struct object *obj = entry->item;
-- 
2.7.0
