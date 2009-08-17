From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 08/11] Place __stdcall to correct position.
Date: Tue, 18 Aug 2009 00:04:59 +0800
Message-ID: <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4ip-0005VS-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbZHQQF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbZHQQF7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:05:59 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:56368 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbZHQQF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:05:58 -0400
Received: by pzk34 with SMTP id 34so1978859pzk.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QTvjOU8pQNkk9JK9FFvaZOaw2GZJ3zE4MI0GC/Gtgsc=;
        b=OLXxxj/VuY2ZeyRNFzIldyL0TwX+2Weh6rtaHGf6ViE5CImf3BXUdWL+a0SY98Nq7C
         1Gk1sC6XhcTVFB4O/y3QhdDXFUxD4LhShrqezHPi/Ag1wAFDgvd8q07+kdFF1nHXl524
         W58XsOsNdXjzubEf3bZ/nIaQDRj8nNfbXh2Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xBrOlGEbNWOtCjiyJb/vDAIG6vryk6CDDjqqxi8eRSwM5TaJYXJBv0KJW34b+j/fik
         29lN61M+ObL0x9XdPemZl9wv7+Bd64t5yD1MbRwZwSV86LOC4ohnbj2Lu8Y3jdyxbkSr
         0iBfzHuzvTU05pJjjKNw5sUQ2tQdSsBccL14I=
Received: by 10.115.100.33 with SMTP id c33mr4984126wam.72.1250525159527;
        Mon, 17 Aug 2009 09:05:59 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id k21sm10694757waf.59.2009.08.17.09.05.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:05:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126209>

MSVC require __stdcall is between return value and function name.
ALL Win32 API definition is as TYPE WINAPI function name

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |    4 ++--
 run-command.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d5fa0ed..0c9c793 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1017,7 +1017,7 @@ static sig_handler_t timer_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static __stdcall unsigned ticktack(void *dummy)
+static unsigned __stdcall ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		if (timer_fn == SIG_DFL)
@@ -1146,7 +1146,7 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef  BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index df139da..423b506 100644
--- a/run-command.c
+++ b/run-command.c
@@ -295,12 +295,12 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #if defined(__MINGW32__) || defined(_MSC_VER)
-static __stdcall unsigned run_thread(void *data)
+static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
 }
-#endif
+#endif /* __MINGW32__ || _MSC_VER */
 
 int start_async(struct async *async)
 {
-- 
1.6.4.msysgit.0
