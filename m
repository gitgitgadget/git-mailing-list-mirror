From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Mon, 22 Oct 2007 02:44:54 -0400
Message-ID: <20071022064454.GV14735@spearce.org>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> <7vejgbdbyn.fsf@gitster.siamese.dyndns.org> <34DAC3CA-E226-4488-8B03-FC45A6A95F78@lrde.epita.fr> <09169ECD-19E1-44D1-8539-71EBBA3826A8@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijr2G-00033s-Ti
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXJVGpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXJVGpA
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:45:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47818 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXJVGo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:44:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijr1z-0003pY-VY; Mon, 22 Oct 2007 02:44:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEF2420FBAE; Mon, 22 Oct 2007 02:44:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <09169ECD-19E1-44D1-8539-71EBBA3826A8@lrde.epita.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61958>

Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> >On Oct 4, 2007, at 1:18 AM, Junio C Hamano wrote:
> >>Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> >>
> >>If we do not care about supporting too old GNU make, we can do
> >>this by first adding this near the top:
> >>
> >>        ifndef NO_RPATH
> >>        LINKER_PATH = -L$(1) $(CC_LD_DYNPATH)$(1)
> >>        else
> >>        LINKER_PATH = -L$(1)
> >>        endif
> >>
> >>and then doing something like:
> >>
> >>	CURL_LIBCURL = $(call LINKER_PATH,$(CURLDIR)/$(lib))
> >>	OPENSSL_LINK = $(call LINKER_PATH,$(OPENSSLDIR)/$(lib))
> >>
> >>to make it easier to read and less error prone.
> >
> >Yes.  I can rework the patch, but the question is: do you care  
> >about old GNU make?  Can I rewrite the patch with this feature?
> 
> I know Junio is still offline but maybe someone else has an objection  
> against this?

How old of a GNU make are talking about here?  The above is certainly
a lot nicer to read, but I'd hate to suddenly ship a new Git that
someone cannot compile because their GNU make is too old.

GNU make is fortunately pretty easy to compile, so it shouldn't be
that difficult for someone to build a newer version if they had to,
but why make them go through all that extra work just to install
a new Git?

What about using a small helper shell script and using $(shell)
instead of $(call)?

So I guess in short I think I was in agreement with Junio a while
ago on this, which was that I don't want to require a newer GNU
make than we already require our users to have.

-- 
Shawn.
