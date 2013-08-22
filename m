From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] index-pack: optionally reject packs with duplicate
 objects
Date: Thu, 22 Aug 2013 10:43:05 -0400
Message-ID: <20130822144305.GA21219@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
 <20130821205220.GB28165@sigill.intra.peff.net>
 <CACsJy8DkUeS3s+X=gKX4ZAi82g_D_9t=bBVs8NNY2EeqM9W-rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 16:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCW6U-0005L4-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 16:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab3HVOnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 10:43:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:56671 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab3HVOnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 10:43:09 -0400
Received: (qmail 29285 invoked by uid 102); 22 Aug 2013 14:43:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Aug 2013 09:43:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Aug 2013 10:43:05 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DkUeS3s+X=gKX4ZAi82g_D_9t=bBVs8NNY2EeqM9W-rQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232767>

On Thu, Aug 22, 2013 at 08:45:19PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Thu, Aug 22, 2013 at 3:52 AM, Jeff King <peff@peff.net> wrote:
> > @@ -68,6 +81,16 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
> >         else
> >                 sorted_by_sha = list = last = NULL;
> >
> > +       if (opts->duplicates == WRITE_IDX_DUPLICATES_REJECT) {
> > +               struct pack_idx_entry **dup;
> > +
> > +               dup = find_duplicate(sorted_by_sha, nr_objects,
> > +                                    sizeof(*sorted_by_sha), sha1_compare);
> > +               if (dup)
> > +                       die("pack has duplicate entries for %s",
> > +                           sha1_to_hex((*dup)->sha1));
> > +       }
> > +
> >         if (opts->flags & WRITE_IDX_VERIFY) {
> >                 assert(index_name);
> >                 f = sha1fd_check(index_name);
> 
> write_idx_file() is called after index-pack processes all delta
> objects. Could resolve_deltas() go cyclic with certain duplicate
> object setup?

Good question. I'm not sure. I'll check it out.

-Peff
