From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Print RUNTIME_PREFIX warning only when GIT_TRACE is set
Date: Tue, 23 Feb 2010 12:42:56 +0100
Message-ID: <4B83BF40.4070802@viscovery.net>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de> <4B83A330.5080403@viscovery.net> <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de> <4B83A9A2.5080500@viscovery.net> <alpine.DEB.1.00.1002231201260.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 12:43:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjtAW-00028v-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 12:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab0BWLnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 06:43:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52644 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751712Ab0BWLnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 06:43:05 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NjtAH-0006ba-Un; Tue, 23 Feb 2010 12:42:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D13B51660F;
	Tue, 23 Feb 2010 12:42:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.1002231201260.3980@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140788>

From: Johannes Sixt <j6t@kdbg.org>

When RUNTIME_PREFIX is enabled, the installation prefix is derived by
trying a limited set of known locations where the git executable can
reside. If none of these is found, a warning is emitted.

When git is built in a directory that matches neither of these known names,
the warning would always be emitted when the uninstalled executable is run.
This is a problem on Windows, where gitk picks the uninstalled git when
invoked from the build directory and gets confused by the warning.

Print the warning only when GIT_TRACE is set.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Johannes Schindelin schrieb:
> P.S.: I cannot recall defending the warning, but I might have thought it a 
> good idea at some stage. This is no longer so.

I do recall you defended it; good to know that you changed your mind.

Thanks,
-- Hannes

 exec_cmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 408e4e5..b2c07c7 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -28,7 +28,7 @@ const char *system_path(const char *path)
 	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
 	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
 		prefix = PREFIX;
-		fprintf(stderr, "RUNTIME_PREFIX requested, "
+		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
 	}
-- 
1.7.0.83.g241b9.dirty
