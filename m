From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 19:19:21 -0700
Message-ID: <7vk6n0vnbq.fsf@assigned-by-dhcp.cox.net>
References: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:16:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLnW-0000Y7-JY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVDRCT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVDRCT3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:19:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21183 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261606AbVDRCTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 22:19:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418021921.WEDX19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 22:19:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171833450.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 17 Apr 2005 19:05:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sun, 17 Apr 2005, Junio C Hamano wrote:
>> 
>> This is the alternative strategy I mentioned in my previous
>> message.  A new -m option to checkout-cache causes it to store
>> contents of unmerged paths in path~1~, path~2~, and path~3~.

LT> I don't think this is wrong, but it all seems a bit hacky. The reason I 
LT> didn't apply your other patch was that I just don't feel quite comfortable 
LT> with what is the RightThing(tm) to do yet.

I do not personally like that '-m' thing either so please feel
free to drop it.  I was just toying with the idea.  I knew you
would not use "-m" yourself (and I would not myself either).
The patch was primarily meant for Pasky to raise his opinion.
If having something like this helps Cogito then he can keep it.
If Cogito will be doing the "show-files --unmerged" with
"cat-file blob" itself and this "checkout-cache -m" does not
help it that much then there is no point having this hack.

LT> I'm actually fairly certain that the right thing to do is to silently 
LT> ignore all unmerged entries. They just aren't "interesting" from a 
LT> checkout-cache perspective, least of all when given the "-a" flag. So even 
LT> warning about them seems to be pointless.

I do not mind your dropping the "warning" bit, but please keep
the skipping bit for "-a".  Dropping that TT from stage 1 into
the working directory and then complaining that TT exists when
it then tries to extract stage 2 and stage 3 is simply madness.

LT> What do you think? I can whip up a "merge-cache" program like that in five 
LT> minutes, and it _seems_ like the right interface..

Yes.  I think that is the right thing to do.  In fact the idea
is quite similar to what I've been working on, which is a
rewrite of that perl thing to use "read-tree -m O A B".

