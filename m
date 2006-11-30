X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robert Shearman <rob@codeweavers.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 21:33:44 +0000
Organization: CodeWeavers
Message-ID: <456F4E38.50001@codeweavers.com>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>	<456EBBE7.8030404@op5.se>	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>	<20061130164046.GB17715@thunk.org>	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>	<87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 21:35:07 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061116)
In-Reply-To: <87hcwgu5t1.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32803>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GptYG-0001Gw-Aa for gcvg-git@gmane.org; Thu, 30 Nov
 2006 22:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967211AbWK3Vee (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 16:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967913AbWK3Vee
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 16:34:34 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59084 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S967211AbWK3Ved
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 16:34:33 -0500
Received: from host81-155-64-86.range81-155.btcentralplus.com ([81.155.64.86]
 helo=[172.16.0.11]) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GptXt-0002MY-Ot; Thu, 30
 Nov 2006 15:34:18 -0600
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> If the "create file; git add; edit file; git commit" confusion isn't
> blisteringly obvious to the git maintainers then I think I have to
> give up here.
>
> And this isn't just CVS-induced brain damage. It's the user being
> required to mentally juggle 3 states for the file, (the last
> "committed" state, the current "working tree" state, and this
> "something else" state). The sequence above, (which is very natural),
> exposes this "something else" state that to a new user.
>   

Exactly. We had a tutorial for the project I contribute to (admittedly 
the initial users were all used to how CVS worked) and while a number of 
people got the concept of the index and were fairly happy with it, it 
did add to the confusion of the tutorial, so now it doesn't mention the 
index at all.

The tutorial introduced it as a staging area for commits, but the 
trouble is that once you work like this you have to remember that 
"git-diff" won't show you what will be committed, so you have to use 
"git-diff-index" as well. If you get them mixed up then you end up 
committing the wrong thing.

Here's a selected list of the commands introduced in the tutorial, 
without mentioning the index:
git diff
git commit -a
git commit <changed-files>
git reset HEAD^
git cherry-pick

Here would be the same entries, but introducing the index too:
git-update-index
git diff
git diff-index
git commit
git commit -a
git commit <changed-files>
git reset HEAD^
git reset --soft HEAD^
git cherry-pick
git cherry-pick -n

The tutorial then goes from having ~12 common commands to learn up to ~17.

> If we imagine a new user as coming, not from cvs, but coming from
> no revision control system, then it's less confusing to add one single
> new state, (the "last committed" state), in addition to the "working
> tree" state the user is familiar with.
>
> Forcing the user to learn two instead of one is just plain harder,
> (which is completely separate from git _allowing_ this extra state
> once you learn it).

Having the index exposed for even simple operations means that the user 
has to initially learn three states instead of two. The worst thing 
about the index is that it is a limbo state. The committed content is in 
the history and can be viewed by gitk (and other tools that the user 
will be introduced to later) and the working tree is exactly what the 
user sees in their editor. Having a hidden state isn't very good from an 
HCI point of view.

Once you understand the concept of the index, it is very useful. 
However, new users should be shielded from it if at all possible.

I'm not advocating making "git-commit" equal to "git-commit -a" as I've 
been frustrated by command's semantics changing in git before. I can 
understand long-time git users would automatically try to use 
"git-commit" to just commit their index and get annoyed if it did 
something unexpected. Therefore, I would advocate there being no default 
behaviour for "git-commit" except for displaying a help message, and 
making previous "git-commit" users now use "git-commit -i".

-- 
Rob Shearman
