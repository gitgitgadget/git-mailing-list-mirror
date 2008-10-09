From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2] Documentation: add manpage about workflows
Date: Thu,  9 Oct 2008 13:42:16 +0200
Message-ID: <1223552537-6918-1-git-send-email-trast@student.ethz.ch>
References: <adf1fd3d0810010254k5961b182ked9acda55e2aa57c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <santi@agolina.net>, "Dmitry Potapov" <dpotapov@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 13:43:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KntvZ-0000tQ-2j
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbYJILmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:42:21 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbYJILmV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:42:21 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:21224 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340AbYJILmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:42:20 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Oct 2008 13:42:14 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Oct 2008 13:42:14 +0200
X-Mailer: git-send-email 1.6.0.2.796.gd596a
In-Reply-To: <adf1fd3d0810010254k5961b182ked9acda55e2aa57c@mail.gmail.com>
X-OriginalArrivalTime: 09 Oct 2008 11:42:14.0783 (UTC) FILETIME=[133DE8F0:01C92A04]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97846>

This attempts to make a manpage about workflows that is both handy to
point people at it and as a beginner's introduction.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

[Apologies if some of the Cc's were sent twice; I got a bounce because
of non-ASCII headers and was unable to tell if any were delivered.]

Let's try another iteration.

I decided the "MANAGING BRANCHES" introduction paragraph was a good
place to (finally) mention the points about merge vs. cherry-pick
raised by Dmitry earlier.

I think I've addressed the other concerns, except for the "SHARING
WORK" section, now renamed to "DISTRIBUTED WORKFLOWS":

Santi B=C3=A9jar wrote:
> Sorry, but I don't see the point explaining how to publish the
> branches, or keep them up to date.

I feel it needs to be explained _somewhere_, since pull is designed to
make the merge workflow as easy as possible, and then push/fetch are
needed to complete the picture (especially so since I'm trying to make
a point of highlighting when not to use pull).  Maybe you can/want to
convince me otherwise.

And note that push is not explained in gittutorial.txt, only linked.
It is explained in gitcore-tutorial.txt, but that says

  However, an understanding of these low-level tools can be helpful if
  you want to understand git's internals.

in the introduction.  I don't really expect any user to read any
further after hearing that everything in there is "low-level".  Maybe
some tutorial cleanup would be in order.

Other than that, I'll wait for some more comments, then polish up the
commit message and submit "for real".

Interdiff will follow, as before.

- Thomas


 Documentation/Makefile         |    2 +-
 Documentation/gitworkflows.txt |  362 ++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 363 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ded0e40..e33ddcb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -6,7 +6,7 @@ MAN5_TXT=3Dgitattributes.txt gitignore.txt gitmodules.t=
xt githooks.txt \
 	gitrepository-layout.txt
 MAN7_TXT=3Dgitcli.txt gittutorial.txt gittutorial-2.txt \
 	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
-	gitdiffcore.txt
+	gitdiffcore.txt gitworkflows.txt
=20
 MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=3D$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflow=
