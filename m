From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 12:20:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101208500.3148@woody.linux-foundation.org>
References: <C3AC2971.10D2D%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD3te-00076g-8X
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 21:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYAJUUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 15:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYAJUUd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 15:20:33 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60536 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753154AbYAJUUc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 15:20:32 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AKKGoa026438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 12:20:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0AKKFGo007507;
	Thu, 10 Jan 2008 12:20:16 -0800
In-Reply-To: <C3AC2971.10D2D%jefferis@gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70082>



On Thu, 10 Jan 2008, Gregory Jefferis wrote:
> 
> I'm not sure that I understand the whole deal about platform default line
> endings.  Isn't plain git functionally agnostic about line endings?  You can
> check in CRLF text files to git and it doesn't care.  You can diff, show etc
> just fine.  I haven't yet found anything that breaks with CRLF files.  In
> this sense plain git is already Windows ready.  Maybe I'm missing something?

If you work together with other people on other platforms, then CRLF is a 
major pain in the *ss.

So you have various options:

 - only develop on unix-like platforms: lines end with LF, and nobody has 
   any problems regardless of autocrlf behaviour. Might as well consider 
   everything binary.

 - only develop on windows, using only one set of basic tools: lines 
   normally end with CRLF, and nobody cares. Migth as well consider 
   everything binary.

 - Mixed windows/unix platfoms, but the Windows people are constrained to 
   use only tools that write text-files with LF. Might we well consider 
   everything binary.

   Quite frankly, Johannes seems to argue that this is a viable 
   alternative, but I seriously doubt that is really true. Yes, there are 
   lots of Windows tools (pretty much all of them by now, I suspect) that 
   *understand* LF-only line endings, but it's also undoubtedly the case 
   that if you allow windows developers to use their normal tools, a 
   number of them *will* write files with CRLF.

 - Mixed windows usage - either with other UNIX users, or even just 
   *within* a windows environment if *some* of the tools are basically 
   UNIX ports (ie MinGW or Cygwin without text-mounts)

   In this case, some tools will write files with CRLF, and others will 
   write them with LF. Again, usually all tools can *read* either form, 
   but the writing is mixed and depends on the tool (so if you work in a 
   group where different people use different editors, you will literally 
   switch back-and-forth between LF and CRLF, sometimes mixing the two in 
   the same file!).

   This one - at the very least - basically requires "autocrlf=input". 
   Anything else is just madness, because otherwise you'll get files that 
   get partly or entirely rewritten in the object database just due to 
   line ending changes.

So in *most* of the situations, you probably don't need to worry about 
autocrlf. But the thing is, I'm almost 100% convinced that the moment you 
have even *one* windows developer, and any UNIX experience at all (whether 
due to people actually working on unix, or just using unixy tools under 
Windows), you will end up in that final case that really does want 
autocrlf.

			Linus
