From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] Fix multi-glob assertion in git-svn
Date: Sat, 9 Aug 2008 00:28:06 -0700
Message-ID: <20080809072806.GA20504@untitled>
References: <20080808084025.GA8718@untitled> <1218184918-9135-1-git-send-email-normalperson@yhbt.net> <7vk5erete1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Griep <marcus@griep.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 09:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRitG-00049L-RH
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 09:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYHIH2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 03:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbYHIH2I
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 03:28:08 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57908 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYHIH2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 03:28:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 470C22DC01B;
	Sat,  9 Aug 2008 00:28:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5erete1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91746>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > From: Marcus Griep <marcus@griep.us>
> >
> > Fixes bad regex match check for multiple globs (would always return
> > one glob regardless of actual number).
> >
> > [ew: fixed a bashism in the test and some minor line-wrapping]
> 
> Thanks both.
> 
> > +test_expect_success 'test disallow multi-globs' '
> > ...
> > +	cd tmp &&
> > +		echo "try try" >> tags/end/src/b/readme &&
> > +		poke tags/end/src/b/readme &&
> > +		svn commit -m "try to try"
> > +		cd .. &&
> 
> Do you want to ignore exit code from 'svn commit -m' here?

Oops, no missed that.

> In any case, I'd want to see "temporarily work in subdirectory" done in a
> subshell when applicable, so that we won't have to worry about where we
> are when we later add more tests, like this:
> 
> 	(
>         	cd tmp &&
>                 echo "try try" >>tags/end/src/b/readme &&
>                 poke tags/end/src/b/readme &&
>                 svn commit -m "try to try" &&
> 	) &&

Yes, that's a good idea

> > +	test_must_fail git-svn fetch three 2> stderr.three &&
> > +	cmp expect.three stderr.three
> 
> s/cmp/test_cmp/;

Noted.

Shall I make those changes and resubmit or are they simple enough
for you to do?

-- 
Eric Wong
