From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question around git-shell usage in Everyday Git
Date: Wed, 01 Feb 2006 21:44:40 -0800
Message-ID: <7vbqxqxqk7.fsf@assigned-by-dhcp.cox.net>
References: <200602012301.56141.alan@chandlerfamily.org.uk>
	<7vy80u64xf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011530530.21884@g5.osdl.org>
	<200602020517.05827.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 06:44:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4XH1-0000Mh-7m
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 06:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422951AbWBBFon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 00:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWBBFon
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 00:44:43 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30848 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422951AbWBBFom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 00:44:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202054159.RSHA17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 00:41:59 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602020517.05827.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Thu, 2 Feb 2006 05:17:05 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15484>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> Then each developer would access the repository via
>
> URL:home.chandlerfamily.org.uk:projectx.git
>
> but would be only allowed access if they were on a white list within each 
> project.

This is the part I highly doubt is doable -- without having
separate unix level UID your whitelist mechanism would not work.
And I do not think you would get separate unix level UID without
having separate $HOME/.ssh directory, even if you have prepared
separate unix level UID in your /etc/passwd file.

Come to think of it, it is worse than that.  IIRC, sshd has
rather strict check to make sure that only one unix user can
write into $HOME/.ssh/ directory (obviously the owner of that
$HOME directory, which means the user who has the directory as
her home directory in /etc/passwd).  If more than one unix level
user shares a home directory, I do not think you can satisfy
that checking.

Maybe it does not matter, since they will be pushing the commits
with their name set to committer/author fields and if you trust
them, but then there is no point assigning one UID per user.

One UID per project is probably doable but I do not think that
is a useful arrangement either.

> So the third approach I am now contemplating is to actually create separate 
> users for each project

You still cannot distinguish your users in a project with each
other, which may or may not matter to you.  Also this is
inconvenient for your developer who works on more than one of
your projects -- I think he needs to use one project identity
for each.

So in short, I am mildly negative about this.  If I were doing
this kind of thing I'd have one unix UID and one directory per
one physical user.  What is the real reason (other than "I just
do not want to" feeling) you want to have smaller number of home
directories than you have users?
