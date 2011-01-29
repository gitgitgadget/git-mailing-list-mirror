From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sat, 29 Jan 2011 20:08:06 +0100
Message-ID: <20110129190806.GC602@nibiru.local>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 20:17:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjGIE-0006fb-D2
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 20:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab1A2TQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 14:16:57 -0500
Received: from caprica.metux.de ([82.165.128.25]:37302 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754520Ab1A2TQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 14:16:56 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0TJDLZR029057
	for <git@vger.kernel.org>; Sat, 29 Jan 2011 20:13:23 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0TJD3r2029041
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:13:03 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0TJ86ds029448
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:08:06 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165665>

* Thomas Hauk <tom@shaggyfrog.com> wrote:
> Back when I worked at a large games company, we used Perforce, and
> our repo structure looked a little something like this:
> 
> /branches
> 	/alpha
> 	/beta
> /mainline
> 	/packages
> 		/external
> 			/foolib
> 				/1.0
> 				/1.1
> 				/2.0
> 		/internal
> 			/barlib
> 				/dev
> 				/1.0
> 				/2.0
> 			/bazlib
> 				/2.34
> 				/2.35
> 			/qux
> 				/dev

Ah, you're conditioned by a VCS that mixes up directory copies and branches,
just like SVN or TFS - those folks (VCS developers as well as their userbase)
still don't get the idea that these are orthogonal concepts ;-o
Needless to say that this makes working w/ branches quite hard (compared
to git ;-p), not even to mention things like remote tracking, rebase, etc.
(guess what: M$ itself recommends against branches or at least very beaurocratic
planning and processes in their own official TFS papers ;-p)

Just forget about that all, forget the whole idea of having dozens of
packages in one fat tree. Develop and track each package saparately and
use an separate dist build tool (eg. Briegel) to put things together.

It'll take some time to get your head around this ideology, but it'll pay out
if you do it consequently. (I've already been through this some years ago).

> At the package level, we would split up packages/libraries into two groups
> based on if they were developed at the company or not (external/internal),

Why exactly that split ? Why not having each package separately, independent
on the supplier ? Each package should stand completely on its own (assuming
dependencies resolved), or it isn't really a package but just a bunch of files.

> and inside each one, we might have multiple versions. In the example above,
> the repo is for the "qux" game, which uses an internal "bazlib" library
> developed by another group, and the "barlib" library which was developed
> for use on "qux" and may be used simultaneously on other projects.

That qualifies an _separate_ (generic) package, which should be developed
and deployed separately. If you need to tweak it for (potentially) each
project (so, have per-project branches of it), you'll most likely have
some serious architectural flaw.

> I've successfully used this repo structure with several other projects
> over the years at other companies (who were mostly using Subversion).

My current customer also used such a model (previously in PVCS, not TFS),
and they discuss hours over hours about how and when to branch and whether
certain things could be merged back at all, instead of just doing the
actual work.

For the product I'm currently working on (imagine that: an embedded linux
project that gets tracked via TFS ;-o) they always tried to do the projects
(each on essentially the same codebase, but each job/project has some
customer-specific changes) sequentially (and even mixed up with standard
feature development), so they could lie to themselves that they would
never need branches. In the end they had two completely separate 
incompatible codebasis which now have to be "merged" together manually,
consuming several man-month. (now I'm there to clean up the mess ;-o).

> Now I'm trying to get into the Git swing of things, but it seems to be
> that Git only offers project-level branching, and doesn't allow for the
> kind of package-level branching I'm describing here.

On sourcetree-, not project-level. Projects and sourcetrees are
completely different concepts. Another important point that many
folks (especially IDE designers) never really understood.

> Am I incorrect or is there a way to accomplish with Git what I was
> doing before with P4 and SVN?

Not really. Rethink your project organization and workflows.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
