From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] fetch: bigger forced-update warnings
Date: Thu, 8 Sep 2011 00:42:45 +0200
Message-ID: <201109080042.45980.trast@student.ethz.ch>
References: <20110902000039.GB9339@sigill.intra.peff.net> <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com> <20110907212042.GG13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	<git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 00:43:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Qpo-00089G-PF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 00:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408Ab1IGWmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 18:42:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:10855 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756985Ab1IGWms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 18:42:48 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 8 Sep
 2011 00:42:45 +0200
Received: from thomas.inf.ethz.ch (129.132.209.196) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 8 Sep
 2011 00:42:46 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110907212042.GG13364@sigill.intra.peff.net>
X-Originating-IP: [129.132.209.196]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180925>

Jeff King wrote:
> On Mon, Sep 05, 2011 at 02:14:57PM -0700, Shawn O. Pearce wrote:
> 
> > > Right. What I mean is, what should the bigger warning look like?
> > 
> > Its a bikeshed. I refuse to paint bikesheds. :-)
[...]
> +	if (uncommon_forced_update)
> +		warning("HEY STUPID FIX YOUR TOPICS");

Whatever comes out of the bikeshedding, I'm going to keep a patch
locally that refreshes the mental picture of Shawn shouting that!

That being said, I think there should be a multiline warning pointing
the user at the "recovering from upstream rebase" section in
git-rebase(1).  At least by default with an advice.* setting to
disable it.

> +       if (!prefixcmp(message, "fetch: fast-forward"))
> +               uc->fastforward++;
> +       else if (!prefixcmp(message, "fetch: forced-update\n"))
> +               uc->forced++;

That doesn't work: fetch puts the whole command line there.
E.g.

  git fetch altgit
  --> fetch altgit: fast-forward

  git fetch altgit next:refs/remotes/next
  --> fetch altgit next:remotes/altgit/next: fast-forward

There's also a minor subtlety here that I had to double-check first:
the message for a branch creation is 'storing head', so the later
check

> +       return uc.fastforward && uc.forced <= 1; /* 1 for the one we just did */

never triggers at the second fetch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
