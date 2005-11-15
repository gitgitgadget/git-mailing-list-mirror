From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.
Date: Tue, 15 Nov 2005 15:49:18 -0800
Message-ID: <7vsltxeakh.fsf@assigned-by-dhcp.cox.net>
References: <20051115233125.2C0355BF73@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 00:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAYG-0000tm-PE
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVKOXtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVKOXtW
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:49:22 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:20146 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965090AbVKOXtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:49:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115234817.TQRM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:48:17 -0500
To: exon@op5.se (Andreas Ericsson)
In-Reply-To: <20051115233125.2C0355BF73@nox.op5.se> (Andreas Ericsson's
	message of "Wed, 16 Nov 2005 00:31:25 +0100 (CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11972>

exon@op5.se (Andreas Ericsson) writes:

> It's by design a bit stupid (matching ^git rather than ^git-), so as
> to work with 'gitk' and 'git' as well.
>
> Signed-off-by: Andreas Ericsson <ae@op5.se>

Thanks, stupid is fine.

> +/* has anyone seen 'man' installed anywhere else than in /usr/bin? */
> +#define PATH_TO_MAN "/usr/bin/man"
> +static void show_man_page(char *git_cmd)
> +{
> +	char *page;
> +
> +	if (!strncmp(git_cmd, "git", 3))
> +		page = git_cmd;
> +	else {
> +		int page_len = strlen(git_cmd) + 4;
> +
> +		page = malloc(page_len + 1);
> +		strcpy(page, "git-");
> +		strcpy(page + 4, git_cmd);
> +		page[page_len] = 0;
> +	}
> +
> +	execlp(PATH_TO_MAN, "man", page, NULL);
> +}

If you do PATH_TO_MAN absolute, execl would suffice, but just
saying "man" and have execlp look for it would be easier to
manage.
