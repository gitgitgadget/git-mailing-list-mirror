From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Tue, 12 May 2015 19:40:14 -0400
Message-ID: <20150512234014.GE31257@tsaunders-iceball.corp.tor1.mozilla.com>
References: <20150509040704.GA31428@peff.net>
 <20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
 <20150511011009.GA21830@peff.net>
 <xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
 <CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
 <xmqqfv73f420.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
 <xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
 <CAP8UFD0k-=ESEu-7jhf8Y5wz+5A=MHsjtMnC7YJv_DRi30TmDw@mail.gmail.com>
 <CAGZ79kZG=9BkEGB_GOsg7F-2mN5iTjmTFK+vUohj_7wJLfPtig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 13 01:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsJml-0002z4-J8
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 01:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933851AbbELXkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 19:40:23 -0400
Received: from tbsaunde.org ([66.228.47.254]:44907 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbbELXkW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 19:40:22 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 930EBC072;
	Tue, 12 May 2015 23:40:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZG=9BkEGB_GOsg7F-2mN5iTjmTFK+vUohj_7wJLfPtig@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268907>

On Tue, May 12, 2015 at 01:58:56PM -0700, Stefan Beller wrote:
> On Tue, May 12, 2015 at 1:43 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Tue, May 12, 2015 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>
> >>> On Mon, May 11, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>>> To be bluntly honest, I think the current one is sufficient as a
> >>>> good-enough default.  The first thing I would do after seeing that
> >>>> message is to either "git checkout <commit-object-name>" or "git
> >>>> show <commit-object-name>", and the current full 40-hex output gives
> >>>> me an easier mouse-double-click target than the proposed abbreviated
> >>>> one, so in that sense the original proposal may even be a usability
> >>>> regression.
> >>>
> >>> Yeah, it might also be a regression if some users have scripts that
> >>> depend on the current behavior.
> >>> ...
> >>>> It is tempting to say that the output can be eliminated by always
> >>>> checking out the first-bad-commit (i.e. only when the last answer
> >>>> that led to the first-bad decision was "good", do a "git checkout"
> >>>> of that bad commit), but in a project where a branch switching is
> >>>> not instantaneous, that might be problematic (unless the first step
> >>>> the user would have done is to check it out anyway, of course).
> >>>
> >>> Yeah, and speaking of regressions, elimiting the output might be a
> >>> more serious regression.
> >>
> >> I am getting somewhat annoyed by this line of thought.
> >>
> >> Who said bisect output is meant to be parseable and be read by
> >> scripts in the first place?  If that were the case, we wouldn't be
> >> having this discussion thread in the first place.
> >
> > Well "git bisect run" is all about automating bisecting and we know
> > that some people have been using it for a long time.
> >
> > See for example this message from 2007:
> >
> > http://lkml.iu.edu/hypermail/linux/kernel/0711.1/1443.html
> >
> > where there is:
> >
> > "Today we can autonomouly
> > bisect build bugs via a simple shell command around "git-bisect run",
> > without any human interaction!"
> >
> > So it is reasonnable to wonder if some scripts might be parsing
> > the output.
> 
> This reasoning sounds to me, that the lack of a plumbing counterpart
> to bisect(porcelain) made it a de facto plumbing command,
> which is unfortunate for discussing changes like these.
> 
> So how to proceed here?
> * one way would be to ignore the scripts out there, "because it's
>   porcelain, so nobody sane would have written a script using it anyway"
>   but this attitude is not well perceived in the community I'd assume.

honestly in this case I'd be inclined to go that route since the output
isn't really great for parsing so I do find it hard to believe there is
a reasonable number of scripts that use git bisect, and depend on its
output.

> * declare the current bisect command a plumbing layer command and
>   introduce a new porcelain command, how about "git find" which can address
>   a variety of issues such as also having the capability to find a fix
> instead of
>   just regressions (make good/bad markers less confusing)

Solving that issue would be nice, but I think git find is much less
intuitive to new people than bisect, but I'm not really a good judge of
that.

>   Depending on the implementation this may be a lot of work
>   -> copy/paste is fast and involves less work now, but more in the future
>   -> or having a new plumbing-bisect header making calls from the porcelain
>       to the plumbing bisect tool.

my sense is that the division between git-bisect.sh and bisect--helper.c
isn't really great and could already use refactoring so I suspect it'd
be a fair amount of work.

Trev
