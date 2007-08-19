From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 21:44:02 +0200
Message-ID: <vpq643bz4vx.fsf@bauges.imag.fr>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
	<7vodh3bbmx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMqhf-0000IG-4G
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 21:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbXHSToh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbXHSToh
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 15:44:37 -0400
Received: from imag.imag.fr ([129.88.30.1]:61371 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbXHSTog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 15:44:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7JJi3Xk010544
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 19 Aug 2007 21:44:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IMqgs-000071-Vu; Sun, 19 Aug 2007 21:44:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IMqgs-0002jv-Th; Sun, 19 Aug 2007 21:44:02 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <7vodh3bbmx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 19 Aug 2007 11\:52\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 19 Aug 2007 21:44:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56142>

Junio C Hamano <gitster@pobox.com> writes:

> Please resend an applyable patch with a sign-off (and acked-by
> as you have seen).

>From 2c79b9a1b446ca9fa9d72fc595120da34fd403dd Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sun, 19 Aug 2007 19:24:36 +0200
Subject: [PATCH] Add and document a global --no-pager option for git.

To keep the change small, this is done by setting GIT_PAGER to "cat".

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Brian Gernhardt <benji@silverinsanity.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git.txt |    6 +++++-
 git.c                 |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8017997..707a756 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,8 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate]
+'git' [--version] [--exec-path[=GIT_EXEC_PATH]] 
+    [-p|--paginate] [--no-pager]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
@@ -103,6 +104,9 @@ OPTIONS
 -p|--paginate::
        Pipe all output into 'less' (or if set, $PAGER).
 
+--no-pager::
+       Do not pipe git output into a pager.
+
 --git-dir=<path>::
        Set the path to the repository. This can also be controlled by
        setting the GIT_DIR environment variable.
diff --git a/git.c b/git.c
index cab0e72..f280e7d 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 const char git_usage_string[] =
-       "git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+       "git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND 
[ARGS]";                                                                                                                                                     
 
 static void prepend_to_path(const char *dir, int len)
 {
@@ -58,6 +58,10 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
                        }
                } else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
                        setup_pager();
+               } else if (!strcmp(cmd, "--no-pager")) {
+                       setenv("GIT_PAGER", "cat", 1);
+                       if (envchanged)
+                               *envchanged = 1;
                } else if (!strcmp(cmd, "--git-dir")) {
                        if (*argc < 2) {
                                fprintf(stderr, "No directory given for --git-dir.\n" );
-- 
1.5.3.rc0.64.gf4f4a-dirty



-- 
Matthieu
