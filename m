From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Mon, 8 Nov 2010 22:03:58 -0500
Message-ID: <20101109030358.GA17747@sigill.intra.peff.net>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
 <20101022192529.GA13059@sigill.intra.peff.net>
 <7v8w1plwq0.fsf@alter.siamese.dyndns.org>
 <20101108223322.GA12258@sigill.intra.peff.net>
 <7vlj53nwjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 04:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFeUL-0000rT-0w
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 04:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab0KIDDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 22:03:07 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60429 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab0KIDDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 22:03:06 -0500
Received: (qmail 3865 invoked by uid 111); 9 Nov 2010 03:03:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Nov 2010 03:03:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 22:03:58 -0500
Content-Disposition: inline
In-Reply-To: <7vlj53nwjl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161013>

On Mon, Nov 08, 2010 at 04:57:34PM -0800, Junio C Hamano wrote:

> The new text indeed looks much clearer, except for one part I am not
> absolutely sure...
> 
> > +new content::
> > +
> > +You may also add new content that does not exist in the patch. Simply
> > +add new lines, each starting with "{plus}".
> > +
> > +You can also perform more complex operations, such as modifying the
> > +content to be staged by a "{plus}" line. However, note that this impacts
> > +_only_ the index; the working tree file will remain unchanged, and will
> > +appear to "undo" the content you have staged. Such operations should be
> > +performed only if you know what you are doing.
> 
> This "However, note that" part should apply not only to newly introduced
> {plus} lines but also to {plus} lines whose change were edited (lines from
> "added content" and from post-image half of "modified content"), no?

Right. The final paragraph you quoted is not part of the list, and it
looks better when rendered by asciidoc, as it's indented differently. So
I think some of the confusion is from the source formatting. But...

> I tried to be careless when reading the two paragraphs above, and managed
> to get an incorrect impression that the caveat applies only to "more
> complex operations", even though it actually applies not just the previous
> "new content" but also "added/modified" content.
> 
> Thinking about it a bit more, it is worse than that.  Turning " " into "-"
> has the same "getting reverted" issue, no?

Yeah, some of the operations described in the upper list are actually
"more complex" in the sense of looking like reverts. Basically any time
you are _introducing_ a change during the diff edit rather than simply
selecting or not-selecting changes that exist in the working tree, you
are going to get confusing results. So let me take one more stab at it,
and I think the correct breakdown is:

  1. stuff you might want to do: staging or not staging added, removed,
     and modified lines

  2. stuff you might want to do if you're insane: marking context lines
     for removal, adding new content, changing content on existing add
     lines

  3. stuff that you never want to do, because it makes the patch
     impossible to apply: deleting, adding, or changing context or
     removal lines

I'll try to do a patch later tonight.

-Peff
