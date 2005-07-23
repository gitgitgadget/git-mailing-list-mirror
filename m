From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-find-new-files to spot files added to the tree, but not the repository
Date: Sat, 23 Jul 2005 13:44:50 -0700
Message-ID: <7vsly5qmkd.fsf@assigned-by-dhcp.cox.net>
References: <20050723074219.GB3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 22:45:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwQru-0004Ne-6Q
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 22:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVGWUoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGWUoz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 16:44:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3786 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261601AbVGWUoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 16:44:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723204448.IGUX3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 16:44:48 -0400
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> Add git-find-new-files to find files that are in the tree, but
> not checked into the repository.

You _ought_ to be able to just say:

 $ git-ls-files --others --exclude-from=<exclude pattern file>

and be done with it.  Also please see the thread about Cogito
and StGIT's use of .gitignore and .git/exclude files.

The current implementation of "git-ls-files" exclude mechanism
may have rooms for improvements; the last time I checked, it
only did the matching of patterns against filename without
leading directories).  The world will be a better place if
somebody extends it, instead of working around its limitation.

I may be tempted to doing it myself, but I'm in the middle of
something else, so ...

> +#	find . -name .git -type d -prune -o -type f -print \
> +#		| grep -v -e .tree1 -e .tree2 \
> +#		| sed -e "s/^\.\///" \
> +#		| sort >.tree1
> +#	git-ls-files | grep -v -e .tree1 -e .tree2 \
> +#		| sort >.tree2
> +#	diff -u .tree1 .tree2

It does not matter since the above is just an example and I
think you should be able to just use "ls-files --others", but
just FYI, you could have written "comm -23 .tree1 .tree2" above
instead of "diff -u".
