From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Fri, 4 Dec 2015 18:25:46 -0500
Message-ID: <20151204232546.GC15064@sigill.intra.peff.net>
References: <20151030005057.GA23251@sigill.intra.peff.net>
 <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
 <20151030210849.GA7149@sigill.intra.peff.net>
 <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
 <20151109155342.GB27224@sigill.intra.peff.net>
 <CAM-tV--hBSdCJckCnMtKgkQB2f_3eN8sXHdFWwg2hzb6s7ufxw@mail.gmail.com>
 <20151110122501.GA14418@sigill.intra.peff.net>
 <xmqqpoymrql7.fsf@gitster.mtv.corp.google.com>
 <20151204190658.GA16692@sigill.intra.peff.net>
 <xmqqlh9arnbz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:25:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4zjd-0003g1-Cf
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 00:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbbLDXZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 18:25:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:37612 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755384AbbLDXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 18:25:49 -0500
Received: (qmail 12701 invoked by uid 102); 4 Dec 2015 23:25:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 17:25:49 -0600
Received: (qmail 30315 invoked by uid 107); 4 Dec 2015 23:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Dec 2015 18:25:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2015 18:25:46 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh9arnbz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282018>

On Fri, Dec 04, 2015 at 12:05:52PM -0800, Junio C Hamano wrote:

> > This probably _does_ trigger setup_git_env() when it was not otherwise
> > called, and it will back to looking at ".git/config" for the repo-level
> > config. That may fail to find the file if we are in a bare repository,
> > or a subdirectory of the working tree. IOW, I suspect this:
> >
> >   git init --bare foo.git
> >   cd foo.git
> >   git config credential.helper cache
> >   git config credentialcache.ignoreSIGHUP true ;# goes into local config
> >   git fetch https://example.com/foo.git
> >
> > may fail to respect the ignoreSIGHUP option.
> >
> > I guess the solution would be to setup_git_director_gently() in the
> > daemon process.
> 
> So I guess I did notice the right breakage ;-)
> 
> At least, this won't be a regression but "a new feature initially
> shipped with a broken corner case", so a follow-up fix is welcome,
> but not a big deal that I've already merged it to 'master'.

Yeah, agreed on all counts. Thanks for noticing.

I suspect in practice is a pretty rare corner case, but I will leave it
to those who are interested in the feature to do the fixup.

-Peff
