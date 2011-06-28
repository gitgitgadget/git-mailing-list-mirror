From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rebase: do not print lots of usage hints after an obvious
 error message
Date: Tue, 28 Jun 2011 14:46:14 +0200
Message-ID: <4E09CD16.2040800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 28 14:58:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbXsE-0007T1-R9
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 14:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757749Ab1F1Mrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 08:47:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4784 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441Ab1F1MqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 08:46:19 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QbXgF-00040f-Bu; Tue, 28 Jun 2011 14:46:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1CE831660F;
	Tue, 28 Jun 2011 14:46:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176398>

From: Johannes Sixt <j6t@kdbg.org>

When a non-existent branch was specified to be rebased, the complete
usage information is printed after the error message that carries the
relevant piece of information:

   $ git rebase master topci
   fatal: no such branch: topci
   usage: git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
      or: git rebase [-i] [options] --onto <newbase> --root [<branch>]
      or: git-rebase [-i] --continue | --abort | --skip

   Available options are
   [30 lines of usage stripped]

The error message was introduced recently by 4ac5356c (rebase: give a
better error message for bogus branch, 2011-01-27), and the result was
acceptable because the usage text was just two lines. But 45e2acf3
(rebase: define options in OPTIONS_SPEC, 2011-02-28) made things worse
because the usage text is now 35 lines.

Just drop the usage information because it does not add value to the
error message.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Note: git-sh-setup's die() does not print "fatal: ".

 git-rebase.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..4761f28 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -441,8 +441,7 @@ case "$#" in
 	then
 		head_name="detached HEAD"
 	else
-		echo >&2 "fatal: no such branch: $1"
-		usage
+		die "fatal: no such branch: $1"
 	fi
 	;;
 *)
-- 
1.7.6.86.gdfda2
