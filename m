From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/9] add strip_suffix function
Date: Wed, 2 Jul 2014 12:38:32 -0400
Message-ID: <20140702163832.GC14404@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
 <20140630165751.GB16637@sigill.intra.peff.net>
 <xmqqlhsbiwmz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NYM-00071E-GB
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbaGBQie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:38:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:54954 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751717AbaGBQie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:38:34 -0400
Received: (qmail 23186 invoked by uid 102); 2 Jul 2014 16:38:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jul 2014 11:38:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2014 12:38:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlhsbiwmz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252794>

On Wed, Jul 02, 2014 at 08:54:44AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For that reason, the "mem" form puts its length parameter
> > next to the buffer (since they are a pair), and the string
> > form puts it at the end (since it is an out-parameter). The
> > compiler can notice when you get the order wrong, which
> > should help prevent writing one when you meant the other.
> 
> Very sensible consideration.  I like commits that careful thinking
> behind them shows through them.

I would like to take credit for advanced thinking, but I actually did
what felt natural, and only noticed the "compiler will tell you when you
are wrong" effect when I got it wrong while writing a later patch in the
series. :)

> If we want to avoid implying NUL-termination, the only way to do so
> would be to use wording that does not hint shortening.  At least for
> the C-string variant, which is measuring the length of the basename
> part (i.e. `basename $str $suffix`) without touching anything else,
> e.g. basename_length("hello.c", ".c", &len), but at the same time
> you want to make it a boolean to signal if the string ends with the
> suffix, so perhaps has_suffix("hello.c", ".c", &len)?

I think that invites some confusion with "ends_with", which is the same
thing (but just does not take the "len" parameter). We could just add
this feature to ends_with, and ask callers who do not care to pass NULL,
but that makes those call sites uglier.

Having had a day to mull it over, and having read your email, I think I
still prefer strip_suffix.

-Peff
