From: David Miller <davem@davemloft.net>
Subject: Re: [ANNOUNCE] GIT 1.6.0-rc2
Date: Sat, 13 Sep 2008 01:33:30 -0700 (PDT)
Message-ID: <20080913.013330.29519747.davem@davemloft.net>
References: <1218099517.8625.3.camel@twins>
	<7v3alhjgau.fsf@gitster.siamese.dyndns.org>
	<20080807.052648.239243998.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peterz@infradead.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 13 10:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeQab-0006Mq-Ug
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 10:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbYIMIdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbYIMIdi
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 04:33:38 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36413
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754544AbYIMIdh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Sep 2008 04:33:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id E016AC8C185;
	Sat, 13 Sep 2008 01:33:30 -0700 (PDT)
In-Reply-To: <20080807.052648.239243998.davem@davemloft.net>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95795>

From: David Miller <davem@davemloft.net>
Date: Thu, 07 Aug 2008 05:26:48 -0700 (PDT)

> From: Junio C Hamano <gitster@pobox.com>
> Date: Thu, 07 Aug 2008 03:00:25 -0700
> 
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > Quick question - where does one go to find out the cool new features
> > > that make it 1.6 and should convince me to upgrade and try this whicked
> > > new release?
> > 
> > Draft release notes for 1.6.0 was posted to the list some time ago
> > already, but as always:
> > 
> >     http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.6.0.txt
> 
> Just FYI, I have some issue with 1.6.x git when pulling remotely from
> it on sparc64.  I suspect it is the usual unaligned access issue and I
> will debug it further soon.

As a followup this turned out to be the classic "PATH when doing GIT over
SSH" problem.

I have to say this is very unfun to debug, and even less fun to "fix"
even once you know this is the problem.  And what's more I know this is
the second time I've had to spend a night debugging this very problem.

I ended up having to make a ~/.ssh/environment file and then restart my
SSH server with "PermitUserEnvironment yes" added to sshd_config.

But I can't believe this is what I have to do just to pull from a machine
where I have GIT only installed in my home directory.  What if I were just
a normal user and couldn't change the SSHD config?  What hoops would I
need to jump through to get my PATH setup correctly? :)

It doesn't even work to put ~/bin into the PATH listed in the system wide
/etc/environment, because that does not do tilde expansion, SSHD just takes
it as-is.

Wouldn't it make sense to put the bindir into PATH when we try to do
execv_git_cmd()?  The code has already put the gitexecdir into the
PATH at this point.

Thanks!
