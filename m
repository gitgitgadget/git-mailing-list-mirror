From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-x86-tip: pilot error?
Date: Mon, 23 Jun 2008 09:14:41 +0200
Message-ID: <20080623071441.GA28887@elte.hu>
References: <20080622123620.GA9328@linux.vnet.ibm.com> <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com> <20080622132105.GD22569@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 09:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAgHR-0005nP-I6
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 09:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbYFWHPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 03:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYFWHPF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 03:15:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35376 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbYFWHPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 03:15:03 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KAgGF-0002qq-7L
	from <mingo@elte.hu>; Mon, 23 Jun 2008 09:14:55 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E00B63E21DD; Mon, 23 Jun 2008 09:14:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080622132105.GD22569@linux.vnet.ibm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85841>


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Trying "git-checkout -b tip-core-rcu 
> tip-core-rcu-2008-06-16_09.23_Mon" acts like it is doing something 
> useful, but doesn't find the recent updates, which I believe happened 
> -before- June 16 2008.

finding the rcu topic branch in -tip can be done the following way:

 $ git-branch -a | grep rcu
   tip/core/rcu

and doing a "git-log tip/core/rcu..linus/master" will show you the 
commits that are in the tip/core/rcu topic branch.

if you check out that branch for your own use, you should also do:

 $ git-merge linus/master

To bring it up to latest upstream. That merge, even if tip/core/rcu 
looks "old" will always be conflict-free, due to scripting we do:

tip-core-rcu-2008-06-16_09.23_Mon is not a snapshot of the rcu topic - 
it is "technical" tag of the upstream Linus -git tree against which the 
rcu topic is based.

We have to track the 'base' of every topic separately because otherwise 
we'd pollute the topic branches with the frequent merges to Linus's 
tree. (occasionally we merge to Linus's tree several times a day, that 
would lead to tons of merge commits that pollute the tree)

So instead we do "on-demand virtual merges": we have scripting which do 
the following: in each iteration step they merge to latest Linus, check 
whether there's any files touched by the merge that are changed by the 
topic branch too - if yes then the merge is made permanent and the "this 
is this topic's latest upstream" tag is updated. If the merge was 
conflict-free, we roll back the merge.

Is there a Git way of finding the common ancestor of a topic branch, 
when compared to upstream?

	Ingo
