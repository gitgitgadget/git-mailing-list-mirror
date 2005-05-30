From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4]
Date: Sun, 29 May 2005 23:58:37 -0700
Message-ID: <7vekbp8ajm.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 08:56:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DceC9-0008Qb-Oo
	for gcvg-git@gmane.org; Mon, 30 May 2005 08:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVE3G6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 02:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVE3G6m
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 02:58:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43964 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261342AbVE3G6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 02:58:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530065836.DQSR12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 02:58:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 16:41:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

	as promised, I am sending a couple of further cleanup,
and a pair of new diffcore routines.

I am assuming that you would have applied the three clean-up
patches I sent after you rejected some of my 12-piece set,
before you use these four.  They come on top of the previous
three.  Although I do not think they depend on the previous
three, I am letting you know that that was how I tested these
four:

    [PATCH 1/4] diff: further cleanup.
    [PATCH 2/4] diff: fix the culling of unneeded delete record.
    [PATCH 3/4] Add -B flag to diff-* brothers.
    [PATCH 4/4] Add -O<orderfile> option to diff-* brothers.

The third one is the gem of this series.  I think I covered the
basics I can think of in the new test script, but there could
still be cases that rename/copy detector does something
interesting when broken pairs are involved.  Please give it a
good beating before you use it for anything important.  This
being diff routine, it obviously cannot corrupt your data,
though.

The fourth one was what both you and Petr expressed reluctance,
although Thomas was supportive.  I admit it is of "nice to have"
category not "great we need to have it inside" category, but it
is my favorite.

Oh, before I forget, I was wondering if you want me to mark
broken pair in any special way, just line I mark matched
rename/copy pairs.  Something along the lines of:

    diff --git a/foo b/foo
    dissimilarity index 100%
    deleted file mode 100644
    --- a/foo
    +++ /dev/null
    @@ ...
    diff --git a/foo b/foo
    dissimilarity index 100%
    new file mode 100644
    --- /dev/null
    +++ a/foo
    @@ ...


