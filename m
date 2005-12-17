From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 17:32:55 -0800
Message-ID: <7vd5jwcxtk.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	<7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
	<7vy82keo8p.fsf@assigned-by-dhcp.cox.net>
	<68948ca0512161335k50a3ec64lee6f73ea4f8ae23f@mail.gmail.com>
	<7voe3gd6ul.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512170056380.11000@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 02:34:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnQwf-0006wG-EB
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 02:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVLQBdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 20:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVLQBdG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 20:33:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45782 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750980AbVLQBdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 20:33:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217013305.BRVJ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 20:33:05 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512170056380.11000@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 17 Dec 2005 00:58:50 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13766>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> just a thought: maybe in this case -- git fails to recognize a rename -- 
> Pasky's idea would have some merit. You could then provide git with some 
> extra information a la .git/info/grafts: "Even if you, git, do not believe 
> it: this file *was* renamed from blah to blop".

Yeah, except small details such as: where does it record it, and
how does the information presented to the user, and how does the
user tell git that information should be used?

What would be interesting would be to extend on this thing I
just wrote:

    Something like:

        $ git resolve-renamed-path arch/ppc64/ arch/powerpc/

    to mean "I want the result of this merge to rename ppc64/Kconfig
    to powerpc/Kconfig", perhaps?

I think this would work very nicely even without rename
detectino by the recursive strategy.  What would happen with
resolve strategy is that unchanged paths are removed from
arch/ppc64 and added to arch/powerpc by the usual read-tree
merge rules, and all paths (not just unrecognizable renames --
because resolve would not even try) that have been changed on
the "test" branch would be in stage1+stage3 state in arch/ppc64,
while the corresponding ones in arch/powerpc are collapsed
("only added in test2 branch") to stage0.  The fictional
resolve-renamed-path command (notice that I removed the explicit
"Kconfig" from the sample command line) could go through the
index file, looking for paths that arch/powerpc/ has stage0 and
arch/ppc64 has stage1+3, and perform the renaming merge at that
point.
