From: Dominik Vogt <vogt@linux.vnet.ibm.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 09:35:31 +0100
Message-ID: <20131210083531.GB4087@linux.vnet.ibm.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
 <xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
Reply-To: vogt@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 09:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqInM-0004jf-GO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 09:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab3LJIfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 03:35:51 -0500
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:34102 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab3LJIfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 03:35:36 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vogt@linux.vnet.ibm.com>;
	Tue, 10 Dec 2013 08:35:34 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
	by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Tue, 10 Dec 2013 08:35:33 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2D61B2190059
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 08:35:32 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBA8ZKZE60358762
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 08:35:20 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rBA8ZWZ3027737
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 01:35:32 -0700
Received: from bl3ahm9f.de.ibm.com (dyn-9-152-212-171.boeblingen.de.ibm.com [9.152.212.171])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id rBA8ZWPi027728
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 01:35:32 -0700
Received: from dvogt by bl3ahm9f.de.ibm.com with local (Exim 4.76)
	(envelope-from <vogt@linux.vnet.ibm.com>)
	id 1VqImx-0001KB-Nz
	for git@vger.kernel.org; Tue, 10 Dec 2013 09:35:31 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13121008-2966-0000-0000-0000099FA98C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239128>

On Mon, Dec 09, 2013 at 12:35:38PM -0800, Junio C Hamano wrote:
> Dominik Vogt <vogt@linux.vnet.ibm.com> writes:
> 
> > Me and some colleagues work on gcc in lots of different branches.
> > For each branch there is a separate build directory for each
> > branch, e.g. build-a, build-b and build-c.  Let's assume that all
> > branches are identical at the moment.  If a file in branch a is
> > changed that triggers a complete rebuild of gcc (e.g.
> > <target>.opt), rebuilding in build-a takes about an hour.  Now,
> >  when I switch to one of the other branches, said file is not
> > identical anymore and stamped with the _current_ time during
> > checkout.  Although branch b and c have not changed at all, they
> > will now be rebuilt completely because the timestamp on that files
> > has changed.
> 
> I am not quite sure I follow your set-up.  Do you have three working
> trees connected to a repository (via contrib/workdir/git-new-workdir
> perhaps), each having a checkout of its own branch?

No, just one working tree, but three separate build directories
for various branches.  Actually, the build directories could be
located at some random place on disk, but it's convenient to keep
them inside the working tree.  Personally I do not use multiple
working trees because in the past I had the impression that this
kind of setup creates more problems than it solves.  Just to give
you an idea how my current workspace looks like:

  ~/rpm/BUILD/gcc-4.1.2-20080825
    build-4.1/
    install-4.1/
    ...
  (branch "master")

  ~/rpm/BUILD/gcc-4.4.7-20120601
    build-4.4/
    install-4.1/
  (branch "master")

  ~/src/git/gcc-unpatched
    build/
    install/
    ...
  (branch "master")

  ~/src/git/gcc-patched
    build-4.8/
    build-4.9/
    build-somefeature/
    install-4.8/
    install-4.9/
    install-somefeature/
    ...
  (various feature branches)

> [snip]

Hm, the case I described was too simple.  Another try:

* With the setup described above I have, say, eleven branches, namely
  a and b, b2, ..., b9:

  ---o---X     <== a
     |
     `---Y     <== b
         |
         |---o <== b2
         ...
         `---o <== b9

* The two commits X and Y both touch a file that triggers a
  complete rebuild, say gcc/common.opt.

* Each branch has a matching build directory build-<branch>, and
  all of them are built for the latest version of the
  corresponding branch.

* Switch to branch a and do some work or just look at it.

* When I switch back to any of the b-branches, gcc/common.opt gets
  stamped with the current time, i.e. "make" considers the whole
  build directory to be outdated and builds everything from
  scratch.  Then I switch to another b-branch and the whole thing
  starts over etc.  With gcc-bootstrapping enabled, such a build
  takes me almost an hour.  In other words, just looking at branch
  a entails a full day just rebuilding branches that have not
  changed at all.

I've discussed that with some of my co-workers, but we still
could not come up with a nice solution.  The "right" way to "fix"
this might be to stash all file modification dates on a branch
switch and restore them when switching back to the original.  But
that sounds awfully expensive, and really out of the scope of an
RCS.  The second best approach I could think of is to stamp files
with the timestamp of the last commit that touched that, but I
guess that is not a cheap operation either.

Ciao

Dominik ^_^  ^_^

-- 

Dominik Vogt
IBM Germany
