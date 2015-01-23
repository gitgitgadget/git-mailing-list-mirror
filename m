From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 1/5] Fix generation of Documentation/usage-%.txt.
Date: Fri, 23 Jan 2015 09:36:14 -0500
Message-ID: <20150123143614.GG101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-2-git-send-email-cederp@opera.com>
 <20150123142103.GA101465@meili.jeffnet.31bits.net>
 <CAP=KgsSMT7Wniek1FgRGkrxa9+45hxcDtE-C1B4sQMvUviKJ1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:36:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfLR-0002pn-77
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203AbbAWOgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:36:18 -0500
Received: from josefsipek.net ([71.174.113.7]:1643 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbbAWOgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:36:16 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 7C18B55654;
	Fri, 23 Jan 2015 09:36:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAP=KgsSMT7Wniek1FgRGkrxa9+45hxcDtE-C1B4sQMvUviKJ1g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262937>

On Fri, Jan 23, 2015 at 03:33:03PM +0100, Per Cederqvist wrote:
> On Fri, Jan 23, 2015 at 3:21 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> > On Fri, Jan 23, 2015 at 02:24:55PM +0100, Per Cederqvist wrote:
> >> The old rule worked, most of the time, but had several issues:
> >>
> >>  - It depended on the corresponding guilt-*.txt file, but the usage.sh
> >>    script actually reads ../guilt-foo.
> >>
> >>  - Actually, each usage-%.txt depended on all guilt-*.txt files, so
> >>    make had to do more work than necessary if a single file was
> >>    altered.
> >>
> >>  - The construct broke parallel make, which would spawn several
> >>    usage.sh at once.  This leads to unnecessary work, and could
> >>    potentially result in broken usage files if the "echo some_string >
> >>    some_file" construct used by usage.sh isn't atomic.
> >>
> >> Fixed by letting the usage.sh script update a single file, and writing
> >> a proper implicit make rule.  This makes parallel make work a lot
> >> better.
> >
> > Nice!
> >
> >> There is a small downside, though, as usage.sh will now be run once
> >> for each command (if everything is regenerated).  I think it is worth
> >> to pay that price to get the correctness.  This command is still very
> >> fast compared to the docbook processing.
> >
> > Given how much simple usage.sh got, I'm thinking it might be worth it to
> > just remove it, and just shove the rule into the makefile itself.
> >
> > Ok, I tried to write it.  I came up with the following.  (Note: I have *not*
> > tested it.)  It's not *that* ugly.
> >
> > usage-guilt-%.txt: ../guilt-% usage.sh
> >         echo "'$(basename $<)' `sed -n -e '/^USAGE=/{s/USAGE="//; s/"$//; p; q}' $<`" > $@
> >
> > What do you think?  Too opaque?  Your change looks good.
> 
> Too opaque,

Between that and the other patch in the series that modifies usage.sh, your
patch is good as is.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

> and not tested enough. It doesn't work, since make will
> handle all $.  You need to write $$ instead of $ in at least one of the
> places.  I would stick with usage.sh, as getting the quoting right when
> you have make, shell, subshells, and sed all at the same time is just
> too painful.

And this is comming from the person that rewrote cmd/shouldfail in a way
that the average shell user will go "whaaa??" :P  (To be fair, I don't know
of a simpler way to make cmd/shouldfail.)

> But it is of course up to you. You are the maintainer. :-)

Heh.

Jeff.

-- 
Real Programmers consider "what you see is what you get" to be just as bad a
concept in Text Editors as it is in women. No, the Real Programmer wants a
"you asked for it, you got it" text editor -- complicated, cryptic,
powerful, unforgiving, dangerous.
