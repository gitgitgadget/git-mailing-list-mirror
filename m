From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Fri, 16 Dec 2005 09:40:45 -0800
Message-ID: <7v3bktj5ya.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<68948ca0512160739g12a3e25en256bae8c354c3a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 18:41:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnJZb-0000dQ-6Y
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 18:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVLPRks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 12:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVLPRks
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 12:40:48 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38876 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750751AbVLPRkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 12:40:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051216174006.MREH15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Dec 2005 12:40:06 -0500
To: Don Zickus <dzickus@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13741>

Don Zickus <dzickus@gmail.com> writes:

>> While I am sympathetic, this "Oops, I said pull when I meant
>> fetch" sounds remotely similar to "oops, I said 'rm -r' when I
>> meant to say 'ls -r'".  Is it that the tool is too fragile?
>
> Sorry, wrong choice of words.  Didn't mean to imply anything negative.
> Though, I am still learning the tool and its features, I do appreciate
> your feedback and your last email was correct in understanding the
> mess I created.  I'll go read up on the differences between 'fetch'
> and 'pull'.

I too was a bit too defensive, and I agree the tool is prone to
easy errors; the worst part is that there is no "rm -i"
equivalent to be extra careful [*1*].  On the other hand, we
have "git reset" to recover from, so it is not as bad as
a mistake with "rm" ;-).

If for example there were a way to say "this `origin' shortcut
is to be pulled into `master' branch and nothing else", we could
have caught the "git pull" you had trouble with.  There was a
discussion on the list in the past to extend remotes/ files to
allow such restriction of the patchflow to be expressed, but
back then I felt the kind of restriction the proposal could
express was too limiting, and the discussion was a bit premature
because we did not have recommended patterns yet.

We might want to revive the discussion post 1.0.  Taking the
example of the topic-branch workflow by Tony, the "patch flow"
language needs to be able to express something at least this:

 - topic branches -- branched from 'origin' somewhere in the
   past; commits accumulated but usually nothing is merged
   into them.

 - 'test' -- branched from 'origin' somewhere in the past; used
   solely to merge topic branches into it and no commits are
   made into it directly; branches that are regularly merged
   into it are:

   - topic branches
   - 'origin'
   - 'release'

 - 'release' -- branched from 'origin' somewhere in the
   past; trivial/obviously correct commits are made into it
   directly; proven to be good topic branches are merged into it
   for consumption by others; branches that are regularly merged
   into it are:

   - topic branches
   - 'origin'
   - never 'test' 



[Footnote]

*1* IMHO "rm -i" is not that safe, though.  If one overuses it,
it trains one's fingers to say "y" without much thinking.
