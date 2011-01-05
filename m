From: Jeff King <peff@peff.net>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 5 Jan 2011 15:53:25 -0500
Message-ID: <20110105205324.GA7808@sigill.intra.peff.net>
References: <ig2kjt$f2u$1@dough.gmane.org>
 <20110105204738.GA7629@sigill.intra.peff.net>
 <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:53:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaaMO-0002Dg-8W
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab1AEUx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:53:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58620 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab1AEUx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:53:27 -0500
Received: (qmail 877 invoked by uid 111); 5 Jan 2011 20:53:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 20:53:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 15:53:25 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164595>

On Wed, Jan 05, 2011 at 12:51:12PM -0800, Shawn Pearce wrote:

> On Wed, Jan 5, 2011 at 12:47, Jeff King <peff@peff.net> wrote:
> >
> > However, in the default configuration, we fetch using a "+" refspec,
> > which forces update of the ref even in the case of a non-fast-forward. I
> > don't know whether that force also would override any lock-checking.
> 
> Nope, it doesn't.  We still use locking to update the refs, to ensure
> the update is seen atomically by a reader.  The + just means don't
> check that the old value is fully reachable from the new after the
> lock as been taken.

Good, that's what IMHO it _should_ do. :)

> If both fetch processes try to update the same ref at the same time,
> one will get the lock and continue, and the other will crash with an
> error (because the lock was busy).  If one is slightly slower than the
> other, they will probably update the refs twice, with the slower fetch
> updating what the faster one had just updated.  :-)

I assumed it would take the "old" value at the very beginning of the
fetch (before talking with the remote), and then see that the ref was
changed under our feet. Or does it simply do it at the end?

... goes to read code ...

-Peff
