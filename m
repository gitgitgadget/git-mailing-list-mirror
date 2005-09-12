From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unified merge driver pushed out to "master" branch
Date: Sun, 11 Sep 2005 18:23:09 -0700
Message-ID: <7vhdcroz9e.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
	<7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
	<20050911210557.GC7486@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 03:23:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEd2S-0007EB-Ka
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVILBXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVILBXM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:23:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13763 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751116AbVILBXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 21:23:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912012311.UBJM2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 21:23:11 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050911210557.GC7486@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 11 Sep 2005 23:05:57 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8356>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I am a bit confused about in what state the index should be in after a
> non-clean merge.

Yeah, I was confused when I wrote it.  Sorry.

> The way the 'resolve' strategy do this seems to be more usable than
> "leave unmerged entries in the cache". In particular, 'git diff' gives
> a usable output in this case.

You are certainly correct about what resolve does, and most
likely right what the most usable output is from an end user's
point of view.  While merging, there _could_ be cases where we
would want to take a look at the current head of our head or the
current head of their head, but my reasoning that leaving those
entries unmerged in the index file _might_ help that (which was
the reason behind that 'leave them unmerged' comment) was quite
faulty.  We can say 'git-diff-cache HEAD' and 'git-diff-cache
MERGE_HEAD' with and without --cached for that.  I think the
current 'resolve' behaviour is the most useful one.

> This is Tony Luck's test case, originally described in
> <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>.
>
> I reported the results for my algorithm on this case in
> <20050826184731.GA13629@c165.ib.student.liu.se>. I think that the
> result produced by my algorithm is the result which Tony expected to
> get.

Yeah, I agree.  I might have sounded as if I was saying that the
automated merge must match the actual result otherwise it is
buggy, but that was not what I wanted to say -- rather we might
have found cases where the traditional 'git-resolve' did a wrong
thing which slipped through unnoticed.
