From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: --exec-path not always honored
Date: Wed, 18 Mar 2009 08:42:53 +0100
Message-ID: <49C0A5FD.70004@viscovery.net>
References: <49BF692B.9020002@viscovery.net> <7v7i2nmlpt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjqRz-0000tG-Jk
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbZCRHnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbZCRHnB
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:43:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54808 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbZCRHnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:43:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjqQP-0001lD-EP; Wed, 18 Mar 2009 08:42:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2DBBF69F; Wed, 18 Mar 2009 08:42:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v7i2nmlpt.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113595>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> git-gc is a builtin. Should git setenv("GIT_EXEC_PATH") before it runs
>> other git commands?
> 
> I think we just never have bothered about such a use case, but you are
> right.  It probably is a good solution, although setenv makes me feel a
> bit nervous for no rational reason.

This patch fixes the use case and is IMO the most logical solution.

diff --git a/exec_cmd.c b/exec_cmd.c
index 217c125..408e4e5 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -61,6 +61,10 @@ const char *git_extract_argv0_path(const char *argv0)
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path = exec_path;
+	/*
+	 * Propagate this setting to external programs.
+	 */
+	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
