From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question Building Deb Packages
Date: Mon, 21 Nov 2005 21:01:49 -0800
Message-ID: <7vr799i8ci.fsf@assigned-by-dhcp.cox.net>
References: <E1EeOHi-0007Bx-HH@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:02:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQHy-0000mT-Uy
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKVFBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKVFBv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:01:51 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:252 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932250AbVKVFBv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 00:01:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122050051.NXAU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 00:00:51 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EeOHi-0007Bx-HH@jdl.com> (Jon Loeliger's message of "Mon, 21
	Nov 2005 20:53:30 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12521>

Jon Loeliger <jdl@freescale.com> writes:

> It _appears_ that the "deb" make target requires it to be
> done in an actual git repository.

I think we could cheat:

    $ tar zxf original-tarball-of-0.99.9j.tar.gz
    $ cd there
    $ fakeroot debian/rules binary

But you are right; "make deb" at the toplevel would not work
well on a virgin machine, because it uses git-tar-tree to do the
tarball construction; we inherited this braindamage from RPM
building procedure.  So if you do not want to cheat:

    $ tar zxf original-tarball-of-0.99.9j.tar.gz
    $ cd there
    $ make install ;# to install in $HOME/bin
    $ cd ..
    $ git clone git://kernel.org/pub/scm/git/git.git/
    $ git checkout -b build v0.99.9j
    $ make deb

Then install the resulting deb and get rid of $HOME/bin/git*.
