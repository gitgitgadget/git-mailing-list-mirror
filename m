From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/4] Extract some utilities from git-svn to allow
 extracting Git::SVN.
Date: Wed, 25 Jul 2012 16:08:33 -0700
Message-ID: <20120725230833.GA23993@dcvr.yhbt.net>
References: <1343196066-81319-1-git-send-email-schwern@pobox.com>
 <1343196066-81319-2-git-send-email-schwern@pobox.com>
 <20120725212418.GA17494@dcvr.yhbt.net>
 <501075B2.8090205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, Jonathan Nieder <jrnieder@gmail.com>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:09:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuAhn-0008Gr-0o
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 01:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab2GYXJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 19:09:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40218 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab2GYXJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 19:09:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8F01F439;
	Wed, 25 Jul 2012 23:08:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <501075B2.8090205@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202214>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.25 2:24 PM, Eric Wong wrote:
> > Didn't we agree to use done_testing()?   Perhaps (as you suggested) with
> > a private copy of Test::More?  It's probably easier to start using
> > done_testing() earlier rather than later.
> 
> Yes, we agreed done_testing is the way forward.  Given how much work I've had
> to do to get even basic patches in I decided to ditch anything extra.  That
> includes adding a t/lib and I didn't want to make it silently depend on an
> upgraded Test::More either.

OK.

> >> +BEGIN {
> >> +    # Override exit at BEGIN time before Git::SVN::Utils is loaded
> >> +    # so it will see our local exit later.
> >> +    *CORE::GLOBAL::exit = sub(;$) {
> >> +        return @_ ? CORE::exit($_[0]) : CORE::exit();
> >> +    };
> >> +}
> > 
> > For new code related to git-svn, please match the existing indentation
> > style (tabs) prevalent in git-svn.  Most of the Perl found in git also
> > uses tabs for indentation.
> 
> About that.  I followed kernel style in existing code, but felt that new code
> would do better to follow Perl style.  The existing Perl code mixes tabs and
> spaces, so I felt it wasn't a strongly held style.  You'll get more Perl
> programmers to work on the Perl code by following Perl style in the Perl code
> rather than kernel style.

git-svn should be all tabs (though some spaces accidentally slipped in
over the years).  git maintainers are mostly C programmers used to tabs,
so non-C code should favor their expectations.

I also favor tabs since they're more space-efficient and leads to faster
"git grep" on large source trees (more important for bigger projects).
I remember many years ago "git grep" was shown to be ~20% faster on
a source tree with tabs.

(I'm neither a kernel hacker nor a regular Perl hacker)

> Alternatively, how about allowing emacs/vim configuration comments?  The
> Kernel coding style doesn't allow them, how do you folks feel?  Then people
> don't have to guess the style and reconfigure their editor, their editor will
> do it for them.

I don't like them, and I think others here frowns upon them, too.  They
take too much space and shows favor/preference towards certain editors.
It'll be a bigger problem if more editors become popular and we start
"supporting" them.

> The important thing is to have one less special thing a new-to-your-project
> Perl programmer has to do.

Historically git development has catered to C programmers used to tabs.
I think the mixing of indentation styles in current Perl files is the
most confusing.
