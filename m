From: Jeff King <peff@peff.net>
Subject: Re: post-fetch, tweak-fetch hook
Date: Mon, 7 May 2012 03:29:34 -0400
Message-ID: <20120507072934.GC19874@sigill.intra.peff.net>
References: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
 <201205062310.q46NAHnM022630@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mitar <mmitar@gmail.com>, git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon May 07 09:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRIO6-0003po-NG
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 09:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197Ab2EGH3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 03:29:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60433
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab2EGH3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 03:29:37 -0400
Received: (qmail 17680 invoked by uid 107); 7 May 2012 07:29:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 03:29:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 03:29:34 -0400
Content-Disposition: inline
In-Reply-To: <201205062310.q46NAHnM022630@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197238>

On Sun, May 06, 2012 at 07:10:17PM -0400, Seth Robertson wrote:

> The output of fetch seems to do that, quite nicely.
> 
> ----------------------------------------------------------------------
> > git fetch
> remote: Counting objects: 24155, done.
> remote: Compressing objects: 100% (6651/6651), done.
> remote: Total 21446 (delta 15831), reused 20146 (delta 14640)
> Receiving objects: 100% (21446/21446), 6.78 MiB | 239 KiB/s, done.
> Resolving deltas: 100% (15831/15831), completed with 574 local objects.
> From git://git.kernel.org/pub/scm/git/git
>    ea2c69e..edf1412  maint      -> origin/maint
>    ae4479d..8275905  master     -> origin/master
>  + b6b16ad...8a79d96 next       -> origin/next  (forced update)
>  + 47db9a0...30b8c95 pu         -> origin/pu  (forced update)
>    ce29fc8..3ca5cbc  todo       -> origin/todo
> ----------------------------------------------------------------------

This output is human-consumable, and is not guaranteed to remain stable
in future versions of git. Push has a --porcelain mode for this reason,
but nobody has bothered to implement it for fetch.

> If you care about race conditions (and really, a lockfile(1) call can
> take care of that easily enough), then parse the output of fetch which
> will make it clear what *this* call did.

Custom locking is not sufficient, as a push could modify refs behind
your back. I guess you could get by with a pre-receive hook that also
took the lock. But that is unnecessarily crappy; git does not have a
whole repo lock, and there is no need for lock contention between pushes
and fetches that are touching different refs.

I would say the "most git" thing would be to implement "fetch
--porcelain", and use its output.

-Peff
