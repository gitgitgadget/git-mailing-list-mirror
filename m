From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 08:05:40 -0400
Message-ID: <20130329120539.GA20711@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
 <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avila.jn@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 13:06:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULY4a-0006DA-T2
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 13:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab3C2MFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 08:05:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48227 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749Ab3C2MFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 08:05:51 -0400
Received: (qmail 5240 invoked by uid 107); 29 Mar 2013 12:07:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 08:07:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 08:05:40 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219497>

On Fri, Mar 29, 2013 at 03:45:35PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Fri, Mar 29, 2013 at 4:48 AM, Jeff King <peff@peff.net> wrote:
> > -       return fnmatch_icase(pattern, name, FNM_PATHNAME) == 0;
> > +       return fnmatch_icase_mem(pattern, patternlen,
> > +                                name, namelen,
> > +                                FNM_PATHNAME) == 0;
> >  }
> 
> I think you (or Junio) should rebase this on maint. Since c41244e
> (included in maint), this call is turned to wildmatch(WM_PATHNAME) and
> WM_PATHNAME is _not_ the same as FNM_PATHNAME for patterns like
> "foo/**/bar". A diff between next and pu shows me that WM_PATHNAME is
> incorrectly converted to FNM_PATHNAME. I hope that is the cause of all
> breakages Junio found out on pu.

I don't think we want to rebase; the regression is in the v1.8.1 series,
and I suspected that Junio was planning to ship a v1.8.1.6 with the fix.
The wildmatch code comes in v1.8.2.

So we would want to do any adjustment to the fix when we merge up to
maint.

-Peff
