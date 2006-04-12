From: sean <seanlkml@sympatico.ca>
Subject: Re: Adding color to git diff output.
Date: Tue, 11 Apr 2006 20:38:41 -0400
Message-ID: <BAYC1-PASMTP119CAD2588D00764DB3EA3AEC20@CEZ.ICE>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
	<7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 02:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTTR3-0004OJ-MY
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 02:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWDLAmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 20:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWDLAmP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 20:42:15 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:65321 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751208AbWDLAmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 20:42:14 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 11 Apr 2006 17:46:00 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id AAF54644C28;
	Tue, 11 Apr 2006 20:42:10 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060411203841.3b824062.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 12 Apr 2006 00:46:00.0890 (UTC) FILETIME=[784061A0:01C65DCA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Apr 2006 17:34:10 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 11 Apr 2006, Junio C Hamano wrote:
> 
> > sean <seanlkml@sympatico.ca> writes:
> > 
> > > Linus posted a colorize program a while back[1] but it wasn't taken into git.  
> > > The patch below takes a different approach, adding a GIT_DIFF_PAGER variable.
> > > You can use it by assigning a filter to the environment variable, like so:
> > >
> > > export GIT_DIFF_PAGER="colordiff | less -RS"
> > 
> > Sounds like a nice idea, even maybe suitable in a FAQ.
> > Unfortunately colordiff does not seem to grok diff --cc output,
> > but that is fine ;-).
> 
> Well, the real problem - at least as far as my usage is concerned - is 
> that I'd want colorization to be more integrated so that it can be turned 
> off when not appropriate.
> 
> Think "colorized 'ls'", where if you enable colorization by default, it 
> only colorizes when the output is a tty, so that you can still script 
> things and output things to a file or so, without it getting colorized. 
> 
> Because most "patch" programs (git-apply included) do not want to see 
> colorization ;)
> 
> So I'd suggest that the "git diff" script at a minimum first check whether 
> the output is to a tty before it decides to use GIT_DIFF_PAGER. With 
> perhaps an option to _force_ colorization if you want to.
> 
> Now, I don't actually enable ls-colorization by default, and I probably 
> wouldn't do it for git diff either, but at least for diffs I _might_. But 
> I'd definitely want it to be turned off automatically so that I can do
> 
> 	git diff .. > ~/patch-file
> 
> without having to remember to turn it off explicitly.
> 

What I have is a script ~/bin/gitcdiff:

#!/bin/sh
tty -s <&1 || exec cat
colordiff | less -RS

And then setting GIT_DIFF_PAGER="~/bin/gitcdiff".  When piping to a file 
it just uses cat, but when the output is a terminal device it uses the 
colordiff.

I thought about integrating that logic into git-diff.sh, but i'm not sure
it's always appropriate.

Sean
