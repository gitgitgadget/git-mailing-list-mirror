From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 08:52:57 +0100
Message-ID: <20051111075257.GA4765@c165.ib.student.liu.se>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 08:53:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaTj4-0007lr-0G
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKKHxF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVKKHxF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:53:05 -0500
Received: from [85.8.31.11] ([85.8.31.11]:57747 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932193AbVKKHxE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 02:53:04 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 4973D40FD; Fri, 11 Nov 2005 09:01:29 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EaTiT-0002Af-00; Fri, 11 Nov 2005 08:52:57 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11571>

On Thu, Nov 10, 2005 at 01:38:35PM +1300, Martin Langhoff wrote:
> We are working with a series of closely related heads, and merging
> among them. I am sometimes finding merge conflicts that I don't think
> I should be seeing. Assuming two branches, 'local' and 'remote', where
> local has with remote before (*), and I have no conflicting changes in
> local...
> 
>  1 - pull and merge from remote. The merge touches file A, B and C
>  2 - on local, develop on unrelated files O,P,Q, commit
>  3 - pull and merge from remote. The merge touches file B, C and D. I
> am sometimes seeing conflicts on file B and C, which was never touched
> on local.
> 
> * - In the case i have, the ancestry before the merge is a bit
> convoluted. AFAIK, this shouldn't affect us going forward. Both
> branches have a common ancestor, though, and are now merging often
> from remote to local.
> 
> We are using cogito for this, although on step 3 I have also tested
> with git-merge.sh and I get the same result.  It could still be a
> problem related to how the merge on step 1 is recording the merge.
> 
> For an example, clone
> http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
> register also the
> http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
> two heads:
> 
>  master: 214e6374d49e6d014f0ba6f159d585a3fe468909
>  remote: 05059be73c9e09e22b98bc796be35c595e551ed6
> 
> On git-merge 'testing merge' master remote you'll see conflicts over
> mod/quiz/editlib.php -- doing the same with cg-merge gets an
> additional conflict on mod/quiz/export.php. Neither of those files
> were ever modified on local -- however, both merges brought in changes
> to the same lines of code.
> 
> I suspect this is because the merge itself is being considered a
> commit on the local branch. Fair enough -- git has no way of ensuring
> that I haven't slipped in a few changes of mine in the merge. OTOH,
> it's pretty unexpected to see this on files that are not one char
> different from the 'remote' branch. Am I doing something wrong?
> 

This merge has two common ancestors, 

    $ git-merge-base --all master remote
    3b12fc6420c26a6556c2d806fca79dd96e8e22b9
    2163a9076d9515f00494ba9df7dbc85c9804790f

This may explain the results you get with cg-merge, as that script
seems to use 'git-merge-base' without the '--all' flag.

It really seems to be the case that there is a real conflict in
mod/quiz/editlib.php, this can be visualized nicely with

    gitk master remote -- mod/quiz/editlib.php


- Fredrik
