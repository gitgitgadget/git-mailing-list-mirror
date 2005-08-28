From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Sun, 28 Aug 2005 10:11:25 -0700
Message-ID: <19723.1125249085@lotus.CS.Berkeley.EDU>
References: <7vll2mmkqk.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 19:12:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Qh0-0001Cv-39
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 19:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVH1RL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVH1RL3
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 13:11:29 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:17093 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750820AbVH1RL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 13:11:29 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id j7SHBP6d019725;
	Sun, 28 Aug 2005 10:11:25 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id j7SHBPTp019724;
	Sun, 28 Aug 2005 10:11:25 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vll2mmkqk.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7880>

And Junio C Hamano writes:
 - >  +    Replace C99 array initializers with code.
 - I presume this is to help older compilers?

Yes, so it's relatively unimportant.  I could work
around it in my situation; I only included it 
because it's "necessary" for some Sun compilers on
older Solaris installations.  A static gcc build
works well enough in my situation.

 - >  +    Replace unsetenv() and setenv() with older putenv().
 - I wonder how buggy various implementations of
 - putenv("THIS_ENV_VAR") are to remove the variable.

I don't know, and it doesn't seem to matter in the git 
code.  I didn't see checks for existance, but I may have
missed something.  Most uses replace a NULL with a 
pointer to "", which is why I just used putenv("FOO=").

This is to cope with an older Solaris installation I 
have to use.  ugh.  I can use a better compiler, but 
I'm stuck with the system library.  Other older systems
probably don't have unsetenv(), either.

The "right" way would be to twiddle the environ and 
use execle, but that's nasty.

 - >  +    Replace zero-length array decls with [].
 - This I am ambivalent about.

I'm fine with requiring a limited C99 compiler.  A
pedantic compiler will reject members with a length
of zero.  6.7.5.2 para1 requires a value greater than
zero for a constant array size.  So the code now (with
[0] decls) is neither C89 nor C99.

Jason
