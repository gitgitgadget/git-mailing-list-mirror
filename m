From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] retrying with "am -3" doesn't work anymore
Date: Wed, 30 Mar 2016 01:06:42 -0400
Message-ID: <20160330050642.GB11007@sigill.intra.peff.net>
References: <20160330021502.GA16077@sigill.intra.peff.net>
 <CACRoPnSrKyNS8EdFM119TT9qoUTdNy_+P5q-7rWMahpDzzGAKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 07:07:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al8LR-0004zO-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 07:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcC3FGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 01:06:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:40596 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751685AbcC3FGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 01:06:45 -0400
Received: (qmail 1161 invoked by uid 102); 30 Mar 2016 05:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 01:06:45 -0400
Received: (qmail 31619 invoked by uid 107); 30 Mar 2016 05:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 01:06:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 01:06:42 -0400
Content-Disposition: inline
In-Reply-To: <CACRoPnSrKyNS8EdFM119TT9qoUTdNy_+P5q-7rWMahpDzzGAKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290270>

On Wed, Mar 30, 2016 at 12:18:30PM +0800, Paul Tan wrote:

> On Wed, Mar 30, 2016 at 10:15 AM, Jeff King <peff@peff.net> wrote:
> > I noticed that I could not get a patch from Junio to apply earlier
> > today, and I think it is a regression in the builtin git-am
> > implementation.  I had trouble reproducing with a basic test case,
> > though.
> >
> > Basically, I picked up the three patches from this sub-thread:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/288987/focus=290222
> >
> > and tried to apply them on top of v2.8.0.
> >
> > Doing it with "git am -3 patches" works. But doing it with:
> >
> >   git am patches
> >   git am -3
> >
> > doesn't. Bisecting shows that it did work before 783d7e8 (builtin-am:
> > remove redirection to git-am.sh, 2015-08-04).
> 
> Yeah, with "git am -3" when resuming, the -3 will only affect the
> current conflicting patch since 852a171 (am: let command-line options
> override saved options, 2015-08-04).

Ah, right. I had a nagging feeling that we had discussed this, and
indeed, I already participated in the discussion last July[1]. I even
apparently argued in favor of the new behavior[2]. Yikes. There goes my
mind.

Running "git am -3" for each patch which needs it does indeed
successfully apply the series.

Thanks for a quick response, and sorry for the noise.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/274574

[2] In http://thread.gmane.org/gmane.comp.version-control.git/274574/focus=274635,
    though I think there I more meant that in:

       git am
       git am -3
       git am

    the third one would not use "-3" again. So I was mostly confused
    that in:

       git am
       git am -3

    we would not use "-3" for the subsequent patches applied by that
    second invocation. So maybe that is a bug. I dunno. I could see
    arguments either way.
