From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 02:43:59 -0800
Message-ID: <20121115104345.GA32465@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 11:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYwvm-00060w-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 11:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993022Ab2KOKoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 05:44:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49236 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964838Ab2KOKoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 05:44:07 -0500
Received: (qmail 15192 invoked by uid 107); 15 Nov 2012 10:44:55 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 05:44:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 02:43:59 -0800
Content-Disposition: inline
In-Reply-To: <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209813>

On Thu, Nov 15, 2012 at 11:28:46AM +0100, Felipe Contreras wrote:

> I tried both:
> 
> ok 19 # skip implicit ident prompts for sender (missing AUTOIDENT of
> PERL,AUTOIDENT)
> ok 20 - broken implicit ident aborts send-email
> 
> ok 19 - implicit ident prompts for sender
> ok 20 # skip broken implicit ident aborts send-email (missing
> !AUTOIDENT of PERL,!AUTOIDENT)
> 
> However, it would be much easier if ident learned to check
> GIT_TEST_FAKE_HOSTNAME, or something.

Yes, it would be. It has two downsides:

  1. The regular git code has to be instrumented to respect the
     variable, so it can potentially affect git in production use
     outside of the test suite. Since such code is simple, though, it is
     probably not a big risk.

  2. We would not actually exercise the code paths for doing
     hostname and GECOS lookup. We do not test their resulting values,
     so the coverage is not great now, but we do at least run the code,
     which would let a run with "--valgrind" check it. I guess we could
     go through the motions of assembling the ident and then replace
     it at the end with the fake value.

I don't have a strong opinion either way.

> > One whose system is configured in such a way that git can produce an
> > automatic ident (i.e., has a non-blank GECOS name and a FQDN).
> 
> And doesn't have any of the following:
> 
>  * configured user.name/user.email
>  * specified $EMAIL
>  * configured sendemail.from
>  * specified --from argument
> 
> Very unlikely.

That is certainly the opinion you have stated already. I'm not sure I
agree. Linus, for example, was an advocate of such a configuration early
on in git's history. I don't think he still runs that way, though.

> And then, what would be the consequences of not receiving this prompt?

An email would be sent with the generated identity.

-Peff
