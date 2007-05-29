From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log,
 etc.
Date: Mon, 28 May 2007 20:01:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
References: <87bqg724gp.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
 <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
 <87sl9hw0o0.fsf@rho.meyering.net> <alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
 <871wh0ww80.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue May 29 05:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsryO-0002sS-52
	for gcvg-git@gmane.org; Tue, 29 May 2007 05:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbXE2DBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 23:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbXE2DBv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 23:01:51 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:36188 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbXE2DBu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 23:01:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4T31GJ2026741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 20:01:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4T31FP8025763;
	Mon, 28 May 2007 20:01:16 -0700
In-Reply-To: <871wh0ww80.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.56 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48661>



On Mon, 28 May 2007, Jim Meyering wrote:
> 
> Um... maybe you've forgotten that this patch fixes a hole in the
> "old code" (git.c).  Many git tools ignore write (ENOSPC) failures.

Maybe you have not noticed, but my argument has ben about EPIPE.

> Compared to that aspect of the fix, I would have thought EPIPE-
> handling would be a minor detail.  But now, the whole patch has
> become "crap"?

About half the patch was _removing_ EPIPE stuff - not at all about the 
ENOSPC stuff you claim.

And the ENOSPC code could have added the same *correct* code that does the 
right thing for EPIPE.

>   1) Continue to ignore EPIPE write failure: can obscure real errors.
>        BTW, Linus, don't you agree?  You never commented on this point.

THAT'S THE ONLY THING I'VE BEEN COMMENTING ON!

They aren't "obscure real errors". EPIPE is neither obscure _nor_ an 
error.

The code-paths where you removed EPIPE handlign have two cases:
 - SIGPIPE happens: you made no change
 - SIGPIPE diesn't happen: you broke the code.

So remind me again, why the hell do you think your patch is so great and 
so important, considering that it broke real code, and made things worse?

And why don't you just admit that EPIPE is special, isn't an error, and 
shouldn't be complained about? If you get EPIPE on the write, it means 
"the other end didn't care". It does NOT mean "I should now do a really 
annoying message".

It's that simple. You seem to admit that SIGPIPE handling in bash should 
have been fixed, and that it was annoying to complain about it there. Why 
can't you just admit that it's annoyign and wrong to complain about the 
same thing when it's EPIPE?

			Linus
