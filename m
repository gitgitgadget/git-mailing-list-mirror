From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] format-patch: support really old non-range syntax, with a
 warning
Date: Tue, 27 Jun 2006 01:14:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270113360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
 <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk673h62w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 01:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv0KK-0002jQ-Kv
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933249AbWFZXP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933245AbWFZXPH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:15:07 -0400
Received: from mail.gmx.net ([213.165.64.21]:1180 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933248AbWFZXPB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 19:15:01 -0400
Received: (qmail invoked by alias); 26 Jun 2006 23:15:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 27 Jun 2006 01:15:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk673h62w.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22693>


Now you can say (again)

	git format-patch <theirs> <mine>

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---


	Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some 
	adhocery

	On Mon, 26 Jun 2006, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> >> > Could you test with "origin..master" instead of "origin master"?
	> >> 
	> >> Funny you mention that! Now it works ;-) and it even produces the
	> >> patches I would expect.
	> >
	> > The funny thing is: I did something to account for the old syntax, but 
	> > only if you specified _one_ ref, not _two_. It would be easy, but is it 
	> > needed? (I.e. are your fingers so trained on it?)
	> 
	> If possible I'd rather correct the two syntaxes once and for all now.
	> Maybe accept two with a warning for deprecation?

	Here you are. (Tested once -- works great!)

 builtin-log.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 44d2d13..64b2830 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -260,6 +260,11 @@ int cmd_format_patch(int argc, const cha
 	if (rev.pending.nr == 1) {
 		rev.pending.objects[0].item->flags |= UNINTERESTING;
 		add_head(&rev);
+	} else if (rev.pending.nr == 2
+			&& !(rev.pending.objects[0].item->flags & UNINTERESTING)
+			&& !(rev.pending.objects[1].item->flags & UNINTERESTING)) {
+		rev.pending.objects[0].item->flags |= UNINTERESTING;
+		fprintf(stderr, "WARNING: obsolete syntax (no range)!\n");
 	}
 
 	if (!use_stdout)
