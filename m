From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Tracking of local branches
Date: Fri, 20 Mar 2009 17:13:35 +0100
Message-ID: <49C3C0AF.6090806@drmicha.warpmail.net>
References: <49C3A6AE.7020104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Mar 20 17:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkhNT-0003Gx-C1
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZCTQNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbZCTQNw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:13:52 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60959 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752873AbZCTQNw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 12:13:52 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2E9042F7312;
	Fri, 20 Mar 2009 12:13:50 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 12:13:50 -0400
X-Sasl-enc: 06o3ode0t1Rz44gg77GU8ASgl/jRDYWkkRwmRgDMLL/p 1237565629
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6A41D2829F;
	Fri, 20 Mar 2009 12:13:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49C3A6AE.7020104@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113972>

Michael J Gruber venit, vidit, dixit 20.03.2009 15:22:
> Hi there,
> 
> me again. In connection with Dscho's recent patch which rang the bell on
> tracked branches I noticed that local branches are treated somewhat
> inconsistently by git. There are 2 ways to fix it, and I ask you for
> your input on which one to choose.
> 
> First of all:
> The documentation seems to imply that it's okay to follow local
> branches, i.e. to have tracked local branches. Specifically, the option
> --track allows setting up tracking info (branch.foo.merge) in cases
> where it's not set up automatically (it is when you branch off a remote
> tracking branch).
> 
> If it's not OK to say "git checkout -b newbranch --track local" when
> local is a local branch you can stop reading here and tell me to stop
> writing...
> 
> Now, assuming it's okay to have a local branch being tracked, the
> current situation is:
> 
> git fetch/pull is okay (respects the setting)
> git status/checkout/rev-parse BEL is not (acts as if there is no
> tracking info)
> 
> I think I have tracked it down (pun intended) to the fact that one sort
> of commands looks at the struct member branch->merge, the other at
> branch->merge_name. The latter is set for branches which follow
> something, the former only for followers of remote branches.
> 
> I semi-successfully messed around in remote.c (format_tracking_info(),
> stat_tracking_info()) to make it use branch->merge_name rather than
> branch->merge. This makes "git status" work as expected ("Your branch
> is... severely screwed.") for tracked local branches. (It's messed up
> for remote ones but hey it was a first shot; merge[0]->dst is really
> needed here I guess.)
> 
> Now I could go after sha1_name.c and do the same,
> 
> OR
> 
> make it so that all branches have their merge member set up, uhm. Any
> possible side effects?
> 
> What do you think?
> Michael

OK, I think I got this working with approach 2 above. All existing tests
pass. Now I'll cook up tests which only my new code passes ;) But that
may take a few days.

Michael
