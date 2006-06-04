From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Support for configurable git command aliases (v2)
Date: Sun, 4 Jun 2006 16:31:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041621010.5498@g5.osdl.org>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
 <20060604212050.GV10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 01:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn24p-0002SW-VS
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 01:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWFDXcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 19:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFDXcI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 19:32:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932303AbWFDXcH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 19:32:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54NVt2g014550
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 16:31:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54NVsia027448;
	Sun, 4 Jun 2006 16:31:55 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060604212050.GV10488@pasky.or.cz>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21295>



On Sun, 4 Jun 2006, Petr Baudis wrote:
> 
> And I forgot to mention that it also adds the interactivity test
> requested by Janek - aliases are now interpreted only when stdout is a
> tty.

I don't think that's a good test.

The fact is, I do

	git diff | less -S

all the time, and if I start doing aliases, I'd expect them to work the 
same regardless of whether I piped the output to "less" or not.

Also, a lot of scripts have stdout going to the regular stdout, so I don't 
think it's even a sufficient test for scripting anyway.

So I would suggest some other way to suppress aliases if we need it, not 
based on "isatty()" and frields.

But I suspect that the easiest solution is to just disallow aliases of 
real built-ins. I realize it could be cool, but the fact is, it's also 
extremely confusing if "git diff" does something else than what it's 
supposed to do, and it _will_ break scripts.

The alternatives is to
 - not do aliases for the "git-xyzzy" format
 - and add a special environment flag ("GIT_NO_ALIASES") to allow scripts 
   to easily disable aliases (and add a "export GIT_NO_ALIASES" line to 
   the git-sh-setup.sh script)

Hmm?

		Linus
