From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 11:18:42 -0700
Message-ID: <7vu0hfdwql.fsf@assigned-by-dhcp.cox.net>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7zpn-0004M7-Fw
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVHXSSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVHXSSp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:18:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20647 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751345AbVHXSSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 14:18:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824181844.DDQS12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 14:18:44 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7715>

Carl Baldwin <cnb@fc.hp.com> writes:

> Attached are the two scripts.  Comments and criticism are welcome.

An obligatory non-technical comment.  I would have liked to see
this not in a MIME multipart format, which made commenting on it
a bit harder than necessary.

> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: attachment; filename=git-undo-script
>
> #!/bin/sh
>
> . git-sh-setup-script || die "Not a git archive"
>
> if [ -n "$(git-diff-files)" ]; then
>     echo The following files should be updated!
>     echo
>     git-diff-files | awk '{print $6}'
> fi

There is nothing wrong with the above, but I would have written
it like this (I think you forgot to exit after showing the list
of files):

    git-update-cache --refresh || exit

Also nice to learn here is "git-diff-files --name-only".

> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: attachment; filename=git-redo-script
>
> #!/bin/sh
>
> . git-sh-setup-script || die "Not a git archive"
>
> if [ -n "$(git-diff-files)" ]; then
>     echo The following files should be updated!
>     echo
>     git-diff-files | awk '{print $6}'
> fi

Same here.

>     currenttree=$(git-write-tree)
>     git-read-tree -u -m $basetree $currenttree $redotree
>     git-merge-cache git-merge-one-file-script -a

Interesting.  Very interesting.
