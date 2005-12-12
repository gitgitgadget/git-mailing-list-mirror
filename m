From: Junio C Hamano <junkio@cox.net>
Subject: Re: make install bug?
Date: Mon, 12 Dec 2005 09:54:40 -0800
Message-ID: <7vzmn6i4kf.fsf@assigned-by-dhcp.cox.net>
References: <2b05065b0512120735v26c8343aged48165f3ccc5892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 18:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elrsu-0006xA-68
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 18:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLLRyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLLRyn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 12:54:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7381 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932076AbVLLRym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 12:54:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051212175352.LXMV6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 12:53:52 -0500
To: eschvoca <eschvoca@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13528>

eschvoca <eschvoca@gmail.com> writes:

> I can fix the problem by changing templates/Makefile to the following:
>
> install: all
>     $(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
>     (cd blt && $(TAR) cf - . > /tmp/a.tar) | \
>     (cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf /tmp/a.tar)

Here is my guess.  Could you try, from your interactive shell:

	$ (unset CDPATH; make install)

first without the above "fix" (your "fixed" pipe does not make
any sense --- what are the data passed between pipe upstream and
downstream?)?

If that makes the problem go away, then your environment is
broken --- my guess is that you are exporting CDPATH to
non-interactive scripts.  Don't do that.

I once googled for "CDPATH" and saw many "guide to unix" type
webpages talk about "CDPATH environment variable"; they are the
real culprit to cause this confusion in peoples' .bash_profile.
CDPATH might be a nice variable for interactive shells, but is a
horrible one if made environment.
