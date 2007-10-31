From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 22:25:23 +0100
Message-ID: <20071031212523.GB4255@steel.home>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InL4G-00057s-Oi
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbXJaVZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754707AbXJaVZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:25:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:10757 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbXJaVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:25:26 -0400
Received: from tigra.home (Fadfc.f.strato-dslnet.de [195.4.173.252])
	by post.webmailer.de (klopstock mo20) (RZmta 14.0)
	with ESMTP id z0391ej9VI4b8n ; Wed, 31 Oct 2007 22:25:24 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 20B75277AE;
	Wed, 31 Oct 2007 22:25:24 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F3AFF56D22; Wed, 31 Oct 2007 22:25:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87d4uv3wh1.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJwDS0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62875>

Sergei Organov, Wed, Oct 31, 2007 20:39:06 +0100:
> $ git rebase --continue
> You must edit all merge conflicts and then
> mark them as resolved using git add
> 
> me> Nice helpful message, -- need to do git-add
> 
> $ git add Documentation/core-tutorial.txt
> $ git rebase --continue
> 
> Applying Use new syntax (-m option) for git-merge.
> 
> No changes - did you forget to use 'git add'?

This "No changes" was meant as a hint

> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase --abort".
> 
> me> What?! I just did the git-add! Moreover, before I did git-add, the
> me> error was different and helpful. Something went wrong? 

Well, you edited you tree to look exactly like it already is.

> me> No luck :( A few seconds of thinking... Hmm... no-op patch, do I
> me> need to skip it? Let's try the --skip:
> 
> $ git rebase --skip

Exactly.

> Applying Fix SYNOPSIS.
> 
> error: patch failed: Documentation/git-merge.txt:10
> error: Documentation/git-merge.txt: patch does not apply
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merged Documentation/git-merge.txt
> CONFLICT (content): Merge conflict in Documentation/git-merge.txt
> Failed to merge in the changes.
> Patch failed at 0003.
> 
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase --abort".
> 
> me> Aha, that's it! But why git didn't just skip the no-op patch
> me> automatically? Well, anyway , now I have a new expected conflict,

it was not a noop patch before you resolved the conflict.

> me> and I'm sure I just want to skip this patch, so let's try exactly
> me> that:
> 
> $ git rebase --skip
> Dirty index: cannot apply patches (dirty: Documentation/git-merge.txt)

Well... This one kind of hard: git-rebase _cannot_ know whether it is
safe to just drop all changes in the index and work tree (you could
have made the changes on purpose). It was decided not to drop
anything. You always can do

    $ git reset --hard # kills all changes in index and work tree
    $ git rebase --skip

(or maybe git-rebase is just too careful...)

> me> No luck :( Well, let's go the long way, -- edit conflicting
> me> Documentation/git-merge.txt (so that it matches upstream),
> 
> $ git add Documentation/git-merge.txt
> $ git rebase --skip
> Nothing to do.
> 
> me> Well, I already knew this will work, but why should I edit the file
> me> and then git-add it just to skip the patch? Is there better way?
> me> Anyway, the "Nothing to do." above is slightly confusing, -- did it
> me> actually skip the patch? So let's check the result:

Yes. It was the last commit. You were just too unlucky to hit all the
hard cases your first day.
