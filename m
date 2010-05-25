From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Use "git pull --ff-only" by default?
Date: Tue, 25 May 2010 10:43:22 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483677DDC@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
 <4BF6A445.1030105@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234FAA@xmail3.se.axis.com>
 <20100524125637.GE3005@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 10:43:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpjh-0006gB-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab0EYInh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:43:37 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:35054 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab0EYInd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 04:43:33 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o4P8hOlt019645;
	Tue, 25 May 2010 10:43:24 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 25 May 2010 10:43:24 +0200
Thread-Topic: Use "git pull --ff-only" by default?
Thread-Index: Acr7QKqfWNvygOAHQcmiolLsd3/PqQAnpFyw
In-Reply-To: <20100524125637.GE3005@dpotapov.dyndns.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147686>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Dmitry Potapov
> Sent: den 24 maj 2010 14:57
> To: Peter Kjellerstedt
> Cc: Michael J Gruber; git@vger.kernel.org
> Subject: Re: Use "git pull --ff-only" by default?
> 
> On Mon, May 24, 2010 at 10:22:45AM +0200, Peter Kjellerstedt wrote:
> >
> > I forgot to mention that I had tried that. It does not work as git
> > explicitly does not allow one to use a git command name as an alias
> > name. And I think this is a good policy since it prevents people
> > from aliasing plumbing commands to do weird things. However, I would
> > like to see some way to affect the defaults of porcelain commands.
> 
> Though, some porcelain commands (such as "branch") should never be used
> in scripts, many others do not have low-level analogue, so they are
> commonly used in scripts.

Well, then I guess it would have to be either specific options for
specific commands, or more generic as any options for specific commands.
The problem then becomes selecting which options and which commands
are allowed to take default values.

> > > I think this boils down to having a few people who are allowed to
> > > push merges because they can make these decisions. Even if people
> > > don't merge "origin" but their own branches they can create a mess, 
> > > so you cannot differentiate based on that.
> >
> > In a larger organization this does not work. Most of our developers
> > are responsible for at least one subsystem and expected to be the one
> > responsible for its master branch.
> 
> Right. Now, if only one person who is responsible for this subsystem is
> expected to be able to push changes to the master branch then this
> person will never need "git pull --ff-only". In fact, when he pulls

Well, most of our subsystems have at least one backup maintainer 
(we cannot stop development just because the main maintainer is home
sick, or on leave), so this is not necessarily true in our case.

> changes from others, he needs a real merge. So, this alone a very
> strong argument against making ff-only by default in any configuration.

Well, we use a central repository with development made on official
topic branches, so he is not supposed to pull from others. He will 
fetch from the central repository and merge the topic branches. And
I do not expect anyone to merge using git pull, but rather using an
explicit git merge. This is why I want to prevent accidental merges 
using git pull by giving the --ff-only option. That way the user 
would have to take an explicit action, and decide whether he should
do a git pull --rebase, put his local changes on a branch or resolve
the problem some other way (initially that would probably be by 
asking me what is going on and what to do, and that way learn how to
handle the situation). Silently creating an automatic merge that does 
not have any meaning and will just confuse anyone looking at the 
revision history later is not something that I want, especially as it
would make the job harder for the maintainer who is supposed to merge
the changes later and then has to untangle the mess.

> And if you think that "pull --ff-only" is very useful for some reason,
> nobody prevents to add an alias for that command, but this command
> should never be called as "pull", because "pull" has always been about
> merging changes, and if it does something different, you should call it
> differently. Why don't call it as "fast-forward" or "ff" for short?

I do not agree with you. When I do git pull it is to get all changes
made to the official repository. I do not want any local changes I have 
to be merged with the official changes, but rather I want my changes
to stay separate, either by using git pull --rebase (if I have hacked
on the same branch for some reason), or by using a private topic branch
that I keep rebasing on master. And having --ff-only by default would 
save me from mishaps in case I forget to give the --rebase option.

And knowing that all our developers come from CVS, I expect it to take
quite a while until they have learned to not just start hacking and
doing occasional git pulls, but rather create separate topic branches 
and rebasing. And in the meantime I want to protect our repositories
from the automatic merges introduces by git pull without --ff-only 
and/or --rebase. 

I have also refrained from setting branch.autosetuprebase to remote 
since I prefer the users to make an active choice as to how to resolve 
updating their branches (and because of the note given for 
branch.<name>.rebase marking it as possibly dangerous to use by default).

> Dmitry

//Peter
