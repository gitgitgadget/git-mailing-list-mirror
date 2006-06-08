From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitignore: regex for the current dir files only?
Date: Wed, 07 Jun 2006 19:40:07 -0700
Message-ID: <7virnccquw.fsf@assigned-by-dhcp.cox.net>
References: <87mzcol7i3.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 04:40:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoARS-0006zT-G1
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 04:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWFHCkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 22:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFHCkK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 22:40:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54711 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750926AbWFHCkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 22:40:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608024008.DWSY12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Jun 2006 22:40:08 -0400
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87mzcol7i3.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Thu, 08 Jun 2006 11:13:24 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21468>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> because we have "vmlinux*" in the toplevel .gitignore in linus's tree,
> all vmlinux.lds.S under arch/$(ARCH)/kernel/ is affected. for kernel,
> it might as easier to remove "*" from the exp.  but I was wandering if
> it's worth to have an expression for gitignore to handle "a regex for
> the current dir only"?

Yeah, that would be a very useful thing to have.  Something like
this?

#!/bin/sh

rm -rf test
mkdir -p test/a/b/c
cd test
git init-db

date >a/vmlinux.1
date >a/b/vmlinux.2
date >a/b/c/vmlinux.3

echo 'vmlinux*' >a/.gitignore
echo '!/vmlinux*' >a/b/.gitignore

git status -u
