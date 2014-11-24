From: Jeff King <peff@peff.net>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Mon, 24 Nov 2014 10:51:08 -0500
Message-ID: <20141124155108.GC25912@peff.net>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com>
 <54730546.7000200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Git Mailing List <git@vger.kernel.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 16:51:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsvv0-00077X-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 16:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaKXPvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 10:51:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:44106 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753138AbaKXPvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 10:51:09 -0500
Received: (qmail 28955 invoked by uid 102); 24 Nov 2014 15:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 09:51:09 -0600
Received: (qmail 17860 invoked by uid 107); 24 Nov 2014 15:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 10:51:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 10:51:08 -0500
Content-Disposition: inline
In-Reply-To: <54730546.7000200@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260130>

On Mon, Nov 24, 2014 at 11:15:34AM +0100, Michael J Gruber wrote:

> > I wonder if we can have an option to sign all blob content of the tree
> > associated to a commit, and the content of parent commit(s). It's more
> > expensive than signing just commit/tag content. But it's also safer
> > without completely ditching SHA-1.
> > 
> 
> This amounts to hashing the blob content with whatever hash you told
> your gpg to use (hopefully not sha1 ;) ) and signing that.

Right. You could also create a graph of SHA-256 (or whatever) object
hashes and sign that. I.e., create a parallel to git's trees using
SHA-256 and include a single:

  object-256 ....

line in the tag header. That still involves re-hashing all of the data,
but it would at least be possible to cache (i.e., a mapping of SHA-1 to
SHA-256 hashes). Of course one way to keep that caching layer up to date
would be to just calculate the SHA-256 along with the SHA-1 whenever we
create an object. And then you can sprinkle SHA-256 links in other
places, too, like commit objects.

And now you are halfway down the road to a combined SHA-1/SHA-256 git.
:)

The tricky thing is fitting the extra hash into the tree objects. And of
course the rules for actually generating and/or sending extra objects.

-Peff
