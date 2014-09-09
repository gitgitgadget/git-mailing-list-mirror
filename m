From: Jeff King <peff@peff.net>
Subject: Re: git fsck exit code?
Date: Tue, 9 Sep 2014 18:09:34 -0400
Message-ID: <20140909220933.GB14029@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <CAA787rmf7aNJ+ErXk6Lc_hLVDxMV8s2Lx_YmZud83yia4n0VKA@mail.gmail.com>
 <1409595463.3057.3.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:10:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTbZ-0006fm-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbaIIWJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:09:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:46214 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751943AbaIIWJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:09:36 -0400
Received: (qmail 19134 invoked by uid 102); 9 Sep 2014 22:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:09:36 -0500
Received: (qmail 11192 invoked by uid 107); 9 Sep 2014 22:09:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 18:09:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 18:09:34 -0400
Content-Disposition: inline
In-Reply-To: <1409595463.3057.3.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256714>

On Mon, Sep 01, 2014 at 02:17:43PM -0400, David Turner wrote:

> > I don't think git fsck should return !0 in this case. Yes, it's an
> > inconsistency in the repo, but it's sometimes due to erroneous
> > conversions from another SCM or some other (non-standard) implementation
> > of the git client. I've seen things like this (and other inconsistencies
> > in repos, like wrong date formats, non-standard Author fields, unsorted
> > trees, zero-padded file modes and so on), and the thing is, owners of
> > public repos with these errors tend to avoid fixing it because it
> > changes the commit SHAs. If git fsck starts to return !0 on these
> > errors, it will always return error on that repo, which in practise
> > means that the error code is rendered useless. IMHO git fsck should only
> > return !0 on errors that can be fixed without changing the commit
> > history, for example missing or invalid objects.
> 
> We could have one exit code for errors which can be fixed without
> rewriting history, and another for errors that can't.  Or different
> command-line arguments to suppress errors of this sort.
> 
> In my case, I actually could fix the issue, because it was in a
> newly-created branch; I just rewrote the script that created the branch
> to be a little smarter.

I think there's obviously some disagreement or room for interpretation
on the exit code. Perhaps a better path forward is to have a
machine-readable output from fsck in the first place, and then we can
annotate each warning/error with extra information that a caller can
use.

As it is now, you have to scrape fsck's stderr stream to figure out what
happened (which is a thing I have done, and it felt dirty and wrong).

-Peff
