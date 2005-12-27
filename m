From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT preformatted documentation available.
Date: Tue, 27 Dec 2005 00:49:17 -0800
Message-ID: <7vu0cuc4c2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <willy@w.ods.org>
X-From: git-owner@vger.kernel.org Tue Dec 27 09:49:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErAWJ-00037s-LF
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 09:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVL0ItU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 03:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVL0ItT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 03:49:19 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46785 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932269AbVL0ItT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 03:49:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227084819.VURZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 03:48:19 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14071>

I was asked to provide pre-formatted man pages (and perhaps html
pages), since the time of kernel developers are better spent on
what they do best, rather than preparing the xmlto toolchain.

I was planning to do a tarball every time I do a "release", but
that would mean it is no better than the current way --- you
could extract manpages out of rpm anyway.

So instead, I'll do independent branches "html" and "man" in
git.git repository to keep the preformatted documentation.

	$ mkdir git.man ; cd git.man
	$ git init-db
        $ ID=$(git fetch-pack -k git://git.kernel.org/pub/scm/git/git man)
        $ expr "$ID" : '\(.*\) .*' >.git/refs/heads/master
        $ cat .git/refs/heads/master >.git/refs/heads/origin
	$ git checkout; /bin/ls -aF
	./  ../  .git/	man1/  man7/
        $ echo >.git/remotes/origin <<\EOF
        URL: git://git.kernel.org/pub/scm/git/git
        Pull: man:origin
        EOF

Would set you up, and you can
to keep them up-to-date, and install them like so:

	$ cd git.man
	$ git pull
	$ cp -a man1 man7 /usr/local/man/

The "html" branch is similar; it is a copy of what is shown at
http://www.kernel.org/pub/software/scm/git/docs/.

This means if you clone from git.git repository, you would end
up with something like this in .git/remotes/origin file:

	URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
        Pull: todo:todo
        Pull: html:html
        Pull: man:man
        Pull: pu:pu
        Pull: maint:maint

Typically, for the repository to track GIT itself, you would
want to trim them like this:

	URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
        Pull: maint:maint
        Pull: +pu:pu
