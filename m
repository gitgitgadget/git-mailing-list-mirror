From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 54/67] color: add overflow checks for parsing colors
Date: Fri, 18 Sep 2015 15:01:16 -0400
Message-ID: <20150918190116.GA3932@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160703.GB29753@sigill.intra.peff.net>
 <CAPig+cQUwsDfL-epJYy+4xoG2-GfDfhb3mH=7WAzYbsea-sXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd0uR-0007gS-H0
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbIRTBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:01:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:33298 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659AbbIRTBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:01:18 -0400
Received: (qmail 18744 invoked by uid 102); 18 Sep 2015 19:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 14:01:18 -0500
Received: (qmail 10599 invoked by uid 107); 18 Sep 2015 19:01:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 15:01:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Sep 2015 15:01:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQUwsDfL-epJYy+4xoG2-GfDfhb3mH=7WAzYbsea-sXDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278215>

On Fri, Sep 18, 2015 at 02:54:11PM -0400, Eric Sunshine wrote:

> > @@ -224,12 +227,18 @@ int color_parse_mem(const char *value, int value_len, char *dst)
> >                         goto bad;
> >         }
> >
> > +#define OUT(x) do { \
> > +       if (dst == end) \
> > +               die("BUG: color parsing ran out of space"); \
> > +       *dst++ = (x); \
> > +} while(0)
> 
> Hmm, can we have an #undef OUT before the #define OUT(...), or choose
> a less conflict-likely name? In particular, I'm thinking about
> preprocessor namespace pollution arising from sources out of our
> control, such as was the case with 414382f (ewah/bitmap: silence
> warning about MASK macro redefinition, 2015-06-03).

Sure. I wouldn't think any headers would be dumb enough to define
something as short and common as OUT. But then I would have said the
same about MASK. ;)

I added an #undef, and I added an #undef at the end of the function, as
well (to clean up after ourselves).

-Peff
