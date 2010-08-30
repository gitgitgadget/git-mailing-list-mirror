From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCHv2 2/3] Allow core.askpass to override SSH_ASKPASS.
Date: Mon, 30 Aug 2010 15:39:38 +0200
Organization: science + computing ag
Message-ID: <201008301539.40165.k.franke@science-computing.de>
References: <201008301536.20414.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:39:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4aW-0007Us-Gg
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0H3Njn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:39:43 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:47060 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732Ab0H3Njn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 09:39:43 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp2.belwue.de with ESMTP id o7UDdfjl013269
	for <git@vger.kernel.org>; Mon, 30 Aug 2010 15:39:41 +0200 (MEST)
	env-from (prvs=851ee50e4=k.franke@science-computing.de)
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id 51FE4414004;
	Mon, 30 Aug 2010 15:39:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtrY+DQrsEqq; Mon, 30 Aug 2010 15:39:40 +0200 (CEST)
Received: from sirmione.science-computing.de (sirmione.science-computing.de [10.10.24.2])
	by scmail.science-computing.de (Postfix) with ESMTP id B3AB1414002;
	Mon, 30 Aug 2010 15:39:40 +0200 (CEST)
Received: from sirmione.localnet (localhost [127.0.0.1])
	by sirmione.science-computing.de (Postfix) with ESMTP id A5AA9AE3C9;
	Mon, 30 Aug 2010 15:39:40 +0200 (CEST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.29-0.1-pae; KDE/4.1.3; i686; ; )
In-Reply-To: <201008301536.20414.k.franke@science-computing.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154799>

Modify handling of the 'core.askpass' option so that it has the same effect as
GIT_ASKPASS also if SSH_ASKPASS is set.

Signed-off-by: Knut Franke <k.franke@science-computing.de>
---
 connect.c |    3 ++-
 git.c     |    3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index e296bfc..3450cab 100644
--- a/connect.c
+++ b/connect.c
@@ -629,7 +629,8 @@ char *git_getpass(const char *prompt)
 	askpass = getenv("GIT_ASKPASS");
 	if (!askpass)
 		askpass = askpass_program;
-
+	if (!askpass)
+		askpass = getenv("SSH_ASKPASS");
 	if (!askpass || !(*askpass))
 		return getpass(prompt);
 
diff --git a/git.c b/git.c
index 12d2952..1545257 100644
--- a/git.c
+++ b/git.c
@@ -55,9 +55,6 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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
