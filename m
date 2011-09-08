From: Jeff King <peff@peff.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Thu, 8 Sep 2011 15:18:42 -0400
Message-ID: <20110908191842.GB16064@sigill.intra.peff.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
 <4E68C04F.9060804@drmicha.warpmail.net>
 <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nsa-0006Ph-J9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1IHXT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:19:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875Ab1IHXSp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:18:45 -0400
Received: (qmail 16358 invoked by uid 107); 8 Sep 2011 19:19:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 15:19:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 15:18:42 -0400
Content-Disposition: inline
In-Reply-To: <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181003>

On Thu, Sep 08, 2011 at 11:02:11AM -0400, John Szakmeister wrote:

> On Thu, Sep 8, 2011 at 9:17 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> [snip]
> > It would be interesting to know what we can rely on in the user group
> > you're thinking about (which I called ssh-challenged). Setting up ssh
> > keys is too complicated. Can we require a working gpg setup? They do
> > want to check sigs, don't they?
> 
> I don't think you can require a working gpg setup (at least for not
> addressing the ssh-challenged group).

Agreed. Anything harder than ssh keys is right out the window, because
they're always the alternative these people could be using (but can't or
don't want to).

We could make our own gpg-based password wallet system, but I think it's
a really bad idea, for two reasons:

  1. It's reinventing the wheel. Which is bad enough as it is, but is
     doubly bad with security-related code, because it's very easy to
     screw something up when you're writing a lot of new code.

  2. It's inconvenient for users. Nobody wants a separate wallet system
     with its own master password. They want to integrate with the
     wallet system they're already using. Which is generally going to be
     way nicer _anyway_, because it's going to be part of the OS and do
     helpful things like unlock the secret store using their login
     credentials.

> > So: What credential store/password wallet/etc. can we rely on for this
> > group? Is gpg fair game?
> 
> I think there probably need to be providers for using Keychain under
> the Mac, gnome-keyring and kwallet under Linux, and probably something
> using the wincrypt API under Windows.  I don't think there's a
> one-store-fits-all solution here, unfortunately. :-(

Exactly. That's why the helpers communicate via pipes. They don't have
to be included with core git at all; you should be able to just drop a
third-party git-credential-foo into your PATH.

> I'm actually tempted try and work on a couple of those myself.

Please do! I mentioned a few people working on helpers elsewhere in this
thread, so you may want to see what they've done and/or coordinate to
avoid duplicate effort. Let me know if you have trouble finding the
appropriate threads in the list archive.

-Peff
