From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Minor bug in git branch --set-upstream-to adding superfluous branch section to config
Date: Fri, 29 Mar 2013 18:20:28 +0100
Message-ID: <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
	<20130329170032.GA3552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Haack <haacked@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULcz6-0007es-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410Ab3C2RUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:20:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:28972 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab3C2RUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:20:32 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 29 Mar
 2013 18:20:21 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 29 Mar 2013 18:20:28 +0100
In-Reply-To: <20130329170032.GA3552@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Mar 2013 13:00:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219510>

Jeff King <peff@peff.net> writes:

> I think what happens is that the config editor runs
> through the files linearly, munging whatever lines necessary for the
> requested operation, and leaving everything else untouched (as it must,
> to leave comments and whitespace intact). But it does not keep a
> look-behind buffer to realize that a section name is now obsolete (which
> we don't know until we get to the next section, or to EOF). In the worst
> case, this buffer can grow arbitrarily large, like:
>
>   [foo]
>   # the above section is now empty
>   # but we have to read through all of
>   # these comments to actually
>   # realize it
>   [bar]

If we treat this case as having a bunch of comments that make the
section non-empty, then we both avoid needing an arbitrarily large
lookbehind and deleting the user's precious comments...

I.e. the rule would be that we only delete the section if there is
nothing but whitespace until the next section header.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
