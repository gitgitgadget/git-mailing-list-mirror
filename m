From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 05/15] Fix __stdcall placement and function
 prototype
Date: Wed, 16 Sep 2009 10:20:21 +0200
Message-ID: <eec2b652c5a8e3e21348a8211d336fce66cb21a5.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com> <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f140.google.com ([209.85.212.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplM-0004pS-Ie
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:16 +0200
Received: by vws4 with SMTP id 4so3156651vws.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=WrwuKmPM0rl9QYi9OriQckBYxNiiG6OTIElfyxMK0TY=;
        b=UY4r7TXP0Gum2BM5PIeIc95Cx6mh5SUtjRq6Fo1CJSFVXcMOKUi3vzkcaMxHJ5SiwT
         Hr+HVngK62Non923cVK4GQzIOcUCLkmn8D6LNfjQGLFADREMLSsUR76gJzYQFYuDuzBu
         sHCJPVGRJNSGBaw3gJTBg5TdcsH6sZlMwSXFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=c5Sgag67SZlg0firtiXetLVv2+C94UEaXeQtpUbCJ6sqN4AF10y3wJer/5BvWXf5S0
         uXC7XHB8ouBHlbDEyHME9nnS/7F+vkC31rSRQjqpES3S+DqF7B40Z/NjNH0v3RWyZ/N8
         lZOKQ1dRoo1CfU+C6Tf9j/Uj6I9mixXLMPRT0=
Received: by 10.150.68.1 with SMTP id q1mr337700yba.1.1253089269852;
        Wed, 16 Sep 2009 01:21:09 -0700 (PDT)
Received: by 10.176.151.15 with SMTP id y15gr7040yqd.0;
	Wed, 16 Sep 2009 01:20:58 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.33 with SMTP id j33mr265983ebn.0.1253089257804; Wed, 16 Sep 2009 01:20:57 -0700 (PDT)
Received: by 10.211.132.33 with SMTP id j33mr265982ebn.0.1253089257772; Wed, 16 Sep 2009 01:20:57 -0700 (PDT)
Received: from mail-ew0-f207.google.com (mail-ew0-f207.google.com [209.85.219.207]) by gmr-mx.google.com with ESMTP id 14si1703115ewy.1.2009.09.16.01.20.56; Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.207 as permitted sender) client-ip=209.85.219.207;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.207 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f207.google.com with SMTP id 3so5024659ewy.42 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=d1U/nbPQGutCNl8YSVd1zhEpZPBISbpR8tZoqjGLCIg=; b=S1w++wbUR8ZDmXoxMqW8TA4Q7clDNZwV/xRGiKiN2Y5Fp+ego+FTWJ6Y4LKfJlRNrg Iv19O7b0T676yaiDq44U47D0+ESl8XVoQufxBkM4NNrCHaYFTUZ8NW16XOzPggs7EAzw EDUpbNUL5mwGPEsDKB4/4UXgYPfZqgcX8i85U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=TsnNYqtxSfjxoydDS7KHojjaLTPn1KdVpoSoy1WkpdWVmGINSTIBv0S59l4XmKVcDe MePWQ0N9siQT6FUoRbxyN+P0Xv9iblmFWvXFoEawLuRr/4FBYnNU6PmIhtCXhDsaS8fF Q2D6BBlaNpiJznYdl4OejOLhq7wVrzAsnBXtg=
Received: by 10.210.9.12 with SMTP id 12mr9700786ebi.3.1253089256504; Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.55 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128620>


From: Frank Li <lznuaa@gmail.com>

MSVC requires __stdcall to be between the functions return value and
the function name, and that the function pointer type is in the form
of
    return_type (WINAPI *function_name)(arguments...)

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    4 ++--
 run-command.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5a8fae8..34ee427 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1027,7 +1027,7 @@ static sig_handler_t timer_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static __stdcall unsigned ticktack(void *dummy)
+static unsigned __stdcall ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		if (timer_fn == SIG_DFL)
@@ -1154,7 +1154,7 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index 02aaedf..bb76750 100644
--- a/run-command.c
+++ b/run-command.c
@@ -316,7 +316,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef __MINGW32__
-static __stdcall unsigned run_thread(void *data)
+static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
-- 
1.6.2.1.418.g33d56.dirty
