From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Mon, 14 Aug 2006 00:00:38 -0700
Message-ID: <7vac67g5t5.fsf@assigned-by-dhcp.cox.net>
References: <20060814064336.GE21963@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 09:00:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCWRH-0001Q0-Kp
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 09:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWHNHAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWHNHAk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 03:00:40 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7892 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751901AbWHNHAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 03:00:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814070039.EKQT14543.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 03:00:39 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060814064336.GE21963@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 14 Aug 2006 09:43:36 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25327>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> $ git pull origin
>
> where origin is a file in .git/remotes/origin with multiple Pull: lines,
> then I seem to get an octopus merge.

You shouldn't.

I have four Pull: lines like these for .git/remotes/ko

        URL: kernel.org:/pub/scm/git/git.git/
        Pull: master:refs/tags/ko-master
        Pull: next:refs/tags/ko-next
        Pull: +pu:refs/tags/ko-pu
        Pull: maint:refs/tags/ko-maint
        Push: heads/master
        Push: heads/next
        Push: +heads/pu
        Push: heads/maint

and "git pull ko" leaves this in .git/FETCH_HEAD:

        460c...		branch 'master' of .kernel.org:/pub/scm/git/git
        767f...	not-for-merge	branch 'next' of .kernel.org:/pub/scm/git/git
        9bd4...	not-for-merge	branch 'pu' of .kernel.org:/pub/scm/git/git
        9a1a...	not-for-merge	branch 'maint' of .kernel.org:/pub/scm/git/git

The latter three are not merged into the current branch with the
above pull command.

Are you by any chance running a version of git that has some
unofficial patches that affect the generation of not-for-merge
markers?
