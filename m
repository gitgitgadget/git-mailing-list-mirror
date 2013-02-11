From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent parents
Date: Mon, 11 Feb 2013 10:54:33 +0000
Message-ID: <20130211105433.GA3245@farnsworth.metanate.com>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
 <20130210210229.GB2270@serenity.lan>
 <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:55:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4r2M-0004PZ-QF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 11:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab3BKKyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 05:54:39 -0500
Received: from dougal.metanate.com ([90.155.101.14]:37881 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753839Ab3BKKyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 05:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4eHbRIxOZUznXFaOcG60i2wIQ48rF1xBjoThaLjeJJE=;
	b=HbvN+lykz7zyi4Gd4a3iFRnOpchio4U1kCp+/bzL46UiR3TNmC9uf8npbsc5ZH0ICPo49GBEoMg27HGrq9yf6S6IulmoqtiENwbJ8vy0DsZgMXJUd77SJqvUaNeXo0t6i4iEE+lhqhhWiAhi1Qy+Q0Gk8BmX8coC75HViB/yoLGgbD7kk5xwZGOJc8O5LfxYO2JjQTmjqr74mOUTw4S6btwvkXo1mFJikQSaYxsUM7osL8l7E2N1WHz/IgGzrScZgU2VvMolppW5Kr8Dh245DAZDEu5I987gJVsDrSkl9LSUUs3rhD61+TUh4DfJWI8Ix7M5Qegi7M4i13m+f/atyg==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1U4r1u-0001aO-6t; Mon, 11 Feb 2013 10:54:34 +0000
Content-Disposition: inline
In-Reply-To: <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216028>

On Sun, Feb 10, 2013 at 02:38:46PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> > On Sun, Feb 10, 2013 at 11:30:39AM -0800, Junio C Hamano wrote:
> > ...
> >> Is it correct to say that this essentially re-does 656197ad3805
> >> (graph.c: infinite loop in git whatchanged --graph -m, 2009-07-25)
> >> in a slightly different way, in that Micha=C5=82's original fix al=
so
> >> protected against the case where graph->state is flipped to
> >> GRAPH_PADDING by graph_next_line() that returns false, but with yo=
ur
> >> fixup, the code knows it never happens (i.e. when graph_next_line(=
)
> >> returns false, graph->state is always in the GRAPH_PADDING state),
> >> and the only thing we need to be careful about is when graph->stat=
e
> >> is already in the PADDING state upon entry to this function?
> >
> > Yes, although I wonder if we can end up in POST_MERGE or COLLAPSING
> > state here as well.  The check in the loop guards against that beca=
use
> > those will eventually end up as PADDING.
> >
> > As far as I can see, this is okay because we have called
> > graph_show_remainder() at the end of outputting a commit, even when=
 we
> > end up outputting the same (merge) commit more than once.  But some=
one
> > more familiar with the graph code might want to comment here.
>=20
> More importantly, that kind of thought process needs to be
> documented in the log message; that will help people to diagnose the
> cause of the problem if they later find that this patch made an
> incorrect assumption while simplifying the code.

Perhaps it's best to leave the patch as it originally was to guarantee
that we can't get stuck in graph_show_commit(), even when it's called a=
t
an unexpected time, but I see you've already squashed this change in.

Would you prefer me to resend the original patch or send an update with
this change and the above reasoning in the commit message?


John
