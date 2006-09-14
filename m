From: Junio C Hamano <junkio@cox.net>
Subject: Re: nightly tarballs of git
Date: Thu, 14 Sep 2006 13:06:03 -0700
Message-ID: <7virjq2oyc.fsf@assigned-by-dhcp.cox.net>
References: <20060914172754.GF8013@us.ibm.com>
	<20060914175116.GB22279@redhat.com>
	<7v1wqe45vs.fsf@assigned-by-dhcp.cox.net>
	<20060914193616.GA32735@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 22:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxTP-0006FD-Av
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWINUGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 16:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWINUGI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:06:08 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47008 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751112AbWINUGF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 16:06:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914200604.XJCK3535.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 16:06:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NL5t1V00F1kojtg0000000
	Thu, 14 Sep 2006 16:05:53 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060914193616.GA32735@redhat.com> (Dave Jones's message of
	"Thu, 14 Sep 2006 15:36:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27035>

Dave Jones <davej@redhat.com> writes:

> DATE=`date +%Y-%m-%d`
>
> PROJ="git"
> cd ~/git-trees
> if [ -d $PROJ ]; then
>   cd $PROJ
>   git pull -n
> else
>   git clone -q git://git.kernel.org/pub/scm/git/git.git
>   cd $PROJ
> fi
> snap=git-snapshot-$(date +"%Y%m%d")
> git-tar-tree HEAD $snap | gzip -9 > $PROJ-$DATE.tar.gz

If you are using git-tar-tree (which by the way _is_ the right
thing to do) and if you are just taking an upstream snapshot
without doing your own development (which also is the case
here), then you do not even need a working tree in the directory
this script runs.  It would save your disk space and time to
check out the updated working tree files.

Perhaps...

#!/bin/sh
URL=git://git.kernel.org/pub/scm/git/git.git
PROJ=git

cd ~/git-trees
if test -d "$PROJ"
then
	cd "$PROJ" && git fetch
else
	git clone -q -n "$URL" "$PROJ" && cd "$PROJ"
fi || {
	echo >&2 Something wicked happend.
        exit $?
}
snap=git-snapshot-$(date +"%Y%m%d")
git-tar-tree origin $snap | gzip -9 > $PROJ-$DATE.tar.gz
