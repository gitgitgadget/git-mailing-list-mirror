From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix 'git help help'
Date: Thu, 21 Aug 2008 16:21:48 +0200
Message-ID: <1219328508-11561-1-git-send-email-vmiklos@frugalware.org>
References: <200808210451.12795.chriscool@tuxfamily.org>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWB3k-0002ix-E4
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759179AbYHUOVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbYHUOVT
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:21:19 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34968 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967AbYHUOVS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:21:18 -0400
Received: from vmobile.example.net (dsl5401C8B6.pool.t-online.hu [84.1.200.182])
	by yugo.frugalware.org (Postfix) with ESMTP id 0D8391DDC5B;
	Thu, 21 Aug 2008 16:21:16 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7ABDA93B4; Thu, 21 Aug 2008 16:21:48 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <200808210451.12795.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93154>

git help foo invokes man git-foo if foo is a git command, otherwise it
invokes man gitfoo. 'help' is not a git command, but the manual page is
called git-help, so add this special exception.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Aug 21, 2008 at 04:51:11AM +0200, Christian Couder <chriscool@tuxfamily.org> wrote:
> But unfortunately it seems that your patch hasn't been merged into
> master,
> so "git help help" is still broken there and in git 1.6.0.

Here is a patch for 'maint'.

 help.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index 3cb1962..dc0786d 100644
--- a/help.c
+++ b/help.c
@@ -555,7 +555,8 @@ static int is_git_command(const char *s)
 {
 	load_command_list();
 	return is_in_cmdlist(&main_cmds, s) ||
-		is_in_cmdlist(&other_cmds, s);
+		is_in_cmdlist(&other_cmds, s) ||
+		!strcmp(s, "help");
 }
 
 static const char *prepend(const char *prefix, const char *cmd)
-- 
1.6.0.rc3.17.gc14c8.dirty
