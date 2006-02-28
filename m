From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Mon, 27 Feb 2006 16:41:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
  <20060227184641.GA21684@hand.yhbt.net>  <20060227185557.GA32142@delft.aura.cs.cmu.edu>
  <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 01:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDsvo-0007I6-TV
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 01:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWB1Ald (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 19:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbWB1Ald
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 19:41:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751851AbWB1Alc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 19:41:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1S0fTDZ020916
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Feb 2006 16:41:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1S0fQks019357;
	Mon, 27 Feb 2006 16:41:27 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16898>



On Tue, 28 Feb 2006, Martin Langhoff wrote:
> 
> git-svn-HEAD "moves" so it's really a bad idea to have it as a tag.
> Nothing within core git prevents it from moving, but I think that
> porcelains will start breaking. Tags and heads are the same thing,
> except that heads are expected to change (specifically, to move
> forward), and tags are expected to stand still.

Well, I wouldn't say that tags are expected to stand still. Some kinds of 
tags are expected to move: a "this is the last tested version" tag would 
be expected to move with testing. 

That said, the movement is _different_ from a branch. A branch is expected 
to move _with_ development, while a tag is expected to either stay the 
same, or move _after_ development.

However, in many ways git really doesn't care much. The "refs/heads" 
directory is the only one that is really special, in that "git checkout" 
refuses to check out a moving branch in anything but that subdirectory. 
The "tags" subdirectory is slightly special to some helpers (like "git 
pull"), which have flags to pull everythying in that subdirectory. 

But other than those two pretty trivial issues, any ref under "refs/" 
should work perfectly fine. I would argue that a specialized tracking tool 
might well be better off without using either "refs/heads" _or_ 
"refs/tags", since those have accepted meaning outside of tracking.

Using a "refs/remotes" subdirectory makes tons of sense for something like 
this. Or something even more specific, like "refs/svn-tracking/". Git 
shouldn't care - all the tools _should_ work fine with any subdirectory 
structure.

		Linus
