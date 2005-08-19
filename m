From: Junio C Hamano <junkio@cox.net>
Subject: [Not A Patch] Octopus demo
Date: Thu, 18 Aug 2005 18:05:07 -0700
Message-ID: <7vy86yd9do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 19 03:06:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJv-0002nY-Cf
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVHSBFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVHSBFK
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:05:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50320 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964785AbVHSBFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:05:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010507.OPHH15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:05:07 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Create an empty directory and running this script in there would
let you see the original Octopus in action.


---
#!/bin/sh

test -d .saved-git || {
    U=http://www.kernel.org/pub/scm/git/git.git
    GIT_DIR=.saved-git
    export GIT_DIR
    git-init-db
    : >$GIT_DIR/FETCH_HEAD
    h=0
    while read SHA1
    do
	    git-http-pull -a -v $SHA1 $U
	    h=$(expr $h + 1)
	    echo $SHA1 >$GIT_DIR/refs/heads/H$h
	    echo "$SHA1	heads/H$h" >>$GIT_DIR/FETCH_HEAD
    done <<\EOF
fc54a9c30ccad3fde5890d2c0ca2e2acc0848fbc
9e30dd7c0ecc9f10372f31539d0122db97418353
c4b83e618f1df7d8ecc9392fa40e5bebccbe6b5a
660265909fc178581ef327076716dfd3550e6e7b
b28858bf65d4fd6d8bb070865518ec43817fe7f3
EOF
    echo ed4eeaf203d0f293bd5ffc2a0ad8711f052db1f3 >$GIT_DIR/HEAD
}

rm -fr testing
git clone -l ./.saved-git testing
cp .saved-git/FETCH_HEAD testing/.git/.

cd testing || exit

git show-branches
git checkout

git octopus || exit

git show-branches
git-rev-list --max-count=1 --pretty HEAD
