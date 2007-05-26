From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Sat, 26 May 2007 09:18:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat May 26 18:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hryyt-0006Ua-JT
	for gcvg-git@gmane.org; Sat, 26 May 2007 18:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbXEZQS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 12:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbXEZQS5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 12:18:57 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:54913 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627AbXEZQS4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2007 12:18:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4QGILpg015286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2007 09:18:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4QGIKrp010972;
	Sat, 26 May 2007 09:18:21 -0700
In-Reply-To: <87bqg724gp.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.451 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48478>



On Sat, 26 May 2007, Jim Meyering wrote:
>
> Each git command should report such a failure.
> Some already do, but with the patch below, they all do, and we
> won't have to rely on code in each command's implementation to
> perform the right incantation.

The patch is wrong.

Some write errors are expected and GOOD.

For example, EPIPE should not be reported. It's normal. The user got 
bored. It might be hidden by the SIGPIPE killing us, but regardless, 
reporting it for the normal log/diff thing is just not correct. EPIPE 
isn't an error, it's a "ok, nobody is listening any more".

Also, PLEASE don't do this:

> +		if (0 <= fcntl(fileno (stdout), F_GETFD)

That's totally unreadable to any normal human.

You don't say "if zero is smaller or equal to X". You say "if X is larger 
than or equal to zero". Stop messing with peoples minds, dammit!

Anybody who thinks that code like this causes fewer errors is just fooling 
himself. It causes *more* bugs, because people have a harder time reading 
it.

Maybe you and Junio have taught yourself bad manners, but you're a tiny 
tiny part of humanity or the development community. Junio can do it just 
because while he's just a single person, he's a big part of the git coding 
base, but anybody else who does it should just be shot.

			Linus
