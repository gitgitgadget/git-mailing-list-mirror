From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 02:57:32 -0700
Message-ID: <20080623095732.GL22569@linux.vnet.ibm.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com> <20080623071441.GA28887@elte.hu>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 11:58:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAiop-0000mZ-78
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 11:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYFWJ5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 05:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbYFWJ5n
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 05:57:43 -0400
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:34635 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYFWJ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 05:57:42 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5N9vPlK025372
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:57:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5N9vabt273730
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:57:36 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5N9vZjl016352
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:57:36 +1000
Received: from paulmck-laptop.localdomain (wecm-9-67-149-169.wecm.ibm.com [9.67.149.169])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5N9vYDP016294;
	Mon, 23 Jun 2008 19:57:34 +1000
Received: by paulmck-laptop.localdomain (Postfix, from userid 1000)
	id E0AC613E9DA; Mon, 23 Jun 2008 02:57:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080623071441.GA28887@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85849>

On Mon, Jun 23, 2008 at 09:14:41AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Trying "git-checkout -b tip-core-rcu 
> > tip-core-rcu-2008-06-16_09.23_Mon" acts like it is doing something 
> > useful, but doesn't find the recent updates, which I believe happened 
> > -before- June 16 2008.
> 
> finding the rcu topic branch in -tip can be done the following way:
> 
>  $ git-branch -a | grep rcu
>    tip/core/rcu

Ah!!!  Good, that does show me this branch.  I created a new branch
"paulmck-rcu-2008-06-23" just out of paranoia.

> and doing a "git-log tip/core/rcu..linus/master" will show you the 
> commits that are in the tip/core/rcu topic branch.
> 
> if you check out that branch for your own use, you should also do:
> 
>  $ git-merge linus/master
> 
> To bring it up to latest upstream.

OK, that did pull in a number of changes.  The gitk tool then shows my
"Merge commit 'linus/master' into paulmck-rcu-2008-06-23" at the head
of the display, with parents as follows:

Parent: 31a72bce0bd6f3e0114009288bccbc96376eeeca (rcu: make rcutorture more vicious: reinstate boot-time testing)
Parent: bec95aab8c056ab490fe7fa54da822938562443d (Merge branch 'release' of git://lm-sensors.org/kernel/mhoffman/hwmon-2.6)

This means that the RCU-related changes show up discontinuously in
the gitk display, but clicking on the left-most connector and selecting
"parent" gets me to the rest of the tip/core/rcu branch, so should be OK,
I guess.  ;-)

I then applied my two patches from yesterday (EDT timezone), just for
practice.

These show up after the merge.

But now when I do "git-log tip/core/rcu..linus/master", I get one very
large pile of patches.  It apparently includes the stuff I merged from
linus/master.  This is expected behavior, correct?

So, if I want to identify the RCU patches since some specific Linus
release (for example, 2.6.26-rc7), I follow the RCU parents down until
I find the desired release tag, then generate diffs from the ranges I
find, right?

Hmmm, actually, no, this bypasses the v2.6.26-rcN tags.

One approach is apparently to use gitk to create a view that includes
the patches touching the RCU-related files.  The git-log command
also takes pathname arguments, so that allows me to get an approximation
as well.

I will have to look more at git-log and gitk -- probably I should be
paying more attention to patches adding or deleting the strings
"RCU" or "rcu" to the kernel.  ;-)

Is there some way to determine whether a give patch has a tagged
patch (e.g., v2.6.26-rc7) as a child?  It would be very cool to
be able to dump only those patches that are not part of v2.6.26-rc7,
as this would allow me to automatically generate the list of
RCU-related patches from linux-2.6-tip to test against this RC.

>                                    That merge, even if tip/core/rcu 
> looks "old" will always be conflict-free, due to scripting we do:
> 
> tip-core-rcu-2008-06-16_09.23_Mon is not a snapshot of the rcu topic - 
> it is "technical" tag of the upstream Linus -git tree against which the 
> rcu topic is based.
> 
> We have to track the 'base' of every topic separately because otherwise 
> we'd pollute the topic branches with the frequent merges to Linus's 
> tree. (occasionally we merge to Linus's tree several times a day, that 
> would lead to tons of merge commits that pollute the tree)
> 
> So instead we do "on-demand virtual merges": we have scripting which do 
> the following: in each iteration step they merge to latest Linus, check 
> whether there's any files touched by the merge that are changed by the 
> topic branch too - if yes then the merge is made permanent and the "this 
> is this topic's latest upstream" tag is updated. If the merge was 
> conflict-free, we roll back the merge.

Sounds like also tracking patches/transformations as first-class objects
would be a good research project.  ;-)

							Thanx, Paul

> Is there a Git way of finding the common ancestor of a topic branch, 
> when compared to upstream?
> 
> 	Ingo
