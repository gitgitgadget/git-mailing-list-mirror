From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] pager: config variable pager.program
Date: Mon, 31 Jul 2006 14:14:26 +0200
Message-ID: <E1G7WfC-000728-9j@moooo.ath.cx>
References: <E1G6wM1-00040z-Bu@moooo.ath.cx> <7v8xmabo37.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 14:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7WfI-0006vb-2Y
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 14:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWGaMO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 08:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWGaMO3
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 08:14:29 -0400
Received: from moooo.ath.cx ([85.116.203.178]:11654 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750912AbWGaMO2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 08:14:28 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8xmabo37.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24517>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Junio C Hamano <junkio@cox.net> wrote:
> I am not enthused about any configuration stored in .git/config
> to override the environment variables.  Files are to store
> reasonable default, and command line flags and environments are
> to override them, but this patch does it the other way around.
You're right, this patch uses $GIT_PAGER.  I don't think pager.program
does make much sense with this (expect someone does not want to export
$PAGER/$GIT_PAGER), should it be introduced anyway (I don't need
it)?
---
 Documentation/git.txt |    3 +++
 pager.c               |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7310a2b..d243883 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -627,6 +627,9 @@ git Diffs
 
 other
 ~~~~~
+'GIT_PAGER'::
+	This environment variable overrides `$PAGER`.
+
 'GIT_TRACE'::
 	If this variable is set git will print `trace:` messages on
 	stderr telling about alias expansion, built-in command
diff --git a/pager.c b/pager.c
index 280f57f..ab9be5d 100644
--- a/pager.c
+++ b/pager.c
@@ -15,10 +15,13 @@ void setup_pager(void)
 {
 	pid_t pid;
 	int fd[2];
-	const char *pager = getenv("PAGER");
+	char *pager;
 
 	if (!isatty(1))
 		return;
+	pager = getenv("GIT_PAGER");
+	if (!pager)
+		pager = getenv("PAGER");
 	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
-- 
1.4.2.rc2.g91b7
