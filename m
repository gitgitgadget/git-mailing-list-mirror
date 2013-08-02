From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 03:54:02 -0700
Message-ID: <20130802105402.GA25697@sigill.intra.peff.net>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joeyh@debian.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 12:54:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Czv-0000mn-81
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 12:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab3HBKyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 06:54:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:36930 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab3HBKyH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 06:54:07 -0400
Received: (qmail 645 invoked by uid 102); 2 Aug 2013 10:54:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Aug 2013 05:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Aug 2013 03:54:02 -0700
Content-Disposition: inline
In-Reply-To: <20130802064003.GB3013@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231521>

On Thu, Aug 01, 2013 at 11:40:03PM -0700, Jonathan Nieder wrote:

> > Commit c334b87b30c1464a1ab563fe1fb8de5eaf0e5bac caused a reversion in
> > git-cat-file --batch.
> >
> > With an older version:
> >
> > joey@gnu:~/tmp/rrr>git cat-file --batch
> > :file name
> > e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 blob 0
> >
> > With the new version:
> >
> > joey@wren:~/tmp/r>git cat-file --batch
> > :file name
> > :file missing
> [...]
> Oh dear.  Luckily you caught this before the final 1.8.4 release.  I
> wonder if we should just revert c334b87b (cat-file: split --batch
> input lines on whitespace, 2013-07-11) for now.

Ugh. Yeah, the incorrect assumption from the commit message of c334b87b
is "Object names cannot contain spaces...". Refs cannot, but filename
specifiers after a colon can.

We need to revert that commit before the release. It can either be
replaced with:

  1. A "--split" (or similar) option to use the behavior only when
     desired.

  2. Enabling splitting only when %(rest) is used in the output format.

And I suppose it is too late in the cycle for either of those to go into
v1.8.4. That's a shame, but I think losing that particular patch does
not affect the rest of the series, so we are OK to ship without it.

Thanks Joey for a timely bug report.

-Peff
