From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: fix --signoff
Date: Sat, 10 Nov 2007 13:47:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711101346120.4362@racer.site>
References: <Pine.LNX.4.64.0711100548071.4362@racer.site>
 <7vr6iyo4ff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqqhG-0005Kw-JI
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 14:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXKJNsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 08:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbXKJNsK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 08:48:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:55444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbXKJNsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 08:48:09 -0500
Received: (qmail invoked by alias); 10 Nov 2007 13:48:06 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 10 Nov 2007 14:48:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SmU5Y7WdSmU4gSQ9ESG6jVXRXNWyBBwaPgDpudM
	zyluE59YGecP4u
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6iyo4ff.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64347>

Hi,

On Sat, 10 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >  	if (signoff) {
> > ...
> > +		strbuf_init(&sob, 0);
> > +		strbuf_addstr(&sob, sign_off_header);
> > +		strbuf_addstr(&sob, git_committer_info(1));
> > +		p = strrchr(sob.buf, '>');
> > +		if (p)
> > +			strbuf_setlen(&sob, p + 1 - sob.buf);
> > +		strbuf_addch(&sob, '\n');
> > +
> > +		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
> > +			; /* do nothing */
> > +		if (prefixcmp(sb.buf + i, sob.buf))
> > +			strbuf_addbuf(&sb, &sob);
> >  	}
> 
> At this point doesn't this leak sob.buf?

Darn.  I had a "strbuf_release(&sob);" there, but at some stage removed it 
by mistake.

But there is more to be fixed.  Rather than let git_committer_info() add 
the timestamp, only to strip it away, is a waste.

Will redo the patch.

Ciao,
Dscho
