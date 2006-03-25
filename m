From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 10:39:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 19:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNDfO-0003sC-At
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 19:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWCYSjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 13:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWCYSjK
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 13:39:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbWCYSjJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 13:39:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PId4DZ024688
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 10:39:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PId34f008276;
	Sat, 25 Mar 2006 10:39:03 -0800
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17991>



On Sat, 25 Mar 2006, Davide Libenzi wrote:
> 
> > Now, to be honest, the real reason I wanted a built-in diff wasn't the
> > speed advantage, but the fact that it's so much more flexible. The lack of
> > fork/exec just allows us to do things that weren't practical before.
> 
> I don't know if git is patch-forkexec sensitive or not, but if it is you can
> take a look at libxdiff's xdl_patch(), or at libifying GNU patch.

I don't need "patch", since I wrote my own anyway. It's just called 
"apply" instead of "patch".

Doing "apply" is not only much simpler than doing "diff", but I needed my 
own much earlier: it's much more timing-critical for me (applying 200 
patches in one go), and git needed something that could honor renames and 
copies, and the mode bits too.

Besides, I hate how GNU patch bends over backwards in applying crap that 
isn't a proper patch at all (whitespace-corruption, you name it: GNU patch 
will accept it). Also, I made "git-apply" be all-or-nothing: either it 
applies the _whole_ patch (across many different files) or it applies none 
of it. With GNU patch, if you get an error on the fifth file, the four 
first files have been modified already - aarrgghhh..

See "apply.c" for details if you care. It's stupid, but it works (and it 
_only_ handles unified diffs - with the git extensions, of course).

(I also absolutely hate the GNU coding standards, so I'd be very unlikely 
to libify any of the FSF projects. With libxdiff, I can actually read the 
code: it may be a bit dense at times, but at least the code is written to 
be readable, unlike most FSF projects).

			Linus
