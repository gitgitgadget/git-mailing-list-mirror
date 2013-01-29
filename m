From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 06:13:22 -0500
Message-ID: <20130129111322.GB11055@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <5107A36D.2050307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 29 12:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U098N-00057k-TT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 12:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3A2LN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 06:13:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53310 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab3A2LNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 06:13:25 -0500
Received: (qmail 20663 invoked by uid 107); 29 Jan 2013 11:14:48 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 06:14:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 06:13:22 -0500
Content-Disposition: inline
In-Reply-To: <5107A36D.2050307@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214929>

On Tue, Jan 29, 2013 at 11:24:45AM +0100, Michael Haggerty wrote:

> On 01/29/2013 10:16 AM, Jeff King wrote:
> > When we are doing a commit traversal that does not need to
> > look at the commit messages themselves (e.g., rev-list,
> > merge-base, etc), we spend a lot of time accessing,
> > decompressing, and parsing the commit objects just to find
> > the parent and timestamp information. We can make a
> > space-time tradeoff by caching that information on disk in a
> > compact, uncompressed format.
> > 
> > TODO: document on-disk format in Documentation/technical
> > TODO: document API
> 
> Would this be a good place to add the commit generation number that is
> so enthusiastically discussed on the mailing list from time to time?

Yes, that is one of my goals. We may even be able to just replace the
timestamp field in the cache with a generation number. When it gets
pretty-printed we pull it out of the commit message again anyway, so in
theory the only use inside "struct commit" is for ordering. But I
haven't looked at all of the use sites yet to be sure nobody is
depending on it being an actual date stamp.

-Peff
