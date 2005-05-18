From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list in local commit order
Date: Wed, 18 May 2005 15:16:58 +1000
Message-ID: <2cfc403205051722163296144@mail.gmail.com>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116192629.11872.201.camel@tglx>
	 <1392.10.10.10.24.1116193437.squirrel@linux1>
	 <1116195235.11872.213.camel@tglx>
	 <1629.10.10.10.24.1116278725.squirrel@linux1>
	 <Pine.LNX.4.58.0505161638090.18337@ppc970.osdl.org>
	 <1116323520.17296.12.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0505170833330.18337@ppc970.osdl.org>
	 <1116349507.17296.31.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0505171035570.18337@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Gleixner <tglx@linutronix.de>, Sean <seanlkml@sympatico.ca>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 07:17:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYGvI-0007zR-LG
	for gcvg-git@gmane.org; Wed, 18 May 2005 07:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVERFRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVERFRL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 01:17:11 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:25453 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262092AbVERFQ6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 01:16:58 -0400
Received: by rproxy.gmail.com with SMTP id i8so11828rne
        for <git@vger.kernel.org>; Tue, 17 May 2005 22:16:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XEg+6ZsxmLHIlLSaL8/yyIyyQPv0FAtLFBLbsoHe7N0T1KPTZssk49+o5VOtluv+u9IlP5yAw0mXATWNOBeVfWTgIDKr4W4KD3Vceggl6g2a6HqjkPuylYqkZigCoqvfwnt4l9dUwnUfVpQIh5Y/mrmkYwlm8MT0jQDAcPdrDoA=
Received: by 10.38.75.64 with SMTP id x64mr71298rna;
        Tue, 17 May 2005 22:16:58 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 17 May 2005 22:16:58 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505171035570.18337@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/18/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Tue, 17 May 2005, Thomas Gleixner wrote:
> >
> > On Tue, 2005-05-17 at 08:43 -0700, Linus Torvalds wrote:
> > > > My idea of repository id was not the notion of workspace seperation. I
> > > > dont care in which directory and on which machine you or who ever
> > > > commits a line of code. I care where the change appears in a public
> > > > repository, which is unique.
> > >
> > > You seem to think that the repository on master.kernel.org is more
> > > important than the one on my private machine, and you're _wrong_.
> >
> > For me yes, as I have no access to your private ones and I can only rely
> > on the integrity of the public accessible ones.
> >
> > For the individual developer the private workspaces are surely more
> > important. I never doubted that, but I do not care whether you use one
> > or ten workspaces and which one of them you blow away or use for
> > updating of master.kernel.org.
> 
> But how would you track "repositoryness", when the repository you care
> about has absolutely nothing to do with the repositories that any of the
> developers who created it in the first place care about?
> 
> See the problem? You can't. You seem to want to track information that
> simply does not _exist_.
> 
> Put another way: the repository ID of the eventual public "target"
> repository only becomes available once the information has been pushed
> there, not before. So a "commit" cannot contain that information, because
> at commit time, you fundamentally cannot know what the eventual public
> repository (if any) will be.

Earlier in a related thread, I argued that what everyone else has been
calling a repo-id is actually a workspace id. Your GIT_COMMITER_EMAIL
idea would have the same practical effect as a separate workspace id,
though it does pollute the interpretation of the e-mail id's since
they are no longer pure e-mail id's...

Would you be amenable to a patch that allowed tools to put attributes
of the form:

   x-"some-attribute" (' ' [^\0]*)+ '\0'

into a commit header?

If, over time, x-"some-attribute" became unversially accepted as
useful, a new release of git could bless it as official and the 'x-'
prefix could be dropped.

In the meantime, tools could experiment with additional commit markers
as they see fit without affecting the interoperability of other tools
which use only the blessed markers.

Of course, a constraint on the semantics of an x-* attribute would
ideally be that it's value must be fixed for all time once the commit
happens since there is no way to change it without creating a new
commit.

jon.
