From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo =
 bar"
Date: Mon, 13 Oct 2014 17:36:33 -0400
Message-ID: <20141013213633.GA16732@peff.net>
References: <20141010060636.GA15057@peff.net>
 <20141010061114.GB15277@peff.net>
 <20141013161022.GA20520@google.com>
 <20141013211524.GB15969@peff.net>
 <20141013213132.GA32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnIF-0005dm-Im
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaJMVgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:36:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:58092 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbaJMVgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:36:35 -0400
Received: (qmail 18519 invoked by uid 102); 13 Oct 2014 21:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 16:36:35 -0500
Received: (qmail 28779 invoked by uid 107); 13 Oct 2014 21:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 17:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 17:36:33 -0400
Content-Disposition: inline
In-Reply-To: <20141013213132.GA32245@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 02:31:32PM -0700, Jonathan Nieder wrote:

> > One of my goals was to provide a more generic helper so that we don't
> > have to make little helpers like this for every command. So I'd much
> > rather something like:
> >
> >   test_output () {
> > 	printf "%s\n" "$1" >expect &&
> > 	shift &&
> > 	"$@" >output &&
> > 	test_cmp expect output
> >   }
> 
> I agree with the principle in general.
> 
> Unfortunately that wouldn't help here --- the "$@" is a command with a
> pipe to sed in it and we still lose the exit status from
> count-objects.

Thanks, I missed that subtlety from what you posted earlier. That's
another good reason that something like test_output is not really
sufficient (you could eval() a snippet of shell, but then we have not
really improved on the "verbose test $a = $b" version, since as you note
we are still missing the exit code).

-Peff
