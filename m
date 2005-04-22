From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] More docs
Date: Fri, 22 Apr 2005 15:23:02 -0700
Message-ID: <7vacnq5u49.fsf@assigned-by-dhcp.cox.net>
References: <4269557C.1050606@dgreaves.com>
	<7vwtqu5ymu.fsf@assigned-by-dhcp.cox.net>
	<4269704A.9090503@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6Tv-0007wf-FZ
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDVWXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDVWXP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:23:15 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2766 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261230AbVDVWXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 18:23:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422222303.MKT23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Apr 2005 18:23:03 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4269704A.9090503@dgreaves.com> (David Greaves's message of
 "Fri, 22 Apr 2005 22:44:42 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> Merging
DG> If -m is specified, read-tree performs 2 kinds of merge, a subservient
DG> tree-read if only 1 tree is given or a 3-way merge if 3 trees are
DG> provided.

AFAICR Linus never used the word "subservient" to describe this
case [*R1*].  I do not know if the word is a good fit for
describing what it does.  Sorry, I cannot help you in deciding
if this is the right word nor in picking a better word.  I am
not a native speaker so I had to look it up in the dictionary.

DG> Furthermore, "read-tree" has special-case logic that says: if you see
DG> a file that matches in all respects in the following states, it
DG> "collapses" back to "stage0":
DG>      - stage 2 and 3 are the same
DG>      - stage 1 and stage 2 are the same and stage 3 is different
DG>      - stage 1 and stage 3 are the same and stage 2 is different

That is what I wrote so I should say "sounds good", but after
re-reading it I realize we should describe how these trivial
ones are resolved, like so:

    Furthermore, "read-tree" has special-case logic that says: if you see
    a file that matches in all respects in the following states, it
    "collapses" back to "stage0":

     - stage 2 and 3 are the same;
       take one or the other (it does not make a difference)
     - stage 1 and stage 2 are the same and stage 3 is different;
       take stage 3
     - stage 1 and stage 3 are the same and stage 2 is different
       take stage 2
    
DG> show-files
DG> show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*
>> Although I like it, I do not think -t is in core.  It is Pasky.
DG> Well, it says Copyright (C) Linus Torvalds, 2005 - and Linus describes
DG> it in his discussion so...

My comment was only about the '-t' option.  It is not one of the
options in the core.  Pasky may want to feed the change to
Linus.


[References]
*R1*

    Date:	Tue, 19 Apr 2005 11:27:34 -0700 (PDT)
    From:	Linus Torvalds <torvalds@osdl.org>
    Subject: Re: naive question
    Message-ID: <Pine.LNX.4.58.0504191117570.19286@ppc970.osdl.org>

    On Tue, 19 Apr 2005, Linus Torvalds wrote:
    > 
    > The real expense right now of a merge is that we always forget all the
    > stat information when we do a merge (since it does a read-tree). I have a
    > cunning way to fix that, though, which is to make "read-tree -m" read in
    > the old index state like it used to, and then at the end just throw it
    > away except for the stat information.

    Ok, done. That was really the plan all along, it just got dropped in the 
    excitement of trying to get the dang thing to _work_ in the first place ;)

    ... I'll also make it do the same for a "single-tree merge":

            read-tree -m <newtree>

    so that you can basically say "read a new tree, and merge the stat 
    information from the current cache".  That means that if you do a
    "read-tree -m <newtree>" followed by a "checkout-cache -f -a", the 
    checkout-cache only checks out the stuff that really changed.

