From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] make-static: master
Date: Wed, 14 Sep 2011 08:50:10 +0200
Message-ID: <4E704EA2.8060307@viscovery.net>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk> <7vhb4in4j7.fsf@alter.siamese.dyndns.org> <4E6FDE71.9050606@ramsay1.demon.co.uk> <7v62kwvwe9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 08:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3jIf-00061A-Dh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 08:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab1INGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 02:50:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63198 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab1INGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 02:50:17 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R3jIQ-0006Fa-LP; Wed, 14 Sep 2011 08:50:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5DEAC1660F;
	Wed, 14 Sep 2011 08:50:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <7v62kwvwe9.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181339>

Am 9/14/2011 1:46, schrieb Junio C Hamano:
> This kind of breakage report was exactly what I was looking for by
> merging it early to 'next'. Hopefully no other (function / platform) combo
> has such dependencies...

There is! prepare_git_cmd is used from the Windows section in run-command.c.
Therefore, the following hunks of the patch should be reverted.

diff --git a/exec_cmd.c b/exec_cmd.c
index 171e841..1dddbf4 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -113,7 +113,7 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
-const char **prepare_git_cmd(const char **argv)
+static const char **prepare_git_cmd(const char **argv)
 {
 	int argc;
 	const char **nargv;
diff --git a/exec_cmd.h b/exec_cmd.h
index e2b546b..f5d2cdd 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -5,7 +5,6 @@ extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
-extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);
