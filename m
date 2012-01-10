From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Tue, 10 Jan 2012 13:51:05 -0500
Message-ID: <20120110185105.GD15273@sigill.intra.peff.net>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
 <1326123647-18352-2-git-send-email-jengelh@medozas.de>
 <20120109162802.GA2374@sigill.intra.peff.net>
 <7vhb04ek6e.fsf@alter.siamese.dyndns.org>
 <20120109223358.GA9902@sigill.intra.peff.net>
 <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkgmw-0007tN-M1
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab2AJSvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:51:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320Ab2AJSvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:51:08 -0500
Received: (qmail 12634 invoked by uid 107); 10 Jan 2012 18:58:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 13:58:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 13:51:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188279>

On Tue, Jan 10, 2012 at 06:42:11AM +0100, Jan Engelhardt wrote:

> >You only have to implement proper backslash decoding, so I think it is
> >not as hard as reimplementing fnmatch:
> >[...]
> >
> >That being said, if this is such a commonly-requested feature
> 
> Was it actually requested, or did you mean "commonly attempted use"?

Both. I meant in my sentence "if this is such a big problem that we need
to add a check for it, then surely it is something people would like to
be using". But if you peruse the list archives, you can find several
people mentioning that they would like it.

> As I see it, foo/**/*.o for example is equal to placing "*.o" in
> foo/.gitignore, so the feature is already implemented, just not
> through the syntax people falsely assume it is. And that is the
> reason for wanting to output a warning. If it was me, I'd even make
> it use error(), because that is the only way to educate people (and
> it works), but alas, some on the list might consider that too harsh.

Those features aren't exactly equivalent. Off the top of my head, I can
think of a few reasons to prefer using the top-level:

  - you simply prefer it because it keeps your rules grouped in a more
    logical way

  - you don't control the sub-tree (e.g., it is brought in by sub-tree
    merge, or you have an agreement with other devs not to touch things
    in it. Also, I don't think .gitignores cross submodule boundaries
    currently, but it is something that could happen eventually).

  - you can write more complex rules with "**" that would otherwise
    necessitate writing multiple rules split across directories

Don't get me wrong. I am not a huge proponent of "**", and I could
really care less if we implement it or not, and we have survived many
years without it. It just seems to me that if it's worth warning about,
it's worth implementing.

-Peff
