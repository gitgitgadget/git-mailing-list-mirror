From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to do these 2 one-liners ?
Date: Mon, 19 Mar 2007 15:44:59 -0700
Message-ID: <7vwt1cetuc.fsf@assigned-by-dhcp.cox.net>
References: <46d6db660703191525w613b02e1nae0f30efaca3b269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQbB-0001MP-OI
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 23:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbXCSWpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbXCSWpA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 18:45:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36139 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbXCSWpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 18:45:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319224500.ZMAN748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 18:45:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cmkz1W00Q1kojtg0000000; Mon, 19 Mar 2007 18:44:59 -0400
In-Reply-To: <46d6db660703191525w613b02e1nae0f30efaca3b269@mail.gmail.com>
	(Christian MICHON's message of "Mon, 19 Mar 2007 23:25:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42677>

"Christian MICHON" <christian.michon@gmail.com> writes:

> ================================================
> 1) how do I check the status of a single file ? ( the file is already
> added in the index)
>
> I usually use git-status here, but for single files that need update,
> there should be a faster way.

"git-diff-files $PATH" shows if it is different relative to the
index, "git-diff-index HEAD $PATH" shows if it is different from
the HEAD, and "git-diff-index --cached $PATH" shows if it is
different between index and HEAD.  git-status uses the first one
and the third one AFAIR.  You say "that need update", so
probably you are interested in seeing the first one only without
the third one.

If you have Git 1.5.1, then:

	if git diff-files --quiet $PATH
        then
        	echo Up to date
	else
        	echo Need update
	fi                

Another more portable way is:

	if test -z "$(git diff-files --raw $PATH)"
        then
        	echo Up to date
	else
        	echo Need update
	fi                

> ================================================
> 2) how do I find in historical reverse order all the commits a
> certain file belongs to since the origin ?
>
> I usually do: git-log <file> | grep ^commit
> I would like to avoid piping here...

git-rev-list -m HEAD -- "$PATH"
