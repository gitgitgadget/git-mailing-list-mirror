From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Use case (was Re: Should branches be objects?)
Date: Wed, 25 Jun 2014 18:44:40 -0400
Message-ID: <20140625224440.GD10397@thunk.org>
References: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
 <20140624110932.GI14887@thunk.org>
 <CAK3OfOgb3zt0HKkeQKfMR9u7sKRzjCZAeOQh=qSyt9cVordG4A@mail.gmail.com>
 <xmqqegycans6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico Williams <nico@cryptonector.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:44:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzvvs-0008EA-AU
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 00:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbaFYWoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 18:44:44 -0400
Received: from imap.thunk.org ([74.207.234.97]:58454 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbaFYWon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 18:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=c2Ghd3KeqjBRZxYlq7w6H1bDxaQIHyT7d5lK2mkZY/s=;
	b=meB/Autr3QhIBT2kaAKgJm/g5yspHcIwQVUsIuSJb0iWTFQJHmBhV9vCbeGz0OLQAixH3EGakoBBpw3onZ2k5+ww5LEWoWs53nkkzUzQGYWtC2PMpP+12JfSD1fgA27lL91FFYzpNW7/J5JiLiSkzkMANoD0oToBynWYUJbZt2E=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1Wzvvk-0007Fn-Kg; Wed, 25 Jun 2014 22:44:40 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 20D02580ED0; Wed, 25 Jun 2014 18:44:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqegycans6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252471>

On Wed, Jun 25, 2014 at 10:42:49AM -0700, Junio C Hamano wrote:
> Nico Williams <nico@cryptonector.com> writes:
> 
> > On Tue, Jun 24, 2014 at 6:09 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> > ...
> >> This seems pretty close to what we have with signed tags.  When I send
> >> a pull request to Linus, I create a signed tag which createscontains a
> >> message about a set of commits, and this message is automatically
> >> included in the pull request message generated with "git
> >> request-pull", and when Linus merges my pull request, the
> >> cryptographically signed tag, along with the message, date of the
> >> signature, etc., is preserved for all posterity.
> >
> > Thanks for pointing this out.  Signed tags are objects -- that's a
> > clear and strong precedent..
> 
> Sounds as if you are interpreting what Ted said as a supporting
> argument for having branches as separate type of objects, but the
> way I read it was "signed tags are sufficient for what you want to
> do; adding a new "branch" type does not make much sense at this
> point".

Yes, that's what I was saying.  If you want to record a reliable "who
pushed this" (or "who requested this to be pulled"), you really want
to use a GPG signature, since otherwise the identity of the pusher can
be completely faked --- especially if the you have a tiered system
where you have sub-maintainers in the mix.  So if you want any kind of
auditability long after the fact, you want digital signatures, and so
a signed tag maps exactly to what you want --- modulo needing a
standardized "Linus Torvalds" bot.  But the nice thing about creating
such an automated pull request processing system is that it doesn't
require making any changes to core git.

If you insist that it has to be done via a "git push", I suspect it
wouldn't be that hard to add changes to Gerrit (which already has an
concept of access control which ssh keys are allowed to push a
change), and extended it to include a hook that validated whether the
push included a signed tag.  Again, no core changes needed to git, or
to the repository format.

					- Ted
