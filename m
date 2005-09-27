From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon: path validation, export all option
Date: Mon, 26 Sep 2005 21:19:57 -0700
Message-ID: <7vslvr6t1u.fsf@assigned-by-dhcp.cox.net>
References: <4338AACC.1050305@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK6xq-00067L-Vc
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 06:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVI0EUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 00:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVI0EUB
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 00:20:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25255 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932096AbVI0EUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 00:20:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927042000.RCPD16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 00:20:00 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4338AACC.1050305@zytor.com> (H. Peter Anvin's message of "Mon,
	26 Sep 2005 19:13:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9364>

"H. Peter Anvin" <hpa@zytor.com> writes:

> A first attempt to make git-daemon a bit more suitable for kernel.org 
> use: it allows the user to specify a whitelist of directories, rejects 
> paths which have . or .. in them (to avoid bypassing the whitelist), and 
> allows for an --export-all option.
>
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

I understand the motivation behind --export-all and directory
whitelist and these changes look good.  Thanks.

> +	if ( ok_paths && *ok_paths ) {
> +		int ok = 0;
> +...
> +	}
> +
> +	return 1;		/* Path acceptable */
> +}

A microNit.  You could lose 'int ok' and return 1 directly where
you assign 1 to it and break.

> -	chdir(".git");

I am unsure about this removal of "minor convenience feature".
Although I do not think git-daemon is widely used on the field,
this change breaks existing setup if there is any.
