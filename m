From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 10:33:57 -0400
Message-ID: <20110329143357.GA10771@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <201103291439.17197.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 16:34:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Zzi-0005Ja-HA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 16:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab1C2OeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 10:34:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41319
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab1C2Od7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 10:33:59 -0400
Received: (qmail 27960 invoked by uid 107); 29 Mar 2011 14:34:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 10:34:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 10:33:57 -0400
Content-Disposition: inline
In-Reply-To: <201103291439.17197.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170271>

On Tue, Mar 29, 2011 at 02:39:17PM +0200, Johan Herland wrote:

> On Tuesday 29 March 2011, Michael J Gruber wrote:
> > As notes become increasingly popular, it's often interesting to show
> > notes from a particular notes ref only. Introduce '--notes-ref=<ref>'
> > as a convenience shortcut for '--no-standard-notes
> > --show-notes=<ref>'.
> >
> > Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> > ---
> > The idea is to use the same name as in "git notes --ref=<ref>" but
> > make it clear for the rev-list option to be about notes, thus
> > "--notes-ref=<ref>".
> 
> The idea and implementation look good to me. Not sure I like the 
> option "bloat" (somehow feels it should be possible to express the same 
> behavior using fewer options), but if there's not a better way to 
> reorganize the options, then you can consider it Acked-by me.

I feel this would be more consistent with most other options that take
an optional argument:

  1. "--show-notes" uses default refs

  2. "--show-notes=<ref>" shows _just_ <ref>, no defaults

  3. "--show-notes=<ref1> --show-notes=<ref2>" shows <ref1> and <ref2>

  4. (Probably) "--show-notes --show-notes=<ref>" should show default
     refs and <ref>. This is the one I'm least sure of, as it leaves no
     way to override what came earlier on the command line (which is
     useful if, for example, we end up with Michael's proposed ui.log).
     Perhaps "--no-notes" would reset, so:

       --show-notes --no-notes --show-notes=<ref>

     would be equivalent to:

       --show-notes=<ref>

Of course a total behavior change of what --show-notes currently does.

Speaking of which, it is kind of weird that --show-notes is negated by
--no-notes. So maybe it makes sense to introduce "--notes[=<ref>]" to do
what I wrote above, and deprecate --show-notes.

-Peff
