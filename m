From: Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH] fetch: only show "Fetching remote" when verbose mode is enabled
Date: Sun, 25 Oct 2015 10:49:44 +0800
Message-ID: <1445741384-30828-1-git-send-email-pabs3@bonedaddy.net>
Cc: Paul Wise <pabs3@bonedaddy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 03:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqBOF-0008Me-2E
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 03:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbbJYCt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 22:49:56 -0400
Received: from master.debian.org ([82.195.75.110]:33498 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbJYCt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 22:49:56 -0400
Received: from localhost ([::1] helo=chianamo.localdomain)
	by master.debian.org with esmtp (Exim 4.84)
	(envelope-from <pabs3@bonedaddy.net>)
	id 1ZqBNX-0001Va-VU; Sun, 25 Oct 2015 02:49:52 +0000
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280137>

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
