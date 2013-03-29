From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] dir.c::match_basename(): pay attention to the length
 of string parameters
Date: Thu, 28 Mar 2013 23:02:17 -0400
Message-ID: <20130329030217.GA1851@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214728.GB10936@sigill.intra.peff.net>
 <CACsJy8CcTqkPeOZ7Xa=7J4BH4sSFD6X6hKjrLz3kf0J0E_J+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 04:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULPaf-0008KD-T4
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 04:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3C2DCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 23:02:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44324 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773Ab3C2DCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 23:02:24 -0400
Received: (qmail 32709 invoked by uid 107); 29 Mar 2013 03:04:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 23:04:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 23:02:17 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CcTqkPeOZ7Xa=7J4BH4sSFD6X6hKjrLz3kf0J0E_J+cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219480>

On Fri, Mar 29, 2013 at 08:25:00AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Fri, Mar 29, 2013 at 4:47 AM, Jeff King <peff@peff.net> wrote:
> > +static int fnmatch_icase_mem(const char *pattern, int patternlen,
> > +                            const char *string, int stringlen,
> > +                            int flags)
> > +{
> > +       int match_status;
> > +       struct strbuf pat_buf = STRBUF_INIT;
> > +       struct strbuf str_buf = STRBUF_INIT;
> > +       const char *use_pat = pattern;
> > +       const char *use_str = string;
> > +
> > +       if (pattern[patternlen]) {
> > +               strbuf_add(&pat_buf, pattern, patternlen);
> > +               use_pat = pat_buf.buf;
> > +       }
> > +       if (string[stringlen]) {
> > +               strbuf_add(&str_buf, string, stringlen);
> > +               use_str = str_buf.buf;
> > +       }
> > +
> > +       match_status = fnmatch_icase(use_pat, use_str, 0);
> 
> You should pass flags in here instead of 0.

Eek, yeah, that's obviously wrong. Thanks for catching it. Fixing that
clears up all of the test failures outside of t5002.

And if you move patch 5 ("special case paths that end with a slash")
into position 2, it cleans up the mid-series failures of t5002, making
the series clean for later bisecting.

Thanks for looking it over.

-Peff
