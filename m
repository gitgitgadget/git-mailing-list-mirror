From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [RFC PATCH] Documentation: add manpage about workflows
Date: Sat, 20 Sep 2008 02:22:58 +0200
Message-ID: <adf1fd3d0809191722n44b49176u83833c33c5779b8d@mail.gmail.com>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch>
	 <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Sep 20 02:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgqGk-0007vu-JV
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 02:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbYITAXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYITAXB
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 20:23:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:54945 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYITAXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 20:23:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so727005fgg.17
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 17:22:58 -0700 (PDT)
Received: by 10.102.247.4 with SMTP id u4mr613291muh.94.1221870178150;
        Fri, 19 Sep 2008 17:22:58 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Fri, 19 Sep 2008 17:22:58 -0700 (PDT)
In-Reply-To: <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96328>

On Thu, Sep 11, 2008 at 5:39 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> This attempts to make a manpage about workflows that is both handy to
> point people at it and as a beginner's introduction.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  Documentation/Makefile         |    2 +-
>  Documentation/gitworkflows.txt |  326 +
+++++++++++++++++++++++++++++++++++++++

It should be linked/advertised from other pages (git, tutorial, everyda=
y?)
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkfl=
ows.txt
> new file mode 100644
> index 0000000..3462000
> --- /dev/null
> +++ b/Documentation/gitworkflows.txt

[...]

> +To achieve this, try to commit your new work at least every couple
> +hours. You can always go back and edit the commits with `git rebase
> +--interactive` to further improve the history before you publish it.

I do not agree with this. I don=B4t much differences between a big patc=
h
and the same patch divided randomly.

To achieve this, try to commit when you are minimally satisfied with
the new code or before large changes. You can always go back and edit
the commits with `git rebase --interactive` to further improve the
history before you publish it, or you could split a big patch as is
explained in gitlink:git-stash.

> +
> +
> +MANAGING BRANCHES
> +-----------------
> +
> +In the following, we will assume there are 'developers', 'testers' a=
nd
> +'users'.  Even if the "Testers" are actually an automated test suite
> +and all "Users" are developers themselves, try to think in these ter=
ms

"Testers" -> 'testers', ...

> +as you follow a software change through its life cycle.
> +
> +Usually a change evolves in a few steps:
> +
> +* The developers implement a few iterations until it "seems to work"=
=2E
> +
> +* The testers play with it, report bugs, test the fixes, eventually
> +  clearing the change for stable releases.
> +
> +* As the users work with the new feature, they report bugs which wil=
l
> +  have to be fixed.
> +
> +In the following sections we discuss some problems that arise from
> +such a "change flow", and how to solve them with Git.
> +
> +We consider a fictional project with (supported) stable branch
> +'maint', main testing/development branch 'master' and "bleeding edge=
"
> +branch 'next'.  We collectively call these three branches 'main
> +branches'.

You mention the next branch but it is not explained.

> +
> +
> +Merging upwards
> +~~~~~~~~~~~~~~~
> +
> +Since Git is quite good at merges, one should try to use them to
> +propagate changes.  For example, if a bug is fixed, you would want t=
o
> +apply the corresponding fix to all main branches.
> +
> +A quick moment of thought reveals that you cannot do this by merging
> +"downwards" to older releases, since that would merge 'all' changes.

all development changes

