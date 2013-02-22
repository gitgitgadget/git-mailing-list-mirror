From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] hash-object doc: "git hash-object -w" can write
 invalid objects
Date: Fri, 22 Feb 2013 18:09:10 -0500
Message-ID: <20130222230910.GD21579@sigill.intra.peff.net>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222230132.GB4514@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91kM-0002Sf-K8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab3BVXJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:09:15 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57609 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab3BVXJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:09:13 -0500
Received: (qmail 9561 invoked by uid 107); 22 Feb 2013 23:10:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 18:10:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 18:09:10 -0500
Content-Disposition: inline
In-Reply-To: <20130222230132.GB4514@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216878>

On Fri, Feb 22, 2013 at 03:01:32PM -0800, Jonathan Nieder wrote:

> > Git doesn't handle the resulting tag objects nicely at all. For example,
> > running `git cat-file -p` on the new object outputs a really odd
> > timestamp "Thu Jun Thu Jan 1 00:16:09 1970 +0016" (I'm guessing it
> > parses the year as Unix time),
> 
> The usual rule is that with invalid objects (e.g. as detected by "git
> fsck"), any non-crash result is acceptable.  Garbage in, garbage out.

Agreed, though I think a more consistent garbage would be good (e.g.,
time=0, tz=0).

> I notice that git-hash-object(1) doesn't contain any reference to
> git-fsck(1).  How about something like this, to start?

I think it's a good change. Though note that this problem is not
discovered by fsck (which I think we should also change).

> Perhaps by default hash-object should automatically fsck the objects
> it is asked to create.

Not unreasonable. In this case, we also have git-mktag. It would be nice
if we could simply run the input through a type-specific sanity checker
(optional, I hope; I use hash-object often to craft test cases like this
:) ). The same need came up a month or two ago in a discussion of how to
use "git replace" safely. But I guess fsck after-the-fact is just
another form of the same solution.

-Peff
