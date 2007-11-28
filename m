From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not generate full commit log message if it not going
 to be used
Date: Wed, 28 Nov 2007 12:18:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281211130.27959@racer.site>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
 <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
 <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
 <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com>
 <20071127214425.GA3156@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxLsH-0003a2-B8
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbXK1MSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXK1MSU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:18:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:33485 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752777AbXK1MST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:18:19 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:18:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 28 Nov 2007 13:18:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Qz4MRvDCQjyvHUrgjke0tnnD5hwFR/pP3OCpNA5
	0e72taXDljAfE0
X-X-Sender: gene099@racer.site
In-Reply-To: <20071127214425.GA3156@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66298>

Hi,

On Tue, 27 Nov 2007, Alex Riesen wrote:

> Could not stop myself. Hopefully didn't beat anyone to it :)
> Almost all code shamelessly stolen from builtin-diff-index.c.

Then I have to wonder if it would not be a better idea to refactor the 
code, so that other people do not have to steal the code again, but are 
able to reuse it ;-)

> Preprocessor trickery in DIFF_OPT_* macros is disgusting, it breaks Vim 
> word completion and trying to use many flags in one expression looks 
> just ugly.

How does it break Vim word completion?  And why should something like

		DIFF_OPT_SET(&rev.diffopt, QUIET | EXIT_WITH_STATUS);

look ugly?  I find it highly readable.

> +	if (no_edit) {
> +		static const char *argv[] = { NULL, "HEAD", NULL };
> +		struct rev_info rev;
> +		unsigned char sha1[40];
> +		int is_initial;
> +
> +		fclose(fp);
> +
> +		if (!active_nr && read_cache() < 0)
> +			die("Cannot read index");
> +
> +		if (get_sha1("HEAD", sha1) != 0)
> +			return !!active_nr;

Don't want to be anal here, but are there possibly reasons (read "possible 
errors") other than an empty repo where this triggers?

> +
> +		init_revisions(&rev, "");
> +		rev.abbrev = 0;
> +		(void)setup_revisions(2, argv, &rev, NULL);

(void)?

Besides, would this not be more elegant as

		setup_revisions(0, NULL, &rev, "HEAD");

Hmm?

> +		(void)run_diff_index(&rev, 1 /* cached */);

(void)?

Other than that (including my remark about refactoring that piece of 
code), I like it.

Thanks,
Dscho
