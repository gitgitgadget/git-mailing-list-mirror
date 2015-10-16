From: Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH] fetch: only show "Fetching remote" when verbose mode is enabled
Date: Fri, 16 Oct 2015 14:49:32 +0800
Message-ID: <1444978172-7317-1-git-send-email-pabs3@bonedaddy.net>
Cc: Paul Wise <pabs3@bonedaddy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 09:23:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmzMP-000643-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbbJPHXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:23:25 -0400
Received: from master.debian.org ([82.195.75.110]:36752 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbbJPHXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:23:22 -0400
X-Greylist: delayed 1888 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2015 03:23:22 EDT
Received: from localhost ([::1] helo=chianamo.localdomain)
	by master.debian.org with esmtp (Exim 4.84)
	(envelope-from <pabs3@bonedaddy.net>)
	id 1Zmyrm-0001Yy-NI; Fri, 16 Oct 2015 06:51:51 +0000
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279735>

By default when fetching one remote nothing is printed unless there
are changes that need fetching. This makes fetching multiple remotes
be just as verbose as fetching a single remote.

This is needed when fetching multiple repositories using the myrepos
tool in minimal output mode, where myrepos only prints the repository
names when git fetch prints some output. For example in the output below
the cgit and git-remote-* lines would be hidden if git fetch were
silent by default when fetching multiple remotes, since the default
for myrepos is to fetch all remotes for git repositories.

pabs@chianamo ~ $ mr -m fetch
mr fetch: /home/pabs/cgit
Fetching origin

mr fetch: /home/pabs/git
Fetching origin
From https://github.com/git/git
 - [tag update]      junio-gpg-pub -> junio-gpg-pub
Fetching hg
From https://github.com/SRabbelier/git
 - [tag update]      junio-gpg-pub -> junio-gpg-pub

mr fetch: /home/pabs/git-remote-bzr
Fetching origin

mr fetch: /home/pabs/git-remote-hg
Fetching origin

Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9a3869f..fc33667 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1067,7 +1067,7 @@ static int fetch_multiple(struct string_list *list)
 	for (i = 0; i < list->nr; i++) {
 		const char *name = list->items[i].string;
 		argv_array_push(&argv, name);
-		if (verbosity >= 0)
+		if (verbosity >= 1)
 			printf(_("Fetching %s\n"), name);
 		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 			error(_("Could not fetch %s"), name);
-- 
2.6.1
