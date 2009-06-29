From: Andreas Ericsson <ae@op5.se>
Subject: Re: AW: Parallell Development / Switching to GIT
Date: Mon, 29 Jun 2009 10:35:25 +0200
Message-ID: <4A487CCD.1040406@op5.se>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se> <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local> <20090628184714.GA8634@sigio.peff.net> <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>
X-From: git-owner@vger.kernel.org Mon Jun 29 10:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLCL1-0000eS-HE
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 10:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbZF2Ifc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 04:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZF2Ifb
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 04:35:31 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45302 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752373AbZF2If3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 04:35:29 -0400
Received: from source ([209.85.220.225]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkh80j8URsuEODQGLM4+b9vBYo6x4eJ7@postini.com; Mon, 29 Jun 2009 01:35:33 PDT
Received: by fxm25 with SMTP id 25so992304fxm.13
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 01:35:29 -0700 (PDT)
Received: by 10.86.74.17 with SMTP id w17mr992816fga.12.1246264529512;
        Mon, 29 Jun 2009 01:35:29 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm5354755fge.8.2009.06.29.01.35.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 01:35:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122430>

Patrick Neuner - Futureweb.at wrote:
> Hi,
> 
> thanks for your answers, I appreciate that. I read about
> cherry-picking, but I am not quite sure if that's really what we
> need. Lets assume, you do a new feature:
> 
> /featureX
> 
> You will commit it, check it out on the testserver and probably see a
> bug, fix it, commit and push it again. (and probably more commits
> after the testing person ran over other issues).
> 
> With cherry-picking, I would need to know all commits I have to pick.
>  But as there have been serveral commits, so wouldn't it be a pain to
> check all commits to that file or directory to have the same version?
> 
> 
> Just trying to find the right way to handle that.
> 

I can't help but think you're going about this the entirely wrong way.
It sounds as if every developer has to be able to log in to the test
server to try out their stuff, which sounds just plain insane to me
(unless you're developing supercomputer applications, but a company
named "futureweb" probably doesn't do that).

Anyways, the way you *merge* specific features in git is to develop
them on a topic-branch. If you absolutely do not want that (though I
can't think why, since branching is both cheap and easy in git), you
have to resort to cherry-picking. You cannot merge and say "I want
only changes to these and those files" because you'd end up with 
either a disconnected DAG (meaning git wouldn't know where to merge
from when you want to merge next), or with a connected DAG that
*still* doesn't have all the changes.

In short; Your workflow seems built around the capabilities and
shortcomings of SVN. Git has a different set of capabilities and
shortcomings, so it's natural that some things will feel awkward.
It's like bringing a skateboard to a formula 1 race, really.

With SVN, noone uses feature branches, because merging is a serious
pain. With SVN, every active contributor has commit access to the
central repository, because without it they'd have to juggle patches,
which is boring, and that would hinder them in their work.

With git, a lot of people use feature-branches, because merging is
really easy. With git, there's no real need to let every developer
have write access to the "officially blessed" repository. Instead
it's often useful to have each developer set up his/her own public
repository and then issue "please pull" requests, allowing the
maintainer(s) to fetch their changes, inspect them and then decide
which of the changes to make public. A lot of active git contributors
have their own repositories, and nearly all of the linux subsystem
maintainers have them too. Git also makes it really easy to send
patches by email (and apply such emailed patches). Since git is a
distributed version control system, each developer still gains the
full benefit of using an SCM, while the trusted people act as gate-
keepers for patches that get sent in. But I digress...

> 
> About the 2nd point - I am not sure if I get the different
> repositories thing. Do you talk about to different clones of the rep,
> and give different directory permissions on it,

I'm sure he is, yes.

> or is there a way to
> have like to completly different git rep's running and still merge
> things over (both ways)?

Yes, there is. That's what happens as soon as you have a public repo
and a local repo, and it's how all distributed version control systems
work. They're both separate repositories, but you can merge til your
heart's content between them, ofcourse.

> I just thought this approach would break
> correct mergin, as it doesn't know where it's comming from.
> 

bzzt! wrong. You're thinking SVN. Git has a DAG, with each revision
having a unique name, based on its content and all its history, so
separate copies of the same repository can be merged without problem
at all. This is how Linux development happens; The subsystem maintainers
all have their own repositories, and Linus merges from them during each
merge-window. I think there are about 30 "official" Linux repositories
if you count all the subsystem ones. Git was *designed* for scenarios
like that, so it does it very, very well.

> The only thing I ran over so far is probably doing a hook for that
> (like a pre-pull hook if that exists). didn't get to read too much
> about hooks yet, just did the update hook that checks if the user
> with specific ssh key is allowed to push to a specific branch. That
> works pretty good and is more important in fact.
> 
> But having 2 completly different repos would be another solution, but
> I kinda wonder that mergin would work correctly this way (if both
> sides have changes).
> 

git help merge-base

In SVN, you need to know exactly which revision you've merged before
in order to once again merge the same branch. Git holds that knowledge
already. Spend some time with gitk after following the git tutorial
and you'll probably get a much better grasp of how the DAG works and
how git uses it.

I'd advise you to clone the linux kernel and inspecting its history
using gitk. Every merge-commit you see which has a line saying something
like "merge foo bar frotz of git://example.com/path/to/repo.git" is a
merge with branches from different repositories. I wouldn't be the least
surprised if you find more than 5000 such merges in the linux kernel
history.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
