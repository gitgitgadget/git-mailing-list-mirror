From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Wed, 11 Mar 2015 19:45:12 +0100
Message-ID: <20150311184512.GB5442@vps892.directvps.nl>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
 <1425934575-19581-1-git-send-email-me@ikke.info>
 <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
 <20150310225509.GA5442@vps892.directvps.nl>
 <xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 19:45:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVldA-0006aS-TP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 19:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbbCKSpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 14:45:15 -0400
Received: from ikke.info ([178.21.113.177]:40737 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbbCKSpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 14:45:13 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 430A11DCF6D; Wed, 11 Mar 2015 19:45:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265331>

On Tue, Mar 10, 2015 at 04:12:18PM -0700, Junio C Hamano wrote:
> Kevin Daudt <me@ikke.info> writes:
> 
> > git log --bisect seems to do something different then git rev-list
> > --bisect
> >
> > From git-log(1):
> >
> >     Pretend as if the bad bisection ref refs/bisect/bad was listed and
> >     as if it was followed by --not and the good bisection refs
> >     refs/bisect/good-* on the command line.
> >
> > This seems to just add addition refs to the log command, which seems
> > unrelated to what rev-list --bisect does.
> >
> > So I don't see why git log --bisect --first-parent should be prohibited
> > (unless this combination doesn't make sense on itself).
> 
> Well, but think if your "unless" holds true or not yourself first
> and then say "I do not think this combination doesn't make sense",
> if you truly mean "I don't see why ... should be prohibited".
> 
> What does such a command line _mean_?  It tells us this:
> 
>     Define a set by having the "bad" ref as a positive end, and
>     having all the "good" refs as negative (uninteresting) boundary.
> 
> That is a way to show commits that are reachable from the bad one
> and excluding the ones that are reachable from any of the known-good
> commits.  The area of the graph in the current bisection that
> contains suspect commits.
> 
> Now, what does it mean to pull only the first-parent chain starting
> from the bad one in such a set in the first place?  What does the
> resulting set of commits mean?
> 
> 

In that case it will leave out any merged in branches.

I recalled reading something about this. Searching found me the GSoC
idea:

    When your project is strictly "new features are merged into trunk,
    never the other way around", it is handy to be able to first find a
    merge on the trunk that merged a topic to point fingers at when a
    bug appears, instead of having to drill down to the individual
    commit on the faulty side branch.

So there is definitely a use case for --bisect --first-parent, which
would show you those commits that would be part of the bisection.
