From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import deltas
Date: Wed, 2 Apr 2014 07:10:03 +0900
Message-ID: <20140401221003.GA5923@glandium.org>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
 <20140401141856.GA2497@glandium.org>
 <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 00:10:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV6sz-0000EK-P8
	for gcvg-git-2@plane.gmane.org; Wed, 02 Apr 2014 00:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaDAWKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 18:10:21 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49152 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639AbaDAWKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 18:10:20 -0400
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WV6se-0001ao-T2; Wed, 02 Apr 2014 07:10:04 +0900
Content-Disposition: inline
In-Reply-To: <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245664>

On Tue, Apr 01, 2014 at 10:14:02AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Tue, Apr 01, 2014 at 09:15:12AM -0400, Jeff King wrote:
> >> > It seems to me fast-import keeps a kind of human readable format for its
> >> > protocol, i wonder if xdelta format would fit the bill. That being said,
> >> > I also wonder if i shouldn't just try to write a pack on my own...
> >> 
> >> The fast-import commands are human readable, but the blob contents are
> >> included inline. I don't see how sending a binary delta is any worse
> >> than sending a literal binary blob over the stream.
> >
> > OTOH, the xdelta format is not exactly straightforward to produce, with
> > the variable length encoding of integers. Not exactly hard, but when
> > everything else in fast-import is straightforward, one has to wonder.
> 
> Unless you already have your change in the xdelta on hand, or the
> format your foreign change is in gives sufficient information to
> produce a corresponding xdelta without looking at the content that
> your foreign change applies to, it is silly to try to convert your
> foreign change into xdelta and feed it to fast-import.
> 
> What constitutes "sufficient" information?  The xdelta format is a
> series of instructions that lets you:
> 
>  - copy N bytes from offset in the source material to the
>    destination; or
>  - copy these N literal bytes to the destination.
> 
> to an existing piece of content, identified by the object name of
> the "source material", to produce a result of "applying delta".

The patch format I'm getting from mercurial boils down to:
  - replace N bytes from offset in the source material with the given
    M bytes.
Which can easily be converted to xdelta without looking at the original.

Mike
