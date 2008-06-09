From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-remote: make reuse of code easier by not die()ing
Date: Mon, 9 Jun 2008 21:11:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092110020.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer>
 <484D6128.1010800@freesurf.fr> <alpine.DEB.1.00.0806091856180.1783@racer> <484D7860.6050301@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-418309434-1213042306=:1783"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:14:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nkV-0007KE-Lz
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbYFIUM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYFIUM6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:12:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:56038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753343AbYFIUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:12:58 -0400
Received: (qmail invoked by alias); 09 Jun 2008 20:12:55 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 09 Jun 2008 22:12:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/f9Q13kj7f8erT8Di2BWwRiLlquB5nW4yifPhLzV
	55xNDbsV+691sX
X-X-Sender: gene099@racer
In-Reply-To: <484D7860.6050301@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84417>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-418309434-1213042306=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


By mistake, this programmer used a die() call when an error() was much
more appropriate.  Code reuse was not possible, hence this fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 9 Jun 2008, Olivier Marin wrote:

	> Johannes Schindelin a écrit :
	> > 
	> > But did you not now make it harder to fix "that"?  By relying 
	> > on the die() behaviour in your regression fix?
	> 
	> If I change return path for some functions, I will have to check 
	> all the callers anyway. So, no I don't think it make things harder to 
	> fix. Also I don't like to add dead code.
	> 
	> Please, let me do this fix so that I can post my next patches. 
	> After that I will be happy to work on what you asked.

	Wow, that patch was hard ;-)

	BTW this thread shows -- again -- how hard it is to push toward 
	libification.  People seem to actively block it.

 builtin-remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 2641e20..9939c96 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -243,7 +243,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 
 	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
 		if (get_fetch_map(ref, states->remote->fetch + i, &tail, 1))
-			die("Could not get fetch map for refspec %s",
+			return error("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
 	states->new.strdup_paths = states->tracked.strdup_paths = 1;
-- 
1.5.6.rc1.181.gb439d

--8323329-418309434-1213042306=:1783--
