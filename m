From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] setup: clarify error messages for file/revisions ambiguity
Date: Fri,  3 Aug 2012 10:21:20 +0200
Message-ID: <1343982080-15054-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 03 10:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxD8d-0002IN-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 10:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab2HCIVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 04:21:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44654 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab2HCIVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 04:21:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q738Itnv025772
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Aug 2012 10:18:55 +0200
Received: from fema.imag.fr ([129.88.43.130])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SxD8M-0006HT-Ur; Fri, 03 Aug 2012 10:21:22 +0200
Received: from moy by fema.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SxD8M-0003vR-Sc; Fri, 03 Aug 2012 10:21:22 +0200
X-Mailer: git-send-email 1.7.12.rc0.32.g9fb4847.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Aug 2012 10:18:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q738Itnv025772
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1344586739.685@22gAIEwXsvmlqWxD8ut7Og
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202818>

The previous "Use '--' to separate filenames from revisions" may sound
obvious for an old-time Unix user, but does not make it clear how to use
this '--'. In addition to mentionning this '--', give an idea of what the
new command should look like.

Ideally, we could provide cut-and-paste ready commands based on the
command that just failed, but we have no easy access to argv[] in this
place of the code.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 setup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 9139bee..3a1b2fd 100644
--- a/setup.c
+++ b/setup.c
@@ -79,7 +79,7 @@ static void NORETURN die_verify_filename(const char *prefix,
 {
 	if (!diagnose_misspelt_rev)
 		die("%s: no such path in the working tree.\n"
-		    "Use '-- <path>...' to specify paths that do not exist locally.",
+		    "Use 'git <command> -- <path>...' to specify paths that do not exist locally.",
 		    arg);
 	/*
 	 * Saying "'(icase)foo' does not exist in the index" when the
@@ -92,7 +92,8 @@ static void NORETURN die_verify_filename(const char *prefix,
 
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-	    "Use '--' to separate paths from revisions", arg);
+	    "Use '--' to separate paths from revisions, like this:\n"
+	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 
 }
 
@@ -141,7 +142,8 @@ void verify_non_filename(const char *prefix, const char *arg)
 	if (!check_filename(prefix, arg))
 		return;
 	die("ambiguous argument '%s': both revision and filename\n"
-	    "Use '--' to separate filenames from revisions", arg);
+	    "Use '--' to separate paths from revisions, like this:\n"
+	    "'git <command> [<revision>...] -- [<file>...]'", arg);
 }
 
 /*
-- 
1.7.12.rc0.32.g9fb4847.dirty
