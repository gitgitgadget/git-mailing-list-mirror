From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
	HEADs
Date: Sat, 14 Feb 2009 13:54:11 -0500
Message-ID: <20090214185411.GA13121@coredump.intra.peff.net>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090214175420.GA3457@coredump.intra.peff.net> <76718490902141035o5430707ck47cd72d9efe87318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 19:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPgf-0001Xm-MP
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 19:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbZBNSyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 13:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbZBNSyO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 13:54:14 -0500
Received: from peff.net ([208.65.91.99]:52714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbZBNSyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 13:54:14 -0500
Received: (qmail 1354 invoked by uid 107); 14 Feb 2009 18:54:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 14 Feb 2009 13:54:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 13:54:11 -0500
Content-Disposition: inline
In-Reply-To: <76718490902141035o5430707ck47cd72d9efe87318@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109891>

On Sat, Feb 14, 2009 at 01:35:03PM -0500, Jay Soffian wrote:

> On Sat, Feb 14, 2009 at 12:54 PM, Jeff King <peff@peff.net> wrote:
> >> +             if (opt_a)
> >> +                     printf("%s/HEAD set to %s\n", argv[0], head_name);
> >
> > This was a surprise based on reading the commit message, but I think it
> > is a sensible enhancement.
> 
> It seemed that when doing something "--automatically" it might be nice
> to tell the user what we just did, but I'm confused why this was a
> surprise.

I just meant that the commit message did not mention changes in this
area, and it is largely orthogonal to the rest of the patch (you could
just as easily apply this hunk without the rest of your patch, and it
would have the same value). Thus I was surprised.

But I do think it is a good change.

> > cat > test/expect <<EOF
> > refs/remotes/origin/master
> > EOF
> >
> > test_expect_success 'set-head --auto' '
> >        (cd test &&
> >         git remote set-head --auto origin &&
> >         git symbolic-ref refs/remotes/origin/HEAD > output &&
> >        test_cmp expect output)
> > '
> 
> Right.

I suspect Junio can just fix this up during application if he agrees.

<random process musing>
Which made me think of something else, with all of this talk about
reviewers that has been going on. Junio is actually in a little bit of a
special position with small changes (like style issues) to say "I'll
apply this, but tweak these changes". But the rest of us are stuck
saying "I would change this one line" to the list; then either:

  - the original submitter re-rolls the patch, which takes their time
    and everyone else's time to look at the new patch, see that it is
    trivially changed, etc

    or

  - Junio has to read the followup comments, then go back and find the
    spot in the original patch to mark it up.

Which means that there is a transaction cost to little comments due to
the extra communication. And that cost can dwarf the actual time for the
change.

I don't know if there is a better method, or better tool support. I
guess reviewers could act like the maintainer, tweaking patches and then
publishing the result, which Junio would then pull. Or instead of
publishing the result, publishing an interdiff along with comments. But
basically putting the comments into a form that can be communicated and
applied more easily, which cuts down on the communication costs.

I don't know. Just thinking out loud.

-Peff
