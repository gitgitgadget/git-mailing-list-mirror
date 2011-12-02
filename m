From: Jeff King <peff@peff.net>
Subject: Re: Suggestion on hashing
Date: Fri, 2 Dec 2011 13:09:51 -0500
Message-ID: <20111202180951.GC24093@sigill.intra.peff.net>
References: <1322813319.4340.109.camel@yos>
 <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Zaumen <bill.zaumen@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 19:10:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWXYc-0001lF-HR
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 19:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315Ab1LBSJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 13:09:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39081
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757270Ab1LBSJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 13:09:53 -0500
Received: (qmail 8742 invoked by uid 107); 2 Dec 2011 18:16:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Dec 2011 13:16:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Dec 2011 13:09:51 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186236>

On Fri, Dec 02, 2011 at 09:22:31PM +0700, Nguyen Thai Ngoc Duy wrote:

> > So the question is whether
> > using SHA-1 as an ID and SHA-256(?) as a digest is a better long term
> > solution than simply replacing SHA-1.
> 
> I would not stick with any algorithm permanently. No one knows when
> SHA-256 might be broken.

Yeah, you could stick a few bits of algorithm parameter in the beginning
of each identifier. It would mean unique hashes get one character or so
longer (and they would all start with "1", or whatever the identifier
is).

SHA-256 doesn't suffer from SHA-1's problems, though they are based on
related constructions, so I think there is some concern that it may
eventually fail in the same way. SHA-3 is a better bet in that sense,
but it will also be very unproven, even once it is actually
standardized.

> > Replacing SHA-1 with something like SHA-256 sounds easier to implement,
> 
> SHA-1 charateristics (like 20 byte length) are hard coded everywhere
> in git, it'd be a big audit.

In theory, you could truncate a longer hash to 160-bits. It's not the
bit-strength of SHA-1 that is the problem, but the attacks on the
algorithm itself which reduce the bit-strength to something too low.
I would think a truncated result would retain the same cryptographic
properties, as one of the properties of the un-truncated hash is that
changes in the input data are reflected throughout the hash. Some
hashes, like Skein, explicitly have a big internal state, and then just
let you output as many bytes as is appropriate (i.e., being a drop-in
replacement for SHA-1 is an explicit goal).

But I'm not a cryptographer, so there may be some subtle issues with
doing that to arbitrary hash functions.

-Peff
