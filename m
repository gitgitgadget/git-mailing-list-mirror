From: "Philippe Bruhat (BooK)" <philippe.bruhat@free.fr>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 14:33:34 +0100
Message-ID: <20091110133334.GB8896@plop>
References: <1257850011-7544-1-git-send-email-book@cpan.org> <20091110122315.GA15906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philippe Bruhat (BooK)" <book@cpan.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 14:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7qr0-0006Sk-Vi
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZKJNdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbZKJNdi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:33:38 -0500
Received: from mail-out4.booking.com ([91.195.237.21]:47631 "EHLO
	mail-out4.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZKJNdi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 08:33:38 -0500
Received: from corpds-101.ams4.corp.booking.com ([10.196.68.22])
	by mtx-102.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qqk-0005S6-9d; Tue, 10 Nov 2009 14:33:34 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-101.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qqk-0006gW-7P; Tue, 10 Nov 2009 14:33:34 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id 15559EF80B9;
	Tue, 10 Nov 2009 14:33:34 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qqk-0003d0-2v; Tue, 10 Nov 2009 14:33:34 +0100
Content-Disposition: inline
In-Reply-To: <20091110122315.GA15906@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132565>

On Tue, Nov 10, 2009 at 07:23:15AM -0500, Jeff King wrote:
> On Tue, Nov 10, 2009 at 11:46:51AM +0100, Philippe Bruhat (BooK) wrote:
> 
> > The main Makefile defines PERL_PATH as the perl to use in the shebang
> > line of git*.perl commands. This ensures this will be the perl used
> > to run the tests (in case another perl appears in $PATH before the one
> > defined in $PERL_PATH)

PERL_PATH is a variable in the Makefile that, if not defined is set up
to /usr/bin/perl.

It is used to set the shebang line in the git-* perl scripts.

> I think this "the perl used to run the tests" needs to be clarified in
> the commit message.  There are really three ways we use perl in the
> tests:
> 
>   1. To run to the git-* scripts themselves.

Yes, this PERL_PATH.

>   2. To run a test snippet of perl as if we were a git-* script.

Actually, my goal was to run Makefile.PL with the proper perl (see below).

>   3. To run random perl helper functions.

I didn't replace those ones, because any perl is good enough to do some
perl -i.bak -pe 's/foo/bar/' processing.

> We already use PERL_PATH for (1). I don't think there is much point in
> worrying about (3). If the perl in your PATH is so broken that it can't
> be used for simple helpers, then you should fix your PATH.

The Perl in my PATH doesn't have Error.pm installed, but /usr/bin/perl
has it. When the Makefile.PL is run by /usr/bin/perl, the private-Error.pm
module is not copied in blib. The git-* perl scripts are using the perl
in PERL_PATH, and therefore can't load Error.pm (not in blib during make test),
causing test breakage.

This is the original reason for this patch. I fixed the general (2) case,
deliberately avoiding to replace every call to perl (3).

> Your patch seems to just fix (2), which I think is sane. But I wanted to
> note it, because when I read your commit message, I wasn't sure which
> you were doing.

Yes.

-- 
 Philippe Bruhat (BooK)

 Trust only in incompetence. You will never be disappointed.
                                    (Moral from Groo The Wanderer #16 (Epic))
