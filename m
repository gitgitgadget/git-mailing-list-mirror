From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 9/9] clone: run check_everything_connected
Date: Tue, 26 Mar 2013 18:24:31 -0400
Message-ID: <20130326222431.GB16457@sigill.intra.peff.net>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202627.GI16019@sigill.intra.peff.net>
 <CACsJy8CbBeuHmkEJs4FqGJs_kqEcjKi7RJkp9eNorxJAqgiCrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 23:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKcIi-0006vq-CE
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab3CZWYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:24:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40794 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3CZWYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:24:35 -0400
Received: (qmail 9060 invoked by uid 107); 26 Mar 2013 22:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 18:26:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 18:24:31 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CbBeuHmkEJs4FqGJs_kqEcjKi7RJkp9eNorxJAqgiCrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219224>

On Tue, Mar 26, 2013 at 07:53:42AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 26, 2013 at 3:26 AM, Jeff King <peff@peff.net> wrote:
> >  static void update_remote_refs(const struct ref *refs,
> >                                const struct ref *mapped_refs,
> >                                const struct ref *remote_head_points_at,
> >                                const char *branch_top,
> >                                const char *msg)
> >  {
> > +       const struct ref *rm = mapped_refs;
> > +
> > +       if (check_everything_connected(iterate_ref_map, 0, &rm))
> > +               die(_("remote did not send all necessary objects"));
> > +
> >         if (refs) {
> >                 write_remote_refs(mapped_refs);
> >                 if (option_single_branch)
> 
> Maybe move this after checkout, so that I can switch terminal and
> start working while it's verifying? And maybe an option not to
> check_everything_connected, instead print a big fat warning telling
> the user to fsck later?

I tried to follow the fetch process of not installing the refs until we
had verified that the objects were reasonable. It probably doesn't
matter that much for clone, since you would not have simultaneous users
expecting the repository to be in a reasonable state until after clone
completes, though.

We also would have to tweak check_everything_connected, which does
something like "--not --all" to avoid rechecking objects we already
have. But that is not too hard to do.

-Peff
