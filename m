From: Junio C Hamano <junkio@cox.net>
Subject: finding similar blobs (was: Re: $Revision$ keyword replacement?
Date: Tue, 22 Nov 2005 14:42:07 -0800
Message-ID: <7vy83gb8zk.fsf@assigned-by-dhcp.cox.net>
References: <871x18h9ee.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 23:46:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eegs7-0004fa-Kt
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVKVWnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKVWnl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 17:43:41 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:59379 "EHLO
	fed1rmmtai19.cox.net") by vger.kernel.org with ESMTP
	id S965075AbVKVWnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 17:43:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122224210.GDBG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 17:42:10 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <871x18h9ee.fsf@ifae.es> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Tue, 22
	Nov 2005 18:36:41 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12578>

Santi B=E9jar <sbejar@gmail.com> writes:

>         How similar this file is to the file $path in these commit(s)=
?

Very cute.

> tmp=3D`mktemp -t -d git-find-sim.XXXXXXX`
> ...
> git update-index --add $file || exit 1
> tree=3D`git-write-tree`

Are you going through all this trouble just to avoid a blob and
a tree object left dangling after you are done?  Or is there
something else going on?

> rev_arg=3D`GIT_DIR=3D$GIT_DIR_ORIG git-rev-parse --default HEAD --rev=
s-only "$@"`
> revs=3D`GIT_DIR=3D$GIT_DIR_ORIG git-rev-list $rev_arg`
> for i in $revs; do
>     git diff-tree --name-status $i -C $tree | grep $file |
>     sed "s/^/$i:/"
> done

Perhaps

        GIT_DIR=3D$GIT_DIR_ORIG git-rev-list $rev_arg |
        while read one
            git diff-tree --name-status -r $one -C $tree | grep $file |
            sed "s/^/$one:/"
        done

just in case the similar file you will discover is hidden in a
subdirectory?
