From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 05/12] Place __stdcall between return value and function name
Date: Wed, 19 Aug 2009 23:52:40 +0800
Message-ID: <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnV3-0002JE-Kc
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbZHSPxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZHSPxt
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:53:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:42065 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbZHSPxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:53:48 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1310962rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sj8LonXy+KTvHmpeHmxuLRM7NQhdaQZ1kVqqgqkKvKQ=;
        b=nt17Y7eh8AfE5pE68TfmaH8d99IMr85ZAFOqEL8X2/AvSWeqqIoYLTEqRx9CwTkZVY
         YlGIkoC+pZkzrkyIPXS4/Sb8X7Folx7lur0tt5jz6R57Rb+Qbw74EqS93tMN/bcJhREJ
         8xZYkMnBTZm8ctEYDpklVuYJHkTdPo0XSvIsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tuCBUo3HhhIKYSy8rs5jt3R0TrP68t/nNXM133YHwm0hbKygbwssS0tjNlo2C36oRA
         cqj5mwfIfEGcFfXXOKQ6CCjjzAOBpyENtHccVZCqE9pWprOq0vZcfWEAFeqjRQvSaSu+
         9T8VIpnrDPQTkMdYxofLVGCMS4jJlAuCuNK18=
Received: by 10.141.41.16 with SMTP id t16mr3799701rvj.258.1250697230689;
        Wed, 19 Aug 2009 08:53:50 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id c20sm1283666rvf.11.2009.08.19.08.53.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:53:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126554>

MSVC require __stdcall is between return value and function name.
ALL Win32 API definition is as TYPE WINAPI function name

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/mingw.c |    4 ++--
 run-command.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d5fa0ed..c938f0a 100644
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
+	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index d0833f8..62bea19 100644
--- a/run-command.c
+++ b/run-command.c
@@ -295,7 +295,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef WIN32
-static __stdcall unsigned run_thread(void *data)
+static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
-- 
1.6.4.msysgit.0
