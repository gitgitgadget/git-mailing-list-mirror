From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 01:29:10 -0400
Message-ID: <20160512052909.GA18330@sigill.intra.peff.net>
References: <20160511233546.13090-1-gitster@pobox.com>
 <20160511233546.13090-2-gitster@pobox.com>
 <20160512044730.GA5436@sigill.intra.peff.net>
 <CAHYJk3Q90MrV_hxF+xxbFnJtL6_OLqTRoekwjc9-_LJuFc-aTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 07:29:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jBt-0001WL-SW
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbcELF3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:29:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:38363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751407AbcELF3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:29:14 -0400
Received: (qmail 28822 invoked by uid 102); 12 May 2016 05:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 01:29:13 -0400
Received: (qmail 6368 invoked by uid 107); 12 May 2016 05:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 May 2016 01:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 May 2016 01:29:10 -0400
Content-Disposition: inline
In-Reply-To: <CAHYJk3Q90MrV_hxF+xxbFnJtL6_OLqTRoekwjc9-_LJuFc-aTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294386>

On Thu, May 12, 2016 at 07:23:02AM +0200, Mikael Magnusson wrote:

> >> -             if (!out)
> >> +             if (!out) {
> >> +                     fclose(in);
> >>                       return error(_("could not open '%s' for writing: %s"),
> >>                                       mail, strerror(errno));
> >> +             }
> >
> > Presumably `fclose` doesn't ever overwrite errno in practice, but I
> > guess it could in theory.
> 
> It probably does pretty often in general, but not when the file is
> opened for input only.

Right, I should have said "this fclose".

I think EBADF is the only likely error when closing input, and that's
presumably impossible here.

-Peff
