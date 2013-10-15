From: Jeff King <peff@peff.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Mon, 14 Oct 2013 20:54:17 -0400
Message-ID: <20131015005417.GA16502@sigill.intra.peff.net>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
 <20131015001926.GC10415@sigill.intra.peff.net>
 <CACsJy8DgjCR+B+Bvbydns=bCZP5=TU1avPinnuDKqLZXS=4LNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 02:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVsu0-0007up-8H
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab3JOAyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 20:54:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:49437 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738Ab3JOAyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:54:20 -0400
Received: (qmail 28187 invoked by uid 102); 15 Oct 2013 00:54:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 19:54:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 20:54:17 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DgjCR+B+Bvbydns=bCZP5=TU1avPinnuDKqLZXS=4LNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236159>

On Tue, Oct 15, 2013 at 07:49:57AM +0700, Nguyen Thai Ngoc Duy wrote:

> I see this as pack-objects peformance improvements only. If we could
> make pack-objects run like 10% faster (even only with -adf), then it
> may be worth trying. The 10% is a total guess though as I haven't
> checked how much time we spend in searching deltas.

For "repack -ad", generally we don't spend that much time on deltas. It
depends what your pre-repack state is, of course, but I find that most
of the time goes to "counting objects". With "-adf", I would guess that
we easily spend something like 95% of the time on compressing for a
large repository (just try "repack -adf" on the kernel; even with 8
cores it's a half hour or more on my machine, versus about 25 seconds to
count the objects).

So I think you could potentially get a lot of speedup for the "-adf"
case (and likewise "git gc --aggressive").

-Peff
