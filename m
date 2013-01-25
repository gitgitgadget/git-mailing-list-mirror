From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9902: protect test from stray build artifacts
Date: Thu, 24 Jan 2013 23:23:26 -0500
Message-ID: <20130125042326.GA31281@sigill.intra.peff.net>
References: <201301212330.10824.jn.avila@free.fr>
 <7v7gn6f6ya.fsf@alter.siamese.dyndns.org>
 <20130122003954.GA23297@sigill.intra.peff.net>
 <7vehha89j5.fsf_-_@alter.siamese.dyndns.org>
 <20130125011349.GB27657@sigill.intra.peff.net>
 <7vvcal7vhg.fsf@alter.siamese.dyndns.org>
 <7vr4l97v3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyapR-0008Ej-TV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab3AYEX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:23:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48847 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754634Ab3AYEX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:23:28 -0500
Received: (qmail 7697 invoked by uid 107); 25 Jan 2013 04:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 23:24:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 23:23:26 -0500
Content-Disposition: inline
In-Reply-To: <7vr4l97v3h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214491>

On Thu, Jan 24, 2013 at 08:19:30PM -0800, Junio C Hamano wrote:

> > Ahh, ok, we show one element per line and just make sure "bundle"
> > is there, and we do not care what other buns appear in the output.
> >
> Not so quick, though.  The lower level "read from help -a" is only
> run once and its output kept in a two-level cache hierarchy; we need
> to reset both.

Ugh, I didn't even think about that.

I wonder if it would be simpler if the completion tests actually ran a
new bash for each test. That would be slower, but it somehow seems
cleaner.

> It starts to look a bit too intimately tied to the implementation of
> what is being tested for my taste, though.
> [...]
> +test_expect_success 'help -a read correctly by command list generator' '
> +	__git_all_commands= &&
> +	__git_porcelain_commands= &&
> +	GIT_TESTING_COMMAND_COMPLETION= &&
> +	run_completion "git bun" &&
> +	grep "^bundle $" out
> +'

Agreed. I could take or leave it at this point. It's nice to check that
changes to "help -a" will not break it, but ultimately it feels a bit
too contrived to catch anything useful.

-Peff
