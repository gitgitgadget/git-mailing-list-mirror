From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 17:25:46 -0700
Message-ID: <20120726002546.GA27569@dcvr.yhbt.net>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
 <20120725212418.GA17494@dcvr.yhbt.net>
 <501075B2.8090205@pobox.com>
 <20120725230833.GA23993@dcvr.yhbt.net>
 <501088EC.50405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, Jonathan Nieder <jrnieder@gmail.com>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 02:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuBtp-0005l5-AM
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 02:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2GZAZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 20:25:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40830 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab2GZAZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 20:25:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D75E1F43C;
	Thu, 26 Jul 2012 00:25:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <501088EC.50405@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202219>

Michael G Schwern <schwern@pobox.com> wrote:
> This is rapidly getting into the weeds.  Regardless of the debate below, what
> would you like me to do?  Switch indentation to tabs and resubmit?  AFAIK only
> the new tests are affected.

Yes, unless Jonathan (or anybody else) has more comments.

> On 2012.7.25 4:08 PM, Eric Wong wrote:
> >>>> +BEGIN {
> >>>> +    # Override exit at BEGIN time before Git::SVN::Utils is loaded
> >>>> +    # so it will see our local exit later.
> >>>> +    *CORE::GLOBAL::exit = sub(;$) {
> >>>> +        return @_ ? CORE::exit($_[0]) : CORE::exit();
> >>>> +    };
> >>>> +}
> >>>
> >>> For new code related to git-svn, please match the existing indentation
> >>> style (tabs) prevalent in git-svn.  Most of the Perl found in git also
> >>> uses tabs for indentation.
> >>
> >> About that.  I followed kernel style in existing code, but felt that new code
> >> would do better to follow Perl style.  The existing Perl code mixes tabs and
> >> spaces, so I felt it wasn't a strongly held style.  You'll get more Perl
> >> programmers to work on the Perl code by following Perl style in the Perl code
> >> rather than kernel style.
> > 
> > git-svn should be all tabs (though some spaces accidentally slipped in
> > over the years).  git maintainers are mostly C programmers used to tabs,
> > so non-C code should favor their expectations.
> 
> Perhaps this is self fulfilling.  Would you like to attract more Perl
> programmers?

I prefer programmers not tied to a particular language.

> > I also favor tabs since they're more space-efficient and leads to faster
> > "git grep" on large source trees (more important for bigger projects).
> > I remember many years ago "git grep" was shown to be ~20% faster on
> > a source tree with tabs.
> 
> Storage costs a dime a gig.

It's also kernel page cache overhead.

> Regardless, you don't choose your coding style because it's easier for the
> computer.  You choose it because it makes the code easier for humans to work with.

Hard tabs also happen to be the default indent for my editor (which
is also a popular editor) and slightly easier for me.

> >> Alternatively, how about allowing emacs/vim configuration comments?  The
> >> Kernel coding style doesn't allow them, how do you folks feel?  Then people
> >> don't have to guess the style and reconfigure their editor, their editor will
> >> do it for them.
> > 
> > I don't like them, and I think others here frowns upon them, too.  They
> > take too much space and shows favor/preference towards certain editors.
> > It'll be a bigger problem if more editors become popular and we start
> > "supporting" them.
> 
> What you say above is correct, but the extra space is not wasted.  It would be
> like complaining about all the space that Documentation takes up, and that it
> shows preference towards English.  Its *useful* to somebody not already using
> your style.  It's useful for new-to-your-project folks.  It's also useful for
> somebody switching between the C and Perl code (though a good editor should
> already be set up to do C and Perl differently).
> 
> Are the editor wars still going on here?  Is somebody going to be *offended*
> if their editor isn't represented?  If so, shouldn't they grow up?

It's not about editor wars, but unnecessary code churn to accept/review
patches to support new editors, making it a maintenance burden.  Picking
up (and following) existing conventions within a project ought to be
common sense.

Anyways I don't speak for others, but seeing how we've gone all these
years without editor-specific comments, I don't believe other git devs
want them, either.
