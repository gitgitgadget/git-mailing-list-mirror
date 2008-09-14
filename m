From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Sun, 14 Sep 2008 23:48:02 +0400
Message-ID: <20080914194802.GH28210@dpotapov.dyndns.org>
References: <200809131906.18746.jnareb@gmail.com> <20080914144306.GF28210@dpotapov.dyndns.org> <200809141948.07160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Mahotkin <squadette@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 21:49:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kexaz-0003Ut-L7
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 21:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYINTsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbYINTsK
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 15:48:10 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45839 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYINTsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 15:48:08 -0400
Received: by gxk9 with SMTP id 9so23018650gxk.13
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z2hqZWaKPtpjoezVkTKvcMu/Hfz/yZAipjlOtPMLvAU=;
        b=eoSnAVXwr2+YMKIGXpUXC4OiD95Vp4QCnR5GpOV55U7PIwEh/ZZ/+ix14r9LmbsqZr
         Ep6WZUahcOA1WgiiQBMx26J7Hs2eOzULtbVPTvl0I3RZg3utFzTKMOndjUl4LQDoAkKF
         SPXDMSH63dGyxS/3dfHb2L1X7D/ySfnv42kvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aGkvg2do2cuGZfPHykEc0eesppGDeRt+rLn/N3u5SYFA5nLfb7LBzTQ2hkpkAELTer
         5bwSrHCVGhjNBTx2wpek+QMJntBU0OhHqekrDSsysy78ptR9LXgF8UTU793T7oANhu/P
         uNbzhFUSknAhaEKzABh47LI1ha6455N7a+P60=
Received: by 10.86.68.2 with SMTP id q2mr2056699fga.43.1221421686348;
        Sun, 14 Sep 2008 12:48:06 -0700 (PDT)
Received: from localhost ( [85.141.149.192])
        by mx.google.com with ESMTPS id d4sm16194603fga.5.2008.09.14.12.48.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 12:48:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809141948.07160.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95857>

On Sun, Sep 14, 2008 at 07:48:05PM +0200, Jakub Narebski wrote:
> 
> By the way, perhaps I haven't stressed this like I should, but the
> most important thing I wanted to ask git list about, besides insight
> in my comments and proposal for changes, was if it is possible
> using current hooks infrastructure to restrict changes coming from
> some account in such a way as to allow it only if all changes are
> restricted to specified directory. 

I believe the update hook should be able to do that. You have oldrev and
newrev, so you can run "git diff --name-only oldrev newrev" and see what
files are going to change. And then verify that the user has the write
access to this directories or files.

I have not tried it yet, and I don't think we have a ready example of
how to do that, but I believe that the example of the update hook that
restricts user access based on the target branch can be used as a
starting point.

> 
> IMHO "atomic commits" (or rather "atomic operations", see below) is
> about commit being either in full, or not done at all.  The fact
> that SCM might need some manual steps to recover from failure shouldn't
> factor in evaluating this criterion.

Agreed. Your wording makes much more sense than what was used in the
above criterion.

> 
> > Another thing here is that "git commit" is local, so I am not sure
> > if this question includes network operations...
> 
> Well, I think this session would be better titled "Atomic Operations"
> or just "Atomicity".  Although I'm not sure if for example in Git
> all operations are atomic under all conditions...

I believe that all git basic operations are atomic. In fact, you either
got a new revision with new SHA-1 or don't. Aborting operation may
leave some dangling objects, but it is okay, because they will be
garbage collected later. But I am not sure about additional utilities
such as git-svn. Git-svn uses rebase as it dcommits, being interrupted,
it may leave you in some strange state. It is possible to recover but
it may be not obvious for newbies. Other than that, I think everything
is very resilient to any interruption.

> 
> But even if we leave it "Atomic Commits", as for centralized SCM
> commit includes network operation, to have centralized and distributed
> SCM on equal footing, for distributed SCM this in my opinion should
> mean both atomic commit, and atomic push.  (And that should be stated
> explicitly in the description...)

Agreed.

> 
> > So, perhaps, it should be two separate points:
> > - ability to preserve history of rename (with detail clarification
> >   of what it means)
> > - ability to show renames in the project history
> 
> That are points '1' and '2' on my list, perhaps stated bit differently:
> showing renames in full history / history of project as whole, and
> following history of a single file across renames.

I did not mean '1' and '2' as priorities, but that it is slightly
different features and both can be titled as support of renaming.

> > 
> > Git tracks content rather than file-ids, and therefore it uses heuristics
> > for rename detection.  This approach has an advantage of being able to
> > preserve history for code lines between files, which usually happens much
> > more often than file renaming.
> 
> I would rather write
> 
>   Renames are supported for most practical purposes[1]. By design Git
>   does heuristic <i>rename detection</i> (based on similarity score of
>   pathnames and file contents), instead of doing rename tracking (which
>   usually is based on some kind of file-ids).  This approach allows for
>   more generic content tracking of code movement (which usually happens
>   much often than wholesame file renaming), e.g. in "git blame -C -C".

Sounds good to me. Perhaps, I would drop '(which usually... file-ids)'
to make the sentence a bit shorter.

> > It is whether modification to more than one file can be commited (and
> > propogated) atomically. I also suppose that those changes should be
> > shown in history as a single change (not many changes too different
> > files that took place in the same time and the same commit comment).
> > 
> > However, the whole tree commit is a more strict requirement than
> > just being able to commit a group of changes atomically. For example,
> > "svn ci" creates a changeset and atomically store all its modification
> > on the server. Yet, it is not the whole tree commit, because the result
> > tree may differ from the tree that you commiting (files that are not
> > modified by changeset may differ).
> 
> I think the gist of intent was to have revisions (revision identifiers)
> refer to the state of a whole repository (or to changes to the set of
> files as a whole: a changeset).

Perhaps. Though, then SVN should have 'Yes', but it listed as "partial
support." It seems this feature also implies ability to create a
changset and propagate as separated steps. Yet, svk is listed "Same as
subversion." So, I don't really know what this support of changesets
really means.

> 
> Hmmm... now that you stated that possibility I see how this wording can
> refer to it.  Nevertheless it is irrelevant to the criterion discussed;

Agreed.

> 
> > > scm>         <section id="tracking_uncommited_changes">
> > > scm>             <title>Tracking Uncommited Changes</title>
> > > scm>             <expl>
> > > scm>                 Does the software have an ability to track the changes in the
> > > scm>                 working copy that were not yet committed to the repository?
> > > scm>             </expl>
> > > 
> > > This also should be made more clean.  Does it mean for example ability
> > > to tell which files have changed, or ability to diff working copy to
> > > either last comitted changes, or to any revision available in repository?
> > 
> > Also, ability to diff one or more specified files in the working copy to
> > some specified revision.
> 
> Right.
> 
> I'm not sure now if "Tracking Uncommitted Changes" is a good name for
> this feature / criterion, but I don't have definite idea for change...

Actually, I don't like this name either. In particular, the word
"tracking". Perhaps, "Showing Uncommitted Changes" would be a better
name. Yet, ability to show diff between the working copy as some
arbitrary version should be listed as a separate feature.

> > So, I am not sure were the word "Medium" came from.
> 
> Backward compatibility^W^W Old impressions die hard, I would guess...
> And the meme that git documentation is not user friendly is hard to
> fight.

Yes. And, frankly, earlier versions of it were not very user friendly.
When you looked at some porcelain command and it referred you to
plumbing to see what options it takes, that gave very bad impression.
Now, this and similar shortcomings are corrected, but as you said the
old impressions die hard...


Dmitry