s.txt
new file mode 100644
index 0000000..037ace5
--- /dev/null
+++ b/Documentation/gitworkflows.txt
@@ -0,0 +1,362 @@
+gitworkflows(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+gitworkflows - An overview of recommended workflows with git
+
+SYNOPSIS
+--------
+git *
+
+
+DESCRIPTION
+-----------
+
+This document attempts to write down and motivate some of the workflow
+elements used for `git.git` itself.  Many ideas apply in general,
+though the full workflow is rarely required for smaller projects with
+fewer people involved.
+
+We formulate a set of 'rules' for quick reference, while the prose
+tries to motivate each of them.  Do not always take them literally;
+you should value good reasons for your actions higher than manpages
+such as this one.
+
+
+SEPARATE CHANGES
+----------------
+
+As a general rule, you should try to split your changes into small
+logical steps, and commit each of them.  They should be consistent,
+working independently of any later commits, pass the test suite, etc.
+This makes the review process much easier, and the history much more
+useful for later inspection and analysis, for example with
+linkgit:git-blame[1] and linkgit:git-bisect[1].
+
+To achieve this, try to split your work into small steps from the very
+beginning. It is always easier to squash a few commits together than
+to split one big commit into several.  Don't be afraid of making too
+small or imperfect steps along the way. You can always go back later
+and edit the commits with `git rebase \--interactive` before you
+publish them.  You can use `git stash save \--keep-index` to run the
+test suite independent of other uncommitted changes; see the EXAMPLES
+section of linkgit:git-stash[1].
+
+
+MANAGING BRANCHES
+-----------------
+
+There are two main tools that can be used to include changes from one
+branch on another: linkgit:git-merge[1] and
+linkgit:git-cherry-pick[1].
+
+Merges have many advantages, so we try to solve as many problems as
+possible with merges alone.  Cherry-picking is still occasionally
+useful; see "Merging upwards" below for an example.
+
+Most importantly, merging works at the branch level, while
+cherry-picking works at the commit level.  This means that a merge can
+carry over the changes from 1, 10, or 1000 commits with equal ease,
+which in turn means the workflow scales much better to a large number
+of contributors (and contributions).  Merges are also easier to
+understand because a merge commit is a "promise" that all changes from
+all its parents are now included.
+
+There is a tradeoff of course: merges require a more careful branch
+management.  The following subsections discuss the important points.
+
+
+Graduation
+~~~~~~~~~~
+
+As a given feature goes from experimental to stable, it also
+"graduates" between the corresponding branches of the software.
+`git.git` uses the following 'main branches':
+
+* 'maint' tracks the commits that should go into the next "maintenance
+  release", i.e., update of the last released stable version;
+
+* 'master' tracks the commits that should go into the next release;
+
+* 'next' is intended as a testing branch for topics not stable enough
+  for master yet.
+
+There is a fourth official branch that is used slightly differently:
+
+* 'pu' (proposed updates) is an integration branch for things that are
+  not quite ready for inclusion yet (see "Integration Branches"
+  below).
+
+Each of the four branches is usually a direct descendant of the one
+above it.
+
+Conceptually, the feature enters at an unstable branch (usually 'next'
+or 'pu'), and "graduates" to 'master' for the next release once it is
+considered stable enough.
+
+
+Merging upwards
+~~~~~~~~~~~~~~~
+
+The "downwards graduation" discussed above cannot be done by actually
+merging downwards, however, since that would merge 'all' changes on
+the unstable branch into the stable one.  Hence the following:
+
+.Merge upwards
+[caption=3D"Rule: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Always commit your fixes to the oldest supported branch that require
+them.  Then (periodically) merge the main branches upwards into each
+other.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This gives a very controlled flow of fixes.  If you notice that you
+have applied a fix to e.g. 'master' that is also required in 'maint',
+you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
+downwards.  This will happen a few times and is nothing to worry about
+unless you do it very frequently.
+
+
+Topic branches
+~~~~~~~~~~~~~~
+
+Any nontrivial feature will require several patches to implement, and
+may get extra bugfixes or improvements during its lifetime.
+
+Committing everything directly on the main branches leads to many
+problems: Bad commits cannot be undone, so they must be reverted one
+by one, which creates confusing histories and further error potential
+when you forget to revert part of a group of changes.  Working in
+parallel mixes up the changes, creating further confusion.
+
+The key concept here is "topic branches".  The name is pretty self
+explanatory, with a caveat that comes from the "merge upwards" rule
+above:
+
+.Topic branches
+[caption=3D"Rule: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Make a side branch for every topic (feature, bugfix, ...). Fork it off
+at the oldest main branch that you will eventually want to merge it
+into.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Many things can then be done very naturally:
+
+* To get the feature/bugfix into a main branch, simply merge it.  If
+  the topic has evolved further in the meantime, merge again.
+
+* If you find you need new features from the branch 'other' to continu=
e
+  working on your topic, merge 'other' to 'topic'.  (However, do not
+  do this "just habitually", see below.)
+
+* If you find you forked off the wrong branch and want to move it
+  "back in time", use linkgit:git-rebase[1].
+
+Note that the last two points clash: a topic that has been merged
+elsewhere should not be rebased.  See the section on RECOVERING FROM
+UPSTREAM REBASE in linkgit:git-rebase[1].
+
+We should point out that "habitually" (regularly for no real reason)
+merging a main branch into your topics -- and by extension, merging
+anything upstream into anything downstream on a regular basis -- is
+frowned upon:
+
+.Merge to downstream only at well-defined points
+[caption=3D"Rule: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Do not merge to downstream except:
+
+* with a good reason: upstream API changes affect your branch; your
+  branch no longer merges to upstream cleanly; etc.
+
+* at well-defined points such as when an upstream release has been tag=
ged.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Otherwise, the many resulting small merges will greatly clutter up
+history.  Anyone who later investigates the history of a file will
+have to find out whether that merge affected the topic in development.
+An upstream might even inadvertently be merged into a "more stable"
+branch.  And so on.
+
+
+Integration branches
+~~~~~~~~~~~~~~~~~~~~
+
+If you followed the last paragraph, you will now have many small topic
+branches, and occasionally wonder how they interact.  Perhaps the
+result of merging them does not even work?  But on the other hand, we
+want to avoid merging them anywhere "stable" because such merges
+cannot easily be undone.
+
+The solution, of course, is to make a merge that we can undo: merge
+into a throw-away branch.
+
+.Integration branches
+[caption=3D"Rule: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+To test the interaction of several topics, merge them into a
+throw-away branch.  You must never base any work on such a branch!
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If you make it (very) clear that this branch is going to be deleted
+right after the testing, you can even publish this branch, for example
+to give the testers a chance to work with it, or other developers a
+chance to see if their in-progress work will be compatible.  `git.git`
+has such an official integration branch called 'pu'.
+
+
+DISTRIBUTED WORKFLOWS
+---------------------
+
+After the last section, you should know how to manage topics.  In
+general, you will not be the only person working on the project, so
+you will have to share your work.
+
+Roughly speaking, there are two important workflows: merge and patch.
+The important difference is that the merge workflow can propagate full
+history, including merges, while patches cannot.  Both workflows can
+be used in parallel: in `git.git`, only subsystem maintainers use
+the merge workflow, while everyone else sends patches.
+
+Note that the maintainer(s) may impose restrictions, such as
+"Signed-off-by" requirements, that all commits/patches submitted for
+inclusion must adhere to.  Consult your project's documentation for
+more information.
+
+
+Merge workflow
+~~~~~~~~~~~~~~
+
+The merge workflow works by copying branches between upstream and
+downstream.  Upstream can merge contributions into the official
+history; downstream base their work on the official history.
+
+There are three main tools that can be used for this:
+
+* linkgit:git-push[1] copies your branches to a remote repository,
+  usually to one that can be read by all involved parties;
+
+* linkgit:git-fetch[1] that copies remote branches to your repository;
+  and
+
+* linkgit:git-pull[1] that does fetch and merge in one go.
+
+Note the last point.  Do 'not' use 'git-pull' unless you actually want
+to merge the remote branch.
+
+Getting changes out is easy:
+
+.Push/pull: Publishing branches/topics
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git push <remote> <branch>` and tell everyone where they can fetch
+from.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+You will still have to tell people by other means, such as mail.  (Git
+provides the linkgit:request-pull[1] to send preformatted pull
+requests to upstream maintainers to simplify this task.)
+
+If you just want to get the newest copies of the main branches,
+staying up to date is easy too:
+
+.Push/pull: Staying up to date
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Use `git fetch <remote>` or `git remote update` to stay up to date.
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Then simply fork your topic branches from the stable remotes as
+explained earlier.
+
+If you are a maintainer and would like to merge other people's topic
+branches to the main branches, they will typically send a request to
+do so by mail.  Such a request looks like
+
+-------------------------------------
+Please pull from
+    <url> <branch>
+-------------------------------------
+
+In that case, 'git-pull' can do the fetch and merge in one go, as
+follows.
+
+.Push/pull: Merging remote topics
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git pull <url> <branch>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Occasionally, the maintainer may get merge conflicts when he tries to
+pull changes from downstream.  In this case, he can ask downstream to
+do the merge and resolve the conflicts themselves (perhaps they will
+know better how to resolve them).  It is one of the rare cases where
+downstream 'should' merge from upstream.
+
+
+Patch workflow
+~~~~~~~~~~~~~~
+
+If you are a contributor that sends changes upstream in the form of
+emails, you should use topic branches as usual (see above).  Then use
+linkgit:git-format-patch[1] to generate the corresponding emails
+(highly recommended over manually formatting them because it makes the
+maintainer's life easier).
+
+.format-patch/am: Publishing branches/topics
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+* `git format-patch -M upstream..topic` to turn them into preformatted
+  patch files
+* `git send-email --to=3D<recipient> <patches>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
+manpages for further usage notes.
+
+If the maintainer tells you that your patch no longer applies to the
+current upstream, you will have to rebase your topic (you cannot use a
+merge because you cannot format-patch merges):
+
+.format-patch/am: Keeping topics up to date
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git pull --rebase <url> <branch>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+You can then fix the conflicts during the rebase.  Presumably you have
+not published your topic other than by mail, so rebasing it is not a
+problem.
+
+If you receive such a patch series (as maintainer, or perhaps as a
+reader of the mailing list it was sent to), save the mails to files,
+create a new topic branch and use 'git-am' to import the commits:
+
+.format-patch/am: Importing patches
+[caption=3D"Recipe: "]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git am < patch`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+One feature worth pointing out is the three-way merge, which can help
+if you get conflicts: `git am -3` will use index information contained
+in patches to figure out the merge base.  See linkgit:git-am[1] for
+other options.
+
+
+SEE ALSO
+--------
+linkgit:gittutorial[7],
+linkgit:git-push[1],
+linkgit:git-pull[1],
+linkgit:git-merge[1],
+linkgit:git-rebase[1],
+linkgit:git-format-patch[1],
+linkgit:git-send-email[1],
+linkgit:git-am[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite.
--=20
tg: (2de69d4..) t/doc-workflows (depends on: origin/master t/doc-rebase=
-warn t/doc-rebase-refer)
