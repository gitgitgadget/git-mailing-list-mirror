From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multiple checkouts of the same repository
Date: Tue, 03 Oct 2006 00:59:57 -0700
Message-ID: <7vzmcdrfr6.fsf@assigned-by-dhcp.cox.net>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
	<Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com>
	<Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
	<Pine.LNX.4.64.0610022234330.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Matt McCutchen <hashproduct+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 03 10:00:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUfC6-0005xf-Al
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 10:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWJCH77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 03:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWJCH77
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 03:59:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63683 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964936AbWJCH76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 03:59:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003075958.CREO6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 03:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vk001V0061kojtg0000000
	Tue, 03 Oct 2006 04:00:00 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0610022234330.9789@iabervon.org> (Daniel
	Barkalow's message of "Mon, 2 Oct 2006 22:52:31 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28250>

Daniel Barkalow <barkalow@iabervon.org> writes:

> At one point, I was arguing for storing the information of what commits 
> were the starting point of the current index in the index itself, instead 
> of relying on external files and external links to refs, but I wasn't 
> really working on git enough to argue for it effectively. Among other 
> things, it would allow git to know what's going on if the head changes 
> without the index getting updated. (Of course, all of the cases it 
> supports are really ones where git should just tell you that you've done 
> something wrong,...

I think if you really wanted to, you could put it in the index
extension section along with the cache-tree data.  We would need
to implement a way to query and manipulate data in the index
extension and update git-commit (it should check HEAD matches
the commit you placed in the extension earlier, and after making
a commit and updating HEAD, you should update the index with the
new commit as well), git-checkout (after switching branches you
should update the index with the branch head you switched to; I
think you should sanity check before switching to see if the
current index and HEAD are reasonable as well but I am not
sure), git-reset --hard (set to the resetted HEAD), git-am,
git-applymbox, and git-merge (check before and set after when
successful).
