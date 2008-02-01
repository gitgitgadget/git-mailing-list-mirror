From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: simple cvs-like git wrapper
Date: Fri, 1 Feb 2008 16:35:36 +0100
Message-ID: <200802011635.37255.jnareb@gmail.com>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 16:42:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKy2I-0006Al-Vp
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 16:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbYBAPmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYBAPmF
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 10:42:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:10941 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbYBAPmC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 10:42:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so749075wah.23
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=69Dal35ifmdHk3bwvLTFZuA4knXncF5xeELzObmqv1s=;
        b=IDVUa3FZl/ZUlk5TanqX5OzjnU06VQneQHEk1PIL7SzDamvnQhPXz4S4lgNTGf/PqGBUFKktiYfbVi+RDv4mLKLpupCyDedH2oweML3QR6lrAWWSo7odVWZaSMfj8ntY6ZsvZdqndr+tP8faf8/NDY1RSqaUWRctiKeFsTSZa38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QH0NjDj43iQFFJx861NS/TqAzfWJRm52yqSCWyZaXPWsIz6WAqh/UeYu8R+sIw8Hx+8Ytogmz0y+/RegBno+GSUSSpqZzY3z2lVrth4kHUHJ3bLhoa+YTW1fpJS7yAOAoW39sjfTz5lphqqmp/bKUE7ljNCKKEg1wgsAjkJU43s=
Received: by 10.114.37.1 with SMTP id k1mr4164836wak.6.1201880144183;
        Fri, 01 Feb 2008 07:35:44 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.93])
        by mx.google.com with ESMTPS id h1sm9103341nfh.20.2008.02.01.07.35.40
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 07:35:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080130021050.GB9612@venus>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72177>

On Wed, 30 Jan 2008, Ed S. Peschko wrote:
> Jakub narebski wrote:   <-- re added

Please try to not remove attributions. TIA.

>> One thing (besides horrible branching and even worse merging)  which I
>> hated in multi-user CVS is the "cvs update", namely the fact that if
>> you want to commit changes, you _have_ to rebase them on top of
>> current work. So when you are ready to commit, when you have tested
>> everything, you are sometimes forced to resolve a merge to be able to
>> commit... and have to test resolved merge... and perhaps again, and
>> again.
> 
> Yeah, I realize that it's not exactly the best solution for every
> project, but for projects tied to a piece of hardware (ie: a database, a
> particular box, etc), its much more important to be in sync, to have 
> 'one true view' of the world rather than to have the freedom to have 
> multiple views.
> 
> In our case, our code is tied to a database and a database instance. An
> environment equals attachment to a given oracle SID. If someone is out of sync
> with other people's changes, then that person's environment is wrong.

Err, if it is as bad as you say, and it is not possible to change
environment to what is saved in commit [message] on git-checkout
and on git-reset this just removes any possibility of parallel
development. Not that CVS-like centralized development would do
much better in such case...

It would be nice to save environment state somehow in the commit,
or in worktree / commit tree. Versioning databases (or is it just
database schema) is PITA, and I don't know any good solution. phpBB
modules which need to modify database have some kind of diff-like
thing, but...

[cut]
----
Below there is description of "cvs update" workflow and how it can
be implemented in git, rebase based workflow which is very similar
but allows to generate small incremental commits while retaining
linear history, and default merge based workflow.

(Perhaps something like that should be added to cvs-migration.txt?)

Let's assume that time, or rather parentage/sequence of commits flow
from left to right, so "A---B" means that B is child of commit A (is
later revision), and that A is parent of commit B.  Let us mark
uncommited changes by '*'.

1. First, how 'cvs commit' and 'cvs update' works.
1.1. The case where there were no changes in the central (origin)
     repository

     before "cvs commit"

       A---B---C---* 

     after "cvs commit"

       A---B---C---D

1.2. The case where there were changes in the origin repo
     ("cvs commit" says: need to update, or something like that)

     before "cvs commit", and "cvs update"

       A---B---C---*

     after "cvs update"

       A---B---C---d---e---*'

     where *' means that the state might be modified wrt. *; you might
     have to resolve conflicts, while still not having you work saved
     under version control anywhere

     after "cvs commit" (and after resolving conficts, if there were any)


       A---B---C---d---e---F 

You can implement such workflow in git by stashing your changes, doing
fasfforward-only pull (or fetch), then unstashing changes, resolving
conflicts if there are any, and finally commiting changes. You would
have to implement "needs update" pre-commit hook if you want to follow
CVS workflow fully.

NOTE that while you are working on '*' somobody might have changed
environment!


2. Rebase based workflow; the "git pull --rebase" needs new enough git
   version

   before your work (common base both on your local repository, and
   in the origin / central / distribution point one)

     A---B---C

   you create a few commits, splitting your work into small, self
   contained, easy to understand, bisectable commits

     A---B---C---1---2

   now you want to be up to date wrt central repository, to send your
   changes (push, publish) to central repo, via "git pull --rebase"


     A---B---C---1---2
              \
               \-d---e

     A---B---C---1---2
              \
               \-d---e---1'---2'

     A---B---C---d---e---1'---2'

   where 1' and 2' are your commits modified by the presence of
   'd' and 'e' in the commit chain. Note that in the process of moving
   (copying) your changes on top of fetched changes from central repo
   there can be conflicts.


3. Merge based workflow; ordinary "git pull"

   before your work (common base both on your local repository, and
   in the origin / central / distribution point one)

     A---B---C

   you create a few commits, splitting your work into small, self
   contained, easy to understand, bisectable commits

     A---B---C---1---2

   now you want to be up to date wrt central repository, to send your
   changes (push, publish) to central repo, via "git pull"


     A---B---C---1---2
              \
               \-d---e

     A---B---C---1---2---M
              \         /
               \-d---e-/

   where M is a merge commit; you might have to resolve conflicts here.

-- 
Jakub Narebski
Poland
