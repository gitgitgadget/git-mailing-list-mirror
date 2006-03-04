From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-repack && git-prune-packed isn't doing it's job anymore?
Date: Fri, 03 Mar 2006 16:53:40 -0800
Message-ID: <7v64mv2for.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90603031629qbbb287ckd8da1ef56a831dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 01:54:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFL1o-0003fM-7D
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 01:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWCDAxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 19:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCDAxp
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 19:53:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:59111 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751731AbWCDAxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 19:53:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304005004.UOOM17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 19:50:04 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90603031629qbbb287ckd8da1ef56a831dba@mail.gmail.com>
	(Martin Langhoff's message of "Sat, 4 Mar 2006 13:29:52 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17162>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> $ find .git/objects -type f | grep -v pack | wc -l
>     3297
> $ git-repack && git-prune-packed
> Generating pack...
> Done counting 664 objects.
> Deltifying 664 objects.
>  100% (664/664) done
> Writing 664 objects.
>  100% (664/664) done
> Total 664, written 664 (delta 384), reused 0 (delta 0)
> Pack pack-f38c51a5d5194d6a2f6e711586b9a51980c8d524 created.
> $ find .git/objects -type f | grep -v pack | wc -l
>     2583

The last one would be "git count-objects", but repack packs
things that are reachable from your refs and prune-packed
removes what are in packs, so perhaps these are unreachable
objects?  I'd imagine fsck-objects would say they are dangling.

If that is the case, "git prune" would be the right tool to use.

And this is not something that changed recently.
