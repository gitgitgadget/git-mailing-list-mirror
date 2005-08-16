From: Junio C Hamano <junkio@cox.net>
Subject: Re: How do I track pu branch?
Date: Mon, 15 Aug 2005 19:55:40 -0700
Message-ID: <7vd5oepp3n.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050815185629e5c4b6@mail.gmail.com>
	<7v4q9qr4gn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 04:56:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4rcF-0007EZ-9u
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 04:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVHPCzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 22:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHPCzs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 22:55:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39096 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964809AbVHPCzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 22:55:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816025540.NPSZ19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 22:55:40 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <7v4q9qr4gn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 15 Aug 2005 19:38:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
>> Following an extenal repo, I am not getting all the heads. This is by
>> design, AFAIK, and the question is how do I find what heads the repo
>> offers and pull them in so I can call them by name?

Sorry, "git ls-remote" was the answer to only the first
question.  Regarding your second question.

Once you have found out about them, the way to use shorthand the
current tool offers is:

	$ echo 'http://www.kernel.org/pub/scm/git/git.git/#pu' \
            >.git/branches/ko-pu
	$ git fetch ko-pu

Any "git fetch" creates .git/FETCH_HEAD file which holds the
SHA1 object name of the fetched commit, but when shorthand
recorded in .git/branches is involved, it additionally creates
the file ".git/refs/heads/ko-pu".  Then you could:

	$ git checkout -b for-junio ko-pu
        $ git apply --index <cvsimport-use-kk-flag.patch
        $ git commit -v -s
        $ git format-patch ko-pu..HEAD

Note.  As I may have said elsewhere, "pu" branch in git.git
repository is rebased almost daily, so please be prepared to
throw away any branches you may fork off from it.

Note.  The shorthand notation for the pull/fetch side is planned
to be enhanced so that you can keep track of multiple remote
heads.  That has not happened yet.
