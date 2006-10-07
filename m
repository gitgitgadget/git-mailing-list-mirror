From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Sat, 7 Oct 2006 14:58:02 +0200
Message-ID: <20061007125802.GA20017@pasky.or.cz>
References: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net> <20061006154059.GQ20017@pasky.or.cz> <7vzmc8tqqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 14:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWBku-0005KH-PV
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 14:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWJGM6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 08:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWJGM6G
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 08:58:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19656 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751085AbWJGM6E (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 08:58:04 -0400
Received: (qmail 22862 invoked by uid 2001); 7 Oct 2006 14:58:02 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmc8tqqe.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28479>

Dear diary, on Sat, Oct 07, 2006 at 11:33:29AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> When we introduced symref, "cat .git/HEAD" stopped being the way
> to read the value of the tip of the current branch, "echo
> $commit >.git/HEAD" stopped being the way to update it, and
> "rev-parse --verify HEAD" and "update-ref HEAD $commit" were
> introduced at the same time as the official alternatives to
> support both old and new implementations of .git/HEAD.
> 
> The way to find out which branch we are currently on used to be
> "readlink .git/HEAD"; that stopped to be true, and we introduced
> "symbolic-ref HEAD" as the official alternative to support both
> old and new implementation.
> 
> The way to see if a random symbolic link whose name happens to
> be HEAD is a symref has been to see if it points at a path that
> begins with "refs/".

Cogito does

	[ ! -s "$_git/HEAD" ] || { _git_head="$(git-symbolic-ref HEAD)"; _git_head="${_git_head#refs/heads/}"; }

in the common initialization code, so that cg-reset works even on
repositories with broken HEAD. It hasn't been an issue in the past since
HEAD as a dangling symlink indeed _has_ been broken HEAD in the past.

That said, at least cg-reset will indeed repair it:

	if ! [ -s "$_git/HEAD" ]; then
		rm -f "$_git/HEAD"
		# XXX: git-symbolic-ref is a weenie and won't do the job at this point.
		echo "ref: refs/heads/$_git_head" >"$_git/HEAD"
	fi

But it's still not nice.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
