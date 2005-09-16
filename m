From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon --inetd
Date: Fri, 16 Sep 2005 00:51:39 -0700
Message-ID: <7vbr2tqwl0.fsf@assigned-by-dhcp.cox.net>
References: <43290EFF.3070604@zytor.com>
	<Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 16 09:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGB0a-0006a4-IO
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 09:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVIPHvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 03:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVIPHvm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 03:51:42 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64709 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932606AbVIPHvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 03:51:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916075139.NTRO2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 03:51:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 15 Sep 2005 09:03:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8671>

Linus Torvalds <torvalds@osdl.org> writes:

> Hmm.. That should work fine. You can already just run it that way by just 
> wrapping it in "chroot", but if you don't want that for some reason, how 
> about a patch like this?

Later exchanges between you and HPA appeared to me that we would
need a chroot environment which has "enough stuff" and that this
patch may not help him very much.  Am I mistaken?

If not, then...

> +		if (!strncmp(arg, "--chroot=", 9)) {
> +			if (chroot(arg+9) < 0)
> +				die("unable to chroot to '%s': %s", arg+9, strerror(errno));
> +			if (chdir("/") < 0)
> +				die("unable to chdir to new root");
> +
> +			user = user ? user : "nobody";
> +			group = group ? group : "nobody";
> +			continue;
> +		}
> +
> +		if (!strncmp(arg, "--user=", 7)) {
> +			user = arg+7;
> +			continue;
> +		}

I think resolving user and group to numeric before you do
chroot() might make the setting up of chrooted environment a
little simpler; no need for supporting getpwnam and getgrnam
there.  On the other hand it may not matter -- you can always
give numeric uid/gid to begin with.
