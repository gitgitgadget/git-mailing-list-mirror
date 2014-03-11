From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 11 Mar 2014 16:05:14 -0400
Message-ID: <20140311200513.GB29102@sigill.intra.peff.net>
References: <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net>
 <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSvU-0003De-SY
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbaCKUFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:05:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:37592 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755047AbaCKUFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:05:16 -0400
Received: (qmail 27163 invoked by uid 102); 11 Mar 2014 20:05:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Mar 2014 15:05:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2014 16:05:14 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243888>

On Tue, Mar 11, 2014 at 12:32:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the main flag of interest is giving an fnmatch pattern to limit
> > the advertised refs. There could potentially be others, but I do not
> > know of any offhand.
> 
> One thing that comes to mind is where symrefs point at, which we
> failed to add the last time around because we ran out of the
> hidden-space behind NUL.

Yeah, good idea. I might be misremembering some complications, but we
can probably do it with:

  1. Teach the client to send an "advertise-symrefs" flag before the ref
     advertisement.

  2. Teach the server to include symrefs in the ref advertisement; we
     can invent a new syntax because we know the client has asked for
     it.

That does not have to come immediately, though. Done correctly,
upload-pack2 is not about implementing the fnmatch feature, but allowing
arbitrary capability strings from the client before the ref
advertisement starts. So this just becomes an extension that we can add
and advertise during that new phase.

-Peff
