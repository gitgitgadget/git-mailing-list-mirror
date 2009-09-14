From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 07/17] Fix __stdcall/WINAPI placement and function
 prototype
Date: Mon, 14 Sep 2009 15:11:20 +0200
Message-ID: <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:12:59 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMY-0004G0-7l
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:12:58 +0200
Received: by mail-vw0-f140.google.com with SMTP id 4so1239080vws.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=zqR6Mg185mvW77mYCmvCmbdxikdWzdiKsiKkv1WTJHc=;
        b=y0wliL/z/NP7rRNy2LWq84Qi/n4ujLZi4RTTfZXnTIaBGCi7ABcg7gu0wxg5exxZgk
         bSR7HNBuBXxMHgqtdsGNmEhNgm+cNQmxU/78RTRZJF520sXfsQs6w0qmmNIS8/KmHIIq
         0AHdH0e4tZddvGDjR1fe67UiaCkRVUdIxWls0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=vwX1QMdD1S6aQvsPfC63Nm/EXuim+/fqI3BzoPc7UKHEi+mF9MuYcIAZm250wYDaCX
         zW6O1BSVcRaLM+X/onzXOgC4TXNHaEGlwid6dns1zwbsPGlKIshCDiW2nkZckhKOf+iN
         Bv/unwI7UkFGpNRO4sjNkn+t3JKh/LMsG974E=
Received: by 10.150.168.4 with SMTP id q4mr1947573ybe.4.1252933971920;
        Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
Received: by 10.176.207.9 with SMTP id e9gr6965yqg.0;
	Mon, 14 Sep 2009 06:12:47 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.184.3 with SMTP id l3mr792661ebp.9.1252933966272; Mon, 14 Sep 2009 06:12:46 -0700 (PDT)
Received: by 10.211.184.3 with SMTP id l3mr792660ebp.9.1252933966240; Mon, 14 Sep 2009 06:12:46 -0700 (PDT)
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com [209.85.219.224]) by gmr-mx.google.com with ESMTP id 15si1278658ewy.0.2009.09.14.06.12.45; Mon, 14 Sep 2009 06:12:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.224 as permitted sender) client-ip=209.85.219.224;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.224 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f224.google.com with SMTP id 24so2244969ewy.22 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=tvccg2y+kyymvkWxIzjHcnTRxPe5H34QVjoGnI3RXxU=; b=Ejs+OxLUnLI5umj2Azz79+dririmTtrympZnrpmIm3zTub6VYeI8+/iioWfNEap5FF bClQ2ZNsmFirYYwdDdWS983I6JC6PEhvbh5hBQyCozkEcQYLOjBnC1vBONS9XKh8pwkU C7PAP0eVDXAHsenN6bZ+mg6SNLf/ybdYW0fsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=vm0TY4JHbENIBCBevQw6nLA7bkFG6bTXFdgr1meP0OeoFAk5BUwS7HiJRZDW99gP9E s/lXttYXTAQ+5R1I/feFbckiHHdhXh/qydsaPteZziXJI9yeUXxW+2/yEKv8l/bS/cRT nzqMz3viqiWj280XFlA5dxMsOHRXiwUhMtnrs=
Received: by 10.211.147.12 with SMTP id z12mr6897602ebn.37.1252933964860; Mon, 14 Sep 2009 06:12:44 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.42 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128463>


From: Frank Li <lznuaa@gmail.com>

WINAPI is a macro which translates into the proper calling convention, so
replace __stdcall with that.

MSVC requires WINAPI to be between the functions return value and the
function name, and that the function pointer type is in the form of
    return_type (WINAPI *function_name)(arguments...)

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    4 ++--
 run-command.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 12db9a6..90764eb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1029,7 +1029,7 @@ static sig_handler_t timer_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static __stdcall unsigned ticktack(void *dummy)
+static unsigned WINAPI ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		if (timer_fn == SIG_DFL)
@@ -1156,7 +1156,7 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index 02aaedf..91f6d2e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -316,7 +316,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef __MINGW32__
-static __stdcall unsigned run_thread(void *data)
+static unsigned WINAPI run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
-- 
1.6.2.1.418.g33d56.dirty
