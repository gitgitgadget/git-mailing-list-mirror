From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Thu, 12 Apr 2012 20:46:52 -0400
Message-ID: <1334274951-sup-6013@pinkfloyd.chass.utoronto.ca>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org> <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca> <7vwr5os9zr.fsf@alter.siamese.dyndns.org> <1334018233-sup-7389@pinkfloyd.chass.utoronto.ca> <7vobr0s8ej.fsf@alter.siamese.dyndns.org> <m262d8j8dv.fsf@igel.home> <7vhawrqzue.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 02:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIUfE-0000BY-EY
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 02:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934986Ab2DMAqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 20:46:55 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:36271 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756772Ab2DMAqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 20:46:54 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60037 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SIUf6-0001Cw-OW; Thu, 12 Apr 2012 20:46:52 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SIUf6-0005Fp-NM; Thu, 12 Apr 2012 20:46:52 -0400
In-reply-to: <7vhawrqzue.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195395>

Excerpts from Junio C Hamano's message of Tue Apr 10 12:10:22 -0400 2012:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> FWIW, it bothers me a lot more that expression does not anchor
> >> matches against path elements with explicit '/' than the issue your patch
> >> addresses, i.e.
> >>
> >>     sed -e 's|[^/][^/]*/|../|g'
> >
> > Note that this requires readding a trailing slash to the path, which
> > complicates the whole thing a bit.
> 
> Or simply swapping order of the stripping and sed invocation, which
> is not a big deal.  I personally find the pattern with trailing '/'
> easier to grok but it is also not a big deal.

Sorry for the delay here, I haven't had a chance to look at this in a
few days.  I tried the version with [^/][^/]*/ tonight and it was more
invasive than required for such a simple fix, I think.

Switching the order of the calls is ok, but then you need to use a
rela and relb as the second substitution relies on $a being
/-terminated and the creation of gitdir:... requires the opposite.  So
now, you're switching the order, moving other lines, renaming
variables and also altering the lines used to spit out the paths in
order to avoid also stripping the / from the rel* variables.

Updated patch to follow, but please don't hesitate to request the
alternate version if it really is what you'd like to see.  (I've done
the work already.)

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
