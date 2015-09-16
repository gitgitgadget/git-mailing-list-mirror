From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Wed, 16 Sep 2015 13:23:47 -0400
Message-ID: <20150916172347.GA2234@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152629.GH29753@sigill.intra.peff.net>
 <55F84D9B.90004@ramsayjones.plus.com>
 <20150915175027.GA31091@sigill.intra.peff.net>
 <xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
 <c62ef479c559cb040628fc4ede5b151b@dscho.org>
 <20150916103350.GF13966@sigill.intra.peff.net>
 <xmqq613as399.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 19:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcGR6-0002kO-CW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 19:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbIPRX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 13:23:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:60104 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752636AbbIPRXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 13:23:55 -0400
Received: (qmail 13412 invoked by uid 102); 16 Sep 2015 17:23:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 12:23:55 -0500
Received: (qmail 20053 invoked by uid 107); 16 Sep 2015 17:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 13:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 13:23:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqq613as399.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278037>

On Wed, Sep 16, 2015 at 10:06:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Sep 16, 2015 at 10:15:02AM +0200, Johannes Schindelin wrote:
> >
> >> Maybe we should stick to the established practice of the many, many
> >> reentrant POSIX functions following the *_r() naming convention? I.e.
> >> the reentrant version of localtime() is called localtime_r(), the
> >> reentrant version of random() is called random_r() etc.
> >> 
> >> So I could see myself not needing an explanation if I had read
> >> sha1_to_hex_r(...).
> >
> > I like this suggestion. By itself, the "_r" does not communicate as much
> > as "_to" to me, but as long as the reader knows the "_r" idiom, it
> > communicates much more.
> >
> > I'll switch to this unless there is any objection.
> 
> Fine by me.  Thanks.

I started on this, but realized something interesting as I was updating
the docstrings. sha1_to_hex_r is truly reentrant. But
find_unique_abbrev_r is not, as it calls has_sha1_file(), which touches
lots of global data for the object lookup.

I think it's probably OK, as long as I don't make the claim that it is
truly reentrant.

-Peff
