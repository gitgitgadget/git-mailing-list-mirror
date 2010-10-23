From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Sat, 23 Oct 2010 02:47:44 +0200
Message-ID: <201010230247.45097.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <201010221741.25390.johan@herland.net>
 <AANLkTinY2q-nM8tSWgNG2TtuNXPPzwhY0M-QknODqAoK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 02:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9SIS-0000dL-JI
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 02:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab0JWArs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 20:47:48 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44568 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0JWArr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 20:47:47 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAP006C6WVMTM70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 23 Oct 2010 02:47:46 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 215C2179916A_CC230B2B	for <git@vger.kernel.org>; Sat,
 23 Oct 2010 00:47:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D626F179624B_CC230B1F	for <git@vger.kernel.org>; Sat,
 23 Oct 2010 00:47:45 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAP0007IWVLZW00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 23 Oct 2010 02:47:45 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <AANLkTinY2q-nM8tSWgNG2TtuNXPPzwhY0M-QknODqAoK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159767>

On Friday 22 October 2010, Sverre Rabbelier wrote:
> On Fri, Oct 22, 2010 at 10:41, Johan Herland wrote:
> > On Saturday 09 October 2010, Sverre Rabbelier wrote:
> >> On Sat, Oct 9, 2010 at 03:08, Johan Herland wrote:
> >> > - Fetching and pushing note refs:
> >> >  - Add refs/notes/* to default fetch refspec?
> >> 
> >> Or at least add a '--notes[=<notes namespace>]' to fetch, pull, and
> >> push.
> > 
> > Agreed, at least that.
> > 
> > In order to promote sharing of notes, though, I'd like for it to be
> > possible to configure the repo so that a vanilla 'git fetch' also
> > updates your notes. In fact, I wonder if this should even be made the
> > default.
> 
> I think notes directly under /refs/notes/ should be shared by default,
> but those in sub-refs (such as the /refs/notes/am/ that's been
> mentioned before) should not.

In theory that would make sense, but how you write that as a refspec? AFAIK, 
refspecs don't (yet) support a syntax for (a) _excluding_ something from a 
glob, and certainly not (b) excluding all "sub-refs" from a glob.

Alternatively, we could share everything under refs/notes/, except 
/refs/notes/local/ (or refs/notes/private/ or whatever). That would just 
require support for (a)...

> >> >  - A way to specify (at clone time) which refspec(s) to set up?
> >> 
> >> How would that look like?
> > 
> > Maybe add an option to 'git clone' (and 'git remote add') that
> > specifies the refspec you want to use in your config for that remote.
> > Something like:
> > 
> >  git clone --fetch="+refs/heads/*:refs/remotes/origin/*" \
> >            --fetch="+refs/notes/*:refs/remotes/origin/notes/*" \
> >            <source_url> ...
> 
> Who's going to type that out though? The only use case I can think of
> is if you want to be able to give someone a line they can paste and be
> set right away, but I don't see why in that case pasting multiple
> commands (i.e., calling 'git config' a few times) wouldn't suffice.

You might be right. I was thinking that before we provide shorthands, we 
should provide an option that let you specify _any_ refspec. Sort of as a 
fallback if somebody's scenario doesn't fit into any of the shorthands.

But as you say, this can also be done with a few calls to git config.

> > Obviously, we would probably want to provide shorthands for the most
> > common refspecs, like:
> > 
> >  git clone --fetch=default,notes <source_url> ...
> >  git clone --fetch-heads --fetch-notes <source_url> ...
> 
> Adding refspec shorthands _does_ make sense. However, it might make
> more sense to put those under 'git remote' instead?

I'd say _both_ 'git remote' and 'git clone'.

> >> >  - A way for the remote repo to hint at which refspecs you might
> >> > want to set up (by default?)
> >> 
> >> I assume this would be a generic mechanism of sorts? Are there any
> >> other use cases for this other than notes?
> > 
> > Yes, I believe so (although I haven't thought much about this, yet).
> > There's been earlier discussions on hiding certain branches from view.
> > This could maybe be solved by the server suggesting a refspec that
> > excludes the stuff you don't want to share (by default). Similary, the
> > refspec could _include_ notes namespaces that you do want to share.
> 
> That sounds like a good use case.

But I believe we need to extend the refspec syntax to support at least (a) 
from above (excluding named entries from a refspec glob) in order to support 
hiding of certain refs. Still, I think it would be a useful addition.

> > Of course (as today) the client should be free to demand a different
> > refspec, e.g. if it wants access to everything, or if it's only
> > interested in a subset of the "default" refs.
> 
> Of course, I reckon it would just set up their refspecs, and the user
> would be free to change it. Especially if we inform the user that the
> refspec was set to something other than the default refspec.

Agreed.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
