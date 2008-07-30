From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Wed, 30 Jul 2008 15:51:00 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807301546360.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080728065023.743930d6.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807281328520.2725@eeepc-johanness> <200807300652.41404.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148944103-642933951-1217425861=:3486"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOC5z-0003Fv-Qe
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYG3NvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYG3NvF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:51:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:37302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbYG3NvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:51:04 -0400
Received: (qmail invoked by alias); 30 Jul 2008 13:51:01 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp003) with SMTP; 30 Jul 2008 15:51:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i1YA4KETiFdB9GQ5ysEbQNmLtIhZc6gaz5BvQw8
	62vx1RUFisNBos
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <200807300652.41404.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90786>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148944103-642933951-1217425861=:3486
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 30 Jul 2008, Christian Couder wrote:

> Le lundi 28 juillet 2008, Johannes Schindelin a écrit :
>
> > On Mon, 28 Jul 2008, Christian Couder wrote:
> > > +	rev = xmalloc((argc - 1) * sizeof(*rev));
> > > +
> > > +	do {
> > > +		struct commit *r = get_commit_reference(argv[1]);
> > > +		if (!r)
> > > +			return 1;
> > > +		rev[rev_nr++] = r;
> > > +		argc--; argv++;
> > > +	} while (argc > 1);
> > > +
> > > +	return show_merge_base(rev, rev_nr, show_all);
> >
> > 	rev = xmalloc((argc - 1) * sizeof(*rev));
> >
> > 	for (rev_nr = 0; rev_nr + 1 < argc; rev_nr++) {
> > 		rev[rev_nr] = get_commit_reference(argv[rev_nr + 1]);
> > 		if (!rev[rev_nr])
> > 			return !!error("Does not refer to a commit: '%s'",
> > 				argv[rev_nr + 1]);
> > 	}
> >
> > 	return show_merge_base(rev, rev_nr, show_all);
> >
> > I do not know about you, but I think this is not only shorter (in spite
> > of adding a helpful error message), but also simpler to understand (not
> > using convoluted do { } while logic), and therefore superior.
> 
> In my last version the loop is reduced to:
> 
> +	do {
> +		rev[rev_nr++] = get_commit_reference(argv[1]);
> +		argc--; argv++;
> +	} while (argc > 1);
> 
> so it's very simple.
> 
> And the stop condition is simpler in my version.

Does not matter.  The logic is convoluted, i.e. not how (most) humans 
think.  And you cheat by putting the argc and argv statements in one line.

And you do not use argc and argv after the loop, so those statements are 
pointless.

And you cheat by not needing that die() anymore because you posted a 
(good!) patch _after_ I sent my version.

So it could e as short as this:

 	while (++rev_nr < argc)
 		rev[rev_nr - 1] = get_commit_reference(argv[rev_nr]);

I would contend that the for() version is more readable.

> > Your performance argument is weak IMHO, as this is not a big 
> > performance hit, and command line parameter parsing is definitely not 
> > performance critical.
> 
> It feels a bit sloppy though.

Sure.

If you think that obviousness in a command line parsing is less important 
than performance.

Ciao,
Dscho

---1148944103-642933951-1217425861=:3486--
