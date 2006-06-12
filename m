From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 09:12:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
References: <20060612043949.20992.qmail@science.horizon.com> 
 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com> 
 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpp1j-0004cM-NP
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWFLQMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWFLQMX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:12:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752116AbWFLQMV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 12:12:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CGCHgt017742
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 09:12:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CGCGW1026275;
	Mon, 12 Jun 2006 09:12:16 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21709>



On Mon, 12 Jun 2006, Jon Smirl wrote:
> 
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 14525 jonsmirl  16   0  604m 391m 1904 S   24 38.7 916:53.39 git-svnimport
> 20947 jonsmirl  17   0     0    0    0 R    1  0.0   0:00.03 git-svnimport

Hard to tell, it's obviously got short-lived processes there too that it's 
not showing, but equally obviously that svnimport script itself is 
spending an alarming amount of CPU time. I don't think it should do that 
much processing, but since it's written in perl, I can't read it.

Are there any other directories that seem to be growing (eg some temp-file 
directory where the old files aren't cleaned away?). I can't imagine what 
else it could be doing in kernel space than simply some silly filesystem 
operation, but dang it all, Linux filesystems are usually very efficient 
indeed, unless we're talking huge directories (and if it's not the git 
object directory any more, it must be something else).

At least with the cvs importer I have _some_ clue what it's doing, since I 
wrote an earlier version myself (very different, but at least I know what 
the operations are). SVN has always just confused me, and I have no idea 
what svnimport does, so I think I'll have to defer to somebody who 
actually knows the code.

Smurf, have you looked at any larger repositories?

		Linus
