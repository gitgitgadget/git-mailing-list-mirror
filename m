From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 8 Oct 2007 04:57:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080450570.4174@racer.site>
References: Pine.LNX.4.64.0710071737500.4174@racer.site
 <11918014664038-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, frank@lichtenheld.de, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 05:58:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iejkv-00043q-4V
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 05:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXJHD54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 23:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXJHD54
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 23:57:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:40495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751409AbXJHD5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 23:57:55 -0400
Received: (qmail invoked by alias); 08 Oct 2007 03:57:53 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp050) with SMTP; 08 Oct 2007 05:57:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198tq42VJ582hK/tyMvk82BaRvq7e58GlqnmFb6gm
	y4+42+pq/9mdVo
X-X-Sender: gene099@racer.site
In-Reply-To: <11918014664038-git-send-email-shawn.bohrer@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60285>

Hi,

On Sun, 7 Oct 2007, Shawn Bohrer wrote:

> +	if (ignored && ignored_only)
> +		usage(builtin_clean_usage);

Maybe a helpful message in that case, too?  (It is not apparent from the 
usage what the user has done wrong here.)

> +	if (disabled) {
> +		die("clean.requireForce set and -n or -f not given; refusing to clean");
> +	}

Please lose the curly brackets here.  They are absolutely useless, and the 
rest of the git source code avoids unnecessary curly brackets.

> +	/* Paths (argc - i) + 8 (Possible arguments)*/
> +	argv_ls_files = xmalloc((argc - i + 8) * sizeof(const char *));
> +	argv_ls_files[0] = "ls-files";
> +	argv_ls_files[1] = "--others";
> +	argv_ls_files[2] = "--directory";
> [...]

As Linus already noted, it is probably easy, and much more efficient, to 
call read_directory() here.  The best example how to use 
read_directory() is... builtin-ls-files.c.

> diff --git a/git.c b/git.c
> index d7c6bca..4e39169 100644
> --- a/git.c
> +++ b/git.c
> @@ -320,6 +320,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
>  		{ "cherry", cmd_cherry, RUN_SETUP },
>  		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
> +		{ "clean", cmd_clean, RUN_SETUP },

You definitely want to have NEED_WORK_TREE here, too.

Ciao,
Dscho
