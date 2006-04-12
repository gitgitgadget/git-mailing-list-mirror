From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Adding color to git diff output.
Date: Tue, 11 Apr 2006 17:34:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604111725590.14565@g5.osdl.org>
References: <BAYC1-PASMTP08B0DB32592225AAD0838AAECD0@CEZ.ICE>
 <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 12 02:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTTJj-0002d8-V3
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 02:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDLAek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 20:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDLAek
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 20:34:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751182AbWDLAek (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 20:34:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3C0YCtH016939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Apr 2006 17:34:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3C0YAbP017896;
	Tue, 11 Apr 2006 17:34:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virpf4sg4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18623>



On Tue, 11 Apr 2006, Junio C Hamano wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> > Linus posted a colorize program a while back[1] but it wasn't taken into git.  
> > The patch below takes a different approach, adding a GIT_DIFF_PAGER variable.
> > You can use it by assigning a filter to the environment variable, like so:
> >
> > export GIT_DIFF_PAGER="colordiff | less -RS"
> 
> Sounds like a nice idea, even maybe suitable in a FAQ.
> Unfortunately colordiff does not seem to grok diff --cc output,
> but that is fine ;-).

Well, the real problem - at least as far as my usage is concerned - is 
that I'd want colorization to be more integrated so that it can be turned 
off when not appropriate.

Think "colorized 'ls'", where if you enable colorization by default, it 
only colorizes when the output is a tty, so that you can still script 
things and output things to a file or so, without it getting colorized. 

Because most "patch" programs (git-apply included) do not want to see 
colorization ;)

So I'd suggest that the "git diff" script at a minimum first check whether 
the output is to a tty before it decides to use GIT_DIFF_PAGER. With 
perhaps an option to _force_ colorization if you want to.

Now, I don't actually enable ls-colorization by default, and I probably 
wouldn't do it for git diff either, but at least for diffs I _might_. But 
I'd definitely want it to be turned off automatically so that I can do

	git diff .. > ~/patch-file

without having to remember to turn it off explicitly.

		Linus
