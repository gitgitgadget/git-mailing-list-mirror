From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Wed, 24 Jun 2009 18:04:51 -0700
Message-ID: <7veit9m8cs.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJdOg-0001tL-Gv
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 03:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZFYBEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 21:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbZFYBEu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 21:04:50 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64303 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZFYBEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 21:04:50 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625010452.NNRW17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Wed, 24 Jun 2009 21:04:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 814s1c0074aMwMQ0414sq0; Wed, 24 Jun 2009 21:04:52 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=ybZZDoGAAAAA:8 a=0jpEFwrm-tKDAhv7V8AA:9
 a=cRghpXULiEm5l8mSqodoSmW9wiAA:4 a=jbrJJM5MRmoA:10 a=qIVjreYYsbEA:10
 a=QKWhMKYXZzGOQbCM:21 a=64U5gUeFfpXmOkL3:21
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain> (Linus Torvalds's message of "Wed\, 24 Jun 2009 14\:35\:13 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122173>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, so I have a practice of occasionally doing octopus merges when I have 
> two branches with trivial fixes from the same person.
>
> That all works fine when they use the "multiple branches in the same 
> repository" approach (eg x86 "tip" tree), but other people tend to prefer 
> to use multiple repositories for different features, rather than branches. 
> And git generally lets you do things either way with no real difference.
>
> But for the octopus case, it does make a difference. You can easily make 
> octopus merges only from one repository.
>
> Which is kind of sad. 
>
> So I did kernel commit c6223048259006759237d826219f0fa4f312fb47 by 
> basically doing the 'git pull" logic by hand, and while this was just a 
> trial and maybe I'll never feel the urge to do it again, I'm wondering it 
> maybe we should make it easier to do.

Every once in a while I have this urge to see how it feels to be Linus
by pretending to be him, trying what he did.

(1) So where is he?

    $ git pull
    ...
    From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
       f234012..28d0325  master     -> linus
     * [new tag]         v2.6.31-rc1 -> v2.6.31-rc1
    Updating f234012..28d0325
    Fast forward
     ...

(2) Let's pretend to be Linus, just before he made this merge.

    $ git checkout c62230^

(3) Let's see what he did with that thing.

    $ git show c62230
    commit c6223048259006759237d826219f0fa4f312fb47
    Merge: bd453cd d5bb68a 3a6a6c1
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Wed Jun 24 14:17:14 2009 -0700

        Merge branches 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/{vfs-2.6,audit-current}

        * 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6:
          another race fix in jfs_check_acl()
          Get "no acls for this inode" right, fix shmem breakage
          inline functions left without protection of ifdef (acl)

        * 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current:
          audit: inode watches depend on CONFIG_AUDIT not CONFIG_AUDIT_SYSCALL

    Ah, so we know the two repositories and branches involved.

(4) Let's pretend to be Linus.  Fetch the first branch and drop the
    necessary information in FETCH_HEAD.

    $ git fetch \
      git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6 \
      for-linus

(5) Continue pretending to be Linus, complete the octopus.  The key is to
    let the "fetch" phase of this to append to the FETCH_HEAD, not
    replacing it.

    $ git pull --append \
      git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current \
      for-linus

(6) Did I succeed?  Let's see.

    $ git diff c62230

    Yay, identical tree.

(7) How does the log message look?

    $ git show
    commit cb1e4198421091ea5844d93624d5d5499537dbe0
    Merge: bd453cd d5bb68a 3a6a6c1
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Wed Jun 24 17:45:09 2009 -0700

        Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6; branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current into HEAD

        * 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6:
          another race fix in jfs_check_acl()
          Get "no acls for this inode" right, fix shmem breakage
          inline functions left without protection of ifdef (acl)

        * 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current:
          audit: inode watches depend on CONFIG_AUDIT not CONFIG_AUDIT_SYSCALL

    Hmm, Linus's combined notation on the summary line that uses {} is
    much nicer.

> Right now the "git pull" syntax is
>
> 	git pull <repo> <branch>*
>
> and you cannot specify multiple repositories, only multiple branches.
>
> But at the same time, it should be pretty unambiguous whether an argument 
> is a repository or a branch (':' in a remote repository, or "/" or ".." at 
> the beginning of a local one - all invalid in branch names).
>
> So it _should_ be syntactically unambiguous to allow
>
> 	git pull (<repo> <branch>*)+
>
> for the octopus case. Hmm?

Strictly speaking, you are not quite correct.  Arguments after <repo> can
be storing refspecs and they do come with colon.

Conclusion.  git-fmt-merge-msg may need to learn the trick of using {}.
No other changes needed.

Side note.

People sometimes say, and I am certain I agreed to them on more than one
occasions, that Octopus hurt bisectability and does not have much value in
real life.  I've always thought this bisectability issue was a downside of
Octopus merges, but now I think about it, perhaps "git bisect" can be
taught to dynamically decompose an Octopus merges into a sequence of
two-head virtual merges while bisecting.  We strongly discourage and do
not allow conflicting Octopus merges, so when you need to bisect a history
with an Octopus that looks like this:

    ---o---A
            \    
  ---o---B---M---o
            /    
    ---o---C

it should be able to mechanically decompose it, without conflicts, into


    ---o---A
            \    
  ---o---B---M1--M2--o
                /    
        ---o---C

where the tree of M and the tree of M2 are identical.
