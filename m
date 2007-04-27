From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Fri, 27 Apr 2007 01:54:55 -0700
Message-ID: <7vd51qp57k.fsf@assigned-by-dhcp.cox.net>
References: <20070426192439.GA6976@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMEe-0006AR-UG
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 10:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbXD0IzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 04:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbXD0IzU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 04:55:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36849 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbXD0Iy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 04:54:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427085455.CYYR22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 04:54:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s8uv1W0041kojtg0000000; Fri, 27 Apr 2007 04:54:55 -0400
In-Reply-To: <20070426192439.GA6976@ferdyx.org> (Fernando J. Pereda's message
	of "Thu, 26 Apr 2007 21:24:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45704>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> +int split_maildir(const char *maildir, const char *dir, int nr_prec, int skip)
>  {
> ...
> +	while ((maildent = readdir(mddir)) != NULL) {
> +		FILE *f;
> +
> +		snprintf(file, sizeof(file), "%s/%s",
> +				curdir, maildent->d_name);
> +
> +		if (maildent->d_name[0] == '.')
> +			continue;
>  ...
> +		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
> +		split_one(f, name, 1);
> +
> +		fclose(f);
> +	}
> +
> +	closedir(mddir);
> +
> +	ret = skip;
> +out:
> +	return ret;
> +}

I do not personally deal with maildir so I do not know for sure,
but this feels very wrong.

What order are you emitting the output?

split_mbox() is designed to number the messages the same order
as they are found in the mailbox, but the above loop relies on
readdir() to give them in a reasonable order to you, which does
not seem a right assumption to me (otherwise "/bin/ls" and
friends would not sort what they read from the filesystem would
they?).
