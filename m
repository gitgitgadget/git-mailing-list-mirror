From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] fast-export: use object to uint32 map instead of
 "decorate"
Date: Fri, 15 Jul 2011 16:00:44 -0400
Message-ID: <20110715200044.GB356@sigill.intra.peff.net>
References: <20110714173454.GA21657@sigill.intra.peff.net>
 <20110714175211.GB21771@sigill.intra.peff.net>
 <CAGdFq_guf8fa014t17KyNoEzpCAK-aG5BrpQ40tQ=1507OJ8bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhoZA-0001sx-Qg
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1GOUAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:00:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55152
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372Ab1GOUAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:00:47 -0400
Received: (qmail 25950 invoked by uid 107); 15 Jul 2011 20:01:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 16:01:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 16:00:44 -0400
Content-Disposition: inline
In-Reply-To: <CAGdFq_guf8fa014t17KyNoEzpCAK-aG5BrpQ40tQ=1507OJ8bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177221>

On Fri, Jul 15, 2011 at 11:40:02AM +0200, Sverre Rabbelier wrote:

> On Thu, Jul 14, 2011 at 19:52, Jeff King <peff@peff.net> wrote:
> > Previously we encoded the "mark" mapping inside the "void *"
> > field of a "struct decorate". It's a little more natural for
> > us to do so using a data structure made for holding actual
> > values.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > And this is an example of use. It doesn't save all that much code, but I
> > think it's a little more natural. It can also save some bytes of the hash
> > value in each entry if your pointers are larger than 32-bit.
> 
> Did you run any benchmarks on this?

No, I didn't. I expect it to be exactly the same on x86_64. We save
32-bits of pointer space, but the generality I mentioned in patch 1
wastes 32-bits of space for the "used" flag. So it evens out,
space-wise.

The time complexity should be exactly the same (the macro definitions
are more or less the exact decorate code, but with the types
parameterized, so the generated code should be the same).

But I'm not sure this code is going to end up used, anyway. It looks
like we might add a generation header after all.

-Peff
