From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 3 Sep 2006 17:42:13 +0200
Message-ID: <200609031742.13902.jnareb@gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com> <ede6in$b9u$1@sea.gmane.org> <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 23:26:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzTy-0003D4-3R
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWICV0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWICV0T
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:26:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:47508 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWICQSC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 12:18:02 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1370416ugc
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 09:18:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y2ZRucpZOMZPm1Pt2DyWZYHJ2Zr4KNKuKr1PCNz5KQIjkkvsYmmgM1bP1spBvu3P93QS08148wULb2/2JHR9KktLtYYJ5KnRp4QEZW1ECoWoP3bNmp5OmzBLLU0+CwP5HEysu0K4RRr+FjHxplfl/xmIEusDzPVqiduZxrhIToU=
Received: by 10.66.252.4 with SMTP id z4mr2368497ugh;
        Sun, 03 Sep 2006 09:17:59 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id q1sm6748322uge.2006.09.03.09.17.58;
        Sun, 03 Sep 2006 09:17:59 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26381>

On 03-09-2006 15:46, Jon Smirl wrote:
> On 9/3/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > Jon Smirl wrote:
> >
> > >> Oh, and "partial tree pulls for localisers". Perhaps git-cvsserver can
> > >> help there? Localisers can just use TortoiseCVS and get a checkout of
> > >> the language pack subdir.
> > >
> > > Partial repo pulls and an issue to. The mozilla repo has much more
> > > than a browser in it, it also has a large mail/news program. A partial
> > > repo pull may not be what is needed for git, instead git needs a
> > > partial repo checkout.
> >
> > Or better support for subprojects.
> >
> > I think you can fake subproject support using separate repositories
> > for subprojects, in the directory matching the one in the whole project,
> > and the project repository, where we pull/push subprojects into.
> 
> You can't really fake it. Many of the projects in Mozilla are
> dependent on each other. If you break them up into separate
> repositories you lose the ability to do a cross project commit. This
> is common when you are changing an interface between the subprojects.
> 
> Would it make sense for git to treat a tree of projects like you
> describe as a single entity? So a commit would transparently commit to
> all of the subprojects. Maybe the commit entry's sha1 could be set up
> so that it would be identical in all subprojects. That would let you
> string them back together.

Scratch that. You can fake subproject support using something similar
to the way Junio works with TODO branch. Namely, separate repositories
for subprojects, each as if it would start from it's own directory
(although you can manage without that, it only would be slightly harder
to set it up), and main repository working directory composed from
subproject repositories checked out to correct place. Add to this
ingnoring object database (i.e. .git repositories), and you have whole
repository... where you can do whole repository commits to.

E.g. the following directory structure

	main-project/
	main-project/.git
	main-project/subproject/
	main-project/subproject/.git
	main-project/subproject/...subproject files...

where second .git is in .gitignore or info/excludes, but the subrpoject/
directory itself isn't.


If this is not enough, check out ideas in Subpro.txt in the 'todo' branch
in git repository. It adds additional 'bind' header... the implementation
(search for 'gitlink') were if I remember correctly never fully implemented
and is not in git, although parts of it like git-read-tree and 
git-write-tree --prefix option made it.
  http://www.kernel.org/git/?p=git/git.git;a=blob;f=Subpro.txt;hb=todo


As commit id depends on the contents, including _parents_ and _tree_,
it is I think impossible to set commit entry sha1 to be identical.

P.S. I just hope that it would pass VGER filter. I don't have much luck
with it lately...
-- 
Jakub Narebski
Poland

-- 
VGER BF report: S 0.994192
