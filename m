X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:35:37 -0800
Message-ID: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<200612141136.59041.andyparkins@gmail.com>
	<20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
	<20061214120518.GL1747@spearce.org>
	<Pine.LNX.4.64.0612141251520.18171@xanadu.home>
	<7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
	<20061214200245.GP1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:36:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214200245.GP1747@spearce.org> (Shawn Pearce's message of
	"Thu, 14 Dec 2006 15:02:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34393>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxIz-0003LR-SZ for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932864AbWLNUfl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbWLNUfl
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:35:41 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44322 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932898AbWLNUfj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:35:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214203539.YTTZ20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 15:35:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ykbq1V00H1kojtg0000000; Thu, 14 Dec 2006
 15:35:50 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Does anyone on the mailing list really have an objection to having
> reflogs on by default?

When you talk about potential breakage for existing users, you
should not be asking people on THIS list.  You instead should
talk with or at least think about people on linux-kernel, x.org
and wine people, and possibly others.  git is maturing, and we
cannot expect that most of the users are paying attention to
what is happening on this list anymore.

I 100% agree that it makes sense to have reflog enabled for a
repository with an associated worktree.  I would say that we do
not even need it to be conditional on the configuration variable
for such a repository.

My answer to your question is:

	kernel.org:/pub/scm/

I would REALLY be worried to have reflog enabled at a public
distribution point where the only ways the owners interact with
it daily are 'git push' and 'git pull'.  As you mentioned, there
is one extra potential receive-pack failure, and in general it
is one more thing that can go wrong, and hard to notice breakage
because it is on the other side of the connection.

Worse yet, there is no easy way to garbage collect.  Even in an
end-user repository with a worktree, the only way to garbage
collect older reflog entries is to edit the reflog files to
remove the top part.

Maybe a check to say if $GIT_DIR is ".git" or ends with "/.git"
then enable it and otherwise honor the configuration variable,
without changing the default in the code (with your patch) nor
in the default configuration ("enable for new repositories" as I
suggested) might be a workable compromise.
