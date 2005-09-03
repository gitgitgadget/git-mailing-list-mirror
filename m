From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Fri, 02 Sep 2005 18:36:10 -0700
Message-ID: <7vek87djat.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 03:36:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBMx5-0003oj-Cw
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 03:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVICBgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 21:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVICBgN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 21:36:13 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42725 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751358AbVICBgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 21:36:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903013612.NULX9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 21:36:12 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4318E754.9000703@zytor.com> (H. Peter Anvin's message of "Fri,
	02 Sep 2005 16:59:16 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8031>

"H. Peter Anvin" <hpa@zytor.com> writes:

> I currently have two klibc trees,
>
> rsync://rsync.kernel.org/pub/scm/libs/klibc/klibc.git
>
> and
>
> rsync://rsync.kernel.org/pub/scm/libs/klibc/klibc-kbuild.git

I cloned them to take a look.  You_do_ seem to have a lot of
renames.

    $ git clone .../klibc.git klibc
    $ cd klibc
    $ git fetch .../klibc-kbuild.git master:kbuild
    $ git diff -M --diff-filter=R -p kbuild..master |
      git apply --summary --stat

shows that there are 36 files moved around and there are not
that much change overall between them.

Currently merge operation of git does not take any advantage of
the rename/copy detection smarts from git-diff-* family.  So
the short answer to your question is unfortunately no.

Given that they are 'related' trees, and we have proper merge
ancestry information ('git show-branch kbuild master' shows they
were merged two commits before klibc's master branch, and
kbuild's master has 8 or so commits since they last merged), we
should be able to do better.  Let me think about it a bit.
