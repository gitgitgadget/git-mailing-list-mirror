From: Jeff King <peff@peff.net>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 25 Sep 2013 05:12:59 -0400
Message-ID: <20130925091259.GA5844@sigill.intra.peff.net>
References: <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
 <5230AD23.2050009@bracey.fi>
 <20130911182444.GD4326@google.com>
 <5230C6E3.3080406@bracey.fi>
 <xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
 <xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
 <20130920033541.GC15101@sigill.intra.peff.net>
 <xmqqioxwqec0.fsf@gitster.dls.corp.google.com>
 <20130920051107.GA17609@sigill.intra.peff.net>
 <xmqqeh8jqt38.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Bracey <kevin@bracey.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 11:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOl9g-0000jz-MA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 11:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab3IYJNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 05:13:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:35709 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3IYJND (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 05:13:03 -0400
Received: (qmail 25513 invoked by uid 102); 25 Sep 2013 09:13:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Sep 2013 04:13:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Sep 2013 05:12:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh8jqt38.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235339>

On Fri, Sep 20, 2013 at 10:51:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > My original question was going to be: why bother peeling at all if we
> > are just going to push the outer objects, anyway?
> >
> > And after staring at it, I somehow convinced myself that the answer was
> > that you were pushing both. But that is not the case. Sorry for the
> > noise.
> 
> But that is still a valid point, and the patch to avoid peeling for
> non symmetric diff does not look too bad, either.
> 
>  revision.c               | 59 ++++++++++++++++++++++++++++++------------------
>  t/t6000-rev-list-misc.sh |  8 +++++++
>  2 files changed, 45 insertions(+), 22 deletions(-)

FWIW, the flow of this version makes more sense to me. It also allows
things like:

  git rev-list --objects $blob..$tree

which I cannot see anybody actually wanting, but it somehow seems
simpler to me to say "A..B" is syntactic sugar for "^B A", without
qualifying "except that A and B must be commit-ishes".

-Peff
