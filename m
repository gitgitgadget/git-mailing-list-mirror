From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 12:24:24 +0200
Message-ID: <20080623102424.GA28192@elte.hu>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu> <20080623095732.GL22569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 12:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAjEy-0000XJ-V5
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 12:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYFWKYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 06:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbYFWKYn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 06:24:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59008 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbYFWKYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 06:24:41 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KAjDo-00040h-T8
	from <mingo@elte.hu>; Mon, 23 Jun 2008 12:24:35 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id CC0C53E21DD; Mon, 23 Jun 2008 12:24:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623095732.GL22569@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85851>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> On Mon, Jun 23, 2008 at 09:14:41AM +0200, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > Trying "git-checkout -b tip-core-rcu 
> > > tip-core-rcu-2008-06-16_09.23_Mon" acts like it is doing something 
> > > useful, but doesn't find the recent updates, which I believe happened 
> > > -before- June 16 2008.
> > 
> > finding the rcu topic branch in -tip can be done the following way:
> > 
> >  $ git-branch -a | grep rcu
> >    tip/core/rcu
> 
> Ah!!!  Good, that does show me this branch.  I created a new branch
> "paulmck-rcu-2008-06-23" just out of paranoia.

that's OK - having more branches never hurts.

if, while juggling branches, you lose some commit somewhere it makes 
sense to check .git/logs/. [ Up until the point Git does a 
garbage-collection run and zaps any orphaned commits ;-) ]

> > if you check out that branch for your own use, you should also do:
> > 
> >  $ git-merge linus/master
> > 
> > To bring it up to latest upstream.
> 
> OK, that did pull in a number of changes.  The gitk tool then shows my 
> "Merge commit 'linus/master' into paulmck-rcu-2008-06-23" at the head 
> of the display, with parents as follows:
> 
> Parent: 31a72bce0bd6f3e0114009288bccbc96376eeeca (rcu: make rcutorture more vicious: reinstate boot-time testing)
> Parent: bec95aab8c056ab490fe7fa54da822938562443d (Merge branch 'release' of git://lm-sensors.org/kernel/mhoffman/hwmon-2.6)
> 
> This means that the RCU-related changes show up discontinuously in the 
> gitk display, but clicking on the left-most connector and selecting 
> "parent" gets me to the rest of the tip/core/rcu branch, so should be 
> OK, I guess.  ;-)

i have just talked to Thomas about it and we'll change our scripting so 
that the tip/core/rcu branch will always be very recent and merged up to 
latest -git.

As one of the goals of the tip/* structure is to distribute topics to 
others (or as Linus has put it, Thomas and me needs to become more 
managerial about maintenance ;), there's real value in having the topics 
appear up-to-date when people try them out.

( it's possible to do this without criss-cross merge commits - it just
  needs some more creative scripting in -tip. )

> I then applied my two patches from yesterday (EDT timezone), just for 
> practice.
> 
> These show up after the merge.
> 
> But now when I do "git-log tip/core/rcu..linus/master", I get one very 
> large pile of patches.  It apparently includes the stuff I merged from 
> linus/master.  This is expected behavior, correct?

That would be expected behavior, yes. You can try a "test-pull" into 
core/rcu:

  git-checkout -b test-rcu tip/core/rcu
  git-merge paulmck-rcu-2008-06-23   # replace with git-pull and an URI

... and then look at how "git-log test-rcu..linus/master" looks like. It 
should show all the changes of the RCU topic, your two new commits 
included.

> So, if I want to identify the RCU patches since some specific Linus 
> release (for example, 2.6.26-rc7), I follow the RCU parents down until 
> I find the desired release tag, then generate diffs from the ranges I 
> find, right?
> 
> Hmmm, actually, no, this bypasses the v2.6.26-rcN tags.
> 
> One approach is apparently to use gitk to create a view that includes 
> the patches touching the RCU-related files.  The git-log command also 
> takes pathname arguments, so that allows me to get an approximation as 
> well.
> 
> I will have to look more at git-log and gitk -- probably I should be 
> paying more attention to patches adding or deleting the strings "RCU" 
> or "rcu" to the kernel.  ;-)

You can use the filenames as a commit filter, for example:

   git-shortlog v2.6.25.. kernel/rcu* include/linux/rcu*

Will give you a rather good view about what things changed in RCU land 
in v2.6.26 so far.

To see what is queued up in -tip for v2.6.27 that affect RCU, you can 
do:

   git-shortlog linus/master..tip/master kernel/rcu* include/linux/rcu*

This will show tip/core/rcu changes. Not unsurprisingly this will show 
something quite similar to:

   git-shortlog linus/master..tip/core/rcu

... as all RCU patches are supposed to be in that topic branch. [ But it 
does not hurt to double check me on that :-) ]

The widest search that doesnt involve the checking of around 100,000 
commits is the tip-log-line utility you can find in the tip/tip branch. 
Via that utility you can filter out all interesting RCU commits:

   tip-log-line kernel/rcu* include/linux/rcu*

it will output a tidy list of branches, sha1's and subject lines.

(you'll probably first need to run tip-create-local-branches.sh to 
create local branches out of all the tip topics.)

for example, to see RCU affecting changes not queued up in tip/core/rcu, 
you can do:

 ~/tip> tip-log-line kernel/rcu* include/linux/rcu* | grep -v ' core/rcu:'
 # core/softirq: 962cf36: Remove argument from open_softirq which is always NULL
 # core/softirq: a60b33c: Merge branch 'linus' into core/softirq
 # cpus4096: 363ab6f: core: use performance variant for_each_cpu_mask_nr

> Is there some way to determine whether a give patch has a tagged patch 
> (e.g., v2.6.26-rc7) as a child?  It would be very cool to be able to 
> dump only those patches that are not part of v2.6.26-rc7, as this 
> would allow me to automatically generate the list of RCU-related 
> patches from linux-2.6-tip to test against this RC.

if i understood you correctly, git-describe will do that for you 
normally. If you have an sha1 you can do:

 $ git-describe 481c5346d0981940ee63037eb53e4e37b0735c10
 v2.6.26-rc7-25-g481c534

	Ingo
