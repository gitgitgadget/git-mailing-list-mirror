From: Junio C Hamano <junkio@cox.net>
Subject: Re: Destructive side-effect of "cg-status"
Date: Sat, 01 Oct 2005 11:14:32 -0700
Message-ID: <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
References: <20050930160353.F025C352B7B@atlas.denx.de>
	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 20:15:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELlsy-0005pB-Lk
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 20:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJASOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 14:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVJASOj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 14:14:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50922 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbVJASOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 14:14:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001181428.WJLP29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 14:14:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 1 Oct 2005 09:41:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9599>

Linus Torvalds <torvalds@osdl.org> writes:

> -	return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0600);
> +	return open(cf->lockfile, O_RDWR | O_CREAT | O_EXCL, 0666);

Good spotting - thanks.  We tried to use 0666/0777 everywhere
and let umask do its job, but this was one of the two places we
still had 0[67]00.  I'd do the same for the other 0600 in
mailsplit.c, not that I think it matters, but just for
consistency.

Unrelated to the topic at hand, but related to the mode bits --
tar-tree generates archives with 0644/0755 permission bits.  It
might not be a bad idea to just let the tar command honor umask
of the extracter, by storing 0666 and 0777 in the archive.

I always work in an environment where umask 002 is the norm, and
get irritated when upstream tarballs of other peoples' projects
create directories with mode 0755, making me do chmod 2775 on
them.
