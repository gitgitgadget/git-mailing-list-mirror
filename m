From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW
 and MSVC
Date: Thu, 17 Sep 2009 10:02:51 +0200
Message-ID: <1eeb32498237638df6d954dc65ab5372dd0f04c9.1253174364.git.mstormo@gmail.com>
References: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Sep 17 10:03:22 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f137.google.com ([209.85.211.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBxZ-0004hm-F7
	for gcvm-msysgit@m.gmane.org; Thu, 17 Sep 2009 10:03:21 +0200
Received: by mail-yw0-f137.google.com with SMTP id 1so480154ywh.24
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Sep 2009 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=jruHi6eoMBvarAmNdAX3DqCpGch0c26cTqbibl3TCdw=;
        b=s7RLNCfi0S+kY0rdNFad4KtoPBD4zl9hZREzJmn+AD9u3PHkP5we0FlO/xA7atkfPQ
         xRrckAYzhIrcAIjyUFXeY/hU+8n+VLef76TBnE99NkRuq6rqKQhhsH4+P9VoEBECLonD
         9b/gjkRxM8Tzitxp73Miv95hpvZ3LX3X3B3cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=e8X9xysZOmkK83z049MTFm0LHTJkrKPwVPhfOqesyYXnylYGd3WDunmeSIFt0z+Ejm
         JgbVomDYOFbPlBG5wlkfjOA3hxTZCTMZyKlojwtG7gitqrInjcI0HiddXfO+KBuHKXtk
         SdGAGHUC7V7Krk+HJOhUcZ26s1BiWKWg2x7m8=
Received: by 10.150.68.1 with SMTP id q1mr91842yba.1.1253174595223;
        Thu, 17 Sep 2009 01:03:15 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7063yqm.0;
	Thu, 17 Sep 2009 01:03:10 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.174.12 with SMTP id b12mr35329ebp.15.1253174589533; Thu, 17 Sep 2009 01:03:09 -0700 (PDT)
Received: by 10.211.174.12 with SMTP id b12mr35328ebp.15.1253174589511; Thu, 17 Sep 2009 01:03:09 -0700 (PDT)
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com [209.85.219.226]) by gmr-mx.google.com with ESMTP id 14si1901371ewy.1.2009.09.17.01.03.08; Thu, 17 Sep 2009 01:03:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.226 as permitted sender) client-ip=209.85.219.226;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.226 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f226.google.com with SMTP id 26so159578ewy.5 for <msysgit@googlegroups.com>; Thu, 17 Sep 2009 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=gW1xAeWsdl12lysZYlFiqzpdpagG4H/ckGMJWAgPqmA=; b=LgNQ31KDj4t7Lr6ELRPaE/optNX/lzvIYbmV6uPsDDJCUuPzX3TeMjVpFEbITMsQHz ztNhTb8NsEXff30Y+aqs7PAPm+sDv6jIydCUNZciitg9vzzwPQe24DKI7GrPmj4skCPB VUWtfZMXZ7AcD3QourHjh1qEqQ/4iTgBAspiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=gHFRLEGvoJrCHol7eh4Fvgzt5lcTVaYlxbpTrmHechkPspb3QlUp97R5hB7JQ2cQpN E2nZPxa3LiQnMJOIIIItAc/q1oGDoH5kxX8GBzqUNsKzjRH4un74hcOUEbKSKYH8v+al 0xDfVajnGLnwda8XWhQLQbOxuAlmUQ2NHljZ8=
Received: by 10.216.88.146 with SMTP id a18mr76553wef.56.1253174588377; Thu, 17 Sep 2009 01:03:08 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm4890304eyg.10.2009.09.17.01.03.05 (version=SSLv3 cipher=RC4-MD5); Thu, 17 Sep 2009 01:03:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128729>


MinGW set the _CRT_fmode to set both the default fmode and
_O_BINARY on stdin/stdout/stderr. Rather use the main()
define in mingw.h to set this for both MinGW and MSVC.

This will ensure that a MinGW and MSVC build will handle
input and output identically.

Alexey Borzenkov:
Include git-compat-util.h from the test-genrandom.c so
that the application also will use the main() define,
and thus the stdout mode is set correctly and generated
data stays the same.

Johannes Sixt:
Before, since the test-genrandom application would link
against libgit.a, the MinGW process initialization code
would pick up the definition of _CRT_fmode from mingw.c
that is initialized to _O_BINARY. After this patch,
however, the _CRT_fmode symbol is no longer present in
libgit.a, so MinGWs process initialization code will not
set the correct std(in|out|err) mode. So, the include is
needed to override main() and explicitly set the mode.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c   |    2 --
 compat/mingw.h   |    5 +++++
 test-genrandom.c |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5478b74..5a8fae8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,8 +3,6 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-unsigned int _CRT_fmode = _O_BINARY;
-
 static int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
diff --git a/compat/mingw.h b/compat/mingw.h
index c43917c..bcd23b0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -227,12 +227,17 @@ void free_environ(char **env);
 
 /*
  * A replacement of main() that ensures that argv[0] has a path
+ * and that default fmode and std(in|out|err) are in binary mode
  */
 
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	_fmode = _O_BINARY; \
+	_setmode(_fileno(stdin), _O_BINARY); \
+	_setmode(_fileno(stdout), _O_BINARY); \
+	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
diff --git a/test-genrandom.c b/test-genrandom.c
index 8ad276d..5849599 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include "git-compat-util.h"
 
 int main(int argc, char *argv[])
 {
-- 
1.6.2.1.418.g33d56.dirty
