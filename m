From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH 2/2] Allow core.askpass to override SSH_ASKPASS.
Date: Fri, 27 Aug 2010 12:51:21 +0200
Organization: science + computing ag
Message-ID: <201008271251.23136.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 13:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oowm0-0002Wo-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 13:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab0H0LGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 07:06:45 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:39571 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753328Ab0H0LDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 07:03:32 -0400
X-Greylist: delayed 728 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2010 07:03:31 EDT
Received: from mx4.science-computing.de (mx4.science-computing.de [193.197.16.30])
	by smtp1.belwue.de with ESMTP id o7RApOlW005792
	for <git@vger.kernel.org>; Fri, 27 Aug 2010 12:51:24 +0200 (MEST)
	env-from (prvs=84877ebac=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 7C54F414003;
	Fri, 27 Aug 2010 12:51:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2y7G3VE+DK0H; Fri, 27 Aug 2010 12:51:23 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id D1C6A414002;
	Fri, 27 Aug 2010 12:51:23 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id B1431AE358;
	Fri, 27 Aug 2010 12:51:23 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154592>

From: Knut Franke <k.franke@science-computing.de>

Modify handling of the 'core.askpass' option so that it has the same effect as
GIT_ASKPASS also if SSH_ASKPASS is set.

Signed-off-by: Knut Franke <k.franke@science-computing.de>
---
I'd say this precedence order is more intuitive; and more useful.

 connect.c |    4 ++++
 git.c     |    3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index e296bfc..f97b84c 100644
--- a/connect.c
+++ b/connect.c
@@ -627,9 +627,13 @@ char *git_getpass(const char *prompt)
 	static struct strbuf buffer = STRBUF_INIT;
 
 	askpass = getenv("GIT_ASKPASS");
+
 	if (!askpass)
 		askpass = askpass_program;
 
+	if (!askpass)
+		askpass = getenv("SSH_ASKPASS");
+
 	if (!askpass || !(*askpass))
 		return getpass(prompt);
 
diff --git a/git.c b/git.c
index 12d2952..1545257 100644
--- a/git.c
+++ b/git.c
@@ -55,9 +55,6 @@ static int handle_options(const char ***argv, int *argc, int 
*envchanged)
 {
 	int handled = 0;
 
-	if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
-		setenv("GIT_ASKPASS", getenv("SSH_ASKPASS"), 1);
-
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
 		if (cmd[0] != '-')
-- 
1.7.2.1


-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
