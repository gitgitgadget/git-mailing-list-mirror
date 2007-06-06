From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: use $(($i+1)) instead of $((i+1))
Date: Wed, 6 Jun 2007 16:24:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061620540.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org>
 <Pine.LNX.4.64.0706030147520.4046@racer.site> <20070605101845.GA16160@diku.dk>
 <7vzm3ebsnk.fsf@assigned-by-dhcp.cox.net> <20070605103421.GB16160@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Jun 06 17:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvxP3-0000my-8l
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 17:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168AbXFFP0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 11:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762516AbXFFP0U
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 11:26:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:48198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760168AbXFFP0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 11:26:19 -0400
Received: (qmail invoked by alias); 06 Jun 2007 15:26:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 06 Jun 2007 17:26:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1829hBijA82BjgldvaCB3cpytrsMH6JR/7s6c1N0T
	dD+CQ0r6z6UrF4
X-X-Sender: gene099@racer.site
In-Reply-To: <20070605103421.GB16160@diku.dk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49293>


The expression $((i+1)) is not portable at all: even some bash versions
do not grok it. So do not use it.

Noticed by Jonas Fonseca.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 5 Jun 2007, Jonas Fonseca wrote:
	
	> Junio C Hamano <gitster@pobox.com> wrote Tue, Jun 05, 2007:
	> > Jonas Fonseca <fonseca@diku.dk> writes:
	> > 
	> > > $ git filter-branch H2
	> > > /home/fonseca/bin/git-filter-branch: 386: arith: syntax error: "i+1"
	> > > $
	> > >
	> > > A possible fix that makes the test pass for me.
	> >
	> > [...]
	> >
	> > The portable ones we already have in the code say things like:
	> > 
	> > 	msgnum=$(($msgnum+1))
	> 
	> Yes, I should have investigated before sending.
	> 
	> > The one in filter-branch that bit you does not dereference 'i'.
	> > I am reasonably sure if you fix it to read:
	> > 
	> > 	i=$(( $i+1 ))
	> > 
	> > dash would grok it.
	> 
	> This works here. Even without the spaces.

	Voila.

 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 6807782..f89cfe1 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -334,7 +334,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 i=0
 while read commit; do
-	i=$((i+1))
+	i=$(($i+1))
 	printf "$commit ($i/$commits) "
 
 	git-read-tree -i -m $commit
-- 
1.5.2.1.2656.g1921f
