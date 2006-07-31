From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] pager: environment variable GIT_PAGER to override PAGER
Date: Mon, 31 Jul 2006 15:27:00 +0200
Message-ID: <E1G7XnQ-0002bA-Fm@moooo.ath.cx>
References: <E1G6wM1-00040z-Bu@moooo.ath.cx> <7v8xmabo37.fsf@assigned-by-dhcp.cox.net> <E1G7WfC-000728-9j@moooo.ath.cx> <Pine.LNX.4.63.0607311454040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 15:27:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Xnc-0002Nf-6o
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 15:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWGaN1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 09:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGaN1E
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 09:27:04 -0400
Received: from moooo.ath.cx ([85.116.203.178]:16356 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750783AbWGaN1D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 09:27:03 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607311454040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24522>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Mon, 31 Jul 2006, Matthias Lederhofer wrote:
> 
> > Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> 
> The commit message no longer reflects what the patch does ;-)
> 
> > -	const char *pager = getenv("PAGER");
> > +	char *pager;
> 
> You do not need to lose the "const" (it means that you cannot access the 
> memory it points to, but you can change the pointer). Also, you could make 
> a more minimal patch by replacing PAGER by GIT_PAGER here, instead of 
> having this extra line:
> 
> > +	pager = getenv("GIT_PAGER");
Thanks, I should be more careful when correcting a patch with
--amend.
---
 Documentation/git.txt |    3 +++
 pager.c               |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)

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
index 280f57f..dcb398d 100644
--- a/pager.c
+++ b/pager.c
@@ -15,11 +15,13 @@ void setup_pager(void)
 {
 	pid_t pid;
 	int fd[2];
-	const char *pager = getenv("PAGER");
+	const char *pager = getenv("GIT_PAGER");
 
 	if (!isatty(1))
 		return;
 	if (!pager)
+		pager = getenv("PAGER");
+	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
-- 
1.4.2.rc2.g91b7
