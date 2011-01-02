From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Push to all repositories
Date: Sun, 2 Jan 2011 10:54:25 +0100
Message-ID: <20110102095425.GA7061@nibiru.local>
References: <1291829983410-5816069.post@n2.nabble.com> <20101208180049.GC5687@burratino> <1291849156593-5817177.post@n2.nabble.com> <1291898174244-5818757.post@n2.nabble.com> <AANLkTik9CxVD9A-2QEyD_tZiyYoCOitfViWucGCudzh-@mail.gmail.com> <20101209195204.GB6884@burratino>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 02 11:00:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZKjt-0004VQ-H8
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 11:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1ABKAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 05:00:25 -0500
Received: from caprica.metux.de ([82.165.128.25]:38323 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751304Ab1ABKAW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jan 2011 05:00:22 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p029u1HT010619
	for <git@vger.kernel.org>; Sun, 2 Jan 2011 10:56:04 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p029tj0l010600
	for git@vger.kernel.org; Sun, 2 Jan 2011 10:55:45 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p029sPE3008238
	for git@vger.kernel.org; Sun, 2 Jan 2011 10:54:25 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101209195204.GB6884@burratino>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164414>

* Jonathan Nieder <jrnieder@gmail.com> wrote:

> Consider a project in a patches+tarballs workflow.  It begins like
> this:
> 
>  1. Acquire a tarball with the version you want to base your work on.
>  2. Untar.
>  3. Copy the result to save the current state.
>  4. Test it.
>  5. Fix a bug or add a feature.
>  6. Make a patch with "diff -pruN"
>  7. Return to step 3.
>     ...
>  8. Looks good; email out the patches to get some feedback.
> 
> Now another person wants to test the patches; so she tries:
> 
>  1. Acquire a tarball with the version you want to test against.
>  2. Untar.
>  3. Apply patches with "patch -p1".
> 
> Wait a second --- the patches don't apply!  Or worse, they
> apply but the result is broken.  Okay:
> 
>  4. Complain to the patch author.
> 
> Finally the patch author has more work to do:
> 
>  9. Acquire a newer tarball, and use either "patch --reject-file"
>     or rcs "merge" to reconcile the differences.  Email out the
>     result.

Compared to git:

1. Clone repo and checkout the desired version
2. Fix a bug or add a feature and commit to your local branch
3. Do your tests and cleanups (eg. cleanups w/ interactive rebase)
3. Push your branch to some place others can catch it and
   announce it to others

Now another person wants to test your version:

1. Clone your repo and checkout your branch.
--> there is nothing that could fail to apply - everything's consistant
    by design (assuming the repo was cleanly cloned ;-o)
2. Possibly become an author yourself:
   a. rebase to a newer upstream version
   --> same as above

> The result is a sequence of snapshots that have been _tested_ to work
> correctly.  Now compare the svn workflow I briefly used at work:
> 
>  1. svn update
>  2. hack hack hack
>  3. svn update
>  4. hack hack hack
>  5. svn update
>  6. hack hack hack
>  7. send out a patch for feedback

SVN has a quite bad idea of branches and isn't even near to support
things like rebasing anyhow.

> Unfortunately, the version committed (1) does not reflect the
> development history and (2) is not even tested, if changes
> happened in trunk between step 9 and step 10.

The idea of having everything in a big trunk is, aehm, quite suboptimal.
Better: have each issue in its own branch, that gets rebased to the
mainline frequently and merged back there when properly tested.

> Of course in the opposite direction is
> 
>  - changes to workflow can be hard for a team to adjust to
> 
> (i.e., "don't fix what isn't broken").

Well, many people tend to stick in old ideas (including workflows),
no matter what newer developments are made. I currently have to cope
with that in an customer project: most of the people here don't even
consider using branches since the only vcs'es they know have no really
usable support for this (TFS, etc ;-o), and they refuse to learn
something new as long as their old way seems to work somehow (no matter
of costs). I've estimated the productivity loss caused by sticking
backwards cruft like TFS on factors of 5..10 - nobody cares.
(actually, not really bad for me: the longer it takes, the more 
money I earn ;-P)


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
