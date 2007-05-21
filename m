From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 20:15:12 -0700
Message-ID: <7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
References: <20070520181447.GA10638@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Mon May 21 05:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpyMj-00088r-1f
	for gcvg-git@gmane.org; Mon, 21 May 2007 05:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXEUDPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbXEUDPP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 23:15:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54592 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbXEUDPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 23:15:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521031513.PCWP6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 23:15:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1fFC1X00Q1kojtg0000000; Sun, 20 May 2007 23:15:13 -0400
In-Reply-To: <20070520181447.GA10638@ferdyx.org> (Fernando J. Pereda's message
	of "Sun, 20 May 2007 20:14:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47960>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> -	ret = split_mbox(argp, dir, allow_bare, nr_prec, nr);
> +	while (*argp) {
> +		const char *arg = *argp++;
> +		struct stat argstat;
> +
> +		if (arg[0] == '-' && arg[1] == 0) {
> +			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
> +			continue;
> +		}
> +
> +		if (stat(arg, &argstat) == -1) {
> +			error("cannot stat %s (%s)", arg, strerror(errno));
> +			return 1;
> +		}
> +
> +		if (S_ISDIR(argstat.st_mode))
> +			ret |= split_maildir(arg, dir, nr_prec, nr);
> +		else
> +			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
> +	}
> +
>  	if (ret != -1)
>  		printf("%d\n", ret);
>  

No kidding.  ret |= stuff and then printf("%d\n", ret) would not
give us the number of commit e-mails on the standard output.
