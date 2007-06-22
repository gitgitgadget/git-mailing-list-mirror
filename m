From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 18:47:12 -0400
Message-ID: <20070622224712.GI17393@spearce.org>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com> <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com> <20070622022426.GA2961@bowser.ruder> <1182496916.6207.11.camel@localhost> <Pine.LNX.4.64.0706221224310.4059@racer.site> <1182519484.6207.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1ruS-0008Bs-1x
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 00:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXFVWrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 18:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXFVWrS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 18:47:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48287 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXFVWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 18:47:18 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1ruC-0001t2-VB; Fri, 22 Jun 2007 18:47:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0E6220FBAE; Fri, 22 Jun 2007 18:47:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1182519484.6207.38.camel@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50713>

Raimund Bauer <ray007@gmx.net> wrote:
> On Fri, 2007-06-22 at 12:26 +0100, Johannes Schindelin wrote: 
> > On Fri, 22 Jun 2007, Raimund Bauer wrote:
> > 
> > > $ git push slcom test:test 
> > > error: dst refspec test does not match any existing ref on the remote
> > > and does not start with refs/.
> > 
> > It says that there is no branch named "test" on the remote side, and since 
> > you could also want to push a tag, you have to say
> > 
> > 	test:refs/heads/test
> > 
> > here. However, I do not understand why you bother to use the :dst syntax 
> > here, since your target name is _exactly_ the same as the source name. Why 
> > not just
> > 
> > 	git push slcom test
> 
> because I had gotten the command line from bash-completion

I just patched the bash completion package to offer `git push slcom
test` as the completion, instead of `git push slcom test:test`.
The patch was pretty trivial, and is now also in my fastimport.git
tree on repo.or.cz.

-->8--
Avoid src:dst syntax as default bash completion for git push

Raimund Bauer just discovered that the default bash completion for
a local branch name in a git-push line is not the best choice when
the branch does not exist on the remote system.

In the past we have always completed the local name 'test' as
"test:test", indicating that the destination name is the same as
the local name.  But this fails when "test" does not yet exist on
the remote system, as there is no "test" branch for it to match
the name against.

Fortunately git-push does the right thing when given just the
local branch, as it assumes you want to use the same name in the
destination repository.  So we now offer "test" as the completion
in a git-push line, and let git-push assume that is also the remote
branch name.

We also still support the remote branch completion after the :,
but only if the user manually adds the colon before trying to get
a completion.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9e72f0f..c7c9963 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -683,7 +683,7 @@ _git_push ()
 			__gitcomp "$(__git_refs "$remote")" "" "${cur#*:}"
 			;;
 		*)
-			__gitcomp "$(__git_refs2)"
+			__gitcomp "$(__git_refs)"
 			;;
 		esac
 		;;
-- 
1.5.2.2.1050.g51a8b

-- 
Shawn.
