From: Jeff King <peff@peff.net>
Subject: Re: Git stops forever while cloning remote repo
Date: Wed, 4 Apr 2012 17:07:07 -0400
Message-ID: <20120404210707.GA5054@sigill.intra.peff.net>
References: <805073108.1332078446.170729064.12423@mcgi-wr-20.rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: oldb0t@ro.ru
X-From: git-owner@vger.kernel.org Wed Apr 04 23:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXQD-0004U2-ET
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab2DDVHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:07:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46234
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2DDVHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:07:09 -0400
Received: (qmail 14215 invoked by uid 107); 4 Apr 2012 21:07:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 17:07:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 17:07:07 -0400
Content-Disposition: inline
In-Reply-To: <805073108.1332078446.170729064.12423@mcgi-wr-20.rambler.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194740>

On Sun, Mar 18, 2012 at 05:47:26PM +0400, oldb0t@ro.ru wrote:

> I try to clone https://github.com/angband/angband.git locally, and
> git stops in the middle, again and again, in different places. For
> instance, one time it was 38% of full repo, and another time it was
> 4% of depth 1 shallow clone. Once it stopped, it doesn't try to
> continue anymore, just get stuk forever. My internet connection is
> fine, all other works perfect: wget, browsers, mail client.

I tried to reproduce this here, but it works fine for me. Have you tried
cloning from git://github.com/angband/angband.git instead? If that works
better, that would give us a data point about where the problem is.

> Is there any way to force git to retry the connection? Something like
> wget does with -t and -T options. I use git 1.7.9.1 from Debian
> testing.

Unfortunately, no. Because the packs are generated on the fly, resuming
is tricky. One solution is to create static "bundles" that are
resumable, but not every service (nor most, really) does that[1].
However, you can try Tomas's bundler service, which will generate a
resumable bundle for you:

  https://bundler.caurea.org/

-Peff

[1] I hope to eventually have GitHub do this itself, but right now the
    client side of it is very manual. I have some patches in the works
    to make this happen transparently if the server advertises a bundle
    mirror.
