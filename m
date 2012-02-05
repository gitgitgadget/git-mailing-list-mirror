From: Jeff King <peff@peff.net>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 5 Feb 2012 18:50:44 -0500
Message-ID: <20120205235044.GB28735@sigill.intra.peff.net>
References: <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <CAMP44s2r-fcnfpdT4u5U7TwF1z6Abp+J1U7oqfsSrYMuD6weOQ@mail.gmail.com>
 <20120204232015.GB1170@sigill.intra.peff.net>
 <CAMP44s0xmvjxsE6AYrA5qTZuDfWq8vPDPOo69hiRS+xWbsbS7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 00:50:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuBr8-00087p-QN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 00:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab2BEXuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 18:50:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58447
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab2BEXuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 18:50:46 -0500
Received: (qmail 20743 invoked by uid 107); 5 Feb 2012 23:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 18:57:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 18:50:44 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0xmvjxsE6AYrA5qTZuDfWq8vPDPOo69hiRS+xWbsbS7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189987>

On Sun, Feb 05, 2012 at 11:11:20PM +0200, Felipe Contreras wrote:

> > Because of the calling convention of map_user, the buffer with the input
> > must also be writable (since it holds the result). So there should be no
> > loss of efficiency to convert the ">" into a "\0" (and in fact, the
> > simplest fix is probably to just have map_user "tie off" any ">" it
> > detects).
> 
> Yes, but then the caller (git blame) would need to _always_ do that
> conversion before (">" -> "\0"), and after ("\0" -> ">"), as opposed
> to now, that it does the conversion only when map_user succeeds (or
> checks if it has to do it).

Yes, I'm talking about changing the calling and return conventions of
map_user. I think the efficiency change is negligible, though, as we
are talking about character assignments (and in fact, it would probably
end up more efficient, as we could eliminate some copying inside
map_user). But Junio's patch is simple, and fixes the problem without
creating any complexity for the callers. So I think it's a good fix.

-Peff
