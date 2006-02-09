From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: Fatal error from git bisect
Date: Thu, 9 Feb 2006 12:16:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091210230.2458@g5.osdl.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A4A8@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:16:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7IDM-0001SF-C2
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBIUQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWBIUQ0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:16:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWBIUQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 15:16:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19KGHDZ018110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 12:16:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19KGBNs010582;
	Thu, 9 Feb 2006 12:16:14 -0800
To: Mark E Mason <mark.e.mason@broadcom.com>
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D0773A4A8@NT-SJCA-0750.brcm.ad.broadcom.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15822>



On Thu, 9 Feb 2006, Mark E Mason wrote:
> 
> I thought of that, but even removing the workspace file doesn't get
> around this:

That doesn't necessarily help. Removing the workspace file potentially 
just makes the workspace even _more_ dirty, rather than less. It makes git 
think you've edited the file that it wants to check out another verion of.

(Of course, an extra file can _also_ be a sign of being dirty, so 
sometimes removing such a file _does_ generate a "more clean" tree).

Basically, "dirty" means that it doesn't match the head commit. 

> I've made no commits to this tree - it's just an up-to-date pull of the
> linux-mips.org tree.  I also have no local edits at this point.
> 
> [mason@hawaii linux.git]$ git diff
> [mason@hawaii linux.git]$
> 
> What's puzzling me is that (as I understand it) git bisect simply
> manipulates the workspace, not the repository.

Well, it doesn't _change_ the repository, but it does move around in it, 
using "git-read-tree -u -m". That can error out if the old tree and the 
new tree differs in a particular file, and the workspace doesn't match the 
old tree in that file.

Now, it could be a git bug, but before you go there, try to make sure tat 
your tree is really clean. Do a

	git checkout -f master

followed by "git status" to make sure that the workspace is clean (no 
unexpected untracked files, no diffs against HEAD, no nothing). The "git 
checkout -f master" should have cleaned everything up, but it won't 
actually touch extra files that it doesn't know about, so..

		Linus
