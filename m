From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 16:05:46 -0700
Message-ID: <7vd5shm94l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
	<7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:02:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZ3L-0007E5-GM
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVDZXGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVDZXGR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:06:17 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55259 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261839AbVDZXFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 19:05:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426230547.UOTV20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 19:05:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 15:40:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Why not just make this the default? Who really cares about
LT> show-diff?

Me, to care enough about it to send patches in ;-).

LT> So why not just make "rational" the standard format, and then make 
LT> "diff-tree-helper" warn about unmerged ("U") files?

LT> As far as I can tell, that is really what _everybody_ wants.

I do not think of a good reason to forbid people from getting a
patch out of core GIT without going through the wrapper layer,
and the code is already there.  That said, I agree that scripts
usually do not use patch generating form.  I checked Cogito
before doing the patch to make sure it is not affected by this,
and my JIT core tools do not use it either.

I think making the diff-tree/cache compatible output default
would be fine.  The current diff-producing behaviour can be made
into an option (yes, I want to keep it).

LT> And calling "-r" "rational", when it means "recursive" for
LT> diff-tree and diff-cache doesn't sound rational to me.

Well, the truth is that -r does not stand for anything.  It just
is there to match useless -r to diff-cache (the change you made
to it to accept the same command line parameters -r (and
optionally -z) people would always give diff-tree.  You can call
it recursive if you want.

How about me doing the following and resubmitting?

 - Make this diff-tree/cache compatible output the default.

 - Take but ignore -r flag like diff-cache.

 - Add U warning to diff-tree-helper.

 - Add -p flag (patch) and have it cause the patch generating
   behaviour. 

Later I'll add -p flag to diff-cache and diff-tree, so the usage
of these three commands match.  That is:

    show-diff  -r (useless) -z           | diff-tree-helper -z
    diff-cache -r (useless) -z tree      | diff-tree-helper -z
    diff-tree  -r           -z tree tree | diff-tree-helper -z

    show-diff  -p [-r (useless)]
    diff-cache -p [-r (useless)]
    diff-tree  -p [-r]

With the GIT_EXTERNAL_DIFF envioronment variable, I suspect that
wrapper scripts do not have to use the diff-tree-helper but
directly use the -p form; but that will come later.  Thoughts?

