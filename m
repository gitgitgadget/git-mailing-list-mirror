From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 10:14:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 19:15:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNDHi-0007w8-Ef
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 19:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWCYSOl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 13:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWCYSOl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 13:14:41 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:58249 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751599AbWCYSOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 13:14:40 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C6A60> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 25 Mar 2006 10:14:36 -0800
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17990>

On Sat, 25 Mar 2006, Linus Torvalds wrote:

> On Sat, 25 Mar 2006, Linus Torvalds wrote:
>>
>> I'll be taking a look at trying to fix it.
>
> Actually, it ended up being easier than I expected it to be.
>
> This (on top of the previous patch) should fix it.
>
> And yes, with this, I can pass the output of
>
> 	git diff v2.6.16..
>
> to "git-apply" and it not only passes the "--stat" thing (which verifies
> that git-apply is happy with the diff) but it also results in exactly the
> same tree when applied on top of v2.6.16 (and the patch has two cases
> where the "no newline" test triggers).
>
> The speed-up is quite noticeable, especially when doing things like
>
> 	git diff v2.6.16.. | git-apply --stat
>
> which just _used_ to be painfully slow (25 seconds for me) and is now
> under five seconds. That's the difference between "twiddling your thumbs"
> and "ok, that wasn't too bad".

Yeah, that works. It has never been an algorithm problem, but a diff 
output one. And following what GNU diff does looks fine to me. I'll fix 
libxdiff with that. I also have to teach libxdiff patch algo to recognize 
the tag and do the right thing during the patch operation.



> Now, to be honest, the real reason I wanted a built-in diff wasn't the
> speed advantage, but the fact that it's so much more flexible. The lack of
> fork/exec just allows us to do things that weren't practical before.

I don't know if git is patch-forkexec sensitive or not, but if it is you 
can take a look at libxdiff's xdl_patch(), or at libifying GNU patch.



- Davide
