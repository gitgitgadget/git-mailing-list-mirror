From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Suggestion on hashing
Date: Sat, 3 Dec 2011 15:34:44 -0000
Organization: OPDS
Message-ID: <68774CC59ECA4F7AB5DA410F34045F32@PhilipOakley>
References: <1322813319.4340.109.camel@yos> <20111202175444.GB24093@sigill.intra.peff.net> <1322877021.1729.118.camel@yos> <20111203150842.GA4442@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <pclouds@gmail.com>,
	"Jeff King" <peff@peff.net>
To: "Bill Zaumen" <bill.zaumen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 16:34:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWrbV-0002dJ-Iv
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 16:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab1LCPeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 10:34:12 -0500
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:12885 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591Ab1LCPeM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2011 10:34:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnQBAG1A2k5Z8rNB/2dsb2JhbABEFoRvhU2PNY8OgReBBoFtBQEBBAEIAQEZFR4BASEFBgIDBQIBAxQBAwICBSECAhQBBBoGBxcGEwgCAQIDAYd2AgakKJEVgTCIWzNjBIxxKJlb
X-IronPort-AV: E=Sophos;i="4.71,290,1320624000"; 
   d="scan'208";a="510555161"
Received: from host-89-242-179-65.as13285.net (HELO PhilipOakley) ([89.242.179.65])
  by out1.ip08ir2.opaltelecom.net with SMTP; 03 Dec 2011 15:34:09 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186254>

Had you seen the recent thread by Junio with the footnote link to the paper 
on reconcilliation by using multiple hashes?
http://article.gmane.org/gmane.linux.kernel/1214517.
"What's the Difference? Efficient Set Reconciliation without Prior
Context" http://cseweb.ucsd.edu/~fuyeda/papers/sigcomm2011.pdfIt looks to 
have a lot of the properties being sought, and links with other git aspects.

Philip

From: "Jeff King" <peff@peff.net>: Saturday, December 03, 2011 3:08 PM
On Fri, Dec 02, 2011 at 05:50:21PM -0800, Bill Zaumen wrote:

> On Fri, 2011-12-02 at 12:54 -0500, Jeff King wrote:
> > On Fri, Dec 02, 2011 at 12:08:39AM -0800, Bill Zaumen wrote:
>
> > I think your code is solving the wrong problem (or solving the right
> > problem in a half-way manner). The only things that make sense to me
> > are:
> >
> >   1. Do nothing. SHA-1 is probably not broken yet, even by the NSA, and
> >      even if it is, an attack is extremely expensive to mount. This may
> >      change in the future, of course, but it will probably stay
> >      expensive for a while.
> >
> >   2. Decouple the object identifier and digest roles, but insert the
> >      digest into newly created objects, so it can be part of the
> >      signature chain. I described such a scheme in one of my replies to
> >      you. It has some complexities, but has the bonus that we can build
> >      directly on older history, preserving its sha1s.
> >
> >   3. Replace SHA-1 with a more secure algorithm.
>
> Suppose I make the digest pluggable, something I intended to do
> eventually anyway?  Then you just use the existing SHA-1 as an
> object identifier and the new digest in a signature chain?  What I
> did was essentially to compute the new digest (using a CRC as the
> trivial case) whenever an object's SHA-1 hash is computed, plus
> using the new digest for low-cost collision checks.

If you make the digest stronger (or pluggable) and include it in the
actual objects themselves, then you have a start on (2).

I'd drop all of the digest-exchange bits from the protocol, as the
actual signatures are the real, trustable verification. I don't think
you can drop the external storage of the digests, which is one of the
ugliest bits. You'll be asking for the digests all the time to create
new commit objects, so you need to have it at hand without rehashing.

And I wouldn't get my hopes up that this will go into git any time soon.
At this point, we're really guessing about how broken SHA-1 will be in
the future, and how much we are going to want to care.

Just my two cents.

-Peff
--
Version: 2012.0.1873 / Virus Database: 2102/4653 - Release Date: 12/02/11
