From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling
 command_close_bidi_pipe
Date: Tue, 12 Feb 2013 16:17:59 -0500
Message-ID: <20130212211759.GA30329@sigill.intra.peff.net>
References: <cover.1360677646.git.mina86@mina86.com>
 <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com>
 <20130212205141.GC25330@sigill.intra.peff.net>
 <7va9r9fd4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:18:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5NFa-0002LI-Qp
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982Ab3BLVSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:18:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037Ab3BLVSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:18:02 -0500
Received: (qmail 6206 invoked by uid 107); 12 Feb 2013 21:19:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 16:19:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:17:59 -0500
Content-Disposition: inline
In-Reply-To: <7va9r9fd4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216205>

On Tue, Feb 12, 2013 at 01:14:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 12, 2013 at 03:02:31PM +0100, Michal Nazarewicz wrote:
> >
> >>  sub command_close_bidi_pipe {
> >>  	local $?;
> >>  	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
> >> -	_cmd_close($ctx, $in, $out);
> >> +	_cmd_close($ctx, grep defined, $in, $out);
> >
> > Maybe it is just me, but I find the "grep EXPR" form a little subtle
> > inside an argument list. Either:
> >
> >   _cmd_close($ctx, grep { defined } $in, $out);
> >
> > or
> >
> >   _cmd_close($ctx, grep(defined, $in, $out));
> >
> > is a little more obvious to me.
> 
> I would actually vote for the most explicit:
> 
> 	_cmd_close($ctx, (grep { defined } ($in, $out)));

Gross. My perl spider-sense tingles at seeing that many optional
punctuation characters, but it should at least be obvious to a casual or
new perl programmer what is going on. I'm fine with it.

-Peff
