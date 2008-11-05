From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Tue, 4 Nov 2008 22:05:25 -0500
Message-ID: <20081105030525.GC20907@coredump.intra.peff.net>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <1225691960.20883.41.camel@maia.lan> <20081104091800.GB24100@dpotapov.dyndns.org> <1225822231.6722.3.camel@maia.lan> <7vr65rqnoj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 04:06:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxYjE-0002c6-6E
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 04:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYKEDFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 22:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYKEDFa
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 22:05:30 -0500
Received: from peff.net ([208.65.91.99]:1561 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbYKEDF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 22:05:29 -0500
Received: (qmail 11485 invoked by uid 111); 5 Nov 2008 03:05:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 22:05:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 22:05:25 -0500
Content-Disposition: inline
In-Reply-To: <7vr65rqnoj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100137>

On Tue, Nov 04, 2008 at 11:46:36AM -0800, Junio C Hamano wrote:

> These days, people who would want the maching behaviour can explicitly ask
> for it, so there is one less reason to resist changing the default
> (i.e. earlier explicitly askinf for "matching" was impossible, but now we
> can).  The remaining reason of resistance is pure inertia (i.e. not
> changing the behaviour of the command only because you upgraded your git),
> and the only way to address it is to start issuing the warning when "git
> push" or "git push $there" is used and the matching behaviour was chosen
> without configuration (i.e. no "remote.<there>.push = :"), and keep it
> that way for two release cycles, and finally change the default.

Hmm. It really seems to me that there are two desires for push behavior,
based on particular workflows. I.e., some people seem to want the
matching behavior by default, and others want to push the current
branch.

And we already can control that via configuration of the refspec. So any
argument that "git push should do the same thing even on somebody else's
setup" is already wrong. But I do think Junio has a good point, which is
that there is going to be confusion if upgrading git suddenly causes
"git push" to do something else.

So why not take one step back in the behavior change? We can set up the
"push just this branch" refspec during clone, which will leave existing
repositories untouched. And to make things even gentler, we can start
with opt-in to the clone feature, notify users via the release notes
(which, as we have established, EVERYONE reads), and then decide if and
when to switch the option on by default.

So something like a "remote.push" config option, the value of which gets
added to newly created remotes (including those created on clone). It
would default to ":", but you could easily set "git config remote.push
HEAD" to get the other behavior.

No, this doesn't get rid of the eventual need to choose whether to
switch the default. But I think it eases us into it a little more. And I
think such an option is a lot more generally applicable than a "default
push to matching versus HEAD" option.

-Peff
