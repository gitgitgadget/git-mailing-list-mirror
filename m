From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] commit caching
Date: Wed, 30 Jan 2013 02:18:39 -0500
Message-ID: <20130130071839.GF11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <CACsJy8BE3LdxbZzdQXuvEJop23KnnLbCTgPos9CywKV7EY2q9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Rwn-0006kk-Um
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab3A3HSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:18:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53836 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3A3HSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:18:44 -0500
Received: (qmail 27557 invoked by uid 107); 30 Jan 2013 07:20:06 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 02:20:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 02:18:39 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BE3LdxbZzdQXuvEJop23KnnLbCTgPos9CywKV7EY2q9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215002>

On Wed, Jan 30, 2013 at 10:31:43AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Jan 29, 2013 at 4:14 PM, Jeff King <peff@peff.net> wrote:
> > The timings from this one are roughly similar to what I posted earlier.
> > Unlike the earlier version, this one keeps the data for a single commit
> > together for better cache locality (though I don't think it made a big
> > difference in my tests, since my cold-cache timing test ends up touching
> > every commit anyway).  The short of it is that for an extra 31M of disk
> > space (~4%), I get a warm-cache speedup for "git rev-list --all" of
> > ~4.2s to ~0.66s.
> 
> Some data point on caching 1-parent vs 2-parent commits on webkit
> repo, 26k commits. With your changes (caching 2-parent commits), the
> .commits file takes 2241600 bytes. "rev-list --all --quiet":

Hmm. My webkit repo has zero merges in it (though it is the older
svn-based one). What percentage of the one you have are merges? How does
your 1-parent cache perform on something like git.git, where about 25%
of all commits are merges?

> The performance loss in 1-parent case is not significant while disk
> saving is (although it'll be less impressive after you do Shawn's
> suggestion not storing SHA-1 directly)

Yeah, I think moving to offsets instead of sha1s is going to be a big
enough win that it won't matter anymore.

-Peff
