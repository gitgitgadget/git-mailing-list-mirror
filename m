From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make t8001-annotate and t8002-blame more portable
Date: Sun, 18 Jun 2006 13:58:09 -0700
Message-ID: <7v3be218ri.fsf@assigned-by-dhcp.cox.net>
References: <20060618203321.G2e8b0080@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 22:58:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs4Lc-00043Q-5K
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWFRU6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 16:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWFRU6M
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 16:58:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38074 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750960AbWFRU6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 16:58:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618205810.KOSX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 16:58:10 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060618203321.G2e8b0080@leonov.stosberg.net> (Dennis Stosberg's
	message of "Sun, 18 Jun 2006 22:33:21 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22101>

Dennis Stosberg <dennis@stosberg.net> writes:

> These two tests assume that "sed" will not modify the final line of a
> stream if it does not end with a newline character.  The assumption is
> not true at least for FreeBSD and Solaris 9.  FreeBSD's "sed" appends
> a newline character; "sed" in Solaris 9 even removes the incomplete
> final line.

Gaaah.

> -    'mv file file1 &&
> -     sed -e 1d -e "5s/3A/99/" file1 >file &&
> -     rm -f file1 &&
> +    'perl -pi -e "s/^1A.*\n$//; s/^3A/99/" file &&
>      GIT_AUTHOR_NAME="D" git commit -a -m "edit"'

The first line in the original is removed while the perl version
seems to just makes it empty -- ah, you remove the trailing LF
as well there.  I've never seen this done like this, but OK.

It would have been more obvious if it were written like this:

	$_ = "" if ($. == 1);

but probably it is just me.

Thanks for the patch.
