From: Ingo Molnar <mingo@elte.hu>
Subject: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 11:36:48 +0200
Message-ID: <20110608093648.GA19038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 11:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUFCS-00043b-3d
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 11:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab1FHJhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 05:37:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46808 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510Ab1FHJhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 05:37:04 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QUFBz-0000J5-BE
	from <mingo@elte.hu>; Wed, 08 Jun 2011 11:36:56 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 9D51C3E2539; Wed,  8 Jun 2011 11:36:45 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175345>


This might be a FAQ, but i couldn't find an elegant Git-ish answer 
for it, so please bear with my stupid question :-)

In an upstream Linux kernel Git repo, with linux-next as a remote 
present (but -git checked out), what is the way to find out when a 
particular commit was merged upstream?

So for example when was 189d3c4a94 merged upstream?

The proper Git answer would be:

  $ git describe --contains 189d3c4a94
  next-20080501~97

But the next-20080501 tag is useless, and i don't have linux-next as 
HEAD, it's only a remote.

Right now i have this imperfect hack instead:

  $ git log --pretty=oneline 189d3c4a94.. Makefile | tail -5

Which gives this answer:

  $ git log --pretty=oneline 189d3c4a94.. Makefile | tail -5
  b8291ad07a7f3b5b990900f0001198ac23ba893e Linux 2.6.26-rc3
  492c2e476eac010962850006c49df326919b284c Linux 2.6.26-rc2
  a95bcfac2b5f353f99c6a338d77eb5584ab35d83 kbuild: escape meta characters in regular expression in make TAGS
  2ddcca36c8bcfa251724fe342c8327451988be0d Linux 2.6.26-rc1
  90ebd878a5900839106664fae40a6cc83dbe86ab kbuild: fix vmlinux.o link

So i can see that this commit went upstream in the .26 merge window 
and was released in .26-rc1 for the first time.

This (ab)-uses the fact that the toplevel Makefile gets edited for 
every release by Linus, and it does not have many other changes.

But ... it would be much nicer if i could make 'git describe 
--contains' work better.

Any ideas?

Thanks,

	Ingo
