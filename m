From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH v3] Documentation: convert tutorials to man pages
Date: Sun, 25 May 2008 10:12:35 +0900
Message-ID: <200805250113.m4P1DSCg028065@mi1.bluebottle.com>
References: <20080524205644.f056db96.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 25 03:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K04oY-0005TU-TE
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbYEYBNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbYEYBNa
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:13:30 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:52161 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbYEYBN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 21:13:29 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4P1DSCg028065
	for <git@vger.kernel.org>; Sat, 24 May 2008 18:13:28 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=MWAx/kTCOdkouDp+EzWPEW1tnkRQkD76/4zrh4m2VVY/1YLkM5JbpKeKhnK6U6WtE
	cql3/KOhLYakYX3pzSWNSSJI3m1NbxGtVZTjcGrFyJfG6qNGs/EeF7Yp13+87wX
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4P1D6oT019014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 May 2008 18:13:10 -0700
In-Reply-To: <20080524205644.f056db96.chriscool@tuxfamily.org>
X-Trusted-Delivery: <8fc43c34cd826984a2439d9996fb669b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82843>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch renames the following documents and at the same time converts
> them to the man page format:
>
> cvs-migration.txt -> gitcvs-migration.txt
> tutorial.txt      -> gittutorial.txt
> tutorial-2.txt    -> gittutorial-2.txt
>
> These new man pages are put in section 1.
>
> Other documents that reference the above ones are change accordingly.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

There are too many unrelated line re-wrapping changes that are distracting for reviewing your changes.

However, I think this is much improved, compared to the one around the beginning of the month.  Especially that documents like the user manual that do not fit well in "manual page" format are excluded.

But if I read intro(1) and intro(7) correctly, nothing other than the user commands should go to section 1.  Here is my attempt, as a replacement patch, to clean it up.

What do you think?

 Documentation/Makefile                             |    8 ++---
 Documentation/core-tutorial.txt                    |    4 +-
 Documentation/git.txt                              |    4 +-
 .../{cvs-migration.txt => gitcvs-migration.txt}    |   29 +++++++++++++++--
 .../{tutorial-2.txt => gittutorial-2.txt}          |   30 ++++++++++++++++--
 Documentation/{tutorial.txt => gittutorial.txt}    |   32 ++++++++++++++++---
 Documentation/user-manual.txt                      |    4 +-
 7 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4144d1e..9750334 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,7 +3,8 @@ MAN1_TXT= \
 		$(wildcard git-*.txt)) \
 	gitk.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
-MAN7_TXT=git.txt gitcli.txt
+MAN7_TXT=git.txt gitcli.txt gittutorial.txt gittutorial-2.txt \
+	gitcvs-migration.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -11,10 +12,7 @@ MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
-ARTICLES = tutorial
-ARTICLES += tutorial-2
-ARTICLES += core-tutorial
-ARTICLES += cvs-migration
+ARTICLES = core-tutorial
 ARTICLES += diffcore
 ARTICLES += howto-index
 ARTICLES += repository-layout
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5a55312..b50b5dd 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -8,7 +8,7 @@ This tutorial explains how to use the "core" git programs to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with link:tutorial.html[a tutorial introduction to git] or
+to start with linkgit:gittutorial[7][a tutorial introduction to git] or
 link:user-manual.html[the git user manual].
 
 However, an understanding of these low-level tools can be helpful if
@@ -1581,7 +1581,7 @@ suggested in the previous section may be new to you. You do not
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See link:cvs-migration.html[git for CVS users] for the details.
+See linkgit:gitcvs-migration[7][git for CVS users] for the details.
 
 Bundling your work together
 ---------------------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index adcd3e0..735f0d1 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -20,10 +20,10 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See this link:tutorial.html[tutorial] to get started, then see
+See this linkgit:gittutorial[7][tutorial] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of commands, and
 "man git-commandname" for documentation of each command.  CVS users may