> +Hence the following:
> +
> +.Merge upwards
> +[caption=3D"Rule: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Always commit your fixes to the oldest supported branch that require
> +them.  Then (periodically) merge the main branches upwards into each
> +other.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This gives a very controlled flow of fixes.  If you notice that you
> +have applied a fix to e.g. 'master' that is also required in 'maint'=
,
> +you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
> +downwards.  This will happen a few times and is nothing to worry abo=
ut
> +unless you do it all the time.
> +
> +
> +Topic branches
> +~~~~~~~~~~~~~~
> +
> +Any nontrivial feature will require several patches to implement, an=
d
> +may get extra bugfixes or improvements during its lifetime.  If all
> +such commits were in one long linear history chain (e.g. if they wer=
e
> +all committed directly to, 'master'), it becomes very hard to see ho=
w
> +they belong together.
> +
> +The key concept here is "topic branches".  The name is pretty self
> +explanatory, with a minor caveat that comes from the "merge upwards"
> +rule above:
> +
> +.Topic branches
> +[caption=3D"Rule: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Make a side branch for every topic. Fork it off at the oldest main
> +branch that you will eventually want to merge it into.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Many things can then be done very naturally:
> +
> +* To get the feature/bugfix into a main branch, simply merge it.  If
> +  the topic has evolved further in the meantime, merge again.
> +
> +* If you find you need new features from an 'other' branch to contin=
ue

=2E.. from the branch 'other' to continue

> +  working on your topic, merge 'other' to 'topic'.  (However, do not
> +  do this "just habitually", see below.)
> +
> +* If you find you forked off the wrong branch and want to move it
> +  "back in time", use linkgit:git-rebase[1].
> +
> +Note that the last two points clash: a topic that has been merged
> +elsewhere should not be rebased.  See the section on RECOVERING FROM
> +UPSTREAM REBASE in linkgit:git-rebase[1].
> +
> +We should point out that "habitually" (regularly for no real reason)
> +merging a main branch into your topics--and by extension, merging
> +anything upstream into anything downstream on a regular basis--is
> +frowned upon:
> +
> +.Merge to downstream only at well-defined points
> +[caption=3D"Rule: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Do not merge to downstream except:
> +
> +* with a good reason (such as upstream API changes that affect you),=
 or
> +
> +* at well-defined points such as when an upstream release has been t=
agged.

Do not merge to downstream except with a good reasons:

* API changes that affect you branch
* your branch no longer merges cleanly
* when your branch is way not up-to-date.

And mainly at well-defined points, such as when an upstream release
has been tagged, preferably stable release.

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Otherwise, the many resulting small merges will greatly clutter up
> +history.  Anyone who later investigates the history of a file will
> +have to find out whether that merge affected the topic in
> +development.  Linus hates it.  An upstream might even inadvertently =
be
> +merged into a "more stable" branch.  And so on.

Yes, the main point is that Linus hates it :-)
> +
> +
> +Integration branches
> +~~~~~~~~~~~~~~~~~~~~
> +
> +If you followed the last paragraph, you will now have many small top=
ic
> +branches, and occasionally wonder how they interact.  Perhaps the
> +result of merging them does not even work?  But on the other hand, w=
e
> +want to avoid merging them anywhere "stable" because such merges
> +cannot easily be undone.
> +
> +The solution, of course, is to make a merge that we can undo: merge
> +into a throw-away branch.
> +
> +.Integration branches
> +[caption=3D"Rule: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To test the interaction of several topics, merge them into a
> +throw-away branch.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +If you make it (very) clear that this branch is going to be deleted
> +right after the testing, you can even publish this branch, for examp=
le
> +to give the testers a chance to work with it, or other developers a
> +chance to see if their in-progress work will be compatible.
> +
> +
> +SHARING WORK
> +------------
> +
> +After the last section, you should know how to manage topics.  In
> +general, you will not be the only person working on the project, so
> +you will have to share your work.
> +
> +Roughly speaking, there are two important workflows.  Their
> +distinguishing mark is whether they can be used to propagate merges.

and one keeps the branch history while the other rewrite it.

> +Medium to large projects will typically employ some mixture of the
> +two:

I would remove this.

The different actors share their work as:
> +
> +* "Upstream" in the most general sense 'pushes' changes to the
> +  repositor(ies) holding the main history.  Everyone can 'pull' from
> +  there to stay up to date.

s/repositor(ies)/repository/

And:

She pull from her (trusted) downstreams, and applies the patches from
the others.

> +
> +* Frequent contributors, subsystem maintainers, etc. may use push/pu=
ll
> +  to send their changes upstream.

?

Maybe:

* (Trusted) Downstreams act like the Upstreams but publish their
changes in their own repository.
> +
> +* The rest -- typically anyone more than one or two levels away from=
 the
> +  main maintainer -- send patches by mail.
> +
> +None of these boundaries are sharp, so find out what works best for
> +you.
> +
> +
> +Push/pull
> +~~~~~~~~~
> +
> +There are three main tools that can be used for this:
> +
> +* linkgit:git-push[1] copies your branches to a remote repository,
> +  usually to one that can be read by all involved parties;
> +
> +* linkgit:git-fetch[1] that copies remote branches to your repositor=
y;
> +  and
> +
> +* linkgit:git-pull[1] that is fetch and merge in one go.
> +
> +Note the last point.  Do 'not' use 'git-pull' unless you actually wa=
nt
> +to merge the remote branch.

No need to repeat what is explained in the tutorial.

> +
> +Getting changes out is easy:
> +
> +.Push/pull: Publishing branches/topics
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git push <remote> <branch>` and tell everyone where they can fetch
> +from.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +You will still have to tell people by other means, such as mail.  (G=
it

s/tell/inform/

> +provides the linkgit:request-pull[1] to send preformatted pull
> +requests to upstream maintainers to simplify this task.)
> +


> +If you just want to get the newest copies of the main branches,
> +staying up to date is easy too:
> +
> +.Push/pull: Staying up to date
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Use `git fetch <remote>` or `git remote update` to stay up to date.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Then simply fork your topic branches from the stable remotes as
> +explained earlier.
> +

In tutorial.txt. And it applies to everybody (upstream, contributors,..=
=2E)

> +If you are a maintainer and would like to merge other people's topic
> +branches to the main branches, they will typically send a request to
> +do so by mail.  Such a request might say
> +
> +-------------------------------------
> +Please pull from
> +    git://some.server.somewhere/random/repo.git mytopic
> +-------------------------------------
> +
> +In that case, 'git-pull' can do the fetch and merge in one go, as
> +follows.
> +
> +.Push/pull: Merging remote topics
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git pull <url> <branch>`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

In tutorial. I think they are well explained in the tutorial. No need
to repeat it here. You could just mentions the tools and the recipies.

> +Occasionally, the maintainer may get merge conflicts when he tries t=
o
> +pull changes from downstream.  In this case, he can ask downstream t=
o
> +do the merge and resolve the conflicts themselves (perhaps they will
> +know better how to react).  It is one of the rare cases where
> +downstream 'should' merge from upstream.
> +
> +
> +format-patch/am
> +~~~~~~~~~~~~~~~
> +
> +If you are a contributor that sends changes upstream in the form of
> +emails, you should use topic branches as usual (see above).  Then us=
e
> +linkgit:git-format-patch[1] to generate the corresponding emails
> +(highly recommended over manually formatting them because it makes t=
he
> +maintainer's life easier).
> +
> +.format-patch/am: Publishing branches/topics
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git format-patch -M upstream..topic` and send out the resulting fil=
es.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See the linkgit:git-format-patch[1] manpage for further usage notes.
> +Also you should be aware that the maintainer may impose further
> +restrictions, such as "Signed-off-by" requirements.

the further restrictions are not only for git-format-patch users.

> +
> +If the maintainer tells you that your patch no longer applies to the
> +current upstream, you will have to rebase your topic (you cannot use=
 a
> +merge because you cannot format-patch merges):
> +
> +.format-patch/am: Keeping topics up to date
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git rebase upstream`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

git rebase <upstream>

> +
> +You can then fix the conflicts during the rebase.  Presumably you ha=
ve
> +not published your topic other than by mail, so rebasing it is not a
> +problem.
> +
> +If you receive such a patch (as maintainer, or perhaps reader of the

as a reader

> +mailing list it was sent to), save the mail to a file and use
> +'git-am':
> +
> +.format-patch/am: Publishing branches/topics
> +[caption=3D"Recipe: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +`git am < patch`
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +One feature worth pointing out is the three-way merge, which can hel=
p
> +if you get conflicts because of renames: `git am -3` will use index
> +information contained in patches to reconstruct a merge base.  See
> +linkgit:git-am[1] for other options.
> +
> +
> +SEE ALSO
> +--------
> +linkgit:gittutorial[7],
> +linkgit:git-push[1],
> +linkgit:git-pull[1],
> +linkgit:git-merge[1],
> +linkgit:git-rebase[1],
> +linkgit:git-format-patch[1],
> +linkgit:git-am[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite.
> --

Santi-
