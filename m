From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 13:22:33 +0200
Message-ID: <20080623112233.GB7485@elte.hu>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu> <20080623095732.GL22569@linux.vnet.ibm.com> <20080623102424.GA28192@elte.hu> <20080623111144.GP22569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 13:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAk9D-0000D1-1U
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 13:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYFWLWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 07:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYFWLWv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 07:22:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38469 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbYFWLWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 07:22:51 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KAk84-00020U-QP
	from <mingo@elte.hu>; Mon, 23 Jun 2008 13:22:42 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E903C3E21DD; Mon, 23 Jun 2008 13:22:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623111144.GP22569@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85853>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > That would be expected behavior, yes. You can try a "test-pull" into 
> > core/rcu:
> > 
> >   git-checkout -b test-rcu tip/core/rcu
> >   git-merge paulmck-rcu-2008-06-23   # replace with git-pull and an URI
> > 
> > ... and then look at how "git-log test-rcu..linus/master" looks like. It 
> > should show all the changes of the RCU topic, your two new commits 
> > included.
> 
> The git-merge seemed to run normally, but the git-log command showed
> no output.  Hmmm...

sorry, i accidentally reversed the arguments, that should have been:

  git-shortlog linus/master..test-rcu
  git-log linus/master..test-rcu

the way such things can be noticed is to replace git-log with git-diff:

   git-diff test-rcu..linus/master

and if that does not come empty (and it didnt), it's an ordering 
problem.

> >  $ git-describe 481c5346d0981940ee63037eb53e4e37b0735c10
> >  v2.6.26-rc7-25-g481c534
> 
> So this shows the last linus/master commit -not- containing the patch, 
> correct?  Ah, the most recent -tag-.  So I have to be a bit careful 
> about creating tags if I want this to work for me.  Fair enough!

you most definitely need to be careful about creating tags. Tags have 
extra security value (Linus signs them, etc.) and Git will not override 
an existing tag by default in any case. So you definitely dont want to 
create a tag that collides with any expected future upstream tag. (such 
as "v2.6.26" or "2.6.26-rc8")

tags are mostly meant for release management - our use of tags to save 
the "merge base" of topic branches in -tip can be considered mild abuse. 

( But we did not want to pullute the already crowded branch space with 
  extra technical branches. -tip has 127 branches at this moment, 89 of 
  which are topic branches - creating a base branch for each topic would 
  add another 89 branches and bring it all up to 216 branches. )

	Ingo