-also want to read link:cvs-migration.html[CVS migration].  See
+also want to read linkgit:gitcvs-migration[7][CVS migration].  See
 link:user-manual.html[Git User's Manual] for a more in-depth
 introduction.
 
diff --git a/Documentation/cvs-migration.txt b/Documentation/gitcvs-migration.txt
similarity index 93%
rename from Documentation/cvs-migration.txt
rename to Documentation/gitcvs-migration.txt
index 374bc87..c410805 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -1,5 +1,16 @@
-git for CVS users
-=================
+gitcvs-migration(7)
+===================
+
+NAME
+----
+gitcvs-migration - git for CVS users
+
+SYNOPSIS
+--------
+git cvsimport *
+
+DESCRIPTION
+-----------
 
 Git differs from CVS in that every working tree contains a repository with
 a full copy of the project history, and no repository is inherently more
@@ -8,7 +19,7 @@ designating a single shared repository which people can synchronize with;
 this document explains how to do that.
 
 Some basic familiarity with git is required.  This
-link:tutorial.html[tutorial introduction to git] and the
+linkgit:gittutorial[7][tutorial introduction to git] and the
 link:glossary.html[git glossary] should be sufficient.
 
 Developing against a shared repository
@@ -71,7 +82,7 @@ Setting Up a Shared Repository
 
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see the
-link:tutorial.html[tutorial]), or imported from an already existing CVS
+linkgit:gittutorial[7][tutorial]), or imported from an already existing CVS
 repository (see the next section).
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
@@ -170,3 +181,13 @@ variants of this model.
 
 With a small group, developers may just pull changes from each other's
 repositories without the need for a central maintainer.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+link:everyday.html[Everyday Git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/tutorial-2.txt b/Documentation/gittutorial-2.txt
similarity index 96%
rename from Documentation/tutorial-2.txt
rename to Documentation/gittutorial-2.txt
index 7fac47d..5bbbf43 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -1,7 +1,18 @@
-A tutorial introduction to git: part two
-========================================
+gittutorial-2(7)
+================
 
-You should work through link:tutorial.html[A tutorial introduction to
+NAME
+----
+gittutorial-2 - A tutorial introduction to git: part two
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
+
+You should work through linkgit:gittutorial[7][A tutorial introduction to
 git] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
@@ -394,7 +405,7 @@ link:glossary.html[Glossary].
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
 
-The link:cvs-migration.html[CVS migration] document explains how to
+The linkgit:gitcvs-migration[7][CVS migration] document explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
 
@@ -404,3 +415,14 @@ link:howto-index.html[howtos].
 For git developers, the link:core-tutorial.html[Core tutorial] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/tutorial.txt b/Documentation/gittutorial.txt
similarity index 97%
rename from Documentation/tutorial.txt
rename to Documentation/gittutorial.txt
index e2bbda5..898acdb 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -1,5 +1,16 @@
-A tutorial introduction to git (for version 1.5.1 or newer)
-===========================================================
+gittutorial(7)
+==============
+
+NAME
+----
+gittutorial - A tutorial introduction to git (for version 1.5.1 or newer)
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
 
 This tutorial explains how to import a new project into git, make
 changes to it, and share changes with other developers.
@@ -381,7 +392,7 @@ see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-link:cvs-migration.html[git for CVS users].
+linkgit:gitcvs-migration[7][git for CVS users].
 
 Exploring history
 -----------------
@@ -560,7 +571,7 @@ is based:
     used to create commits, check out working directories, and
     hold the various trees involved in a merge.
 
-link:tutorial-2.html[Part two of this tutorial] explains the object
+linkgit:gittutorial-2[7][Part two of this tutorial] explains the object
 database, the index file, and a few other odds and ends that you'll
 need to make the most of git.
 
@@ -581,4 +592,15 @@ digressions that may be interesting at this point are:
 
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
-  * link:cvs-migration.html[git for CVS users].
+  * linkgit:gitcvs-migration[7][git for CVS users].
+
+SEE ALSO
+--------
+linkgit:gittutorial-2[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e2db850..fd8cdb6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1993,7 +1993,7 @@ the right to push to the same repository.  In that case, the correct
 solution is to retry the push after first updating your work by either a
 pull or a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-link:cvs-migration.html[git for CVS users] for more.
+linkgit:gitcvs-migration[7][git for CVS users] for more.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
@@ -2002,7 +2002,7 @@ Setting up a shared repository
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-link:cvs-migration.html[git for CVS users] for instructions on how to
+linkgit:gitcvs-migration[7][git for CVS users] for instructions on how to
 set this up.
 
 However, while there is nothing wrong with git's support for shared



-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
