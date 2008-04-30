From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 12:47:47 -0400
Message-ID: <32541b130804300947s6083156etc6514cc13c24af13@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:57:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrFcX-0001YV-6o
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 18:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018AbYD3Q4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 12:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757999AbYD3Q4k
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 12:56:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:9733 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984AbYD3Q4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 12:56:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so375949fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zUAfb70+24A0ETGqgRwnc/yzZtxJo243J0QPy5oFxFg=;
        b=OlXU6ZTUDmU4cDA+blvjXPCjxmw7cthEcxITaiHduJFfqQUUri30ubtGivWdrgTlKdNw29UosHQ1qiJmRYfRgTmexTPQItnU6bIZF86NlAsZsUWfIR3TLDE/7gaWyb8Sz9pNbPk1rKvomcOudZYItMTck/tOAkx1s6fz3PrODas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R24ZDppKbmwAd+Rx2/5lLWdFrCIQfH19+Y4vEoObqrU384jVQusBb+aaOpjNz60iPnNWh9KQQ9I7z1XtL6Qnf5AJ3A1C6jtZIepa12JlVRGf1dGdNP238sBgKqXZJ8PhoVGHBiRuCwuorV2YGIdpfwl6KgtAbVHFW3XrPXXr0/k=
Received: by 10.82.159.2 with SMTP id h2mr149272bue.25.1209574067232;
        Wed, 30 Apr 2008 09:47:47 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 09:47:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80848>

On 4/30/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Tue, 29 Apr 2008, Tim Harper wrote:
>
>  > 1) The submodule stays in the working copy when changing to a branch
>  >    that does not have a submodule.  This can break a build and cause
>  >    problems.  To work around, I have to delete the folder completely
>  >    (git-clean).  Then, when I switch back to the branch again, I have to
>  >    re-download the submodule.
>
> The problem, of course, is that you can easily have valuable, but
>  not-tracked, files in there.  Deleting the submodule is therefore no
>  option.

I agree that blindly deleting isn't a good choice.  For example, what
if I've checked stuff into the submodule but never pushed it anywhere?
 Ugh.

That said, it makes submodule folders act completely inconsistently
with normal folders, which is highly undesirable.  The current
behaviour strongly encourages me to avoid submodules when I would
otherwise like to use them, just to keep the rest of my team members
(who are not git experts) from going insane.

>  But once you did "submodule init", you will never need to run it again,
>  since it edits your .git/config, which does not change when switching
>  branches.

Not true.  If ".gitmodules" is different between branches, then
.git/config will have the wrong information.  I think this was the
reason for the "read .gitmodules directly and don't worry about
.git/config" discussion/patches earlier.

>  And as for "submodule update", I like the fact that the submodule is not
>  updated automatically.  For example, when I actively develop a submodule,
>  but have to rebase the superproject, I would _hate_ it if the submodule
>  wass updated.

Why?  Every other folder in your entire project gets updated when you
"git checkout".  Why are submodules different?  I can personally vouch
that this is confusing for almost everyone I've seen who tried it.

>  The whole idea about submodules is that they are repositories of their own
>  right, and therefore the superproject should not mess with them, _unless_
>  explicitely asked to, with "submodule update".

I think perhaps this is the root of the problem; you're thinking of
the superproject as (A) "a tool for helping me track multiple
subprojects automatically", while I think most people (or at least I)
think of submodules as (B) "folders that have their own series of
commits and thus can be shared between projects."

If you think of it as (A), it's inconvenient to have them shuffling
around automatically.  But if you're in the (B) camp, having it not
update automatically seems insane.

I actually don't know any use cases for (A).  If my app depends on a
library in a submodule, for example, and I switch to a branch of my
app that uses a different version of the submodule, why would I ever
*not* want the submodule to switch too?  If it doesn't, it'll probably
break the compile.

>  > 3) If I don't run "git submodule update", and carelessly run "git commit
>  >    -a"  or "git add .", I risk propagating a submodule version from
>  >    another branch or undoing an important change.
>
> git commit -a is something that might make sense for newbies, but you
>  really should learn to use git add -p and commit without -a.

This is a matter of opinion; pretty much every other major VCS does
the equivalent of "git commit -a" when you commit, and most people
don't seem to mind.  It is therefore possible that git is the weird
one, not every other VCS.

In particular, in this case what git is doing is, "You checked out a
new branch, but I don't really trust you, so I actually made this
modification in your tree for you.  Now if you commit, you can check
in that change that I think you meant to check in."  Wouldn't you
expect "git checkout branch; git commit -a" on a clean tree to never
commit anything?

>  > PITFALLS:
>  > pitfall)
>  > If you commit a change on a submodule that's not on a branch, auto-updating
>  > submodules will make it difficult to revive that change.
>  >
>  > workaround)
>  > Don't allow the user to commit unless they are on a branch.
>  >
>  > ... couldn't think of anymore.  Anyone?

We had some discussion on the list earlier about having submodule
checkouts automatically acquire a branch name, so that commits don't
get lost as easily.  I was going to think about this more and
eventually submit a patch, but I haven't gotten to it yet.  Anyway,
the idea is that you have a branch by default, so that you don't end
up in the useless situation of not being on a branch, which encourages
checking in without being on a branch, in the first place.

Have fun,

Avery
