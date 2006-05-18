From: Junio C Hamano <junkio@cox.net>
Subject: [WARNING] Please be careful when using "git add" from "next" branch
Date: Thu, 18 May 2006 01:52:44 -0700
Message-ID: <7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
	<7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:52:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgeFV-0002nr-Hd
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWERIwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWERIwq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:52:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45240 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751183AbWERIwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 04:52:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518085245.MTTX17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 04:52:45 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 18 May 2006 01:34:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20276>

There is still a small breakage in the built-in "git add" on the
"next" branch that ends up creating nonsense tree objects.

        $ mkdir foo
        $ date >bar
        $ git-add foo/../bar
        $ git ls-files
        foo/../bar
        $ git ls-tree -r -t $(git-write-tree)
        040000 tree ef5562cd3a9bf66d41a8d4f42f159e8c694ce7e3	foo
        040000 tree 6e1612248e8da43fc5f91592e559da1ad5f9a852	foo/..
        100644 blob 53ab446c3f4e42ce9bb728a0ccb283a101be4979	foo/../bar

If you do not do funky things like foo/../bar, I do not think
you have to worry, but scripted use might break.  It used to
warn and ignore such bogus input, but now it happily accepts it
and produces bogus index which results in bogus trees.

"git update-index --add" is not affected by this breakage.
