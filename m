From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Library code for user-relative paths.
Date: Tue, 01 Nov 2005 16:14:40 -0800
Message-ID: <7vk6fr6h3j.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.2C6035BA82@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:15:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6H8-0007l6-DM
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVKBAOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVKBAOm
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:14:42 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9721 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751470AbVKBAOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:14:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102001403.NBCP29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 19:14:03 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10976>

Andreas Ericsson <ae@op5.se> writes:

> +			if((slash = strchr(dir, '/'))) {
> +				*slash = '\0';
> +				pw = getpwnam(dir);
> +				*slash = '/';

Should you be writing into *slash when dir and path are const
char *?  I know strchr returns "char *" and the compiler would
not complain but this sounds somewhat yucky.

> +		if(slash && *slash + 1)

I think you mean "if (slash && slash[1])" here.  While we are at
it, please have a SP betweeen if and open parenthesis.

> +			dir = slash + 1;
> +		else
> +			dir = current_dir();
> +	}
> +
> +	/* ~foo/path/to/repo is now path/to/repo and we're in foo's homedir */
> +	if(chdir(dir) < 0)
> +		return NULL;

Hmm.  It's not wrong, but "dir = current_dir()" immediately
followed by "chdir(dir)" does not feel right.
