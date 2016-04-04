From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 09:38:54 -0400
Message-ID: <20160404133853.GB25404@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
 <20160403045600.GD1519@sigill.intra.peff.net>
 <20160404041203.GE28933@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 04 15:39:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an4id-0004ee-2G
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 15:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbcDDNi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 09:38:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:43633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbcDDNi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 09:38:58 -0400
Received: (qmail 3068 invoked by uid 102); 4 Apr 2016 13:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 09:38:57 -0400
Received: (qmail 24401 invoked by uid 107); 4 Apr 2016 13:38:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 09:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 09:38:54 -0400
Content-Disposition: inline
In-Reply-To: <20160404041203.GE28933@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290690>

On Mon, Apr 04, 2016 at 12:12:04AM -0400, Santiago Torres wrote:

> > As a side note, it might actually be an improvement for pgp_verify_tag
> > to take a sha1 (so that git-tag is sure that it is verifying the same
> > object that it is printing), but that refactoring should probably come
> > separately, I think.
> 
> Just to be sure, this refactoring is something we should still include
> in this set of patches, right? I think that otherwise we'd lose the
> desambigutaion that git tag -v does in this patch.

I think it can be part of this series, but doesn't have to be. As I
understand it, the current code is just handing the name to the `git
verify-tag` process, so if we continue to do so, that would be OK.

> I also think that most of the rippling is gone if we use and adaptor as
> you suggested. Should I add a patch on top of this to support a sha1 as
> part for gpg_verify_tag()?

Yes, though I'd generally advise against a function taking either a name or
a sha1, and ignoring the other option. That often leads to confusing
interfaces for the callers. Instead, perhaps just take the sha1, and let
the caller do the get_sha1() themselves. Or possibly provide two
functions, one of which is a convenience to translate the name to sha1
and then call the other.

-Peff
