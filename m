From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] git wrapper: Make while loop more reader-friendly
Date: Mon, 25 Aug 2008 22:51:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net>  <7vfxoukv56.fsf@gitster.siamese.dyndns.org>  <20080824203825.GB14930@eagain.net>  <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>  <20080824222534.GC14930@eagain.net>  <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
  <48B29B2A.6000802@gnu.org>  <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com> <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, Tommi Virtanen <tv@eagain.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXiyJ-0008OM-PD
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbYHYUqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYHYUqY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:46:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:36822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751598AbYHYUqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:46:24 -0400
Received: (qmail invoked by alias); 25 Aug 2008 20:46:22 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 25 Aug 2008 22:46:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195Dbh2Fad5VZr9OtFGp+MBrGCSGEsMcPSP2f0Z3p
	qloryuRWxW9Ehu
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93673>


It is not a good practice to prefer performance over readability in
something as performance uncritical as finding the trailing slash
of argv[0].

So avoid head-scratching by making the loop user-readable, and not
hyper-performance-optimized.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The original version threatened to cause eye-cancer with this
	developer, so that I had to run to the physician real quick.
	That was quite hard, as no ophtalmologist seemed to be in
	office at 10:30pm.  But I found a real good witch, and she
	diagnozed me as healthy.

 git.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index a647741..2fd74c4 100644
--- a/git.c
+++ b/git.c
@@ -427,9 +427,8 @@ int main(int argc, const char **argv)
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
 	 */
-	do
-		--slash;
-	while (cmd <= slash && !is_dir_sep(*slash));
+	while (cmd <= slash && !is_dir_sep(*slash))
+		slash--;
 	if (slash < cmd) {
 		cmd = lookup_program_in_path(cmd);
 		for (slash = (char *)cmd + strlen(cmd) - 1;
-- 
1.6.0.211.ga840e.dirty
