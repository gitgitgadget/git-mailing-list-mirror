From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Wed, 14 Mar 2012 10:00:12 -0400
Message-ID: <20120314140012.GA2651@sigill.intra.peff.net>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com>
 <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com>
 <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <4F605DD8.9040504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7okX-0004nr-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab2CNOAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:00:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49156
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab2CNOAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:00:15 -0400
Received: (qmail 9828 invoked by uid 107); 14 Mar 2012 14:00:26 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Mar 2012 10:00:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2012 10:00:12 -0400
Content-Disposition: inline
In-Reply-To: <4F605DD8.9040504@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193107>

On Wed, Mar 14, 2012 at 09:59:04AM +0100, Michael Haggerty wrote:

> > Ending that confusion is one of the best reasons to switch the default,
> > IMHO, but I don't think it argues for "current" versus "upstream", as
> > they both fix it (but Michael's matching-current hybrid would not, so I
> > agree it is less appealing).
> 
> In the case of my proposed matching-current hybrid, the error message
> for the failing push would make it pretty obvious what went wrong and
> how to fix it; something like:
> 
>     $ git push
>     The remote repository "git.example.com:myproject" does not yet
>     contain a branch called "master".  If you would like to create one
>     now, type
> 
>         git push origin master
> 
>     For other alternatives, please see gitworkflows(7).
> 
> This error message would appear *whenever* the matching-current hybrid
> policy caused the push to fail.  Since this problem occurs only if (1)
> the upstream repository is empty and (2) the user hasn't configured a
> more liberal global push.default, and since it is blindingly obvious
> what to do to fix the problem, it doesn't seem especially onerous.

Thanks for the clarification. That does go a long way towards dealing
with the confusion. I think I'd be OK with that, though I am on the
fence about whether just pushing (i.e., "current") would be better or
worse.

> 3. In the branching configurations for which all workflows agree about
>    what "git push" should do, then that is what "git push" should do by
>    default.  When they do not agree, then "git push" should do nothing,
>    give an informative error message, and leave it to the user to
>    decide.
> [...]
> Isn't it obvious?: The fact that we cannot even agree among ourselves
> what "git push" should do in all cases *proves* that we are trying to be
> too ambitious with DWIM.  "git push" must therefore become more
> deferential when the obvious thing to do is unclear, especially given
> that mistakes (due to the very nature of "git push") often have
> embarrassing and publicly visible effects.

I find your approach interesting, but it doesn't deal with one problem:
user perception when git fails to do something out of the box. I am
worried that the rule above means that push will end up defaulting to
nothing. It is one thing to say "there are so many workflows, and they
do not agree, so we should be safe and do nothing"; that makes sense to
an advanced user who thinks about things like different workflows. But
to a brand-new git user who is running "push" in their first session, it
makes git seem very unfriendly.

And that's why I think either "current" or "current-if-matching" as you
describe is a sane default. I don't think it matches with what the
"upstream" people want, and so does not meet your criteria above as a
default behavior. But it does something sensible and not very dangerous
or embarrassing, and it means git will do something that is probably
useful out of the box for a new user.

-Peff
