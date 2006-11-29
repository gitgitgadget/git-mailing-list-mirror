X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 00:07:38 -0800
Message-ID: <7v8xhusmk5.fsf@assigned-by-dhcp.cox.net>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	<20061026101038.GA13310@coredump.intra.peff.net>
	<877iyne4dm.fsf@alplog.fr>
	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	<456B7C6A.80104@webdrake.net>
	<Pine.LNX.4.64.0611271834090.30076@woody.osdl.org>
	<456CEF31.8080600@webdrake.net>
	<Pine.LNX.4.64.0611281906520.3395@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 08:07:57 +0000 (UTC)
Cc: git@vger.kernel.org, Joseph Wakeling <joseph.wakeling@webdrake.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32622>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpKTs-0008IW-IH for gcvg-git@gmane.org; Wed, 29 Nov
 2006 09:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966223AbWK2IHk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966222AbWK2IHk
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 03:07:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:23966 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S966223AbWK2IHj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 03:07:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129080739.GRDS97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 03:07:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id sY761V00G1kojtg0000000; Wed, 29 Nov 2006
 03:07:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> And the problem seems to go to the "root commit": if the file existed in 
> the root, the logic in "git blame" to diff against the (nonexistent) 
> parent of the root commit won't do the right thing, and that just confuses 
> git blame entirely.
>
> I think Junio screwed up at some point. I'll send him a bug-report once 
> I've triaged this a bit more, but I can recreate your breakage if I start 
> a new git database and create two files in the root, and move data between 
> them in the second commit (but if I instead create the second file in the 
> second commit, and do the movement in the third commit, git blame -C works 
> again ;).

Is it safe to assume that the "automatically turning --show-name
on" fixes this issue and it does not have anything to do with
the root commit?  Given the way the "passing the blame"
algorithm works, there should not be anything special about the
root commit --- if some blame remains in a commit:path pair, and
if the commit does not have parents, it takes the blame right
away without needing to run any diff.

> In fact, I'm pretty hardcore, and I don't think I've ever really used 
> "--soft". It's largely been replaced by "git commit --amend", because 
> amending a commit used to be the only reason to use "--soft", really.
> So it might even be worthwhile just dropping "--soft" and "--mixed" 
> altogether, but in the meantime, you might as well just ignore them.

Everything in the above paragraph is correct.

>> git pull seems to do many things which I would need to use bzr merge 
>> for---I can "pull" between branches which have diverged, for example.  
>> I don't understand quite what git merge does that's different, and when 
>> to use one or the other.
>
> Heh. I'm with you. I'm in the "don't use 'git merge' at all" camp, but it 
> was argued that people coming from non-git backgrounds would find it 
> too confusing to just use "git pull" for merging ;)

Interesting.  I had exactly the same response as yours when I
read Joseph's message ;-).
