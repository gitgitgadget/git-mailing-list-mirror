From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCh] jit-trackdown
Date: Fri, 29 Apr 2005 11:47:54 -0700
Message-ID: <7voebx4dyd.fsf@assigned-by-dhcp.cox.net>
References: <42725AB8.5090501@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:42:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRaRW-0003J8-Fq
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVD2SsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVD2SsE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:48:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12736 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262864AbVD2Sr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 14:47:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429184755.PGUF23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 14:47:55 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42725AB8.5090501@dgreaves.com> (David Greaves's message of
 "Fri, 29 Apr 2005 17:03:04 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> Should really be cg-trackdown

Thanks for your kind words and the patch.

     head="$1"
    +if [ $head == "HEAD" ]; then
    +  head=$(cat .git/HEAD)
    +elif [ -f .git/refs/tags/$head ]; then
    +  head=$(cat .git/refs/tags/$head)
    +elif [ -f .git/refs/heads/$head ]; then
    +  head=$(cat .git/refs/heads/$head)
    +fi
    +

I have been primarily looking at the plumbing side and not the
toilet side, and I still have not grokked cg-* yet.  That's why
I did not do the right thing with these .git/refs/* stuff.  If
this were to become part of cg-* suite, I would recommend just
using $(commit-id) there, which should be the only one that
needs to know the .git/* structure convention.

Have toilet side gitters reached a concensus (or semi-concensus)
on how things under .git/ should be organized?  Is there a
summary somewhere, something along the following lines?

    In subdirectories under $GIT_PROJECT_TOP/.git, you have
    files that have some special meaning to the Cogito layer.
    These files are all 41-byte long, which stores a 40-byte
    SHA1 with terminating newline.  What is stored in each
    location is as follows:

    .git/HEAD           	Head commit object of the
                                current tree. 

    .git/refs/heads/$ext	Head commit object of the
                                external tree $ext.  [*Q1*]

    .git/refs/tags/$tag		Named Tag object. [*Q2*]

    *Q1* What is the syntax and semantics rule for $ext, like
         "$ext matches '^[-A-Za-z0-9_]$' and is one of the
         entries in .git/remotes"?

    *Q2* What is the syntax and semantics rule for $tag, like
         "$tag matches '^[-A-Za-z0-9_]$' and can be anything not
         just commit"?

