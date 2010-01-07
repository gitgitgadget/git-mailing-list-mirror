From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 1/2] Rename the mail --refid and --noreply options to
	match Git
Date: Thu, 07 Jan 2010 16:09:32 +0000
Message-ID: <20100107160932.3226.95737.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 17:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSuvf-0007kr-Hn
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 17:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0AGQJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 11:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910Ab0AGQJi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 11:09:38 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:54425 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752823Ab0AGQJh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 11:09:37 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o07G9WeI016700;
	Thu, 7 Jan 2010 16:09:32 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 7 Jan 2010 16:09:32 +0000
User-Agent: StGit/0.15-33-g331e
X-OriginalArrivalTime: 07 Jan 2010 16:09:32.0702 (UTC) FILETIME=[CC8A63E0:01CA8FB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136351>

The new option names are --in-reply-to and --no-thread.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/mail.py |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 8ff0bd4..a78c9d2 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -56,7 +56,7 @@ specified file (defaulting to '.git/covermail.tmpl' or
 
 All the subsequent e-mails appear as replies to the first e-mail sent
 (either the preamble or the first patch). E-mails can be seen as
-replies to a different e-mail by using the '--refid' option.
+replies to a different e-mail by using the '--in-reply-to' option.
 
 SMTP authentication is also possible with '--smtp-user' and
 '--smtp-password' options, also available as configuration settings:
@@ -107,7 +107,7 @@ options = [
         short = 'Add BCC to the Bcc: list'),
     opt('--auto', action = 'store_true',
         short = 'Automatically cc the patch signers'),
-    opt('--noreply', action = 'store_true',
+    opt('--no-thread', action = 'store_true',
         short = 'Do not send subsequent messages as replies'),
     opt('--unrelated', action = 'store_true',
         short = 'Send patches without sequence numbering'),
@@ -127,7 +127,7 @@ options = [
         short = 'Edit each patch before sending'),
     opt('-s', '--sleep', type = 'int', metavar = 'SECONDS',
         short = 'Sleep for SECONDS between e-mails sending'),
-    opt('--refid',
+    opt('--in-reply-to', metavar = 'REFID',
         short = 'Use REFID as the reference id'),
     opt('--smtp-server', metavar = 'HOST[:PORT] or "/path/to/sendmail -t -i"',
         short = 'SMTP server or command to use for sending mail'),
@@ -495,7 +495,7 @@ def __build_cover(tmpl, msg_id, options, patches):
 
     if not options.git:
         __build_address_headers(msg, options)
-    __build_extra_headers(msg, msg_id, options.refid)
+    __build_extra_headers(msg, msg_id, options.in_reply_to)
     __encode_message(msg)
 
     return msg
@@ -638,11 +638,11 @@ def func(parser, options, args):
     if total_nr == 0:
         raise CmdException, 'No patches to send'
 
-    if options.refid:
-        if options.noreply or options.unrelated:
+    if options.in_reply_to:
+        if options.no_thread or options.unrelated:
             raise CmdException, \
-                  '--refid option not allowed with --noreply or --unrelated'
-        ref_id = options.refid
+                  '--in-reply-to option not allowed with --no-thread or --unrelated'
+        ref_id = options.in_reply_to
     else:
         ref_id = None
 
@@ -663,7 +663,7 @@ def func(parser, options, args):
         msg_id = __send_message('cover', tmpl, options, patches)
 
         # subsequent e-mails are seen as replies to the first one
-        if not options.noreply:
+        if not options.no_thread:
             ref_id = msg_id
 
     # send the patches
@@ -681,5 +681,5 @@ def func(parser, options, args):
         msg_id = __send_message('patch', tmpl, options, p, n, total_nr, ref_id)
 
         # subsequent e-mails are seen as replies to the first one
-        if not options.noreply and not options.unrelated and not ref_id:
+        if not options.no_thread and not options.unrelated and not ref_id:
             ref_id = msg_id
