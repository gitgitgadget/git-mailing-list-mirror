X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 10:21:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
References: <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
 <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
 <20061025084810.GA26618@coredump.intra.peff.net>
 <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
 <20061025094900.GA26989@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 25 Oct 2006 17:22:18 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authentication-Warning: attu2.cs.washington.edu: rientjes owned process doing -bs
In-Reply-To: <20061025094900.GA26989@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30079>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcmRv-0001js-HD for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932267AbWJYRVv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJYRVv
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:21:51 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:22506 "EHLO
 mx1.cs.washington.edu") by vger.kernel.org with ESMTP id S932267AbWJYRVu
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:21:50 -0400
Received: from attu2.cs.washington.edu (attu2.cs.washington.edu
 [128.208.1.138]) by mx1.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id
 k9PHLgnA006168 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NOT); Wed, 25 Oct 2006 10:21:42 -0700 (envelope-from
 rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost) by attu2.cs.washington.edu
 (8.13.7/8.13.7/Submit/1.2) with ESMTP id k9PHLgQU000428; Wed, 25 Oct 2006
 10:21:42 -0700 (envelope-from rientjes@cs.washington.edu)
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Wed, 25 Oct 2006, Jeff King wrote:

> Yes, it's true that some operations might be easier to play with in the
> shell. However, does it actually come up that you want to modify
> existing git programs? The more common usage seems to be gluing the
> plumbing together in interesting ways, and that is still very much
> supported.
> 

Yes, it does.  I'll give you an example from six months ago: there was a 
need for the group that I work with to support a faster type of hashing 
function for whatever reason.  This would have been simple with previous 
versions of git, but if you've ever looked at the SHA1 code in git, you'll 
realize that you're probably better off never trying to touch it.  There 
is absolutely _no_ abstraction of it at all and the code is so deeply 
coupled in the source that abstracting it away is a pain.

Likewise, there is always room for personal or organizational tweaks on 
the part of the developer.  Things like distributed pulling and 
merging should actually be pretty simple to implement if the complexity 
wasn't so high in the merge-* family.  This is something I implemented 
after an enormous headache because we were dealing with very large 
projects: yes, larger than the Linux kernel.  And this is _exactly_ where 
piping would help; we have implementations of distributed grep over very 
large datasets (on the order of terabytes).

> You can do the same thing in C. In fact, look at how similar
> git-whatchanged, git-log, and git-diff are.
> 

No you can't.  Making a one line addition, commenting out a line, or 
changing a simple flag in a shell script is much easier.  And like I 
already said, you can save multiple versions for your common use if you 
work on a specific project much of the time and change how it operates 
depending on the needs of that one project so you never need to do it 
again or you can _distribute_ that shell file to your colleagues so that 
everybody is doing their work via the same method.  This makes it so you 
can just say "type X, then type Y, then type Z" and everybody is operating 
together without training them on how to use git.

> > This all became very obvious when the tutorials came out on "how to use 
> > git in 20 commands or less" effectively.  These tutorials shouldn't need 
> > to exist with an information manager that started as a quick, efficient, 
> > and _simple_ project.  You're treating git development in the same light 
> 
> Sorry, I don't see how this is related to the programming language _at
> all_. Are you arguing that the interface of git should be simplified so
> that such tutorials aren't necessary? If so, then please elaborate, as
> I'm sure many here would like to hear proposals for improvements. If
> you're arguing that git now has too many features, then which features
> do you consider extraneous?
> 

It's not, it's related to the original vision of git which was meant for 
efficiency and simplicity.  A year ago it was very easy to pick up the 
package and start using it effectively within a couple hours.  Keep in 
mind that this was without tutorials, it was just reading man pages.  
Today it would be very difficult to know what the essential commands are 
and how to use them simply to get the job done, unless you use the 
tutorials.  This _inherently_ goes against the approach of trying to 
provide something that is simple to the developer.

Revision control is something that should exist in the background that 
does it's simple job very efficiently.  Unfortunately git has tried to 
move its presence into the foreground and requiring developers to spend 
more time on learning the system.

Have you never tried to show other people git without giving them a 
tutorial on the most common uses?  Try it and you'll see the confusion.  
That _specifically_ illustrates the ever-increasing lack of simplicity 
that git has acquired.

> I don't agree with this. There are tons of enhancements that I find
> useful (e.g., '...' rev syntax, rebasing with 3-way merge, etc) that I
> think other developers ARE using. There are scalability and performance
> improvements. And there are new things on the way (Junio's pickaxe work)
> that will hopefully make git even more useful than it already is.
> 

There are _not_ scalability improvements.  There may be some slight 
performance improvements, but definitely not scalability.  If you have 
ever tried to use git to manage terabytes of data, you will see this 
becomes very clear.  And "rebasing with 3-way merge" is not something 
often used in industry anyway if you've followed the more common models 
for revision control within large companies with thousands of engineers.  
Typically they all work off mainline.

> If you don't think recent git versions are worthwhile, then why don't
> you run an old version? You can even use git to cherry-pick patches onto
> your personal branch.
> 

I do.  And that's why I would recommend to any serious developer to use 
1.2.4; this same version that I used for kernel development at Google.

> Where?
> 

Few months back here on the mailing list.  When I tried cleaning up even 
one program, I got the response back from the original author "why fix a 
non-problem?" because his argument was that since it worked the code 
doesn't matter.

	http://marc.theaimsgroup.com/?l=git&m=115589472706036

And that is simply one thread of larger conversations that have taken 
place off-list and aren't archived.

> I don't agree, but since you haven't provided anything specific enough
> to discuss, there's not much to say.
> 

If there's a question about some of the sloppiness in the git source code 
as it stands today, that's a much bigger issue than the sloppiness.  My 
advice would be to pick up a copy of K&R's 2nd edition C programming 
language book, read it, and then take a tour of the source code.

> Can you name one customization that you would like to perform now that
> you feel can't be easily done (and presumably that would have been
> easier in the past)?
> 

Yes, those mentioned above.

