From: Ingo Molnar <mingo@elte.hu>
Subject: "git revert" feature suggestion: revert the last commit to a file
Date: Thu, 5 Feb 2009 21:21:04 +0100
Message-ID: <20090205202104.GA11267@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 21:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAkE-0006FI-CQ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840AbZBEUVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755484AbZBEUVP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:21:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46817 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbZBEUVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:21:15 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LVAif-0006v8-Pm
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Thu, 05 Feb 2009 21:21:12 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B56573E21B0; Thu,  5 Feb 2009 21:21:05 +0100 (CET)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108607>


I frequently come across this workflow pattern: i queue up some new change 
in a topic brach, and there's a test failure within the next 60 minutes or 
so. I know which file causes the breakage - say kernel/softlockup.c - but i 
dont know the precise commit ID. I want to revert the change in the 
integration branch as quickly as possible via a command - without having to 
wade through 'git log' info and cut&paste-ing commit IDs.

I usually know the topic branch name where the breakage originates from, so 
i can do this in the integration branch:

   git revert core/softlockup

and it does the right thing and the tests can continue while i take more 
time in the topic branch to repair the damage there. (at which point i can 
integrate the fixed/updated commit on top of the reverted commit in the 
integration branch.)

But often i have other changes queued up in that topic branch as well - and 
the best, most finegrained information i have about the identity of the 
commit is the filename it went into.

So i have to do something like:

   git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)

(tucked away in a tip-revert-file helper script.)

But it would be so much nicer if i could do the intuitive:

   git revert kernel/softlockup.c

Or at least, to separate it from revision names cleanly, something like:

   git revert -- kernel/softlockup.c

Would something like this be possible in generic Git? It would sure be a 
nice little touch that i would make use of frequently.

Or is it a bad idea perhaps? Or have i, out of sheer ignorance, failed to 
discover some nice little shortcut that can give me all of this already?

Thanks,

	Ingo
