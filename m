From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Wed, 14 Nov 2007 06:48:31 +0100
Message-ID: <D1F72A32-2EE2-4CC9-AC0F-CDB3A261DEA7@zib.de>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>	<87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>	<473A027E.5000107@op5.se> <473A262B.4010205@op5.se> <7vr6itr96h.fsf@gitster.siamese.dyndns.org> <473A493C.4070902@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 14 06:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsB8a-0005Qc-54
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 06:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbXKNFtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 00:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbXKNFtw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 00:49:52 -0500
Received: from mailer.zib.de ([130.73.108.11]:49064 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXKNFtv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 00:49:51 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAE5lJnv018239;
	Wed, 14 Nov 2007 06:49:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1bde7.pool.einsundeins.de [77.177.189.231])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAE5lEuU001734
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 14 Nov 2007 06:47:18 +0100 (MET)
In-Reply-To: <473A493C.4070902@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64950>


On Nov 14, 2007, at 2:02 AM, Andreas Ericsson wrote:

>> BTW, when you have this data-flow (probably typical in a shared
>> repository workflow):
>>     Remote repository               Your repository
>>     refs/heads/foo -------(A)------> refs/remotes/origin/foo
>>          ^                                |
>>          |                               (B)
>>          |                                |
>>          |                                V
>>          `-------------(C)---------- refs/heads/foo
>>          (A) "git fetch" with remote.origin.fetch configuration
>>              set to +refs/heads/*:refs/remotes/origin/* keeps
>>              your refs/remotes/origin/foo up-to-date with their
>>              refs/heads/foo
>>          (B) "git merge origin/foo" while on "foo" branch (there
>>              are few shorthands like "git pull origin foo" while
>>              on "foo" branch.  If you say "git branch --track
>>              foo origin/foo", then running "git pull" without
>>              parameter while on "foo" branch).
>>          (C) "git push origin foo".
>>  * Everybody seems to agree that "refs/remotes/origin/foo" is
>>    called a "remote tracking branch";
>
> I'd like to insert the significant dash there. remote-tracking vs
> remote tracking. It solves the one ambiguity with it, and would
> finally make it clear and consistent almost however it's used.

I recently tried to explain it in the following way:

"refs/remotes/origin/foo" mirrors the original branch (from the
remote repository) in your local repository.  Because it is an
identical copy of the branch in the remote repository it is also
called a "remote-tracking branch" or sometimes just a "remote
branch", although it is stored locally in your repository.


>>  * Your refs/heads/foo follows and builds on top of 'foo' branch
>>    at the remote.  Some people errorneously call it "tracking"
>>    but that is because we do not have a good term for it;
>
> "private tracking branch"? Nah...

"refs/heads/foo" is your local branch that you work
on.  Typically, it's simply called branch foo.  However you
can say "my local branch" foo to emphasis that it's your
branch.  This branch is set up in a way to automatically
merge changes from the remote branch it was created
from.  It is sometimes said to "track" a remote branch,
however it must not be confused with a "remote-tracking
branch".  The terminology used in the documentation is sometimes
confusing.  A clear statement is: "My local branch foo
is configured to automatically merge the remote (tracking)
branch origin/foo, with origin configured to point to
git://server/path/to/repo.git."


>>  * There is no good name for "refs/heads/foo at the remote".  We
>>    always say "the remote branch you follow" (or "track").
>
> "remote-repo branch" perhaps? The universe doesn't exactly toll its
> bells in approval at that, but at least it's not ambiguous.

Typically, the original branch in the remote repository and
its local remote-tracking branch point to the same commit;
or you can easy update the local copy with fetch.  So, often
they are not distinguished.  But you can say "branch foo
from the remote repository git://server/path/to/repo.git"
is mirrored locally as "remote-tracking branch origin/foo" if
you need to be precise.

If you say "I merged origin/foo" it really does not matter
if you mean the branch in the remote repository or its local
remote-tracking branch.  In both cases the reader needs context
to understand what you exactly mean.  If you want to be precise
here, you can say "I merged commit <sha1>".

A technical note: The '--track' option sets up the local
branch to track the original branch in the remote repository.
The setup is not referring to a local remote-tracking branch
at all.  config.<branch>.merge contains the branch as it is
named in the remote repository.  git is automatically merging
from the branch in the remote repository.  The remote-tracking
branch would not be needed to do this.  So I think it's
not a problem that "remote branch foo" sometimes means the
branch in the remote repository and sometimes means its local
remote-tracking branch.  What you really mean in both cases
is the original branch in the remote repository.  If you want
to explicitly point to a specific commit you need to name it
by other means (sha1) anyway.


> I've seen it written as "remote tracking branch" on irc a few times.
> It causes 10 minutes of confusion where no-one's sure what anyone
> else means. With the dash in there, there's no room for ambiguity.

I believe dash is a good idea.

	Steffen
