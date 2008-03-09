From: Samuel Tardieu <sam@rfc1149.net>
Subject: Unclear error message in "git remote update"
Date: Sun, 09 Mar 2008 13:37:55 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-09-13-37-55+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 13:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYKnW-0007dy-FL
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 13:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYCIMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 08:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYCIMiA
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 08:38:00 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:32974 "EHLO
	mail2.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYCIMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 08:37:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id DB72BC408D;
	Sun,  9 Mar 2008 13:37:55 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Xan1i-Wl6yP; Sun,  9 Mar 2008 13:37:55 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id B105DC40B8; Sun,  9 Mar 2008 13:37:55 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76658>

One of my colleague seems to have destroyed one of its head in his
private repository. When fetching from it through "git remote update"
using next, the repository name is not output:

% git remote update
error: refs/heads/2.0-uobjects points nowhere!

Using master, I get:

% git remote update
Updating core
Updating matthieu
error: refs/heads/2.0-uobjects points nowhere!
Updating origin

which is IMO much clearer. Also, I like seeing what remote repository
it is updating from in case anything gets stuck or slow.

Any objection to reinstating the message as does the following patch?

From: Samuel Tardieu <sam@rfc1149.net>
Date: Sun, 9 Mar 2008 13:33:44 +0100
Subject: [PATCH] builtin remote update: print remote name being fetched from

Reinstate the message "Updating <name>" in git remote update.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 builtin-remote.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index ca3bf26..65d90e1 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -46,6 +46,7 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 static int fetch_remote(const char *name)
 {
 	const char *argv[] = { "fetch", name, NULL };
+	printf("Updating %s\n", name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
 		return error("Could not fetch %s", name);
 	return 0;
-- 
1.5.4.3.611.g29c00

