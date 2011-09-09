From: Jeff King <peff@peff.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 9 Sep 2011 14:27:14 -0400
Message-ID: <20110909182714.GC28480@sigill.intra.peff.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
 <4E68C04F.9060804@drmicha.warpmail.net>
 <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com>
 <20110908191842.GB16064@sigill.intra.peff.net>
 <4E69C8DC.7060008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Szakmeister <john@szakmeister.net>,
	Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 20:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R25nP-0006Qv-AX
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 20:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759617Ab1IIS1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 14:27:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59842
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab1IIS1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 14:27:17 -0400
Received: (qmail 32767 invoked by uid 107); 9 Sep 2011 18:28:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Sep 2011 14:28:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Sep 2011 14:27:14 -0400
Content-Disposition: inline
In-Reply-To: <4E69C8DC.7060008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181102>

On Fri, Sep 09, 2011 at 10:05:48AM +0200, Michael J Gruber wrote:

> > Agreed. Anything harder than ssh keys is right out the window, because
> > they're always the alternative these people could be using (but can't or
> > don't want to).
> 
> Sue, the question was: What is easy enough? I hoped that people would be
> using gpg to check signed tags, and that there might be a simple,
> convenient gnupg installer for Win and Mac which ties into the
> respective wallet systems or provides one they use already.

I suspect most people aren't checking signed tags. And even if they did
have gpg installed, most people aren't going to want a new password
wallet.  They're going to want integration with what they're already
using.

Which isn't to say that a gpg-based wallet is wrong, it's just that I
don't think it's filling the role that really needs filled. If you want
to make such a wallet helper, you're welcome to. But it doesn't
necessarily need to be a part of git core, and if it's not, then maybe
it's worth looking at the zillion other password wallet programs that
exist.

FWIW, I keep my passwords in a gpg-encrypted file and wrote a 10-line
shell script helper to do lookups for git. :)

> > We could make our own gpg-based password wallet system, but I think it's
> > a really bad idea, for two reasons:
> > 
> >   1. It's reinventing the wheel. Which is bad enough as it is, but is
> >      doubly bad with security-related code, because it's very easy to
> >      screw something up when you're writing a lot of new code.
> 
> So please let's not deploy credential-store...

I'm tempted to agree. But I also think it represents a nice lowest
common denominator. No hassle, no setup, but no security either. And
there are situations where that's appropriate (e.g., for unattended
cron operation, it's not much different than an unencrypted ssh key on
disk). My compromise was to put a big warning at the top of the
documentation. Maybe that's not enough, though.

And as far as reinventing the wheel with security code, I don't think
git-credential-store counts. It's not secure at all, so there's very
little to screw up. :)

> On 1.+2.: The idea/hope was to use an existing wallet system which
> people use for gnupg already to store their passphrase. If that is not
> used then my suggestion does not help much (the issue of widespread
> deployment), though it still is a secure version of credential-store for
> those who want a desktop-independent secure credential store.

Yeah, if there is an existing wallet system based around gpg, then
absolutely there should be a helper for it. But I don't know that there
is such a widely deployed system. And the helper for it doesn't need to
ship with git-core; anybody who uses their wallet system is free to
write and distribute the helper.

-Peff
