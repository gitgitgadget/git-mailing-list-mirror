From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/10] setup: refactor repo format reading and
 verification
Date: Thu, 3 Mar 2016 13:28:33 -0500
Message-ID: <20160303182833.GC24171@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
 <20160301144206.GF12887@sigill.intra.peff.net>
 <CACsJy8B6j2AB5CCBVVz7f1JShq0XVicJfzZvjRO54ksde0RMfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abXzN-0000Wd-85
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbcCCS2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:28:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:54311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757075AbcCCS2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:28:36 -0500
Received: (qmail 8707 invoked by uid 102); 3 Mar 2016 18:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:28:35 -0500
Received: (qmail 8388 invoked by uid 107); 3 Mar 2016 18:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:28:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 13:28:33 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8B6j2AB5CCBVVz7f1JShq0XVicJfzZvjRO54ksde0RMfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288202>

On Thu, Mar 03, 2016 at 08:19:22PM +0700, Duy Nguyen wrote:

> On Tue, Mar 1, 2016 at 9:42 PM, Jeff King <peff@peff.net> wrote:
> > -               for (i = 0; i < unknown_extensions.nr; i++)
> > -                       warning("unknown repository extension: %s",
> > -                               unknown_extensions.items[i].string);
> > -               *nongit_ok = -1;
> > -               ret = -1;
> > +int verify_repository_format(const struct repository_format *format,
> > +                            struct strbuf *err)
> > +{
> > +       if (GIT_REPO_VERSION_READ < format->version) {
> > +               strbuf_addf(err, "Expected git repo version <= %d, found %d",
> > +                           GIT_REPO_VERSION_READ, format->version);
> > +               return -1;
> 
> Since you have given lots of thoughts about this code, perhaps just a
> little bit more, double check if these strings should be translatable
> or not and mark _() if so?

I don't see any reason they cannot be. I prefer not to mix it in with
the other changes, though, so I'll do a patch on top.

-Peff
