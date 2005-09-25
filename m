From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Implementing diff, was Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 09:08:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509250854570.22725@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org> <Pine.LNX.4.58.0509231737140.3308@g5.osdl.org>
 <7vzmq1twh5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509251745160.17672@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 18:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJZ2L-0004QE-Jl
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 18:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVIYQHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 12:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVIYQHP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 12:07:15 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:26252 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932241AbVIYQHO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 12:07:14 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A1160> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 25 Sep 2005 09:06:48 -0700
X-X-Sender: davide@localhost.localdomain
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509251745160.17672@wgmdd8.biozentrum.uni-wuerzburg.de>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9267>

On Sun, 25 Sep 2005, Johannes Schindelin wrote:

>> Linus Torvalds <torvalds@osdl.org> writes:
>>
>>> The GNU diff sources are hard enough to read that I don't think we want to
>>> try to merge the unified diff generation from there.
>>
>> I was talking with GNU diff maintainer and his impression was
>> that CVS folks may have done enough libification -- I'll find
>> time to look at CVS code and see how much damage we are talking
>> about.
>
> I am not sure if it would be wise to completely do away with the current
> method: Often, I call git-diff with my own wdiff-helper. Also, options
> like "-b" to diff are very useful, and would have to be implemented, too.

What you'd have to do, if you chose to use diffutils stuff, is to 
transform the main() of diff in diff_main(), use setjmp/longjmp to capture 
its exit()s, and make it use a proper allocator (if you want to avoid 
leaks upon aborts). You can see an example inside the diff/libgdiff 
directory of this packages:

https://www.cvshome.org
http://www.opencm.org

In that way, instead of executing "diff -u ...", you'd call diff_main() 
with the proper args array. The CVS one (the other project seems dead, 
and they lifted the thing from CVS anyway) should be readily usable.


- Davide
