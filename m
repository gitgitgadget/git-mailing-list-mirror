From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 02:53:20 +0200
Message-ID: <200610150253.20974.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egrgqe$1i9$1@sea.gmane.org> <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 15 02:53:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYuFh-0000IQ-3X
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 02:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWJOAxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 20:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbWJOAxI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 20:53:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25775 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752316AbWJOAxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 20:53:07 -0400
Received: by ug-out-1314.google.com with SMTP id o38so603262ugd
        for <git@vger.kernel.org>; Sat, 14 Oct 2006 17:53:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HjdXjft5heRncqJj7TkMKDe6eOPqe2VC2sdT78+Bp8Gf+kDTcwVl9nzs8ZP0wKlqhu4LyhJ7Er5kJXzW/DsHyrAaiQg2/uAzmE6pieC+en9GWqO95uKG5+T9ryOQ2rj6EY79xaHGS9xOrZPru/ZUcjyPg6ysL+MYItEOFmZPWYk=
Received: by 10.66.240.12 with SMTP id n12mr6178722ugh;
        Sat, 14 Oct 2006 17:53:05 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id z40sm1735567ugc.2006.10.14.17.53.05;
        Sat, 14 Oct 2006 17:53:05 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28900>

Jon Smirl wrote:
> On 10/14/06, Jakub Narebski <jnareb@gmail.com> wrote:

>>   * It would be nice to have tool to exchange commits between SCM and CVS,
>>     be it like Tailor/git-svn, or via incremental import and exporting
>>     commits to CVS like git-cvsexportcommit. This would ease changing SCM,
>>     as both new SCM and CVS could be deployed in parallel, for a short time
>>     of course.
> 
> From what Brendan wrote they are looking to continue 1.9 in CVS and
> start 2.0 in a new SCM. This pretty much mandates tracking CVS into
> the new SCM for a long period of time. Possibly as much as two years.
> There does not appear to be a need to push 2.0 back into CVS.

That of course limits what we can do in 1.9 to what CVS supports.

> >   * It would be nice to have CVS emulation like git-cvsserver, so users
> >     accustomed to CVS could still use it.
> 
> This can also solve some of the problems with Windows support.

Well, git-cvsserver (perhaps with some improvements) could also serve as
CVS server for 1.9.
 
> > 4. Good support for _large_ project, with large history. Namely, that
> > developer wouldn't need to download many megabytes and/or wouldn't need
> > megabytes of working area. How that is solved, be it partial checkouts,
> > lazy/shallow/sparse clone, subprojects, splitting into
> > projects/repositories and having some superproject or build-time
> > superproject, splitting repository into current and historical... that of
> > course depends on SCM.
> 
> git has issues here. The smallest Mozilla download we have built so
> far is 450MB for the initial checkout.

One way to reduce repository size would be to split fairly independent
subprojects (inependent = independently testable) into separate repositories,
and perhaps use some kind of "super-repository" (common repository) to join
all the project in one single entity. The split can be done using
git-splitrepo (or something like that) which was posted on git mailing list
(most probably by some member of X.Org), or just cg-admin-rewritehist.
While at it we could split repository into current work and historical repo;
and clean up current work repository from the cruft accumulated (e.g. dead
branches, broken tags etc.).


Another way is to use grafts.

Linux kernel has it's current repository (starting somewhere 2.6.x),
and it's historical repository. I don't remember how they arrived at it
(and don't want to check KernelTrap articles), if the seed for current
work repository was simply project import at some state, or (very slow)
import of BitKeeper history. But if I remember correctly it was born split.
You can join both repositories into one (wrt. log and diff for example)
using grafts.

I'm not sure what happens if you pull from repository which has graft
file "cauterizing" history; would you get graft file and history up to
cutoff point? What would happen if your repository, repository you pull to
has cauterization graft file; would it get cut history? Of course
the problem (and the source of proposal and troubles with implementing
of shallow/sparse/lazy clone) lies if someone branches (in public repo)
from below cutoff point. But that is a matter of policy.

But it is true that the size of Mozilla repository is a challenge.
BTW. do you perchance know how other SCM dels with the repository
of that size?

-- 
Jakub Narebski
ShadeHawk on #git
Poland
