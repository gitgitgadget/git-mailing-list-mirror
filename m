Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC55209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032816AbdEZDfQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:16 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34134 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969442AbdEZDfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so43044629pfk.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXPZOf0EjiqmbjzkgGPQ5kD+BEkx+FOEUg7ALvIpnCQ=;
        b=Tz4i+dYPSGlFZKjduJT84upHk94kQ4C2MjE/qPGZ2CHkQvWlyRdnZT1LnhgPS0oANa
         lzeOE7YZSAozPii96DaAAnEjE2AnkPRIMlh5/2/x+jYaua/qcXh2Az4Phsdw1jFMrMT7
         fFolxW2P52fvaZsHWyKBmdACO9czv2t6lHNqsMNk5PUw71ZSGRS9vkW65ixmZZ80anRR
         DWy3/yYMLQEsWkubY/IiTmcPET4xni1qCbu+dYmLxCYslhBcO3FKS8841MNNJyDG1uUh
         +r/zqwI8BQFnLmtEUVmfpfE9YpPW9gfntmbfrkDUHvX54/3mNF5sxdd1OaMXVemKLuyy
         qzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jXPZOf0EjiqmbjzkgGPQ5kD+BEkx+FOEUg7ALvIpnCQ=;
        b=DJzuCOVdUUbMdo+rhBOJdFVAoc5vzl4aBCBDyqlCa9nPZ+r+WsebDaSjEKDiqittjd
         Stbq6/d0GEYQSXOIaZ2jLgswjV2UtPyhogCisgz4qMRN7O9lv8DefpYctgH/pS49DUMq
         zWTLrJ8YEf2g8fpDWfKQTUuqLTAJCRzJQp68xmUyzZYCKXoWBmACdp0oxIKbcTNV5znU
         zblmmEztDdaaNffd7/mO5bbZgLIMa8waswMNu7zzwvI0kegG9NRgCyeVEbfum65Q/yL2
         WV2c4gSBp5VH8vKBurcgtNomCHdMTUKaXOrA+g4oV34vjzyP9+POs/ImgEmApckKgpxR
         agaA==
X-Gm-Message-State: AODbwcCgl1fwje0GEpTjifFADMNHvI2tYTWLOkvY8J2nqaGLm4Tvb/rR
        yYei5fpOPi8HGg==
X-Received: by 10.99.112.29 with SMTP id l29mr50516080pgc.111.1495769713126;
        Thu, 25 May 2017 20:35:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id e124sm16155909pfc.64.2017.05.25.20.35.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 01/13] git_fopen: fix a sparse 'not declared' warning
Date:   Fri, 26 May 2017 12:34:58 +0900
Message-Id: <20170526033510.1793-2-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ramsay Jones <ramsay@ramsayjones.plus.com>

If git is built with the FREAD_READS_DIRECTORIES build variable set, this
would cause sparse to issue a 'not declared, should it be static?' warning
on Linux. This is a result of the method employed by 'compat/fopen.c' to
suppress the (possible) redefinition of the (system) fopen macro, which
also removes the extern declaration of the git_fopen function.

In order to suppress the warning, introduce a new macro to suppress the
definition (or possibly the re-definition) of the fopen symbol as a macro
override. This new macro (SUPPRESS_FOPEN_REDEFINITION) is only defined in
'compat/fopen.c', just prior to the inclusion of the 'git-compat-util.h'
header file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/fopen.c    |  4 ++--
 git-compat-util.h | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/compat/fopen.c b/compat/fopen.c
index b5ca142fed..107b3e8182 100644
--- a/compat/fopen.c
+++ b/compat/fopen.c
@@ -1,14 +1,14 @@
 /*
  *  The order of the following two lines is important.
  *
- *  FREAD_READS_DIRECTORIES is undefined before including git-compat-util.h
+ *  SUPPRESS_FOPEN_REDEFINITION is defined before including git-compat-util.h
  *  to avoid the redefinition of fopen within git-compat-util.h. This is
  *  necessary since fopen is a macro on some platforms which may be set
  *  based on compiler options. For example, on AIX fopen is set to fopen64
  *  when _LARGE_FILES is defined. The previous technique of merely undefining
  *  fopen after including git-compat-util.h is inadequate in this case.
  */
-#undef FREAD_READS_DIRECTORIES
+#define SUPPRESS_FOPEN_REDEFINITION
 #include "../git-compat-util.h"
 
 FILE *git_fopen(const char *path, const char *mode)
diff --git a/git-compat-util.h b/git-compat-util.h
index bd04564a69..6be55cf8b3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -689,10 +689,12 @@ char *gitstrdup(const char *s);
 #endif
 
 #ifdef FREAD_READS_DIRECTORIES
-#ifdef fopen
-#undef fopen
-#endif
-#define fopen(a,b) git_fopen(a,b)
+# if !defined(SUPPRESS_FOPEN_REDEFINITION)
+#  ifdef fopen
+#   undef fopen
+#  endif
+#  define fopen(a,b) git_fopen(a,b)
+# endif
 extern FILE *git_fopen(const char*, const char*);
 #endif
 
-- 
2.13.0-491-g71cfeddc25

