From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Tracability in git commits
Date: Tue, 29 Apr 2008 22:56:39 +0100
Message-ID: <1209506199.5642.66.camel@dax.rpnet.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:58:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxqM-0000oN-4c
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbYD2V5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYD2V5q
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:57:46 -0400
Received: from tim.rpsys.net ([194.106.48.114]:57719 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbYD2V5p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:57:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3TLuthe018082;
	Tue, 29 Apr 2008 22:56:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 17959-04; Tue, 29 Apr 2008 22:56:48 +0100 (BST)
Received: from [192.168.1.3] (dax.rpnet.com [192.168.1.3])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id m3TLubUN018072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Apr 2008 22:56:43 +0100
In-Reply-To: <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80753>

On Tue, 2008-04-29 at 14:34 -0700, Junio C Hamano wrote:
> Richard Purdie <rpurdie@rpsys.net> writes:
> 
> > Assuming a shared server using something like gitosis each set of
> > commits is made under a certain ssh ID and what I'd like is to be able
> > to validate that against the commits so we could tell that commits A-D
> > were made by ID Z.
> 
> First of all, you need to learn the differences between making commits and
> updating remote repositories.  Push does not create commits, it only
> propagates a new part of commit DAG created elsewhere.

I understand that, yes. I also understood the remote repository to be
able to accept or reject commits/merges through its hooks?

> When you grant rights to a person to update the tip of a branch of a
> repository, you are saying that you trust the person to advance the
> history recorded on that branch in a way that is compatible with the goal
> of the branch of your repository.

but you can put a policy in place for that in the hooks if desired?

> Whether you like it or not, git is a distributed system and git does not
> care how that other person came up with the new part of the history.  The
> person may find somebody else's work that is useful and apply patches to
> his history (introducing commits whose authors are not himself), or merge
> it (introducing commits whose committer are not himself), but you trust
> that the person who does so uses good judgement, the same good judgement
> he uses when making changes on his own.

I appreciate this can happen and is often part of the normal workflow. I
have no objection to that, its more a question about whether it can be
controlled or at least logged...

> And then the branch you granted the right to update its tip to that person
> is updated, using that added part of the history.  The updates to the tip
> will be recorded in reflog to record who updated the tip and when, which
> would allow you to go back and point your finger at the person who
> introduced problematic new history and at that point you really do not
> care if the problem you have with the new history was due to faulty
> commits the pusher made himself, was introduced by a merge the pusher did,
> or was applied by the pusher from his mailbox.

This sounds like my answer, it's possible to trace who did what from the
reflog. Which area of code is responsible for updating the reflog, is it
in git itself or is it in the form of a hook? 

I'm asking since if the repository is read/write for several users,
faking the log is easy. If you use something like gitosis it runs under
one user and faking is hard due to the restricted access. There is
probably a need to feed extra information into whatever is making the
log, or generate an additional log though due to the single user?

Thanks,

Richard
