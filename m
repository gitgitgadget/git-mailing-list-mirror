From: Martin Renold <martinxyz@gmx.ch>
Subject: Re: [PATCH] Remove filename from conflict markers
Date: Wed, 1 Jul 2009 18:16:51 +0200
Message-ID: <20090701161651.GA29393@old.homeip.net>
References: <20090628154559.GA29049@old.homeip.net> <7v63ed5pvi.fsf@alter.siamese.dyndns.org> <20090701123310.6117@nanako3.lavabit.com> <20090701075634.GA18326@old.homeip.net> <7vljn8ls0c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM2UZ-0004l4-IB
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 18:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbZGAQQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 12:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZGAQQw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 12:16:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:59647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752655AbZGAQQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 12:16:52 -0400
Received: (qmail invoked by alias); 01 Jul 2009 16:16:52 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp026) with SMTP; 01 Jul 2009 18:16:52 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX19Zx30YY0tZ/2UNj1F6lvUPCv9Bx7++pWAWyMshjf
	ErEKb9QOrDVvkP
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1MM2UN-00033z-L6; Wed, 01 Jul 2009 18:16:51 +0200
Content-Disposition: inline
In-Reply-To: <7vljn8ls0c.fsf@alter.siamese.dyndns.org>
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122583>

On Wed, Jul 01, 2009 at 01:36:03AM -0700, Junio C Hamano wrote:
> Martin Renold <martinxyz@gmx.ch> writes:
> >  git ls-files --stage > out
> >  cat > expect << EOF
> > -100644 da056ce14a2241509897fa68bb2b3b6e6194ef9e 1      a1
> > +100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1      a1
> >  100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2      a1
> >  100644 fd7923529855d0b274795ae3349c5e0438333979 3      a1
> >  EOF
> 
> I think Nana's patch also had this, but what is this hunk about?  IOW, why
> does stage #1 (common ancestor's version) even change?
> 
> Is this a virtual ancestor in a criss-cross recursive merge?

The file contains conflict markers, which is why it changes. I don't
understand why it has them. The merge looks pretty complex.

> But more importantly, would this new output format really as informative
> as you claim, even when the file that cannot be automerged due to its
> binaryness is not named "binary-file" but simply say "X"?  The merge.err
> output shows that there were some file that failed to merge due to being
> binary, and merge.out output owuld show that "X" had conflict.  Would it
> be just as easy for the end user to connect these two as it used to be?

You are right. With both binary and textual conflicts at the same time, the
user can not connect the two events, except by already knowing which files
are binary.

I think ideally the different pieces of information (the filename, the fact
that it has a merge conflict, and that it is binary) should be printed only
once and together.  But this goes beyond what I want to do right now.

>From an implementation point of view, the variables name1 and name2 seem to
be arbitrary, possibly user-defined conflict markers.  I think it is wrong
to print them in ll_xdl_merge() as if they were filenames.  I will try to
make a new patch that also addresses this issue.

> I for now am assuming no mechanical end user is parsing this output to
> figure out what to do, but that assumption might even be wrong.

In the rebase scenario, the mechanical end user has like 5 different places
where he could pick the filename from.  If I was writing a script I would
not expect such an output to remain stable.

bye,
Martin
