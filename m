From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 10:20:42 -0700
Message-ID: <7vmywczyfp.fsf@gitster.siamese.dyndns.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com>
	<7v6431omn8.fsf@gitster.siamese.dyndns.org>
	<20070827014056.GB7422@mediacenter.austin.rr.com>
	<7vlkbxmp50.fsf@gitster.siamese.dyndns.org>
	<20070827075009.GA31438@glandium.org>
	<38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com>
	<20070827170504.GH4680@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPiGk-0000Ea-BC
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 19:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbXH0RUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 13:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757094AbXH0RUu
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 13:20:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981AbXH0RUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 13:20:49 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 51748127432;
	Mon, 27 Aug 2007 13:21:06 -0400 (EDT)
In-Reply-To: <20070827170504.GH4680@thunk.org> (Theodore Tso's message of
	"Mon, 27 Aug 2007 13:05:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56863>

Theodore Tso <tytso@mit.edu> writes:

> The bigger inconsistency is with git-format-patch, which *does* take a
> set of commits, and where "git-format-patch a" does operates on a very
> different set of commits than what what "git-rev-list a" returns.  I
> understand that for backwards compatibility "git-format-patch a" is
> equivalent to "git-format-patch a..HEAD", but what it means is that
> all other ways of specifying sets of commits work with
> git-format-patch, *except* if you want to specify all commits from the
> beginning of time to a particular head (i.e., "git-rev-list a") is
> something that you simply can not possibly do using git-format-patch.

Heh, I really hate when people say this.

If you wanted to, you could:

	$ git format-patch a a

The original syntax

	$ git format-patch upstream

may have been a mistake and maybe

	$ git format-patch ^upstream

or even        

	$ git format-patch --since upstream

might have been better.  It is (1) too late to change now, and
(2) for too small or perhaps negative a gain.

The reason why I say (2) is because _I_ think it is far more
common and frequent to want to get "patches the other guy does
not have" than "everything since nothingness up to this point".

Oops.  I think I have a solution.

	$ git format-patch a a

does not do _ROOT_ commit.  So you have to say

	$ git format-patch --root a a

for the above example to work.  Why not tweak the option parser
so that:

	$ git format-patch --root a

to do what you want?  Without --root and with a single positive
commit, it can keep doing the traditional "what I did since I
forked from that guy's history".

Hmm...
