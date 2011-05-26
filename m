From: Jeff King <peff@peff.net>
Subject: Re: Git-Mediawiki : Question about Jeff King's import script
Date: Thu, 26 May 2011 11:42:14 -0400
Message-ID: <20110526154214.GA4049@sigill.intra.peff.net>
References: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Claire Fousse <claire.fousse@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 17:42:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcha-0001oU-Pp
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab1EZPmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:42:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59406
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab1EZPmR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:42:17 -0400
Received: (qmail 12850 invoked by uid 107); 26 May 2011 15:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 11:42:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 11:42:14 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174524>

On Thu, May 26, 2011 at 05:18:11PM +0200, Claire Fousse wrote:

> We based our script on what you called a few months ago the "quick and
> dirty perl script" for the import part and have a few questions about
> it.
> First of all, just in case, here is your original script :
> http://article.gmane.org/gmane.comp.version-control.git/167560
> 
> It seems like you first used a hashmap for it to be transformed later
> into a flat list / array. What is the reasoning behind this ? Why not
> create an array right away ?

The hashmap is actually backed by an on-disk key/value database.  The
purpose of this was to allow resuming an import that had failed in the
middle (since even for a moderate-sized wiki like the git wiki, the
import was quite slow).

So the hashmap is indexed by page id, and each value contains an array
of revisions for that page. If we see a page id that we've already done,
we can skip importing it.

If you wanted to do it all at once, yes, you could build a flat array of
revisions, with each revision mentioning the page that it came from, and
just keep appending to the array as you read more data from the wiki.
And then at the end, sort that array based on timestamp to get the
chronological ordering of changes.

Hope that helps,
-Peff
