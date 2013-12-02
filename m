From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit-slab: sizeof() the right type in xrealloc
Date: Mon, 2 Dec 2013 10:35:13 -0500
Message-ID: <20131202153513.GA24202@sigill.intra.peff.net>
References: <cover.1385405977.git.tr@thomasrast.ch>
 <f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
 <CACsJy8CnxvPRwC_xXgBNF_JEmkpfnk=faMwOWtkJOFU-18aHgA@mail.gmail.com>
 <87siucpalo.fsf_-_@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 02 16:35:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnVWr-0004VR-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 16:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3LBPfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 10:35:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:49073 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751636Ab3LBPfP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 10:35:15 -0500
Received: (qmail 23374 invoked by uid 102); 2 Dec 2013 15:35:15 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Dec 2013 09:35:15 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Dec 2013 10:35:13 -0500
Content-Disposition: inline
In-Reply-To: <87siucpalo.fsf_-_@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238636>

On Sun, Dec 01, 2013 at 09:41:55PM +0100, Thomas Rast wrote:

> When allocating the slab, the code accidentally computed the array
> size from s->slab (an elemtype**).  The slab is an array of elemtype*,
> however, so we should take the size of *s->slab.

Looks obviously correct.

> I browsed around for a while, and couldn't find out whether any
> architecture actually has any hope of running git (i.e. is at least
> mostly POSIX conformant) but still violates the assumption that all
> pointers[*] are the same size.
> 
> The comp.lang.c FAQ has some interesting examples of wildly different
> pointer representations at:
> 
>   http://c-faq.com/null/machexamp.html

Note that most of those examples are not different sizes, but rather
different null-pointer representations. We are already grossly out of
compliance with the standard there, as we typically use memset() to
zero-out structs with pointers.

-Peff
