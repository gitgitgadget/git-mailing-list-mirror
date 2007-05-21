From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Mon, 21 May 2007 13:56:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705211355181.6410@racer.site>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 14:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq7Rt-0001gk-4g
	for gcvg-git@gmane.org; Mon, 21 May 2007 14:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXEUM5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbXEUM5M
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 08:57:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752100AbXEUM5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 08:57:11 -0400
Received: (qmail invoked by alias); 21 May 2007 12:57:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 21 May 2007 14:57:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Epo4GCDHElvMJP+L154nsHo3RlVbn3UcHZfqtoR
	YQJFuQ+66ffWgH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48017>

Hi,

On Sun, 20 May 2007, Junio C Hamano wrote:

> "Fernando J. Pereda" <ferdy@gentoo.org> writes:
> 
> > -	ret = split_mbox(argp, dir, allow_bare, nr_prec, nr);
> > +	while (*argp) {
> > +		const char *arg = *argp++;
> > +		struct stat argstat;
> > +
> > +		if (arg[0] == '-' && arg[1] == 0) {
> > +			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
> > +			continue;
> > +		}
> > +
> > +		if (stat(arg, &argstat) == -1) {
> > +			error("cannot stat %s (%s)", arg, strerror(errno));
> > +			return 1;
> > +		}
> > +
> > +		if (S_ISDIR(argstat.st_mode))
> > +			ret |= split_maildir(arg, dir, nr_prec, nr);
> > +		else
> > +			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
> > +	}
> > +
> >  	if (ret != -1)
> >  		printf("%d\n", ret);
> >  
> 
> No kidding.  ret |= stuff and then printf("%d\n", ret) would not
> give us the number of commit e-mails on the standard output.

Should we not just stop when split_maildir() or split_mbox() returns -1? 
And yes, we'd probably need a second variable to do take the return value.

Ciao,
Dscho
