From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Mon, 21 Nov 2005 12:45:06 -0800
Message-ID: <7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	<cda58cb80511170236p4a7e2baay@mail.gmail.com>
	<Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	<cda58cb80511171347yef4f090g@mail.gmail.com>
	<Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	<cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	<Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	<7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80511211211l2ff6ff12j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 21:46:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeIXS-0007Ok-Hc
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 21:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKUUpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 15:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVKUUpL
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 15:45:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8622 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932349AbVKUUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 15:45:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121204349.OFBL17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 15:43:49 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	(vagabon.xyz@gmail.com's message of "Mon, 21 Nov 2005 21:11:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12479>

Franck <vagabon.xyz@gmail.com> writes:

> ... But since I used grafting to "cut"
> my light repo and .git/info/grafts file is not copied during
> push/pull/clone operations it's not going to work. Is it a scheme that
> could work ?

If you tell your downloaders that your repository is incomplete
and they need to have at least up to such and such commits from
another repository, they should be able to slurp from you.

It might be possible to teach upload-pack (that is run when your
downloaders run git-fetch or git-clone against your repository)
to somehow send a customized error message to the client when it
finds the other end needs certain objects that you yourself do
not even have. In that message you could say something like "due
to space constraints this repository is an incomplete one, and
you can only use it on top of a clone of such and such
repository, found at this URL: ...".

> Moreover, I'm wondering if my public repository really needs to store
> big repo's pack files as it is described in git tutorial ?

Copying is one way, but if the repository you are borrowing from
lives on the same machine, you could use objects/info/alternates
to point at it from your public repository.  In either case, the
point in that section is to reduce the need to transfer and
expand much stuff in your public repository while keeping the
repository complete.  The recommended procedure in the tutorial
always assumes that the public repository is kept fsck-objects
clean and complete.

What you are trying to do is to keep your public repository
fsck-objects *un*clean and still let downloaders work with it;
so I suspect following that section of the tutorial procedure
defeats the purpose your experiments.
