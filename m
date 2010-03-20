From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 02:04:40 +0530
Message-ID: <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com> 
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com> 
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com> 
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:35:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5O3-0000c1-9S
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab0CTUfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:35:05 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:45124 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab0CTUfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:35:03 -0400
Received: by yxe29 with SMTP id 29so1546028yxe.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=8Q5LR1braozt8KyZlrbWw74hbHYno0DT6aHU2bVcXM8=;
        b=NvgUckBvwl1duBGDUX12ci5PBs+0CCSoajabxZU8r/cvmAakCz9DH+jcgPAx8c13fn
         xzUSiV6Xw+9Qfinyqczp3CH3muEAUNHAkyVyawMhQ835BeyATKLOMwhbhxDEbAiWVF24
         RaxloCPuNOjcRFYAgEVbTPfnhEZ+hH0IRjdtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Plyv9cDuG705y8RbPLt2d4oSNW2tvMhsGSGFEvyPOXKnyKiHXu5p155hSHRiA2JfEr
         gTqv7b2ECbdoFnEO2aWN4snX2SfJCFuXrN5pQu7jNcegx0qZ8VhFCNkNC1n7zO+1k/T2
         5ZDINhVxwXppyKwHJN2+PMBgtriSsTgl6GZ24=
Received: by 10.91.18.5 with SMTP id v5mr2407716agi.62.1269117300425; Sat, 20 
	Mar 2010 13:35:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142746>

Hi,

I just prepared another revision of my proposal- I've tried to be
clearer about the objective, and included a timeline this time. Note
that I've also changed the name from native-git-svn to git-remote-svn,
as recommended by Sverre.

======================================
Project Proposal: git-remote-svn | Native SVN support in Git

== The Outline ==
The objective of git-remote-svn is to allow native interaction with
SVN repositories in Git. The motivation for writing this comes from
the shortcomings of the current approach: git-svn.
1. It is essentially an arcane 5000-line Perl script that doesn't use
git-fast-import/ git-fast-export. It converts an SVN repository to a
Git repository by hand. This makes it virtually unmaintainable.
2. The UI is unnatural and complex. git-svn-* has some commands
corresponding to git-* commands, and it can be quite difficult for the
user to understand which one to use in different situations.
3. It handles the standard trunk/branches/tags layout well, but it
doesn't know how to handle non-standard/ changing SVN layout.
4. There's an array of other annoyances which makes it quite
imperfect. For example, it ignores all SVN properties except
svn:executable.

While the last two problems can be tackled in git-svn.perl itself, a
fresh approach is required to tackle the first two. git-remote-svn is
a proposal for an alternative approach.
1. Several good SVN exporters already exist, and using them with
git-fast-import should simplify a lot of the plumbing git-svn tackles
by hand.
2. Using a remote helper to keep track of SVN remotes will simplify
the UI greatly. The fresh UI will allow for a simple `git clone
svn://example.com/myrepo` and multiple subsequent `git pull`
invocations.

However, the project does not aim to be compatible with git-svn, and
does not serve as an immediate replacement. It can be considered fully
successful after the functionality described in all the components
have been written. Merging the project to upstream will involve small
changes to the Git codebase to incorporate the native UI. I
additionally hope that this project will serve as a roadmap for other
projects that involve natively supporting other versioning systems in
Git.

== The Technicalities ==
I've discussed the project with Sverre Rabbelier at length over email.
The plan is to build component-wise. The distinct components are:
1. An SVN client that uses libsvn to fetch/ push revisions to a remote
SVN repository.
2. An exporter for SVN repositories, which will extract all the
relevant revision history and metadata to import into Git.
3. A remote helper for Git that takes the data from this SVN exporter,
and uses git-fast-import to create corresponding commits in Git.
4. Another remote helper to export commit data and metadata from Git
to import into SVN.
5. An importer for SVN, which will create revisions in SVN
corresponding to commits in Git.
6. A UI that glues all the components together.

Due to a licensing conflict, the details of which can be found here
[1], git-remote-svn will link to libsvn, but will NOT link to Git. It
will simply use a thin wrapper to call compiled Git executables
(referred to as remote helper in article). The following resources
will help build the various components:
1. git_remote_helpers/git/git.py is a small remote helper written by
Sverre that wraps around git-fast-import. I plan to extend this to
wrap around git-fast-export as well.
2. git-svn.perl contains a two-way mapping, parts of which I plan to implement.
3. Thiago Macieira's svn-all-fast-export [2] has a complete SVN -> Git
mapping. I plan to take several ideas from the branch/ tag mapper in
repository.cpp.

== Timeline ==
April 26 - May 24: Study svn-all-fast-export extensively, and chalk
out a mapper for SVN branches and tags. Take time to become
comfortable with libsvn.
May 24 - June 10: Write a minimal importer/ exporter for SVN in
Python. It should allow interconversion between commit messages,
timestamps, authors corresponding to each revision/ commit. Also
figure out how to preserve the data in SVN properties.
June 10 - June 25: Extend the the remote helper in
git_remote_helpers/git/git.py to do git-fast-export as well. Make the
importer/ exporter for SVN work with it.
June 25 - July 5: Implement a minimal SVN client, and make it work
with the SVN exporter.
July 5 - July 10: Write a quick UI binder. This will involve
modifications to builtin-push, builtin-fetch, builtin-clone, and
remote to use the SVN client to perform the corresponding actions in
the case of an SVN remote.
July 10 - July 16: Scrub code and write documentation for mid-term
evaluations. Commit changes to the remote helper to upstream. Try to
get the other changes into `next`.
July 17 - August 9: Implement the branch and tag mapper.
August 9 - August 16: Write more documentation and get everything
ready for final evaluations. Commit the SVN importer/ exporter and UI
changes.

== Who am I? ==
I'm Ramkumar, a student at the Indian Institute of Technology,
Kharagpur. I haven't contributed more than a few small patches to Git
[3], and I look at this project as a fantastic opportunity to get more
involved with the community. In the summer and winter of 2008, I
worked with a Django-based startup. The team comprised of three
experienced Python developers, one designer to steer the project, and
an undergraduate student- me. We versioned everything on Git, deployed
on Apache/ PostgreSQL, using Amazon S3 for static content. While
working for the startup, I also contributed to South.

C, C++ [4], and Python are my strongest languages. I've additionally
learnt Common Lisp through an Emacs Lisp I wrote in summer 2009 [5].
I'm known to be very communicative, both in person, and over email/
chat. The style and clarity of my communication is seen in the slides
I used at FOSS.IN/2009 in winter 2009 [6].

== Notes ==
[1] http://thread.gmane.org/gmane.comp.version-control.git/139545
[2] git://repo.or.cz/svn-all-fast-export.git
[3] 52eb5173ac and 88d50e78c3
[4] On a related note, I've also contributed a little to Chromium
[5] http://github.com/artagnon/ublog.el
[6] http://artagnon.com/wp-content/uploads/haskell-internals.pdf and
http://artagnon.com/wp-content/uploads/unladen-swallow.pdf
======================================

Again, I'd really appreciate comments.

Thanks,
Ramkumar
