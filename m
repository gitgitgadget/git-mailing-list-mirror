From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] lockfile: show absolute filename in unable_to_lock_message.
Date: Thu,  7 Jan 2010 15:54:10 +0100
Message-ID: <1262876050-345-1-git-send-email-Matthieu.Moy@imag.fr>
References: <4B44DB6A.2050804@kdbg.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 07 15:54:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NStlH-0000Xe-9n
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 15:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab0AGOyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 09:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131Ab0AGOyn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 09:54:43 -0500
Received: from mx2.imag.fr ([129.88.30.17]:43737 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637Ab0AGOym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 09:54:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o07EsDWH030919
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jan 2010 15:54:13 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NStke-0004xw-GS; Thu, 07 Jan 2010 15:54:16 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NStke-000068-DA; Thu, 07 Jan 2010 15:54:16 +0100
X-Mailer: git-send-email 1.6.6.81.gda96d0
In-Reply-To: <4B44DB6A.2050804@kdbg.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jan 2010 15:54:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o07EsDWH030919
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1263480854.93385@d7Xs+fB5a+RgfBNc0Ot6ww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136346>

When calling a git command from a subdirectory and a file locking fails,
the user will get a path relative to the root of the worktree, which is
invalid from the place where the command is ran. Make it easy for the
user to know which file it is.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> Since these are merely informative, wouldn't it be more suitable to
> use make_nonrelative_path()?

Sensible, yes.

 lockfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 6851fa5..b0d74cd 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -164,9 +164,10 @@ static char *unable_to_lock_message(const char *path, int err)
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
-		    path, strerror(err));
+			    make_nonrelative_path(path), strerror(err));
 	} else
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
+			    make_nonrelative_path(path), strerror(err));
 	return strbuf_detach(&buf, NULL);
 }
 
-- 
1.6.6.81.gda96d0
