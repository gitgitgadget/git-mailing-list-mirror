From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 07/14] Fix __stdcall/WINAPI placement and function prototype
Date: Fri, 21 Aug 2009 15:30:39 +0200
Message-ID: <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Fri Aug 21 15:31:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeUDB-0000V9-NI
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 15:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZHUNbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 09:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbZHUNbN
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 09:31:13 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45095 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbZHUNbL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 09:31:11 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so637069ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=pXlVZu/lYud2kW3xBOUFrbTd+TKNvwv6RIbHhuxV4bU=;
        b=bt0Mho/UCM5GrchdQwt5eSSrNCAwFQ4KViJHlDoy/2CNEAvjKdLShVKfz3xIB2kms2
         j29EYmRjC6j0GPG39F05gDmHeGvEgeYTTvH0wU10O7E75sYhKz++Jfl9tvuSdoKGIQPC
         3MUorFVF82tmzV3jlLT4uIfd5vR6hbBZ3szW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VQ1xhgfiOM/ERviJXXDGjTy5j1Zs6s7+EsrcYg+NwoOsSxncHBDv+m71XC2l/1QB4q
         ifZFDdxMHYK1MMRguylTjEUgD1xUw9rS6SSVAiTioL7Q1wKZczM2TON5Ki6mmc5WvkcA
         tWu7kcc61XK88dOwPA11R/MoALaIekvJi9cW8=
Received: by 10.210.12.13 with SMTP id 13mr1527092ebl.12.1250861472190;
        Fri, 21 Aug 2009 06:31:12 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm4251897eyd.24.2009.08.21.06.31.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 06:31:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
In-Reply-To: <cover.1250860247.git.mstormo@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126710>

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
index 836426c..9716528 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1017,7 +1017,7 @@ static sig_handler_t timer_fn = SIG_DFL;
  * length to call the signal handler.
  */
 
-static __stdcall unsigned ticktack(void *dummy)
+static unsigned WINAPI ticktack(void *dummy)
 {
 	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
 		if (timer_fn == SIG_DFL)
@@ -1144,7 +1144,7 @@ void mingw_open_html(const char *unixpath)
 
 int link(const char *oldpath, const char *newpath)
 {
-	typedef BOOL WINAPI (*T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
+	typedef BOOL (WINAPI *T)(const char*, const char*, LPSECURITY_ATTRIBUTES);
 	static T create_hard_link = NULL;
 	if (!create_hard_link) {
 		create_hard_link = (T) GetProcAddress(
diff --git a/run-command.c b/run-command.c
index efac7ad..98232e9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -319,7 +319,7 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 }
 
 #ifdef __MINGW32__
-static __stdcall unsigned run_thread(void *data)
+static unsigned WINAPI run_thread(void *data)
 {
 	struct async *async = data;
 	return async->proc(async->fd_for_proc, async->data);
-- 
1.6.3.msysgit.0.18.gef407
