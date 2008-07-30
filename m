From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-help: always load_command_list() in cmd_help()
Date: Thu, 31 Jul 2008 00:38:07 +0200
Message-ID: <1217457487-6509-1-git-send-email-vmiklos@frugalware.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKK1-0005DK-8T
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbYG3Whl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYG3Whl
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:37:41 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37156 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYG3Whj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:37:39 -0400
Received: from vmobile.example.net (dsl5401CE3D.pool.t-online.hu [84.1.206.61])
	by yugo.frugalware.org (Postfix) with ESMTP id 4DD121DDC5B;
	Thu, 31 Jul 2008 00:37:37 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 73FCD1AA738; Thu, 31 Jul 2008 00:38:08 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90866>

When cmd_help() is called, we always need the list of main and other
commands, not just when the list of all commands is shown. Before this
patch 'git help diff' invoked 'man gitdiff' because cmd_to_page()
thought 'diff' is not a git command.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jul 30, 2008 at 01:52:26PM -0700, Kevin Ballard <kevin@sb.org> wrote:
> `git help diff` no longer finds the git-diff manpage (as of tip of
> next branch). I haven't tested, but I suspect
> 940208a771066229bc6a486f6a058e332b71cfe4 is responsible.

This fixed the issue for me.

Thanks!

 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index 88c0d5b..968f368 100644
--- a/help.c
+++ b/help.c
@@ -690,6 +690,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
 	const char *alias;
+	unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
 
 	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
@@ -698,7 +699,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 
 	if (show_all) {
-		unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
 		printf("usage: %s\n\n", git_usage_string);
 		list_commands("git commands", longest, &main_cmds, &other_cmds);
 		printf("%s\n", git_more_info_string);
-- 
1.6.0.rc0.14.g95f8.dirty
