From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 19 Feb 2006 23:57:37 -0800
Message-ID: <7v3bieea32.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 20 08:58:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB5vX-0006u5-Im
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 08:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWBTH5k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 02:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWBTH5k
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 02:57:40 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6125 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932690AbWBTH5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 02:57:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220075626.GIGF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 02:56:26 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16469>

The updated pack-object series is now in "next" branch, and
seems to be cooking nicely.  The "reuse from existing pack"
change seems to be a huge win and I haven't found problems in
there.

There now is further performance improvements for git-send-pack
to avoid sending a huge blob or tree object in its full
representation when we know the other end has a suitable object
to use as the base; instead we can just send it out deltified.
The other end would expand it to a loose object and this would
not make abit of difference in the resulting repository -- only
the bandwidth requirement reduction is visible [*1*].

In principle, this is also applicable for fetch-pack, but it
involves a bit of pack protocol change.  The protocol extension
mechanism was done nicely by Johannes a while ago, and we can
use it to implement this with full backward compatibility.

After a bit more testing, we might want to make --thin transfer
the default (even without an option to turn it off -- I just do
not see a point not to use it if it is bug-free).

* The 'master' branch has these since the last announcement.

Junio C Hamano:
      fmt-merge-msg: say which branch things were merged into unless 'master'
      Allow git-mv to accept ./ in paths.
      Documentation: fix typo in rev-parse --short option description.
      fmt-merge-msg: do not add excess newline at the end.
      Merge branch 'jc/mv'
      Merge branch 'jc/merge-msg'


* The 'next' branch, in addition, has these.

Johannes Schindelin:
      Fixes for ancient versions of GNU make
      avoid makefile override warning
      Really honour NO_PYTHON

Junio C Hamano:
      Merge branch 'jc/merge-msg' into next
      Merge branch 'js/portable' into next
      rev-list --objects-edge
      Merge branch 'jc/rev-list' into next
      Thin pack - create packfile with missing delta base.
      send-pack --thin: use "thin pack" delta transfer.
      Merge branch 'jc/pack-thin' into next


[Footnote]

*1* The version of the patch I earlier sent to the list had a
grave performance bug; please do not use it.  The one in "next"
branch has the bug fixed already.
