From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git tag --contains: avoid stack overflow
Date: Tue, 23 Sep 2014 12:05:52 -0400
Message-ID: <20140923160552.GA20624@peff.net>
References: <20140417215817.GA822@sigill.intra.peff.net>
 <20140423075325.GA7268@camelia.ucw.cz>
 <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
 <20140423191628.GA20596@sigill.intra.peff.net>
 <xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
 <20140423205533.GA20582@sigill.intra.peff.net>
 <xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
 <20140424122029.GA8168@camelia.ucw.cz>
 <20140424122439.GB8168@camelia.ucw.cz>
 <871tr688a4.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stepan Kasal <kasal@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:07:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSbI-0006sJ-G8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbaIWQF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:05:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:50975 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755873AbaIWQFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:05:55 -0400
Received: (qmail 26615 invoked by uid 102); 23 Sep 2014 16:05:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 11:05:55 -0500
Received: (qmail 29280 invoked by uid 107); 23 Sep 2014 16:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 12:06:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 12:05:52 -0400
Content-Disposition: inline
In-Reply-To: <871tr688a4.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257423>

On Sat, Sep 20, 2014 at 08:18:59PM +0200, Andreas Schwab wrote:

> Stepan Kasal <kasal@ucw.cz> writes:
> 
> > diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> > index 143a8ea..a911df0 100755
> > --- a/t/t7004-tag.sh
> > +++ b/t/t7004-tag.sh
> > @@ -1423,4 +1423,30 @@ EOF
> >  	test_cmp expect actual
> >  '
> >  
> > +run_with_limited_stack () {
> > +	(ulimit -s 64 && "$@")
> > +}
> 
> That is way too small.
> 
> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/git/standard/ppc64le

Thanks for the report. I'd be OK with just giving up and dropping this
test as too flaky and system-specific to be worth the trouble.

But if we do want to keep it, does bumping it to 128 (and bumping the
4000 to 8000 in the test below it) work?

-Peff
