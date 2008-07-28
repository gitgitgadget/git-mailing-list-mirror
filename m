From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Mon, 28 Jul 2008 13:33:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281328520.2725@eeepc-johanness>
References: <20080728065023.743930d6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQyy-0006mA-BM
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYG1Lck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbYG1Lck
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:32:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:46097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750720AbYG1Lcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:32:39 -0400
Received: (qmail invoked by alias); 28 Jul 2008 11:32:37 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp015) with SMTP; 28 Jul 2008 13:32:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3hvIi+NW3nu+O9RMsSxLaqT5cz/Aey4X1bpsxAW
	Bbb/ykCDgAHRTu
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080728065023.743930d6.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90444>

Hi,

On Mon, 28 Jul 2008, Christian Couder wrote:

> +	rev = xmalloc((argc - 1) * sizeof(*rev));
> +
> +	do {
> +		struct commit *r = get_commit_reference(argv[1]);
> +		if (!r)
> +			return 1;
> +		rev[rev_nr++] = r;
> +		argc--; argv++;
> +	} while (argc > 1);
> +
> +	return show_merge_base(rev, rev_nr, show_all);

	rev = xmalloc((argc - 1) * sizeof(*rev));

	for (rev_nr = 0; rev_nr + 1 < argc; rev_nr++) {
		rev[rev_nr] = get_commit_reference(argv[rev_nr + 1]);
		if (!rev[rev_nr])
			return !!error("Does not refer to a commit: '%s'",
				argv[rev_nr + 1]);
	}

	return show_merge_base(rev, rev_nr, show_all);

I do not know about you, but I think this is not only shorter (in spite of 
adding a helpful error message), but also simpler to understand (not using 
convoluted do { } while logic), and therefore superior.

Your performance argument is weak IMHO, as this is not a big performance 
hit, and command line parameter parsing is definitely not performance 
critical.

Ciao,
Dscho
