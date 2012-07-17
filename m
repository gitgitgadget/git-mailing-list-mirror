From: Michael Horowitz <mike@horowitz.name>
Subject: Re: git-p4: Jobs and skipSubmitEdit
Date: Tue, 17 Jul 2012 04:49:52 -0400
Message-ID: <CAFLRbooDpeE0U+sysa=OZ2a1sPvPo9MYTi4KLRgfJxkxw2HQyw@mail.gmail.com>
References: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
	<20120624202445.GA27664@padd.com>
	<CAFLRbootAje0BvLOYiH2xOagfUsQ+a_d+9YeTuG1C0a1Pg__Rg@mail.gmail.com>
	<20120626112115.GA3439@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 10:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr3Tj-0001H5-AH
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 10:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab2GQItz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 04:49:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41317 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab2GQItx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 04:49:53 -0400
Received: by pbbrp8 with SMTP id rp8so471157pbb.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=RQUUeoG79AZKuip9xDF0YKk9HZADq8echEAD0F6UbYE=;
        b=VsC+Jx0ddDPzSgQKNqqf+YL5bhlHtYwGGu2rpWf4b+bW/9ShiRT27TqoaDATX9cNqH
         W8y/J+ixlndlS4rdfRlUGSQ8hjG2EkhOhzqzFn1+Ij/s0ruVrq6mCPIMQbz1q6C0j4vy
         WU2F3f3DnFS0rFALxRJ+1+jCToXmvxtS6Og3IEX07kJRZ5JtzgGs6N8WzybEyH2W7mXN
         4edK+uMCtW48GQibfvjQrJ26Sr3oVLQEfEc3TOnS6zm0f0vnu62ddEgRWa25CwPNm9jN
         WqVd+ads4QE+UUzIjD4Sb5PXty+X/xCMiJFS0qkdSYBC6T+EcpbgZsDMS7TY1bzPGov9
         FAxA==
Received: by 10.68.196.228 with SMTP id ip4mr4549005pbc.82.1342514992649; Tue,
 17 Jul 2012 01:49:52 -0700 (PDT)
Received: by 10.68.57.106 with HTTP; Tue, 17 Jul 2012 01:49:52 -0700 (PDT)
In-Reply-To: <20120626112115.GA3439@padd.com>
X-Google-Sender-Auth: ChfHIIpn0VEAe5qCzhp_oCIP9hk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201595>

Pete,

I gave the patch a try, and it seems to work great.

Only problem I realized is that it means that the git commit message
and the p4 log message end up different, because to p4 the jobs lines
are special and get stripped out, but in git it just stays part of the
commit message.  So, when you do a p4 sync/rebase, the commits come
back without it.  This doesn't make much of difference now, because
the commit messages come back modified with the p4 path and changelist
number anyway, but if Luke tries to do that change to store the p4
path/changelist in notes instead, then we wouldn't want any
differences in the commit messages, because then the commits hashes
won't match again.

Not sure what the best thing to do here is, but I guess it doesn't
matter until this mythical notes thing happens.

Mike



On Tue, Jun 26, 2012 at 7:21 AM, Pete Wyckoff <pw@padd.com> wrote:
>
> mike@horowitz.name wrote on Tue, 26 Jun 2012 01:07 -0400:
> > Well, "Jobs:" is the only thing I use.  Everything else is filled in
> > automatically by git-p4.
> >
> > Yeah, so "Jobs:" appears once on a line by itself, and then multiple
> > lines tabbed in of whatever the Job ids are, in our case they are JIRA
> > issue numbers.  So, it might look like:
> >
> > Jobs:
> >     PROJECTNAME-123
> >     PROJECTNAME-456
> >
> > I think that if someone is using git-p4 and they have "Jobs:" at the
> > beginning of a line by itself in a git commit message, then it is safe
> > to stop pre-pending tabs to the lines from there on.  It can also be
> > an option to turn this behavior on.
>
> I agree that it is simpler to explain if Jobs: must come last.
> For the option, I'd prefer not to add another one, and instead
> hope that it's unlikely to find such a construct in a commit
> message that does not want this feature to happen.
>
> I coded it up already, but with a couple little differences.
> Once I get a couple more of the series on which it depends mailed
> out, I'll send it along for you to play with.
>
>                 -- Pete
>
> > On Sun, Jun 24, 2012 at 4:24 PM, Pete Wyckoff <pw@padd.com> wrote:
> > > mike@horowitz.name wrote on Fri, 22 Jun 2012 12:15 -0400:
> > >> I've written a git prepare-commit-msg hook to do what the Perforce
> > >> JobsView would essentially do, so I can include the jobs directly in
> > >> my git commit message, and then use git-p4.skipSubmitEdit=true, so I
> > >> can just push things into Perforce directly from git without ever
> > >> being prompted by Perforce.
> > >>
> > >> Problem is that this doesn't work, because git-p4 tabs in the entire
> > >> commit message to put it in the "Description:" section of the
> > >> Perforce
> > >> changelist, and my "Jobs:" ends up tabbed in, and it it required by
> > >> Perforce to be at the beginning of the line.  The submit ends up
> > >> failing, because "Jobs:" is required.  I am forced to turn off
> > >> skipSubmitEdit and edit the message to remove the tab from the
> > >> "Jobs:"
> > >> line each commit.
> > >>
> > >> Is there any option to make this work right, or does the git-p4 not
> > >> support this?
> > >
> > > This is a great idea, and something I've thought would be useful
> > > too.  There's no code to handle it currently, but it shouldn't be
> > > too hard.
> > >
> > > I'm imagining that special strings in the git commit are hoisted
> > > up out of the description when building the p4 change message,
> > > as you describe.  Are there any more than "Jobs:"?  Is it just
> > > a single instance that might appear?
> > >
> > > An easy way to do this is to change prepareLogMessage to alter
> > > or add a Jobs line.  Unless we decide this needs to be more
> > > general.
> > >
> > >                -- Pete
> >
