From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Mon, 14 May 2007 11:21:20 -0400
Message-ID: <46836.6894325756$1179156135@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNF-0006P0-HX
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbXENPVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:34 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbXENPVc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54954 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbXENPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z0-E7; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47252>

=46rom: Johannes Schindelin <Johannes.Schindelin@gmx.de>

In http://thread.gmane.org/gmane.comp.version-control.git/42479,
a birdview on the source code was requested.

J. Bruce Fields suggested that my reply should be included in the
user manual, and there was nothing of an outcry, so here it is,
not 2 months later.

It includes modifications as suggested by J. Bruce Fields, Karl
Hasselstr=C3=B6m and Daniel Barkalow.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/user-manual.txt |  219 +++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 219 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 13db969..bac9660 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3160,6 +3160,225 @@ confusing and scary messages, but it won't actu=
ally do anything bad. In
 contrast, running "git prune" while somebody is actively changing the=20
 repository is a *BAD* idea).
=20
+[[birdview-on-the-source-code]]
+A birdview on Git's source code
+-----------------------------
+
+While Git's source code is quite elegant, it is not always easy for
+new  developers to find their way through it.  A good idea is to look
+at the contents of the initial commit:
+_e83c5163316f89bfbde7d9ab23ca2e25604af290_ (also known as _v0.99~954_)=
=2E
+
+Tip: you can see what files are in there with
+
+----------------------------------------------------
+$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:
+----------------------------------------------------
+
+and look at those files with something like
+
+-----------------------------------------------------------
+$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:cache.h
+-----------------------------------------------------------
+
+Be sure to read the README in that revision _after_ you are familiar w=
ith
+the terminology (<<glossary>>), since the terminology has changed a li=
ttle
+since then.  For example, we call the things "commits" now, which are
+described in that README as "changesets".
+
+Actually a lot of the structure as it is now can be explained by that
+initial commit.
+
+For example, we do not call it "cache" any more, but "index", however,=
 the
+file is still called `cache.h`.  Remark: Not much reason to change it =
now,
+especially since there is no good single name for it anyway, because i=
t is
+basically _the_ header file which is included by _all_ of Git's C sour=
ces.
+
+If you grasp the ideas in that initial commit (it is really small and =
you
+can get into it really fast, and it will help you recognize things in =
the
+much larger code base we have now), you should go on skimming `cache.h=
`,
+`object.h` and `commit.h` in the current version.
+
+In the early days, Git (in the tradition of UNIX) was a bunch of progr=
ams
+which were extremely simple, and which you used in scripts, piping the
+output of one into another. This turned out to be good for initial
+development, since it was easier to test new things.  However, recentl=
y
+many of these parts have become builtins, and some of the core has bee=
n
+"libified", i.e. put into libgit.a for performance, portability reason=
s,
+and to avoid code duplication.
+
+By now, you know what the index is (and find the corresponding data
+structures in `cache.h`), and that there are just a couple of object t=
ypes
+(blobs, trees, commits and tags) which inherit their common structure =
from
+`struct object`, which is their first member (and thus, you can cast e=
=2Eg.
+`(struct object *)commit` to achieve the _same_ as `&commit->object`, =
i.e.
+get at the object name and flags).
+
+Now is a good point to take a break to let this information sink in.
+
+Next step: get familiar with the object naming.  Read <<naming-commits=
>>.
+There are quite a few ways to name an object (and not only revisions!)=
=2E
+All of these are handled in `sha1_name.c`. Just have a quick look at
+the function `get_sha1()`. A lot of the special handling is done by
+functions like `get_sha1_basic()` or the likes.
+
+This is just to get you into the groove for the most libified part of =
Git:
+the revision walker.
+
+Basically, the initial version of `git log` was a shell script:
+
+----------------------------------------------------------------
+$ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
+	LESS=3D-S ${PAGER:-less}
+----------------------------------------------------------------
+
+What does this mean?
+
+`git-rev-list` is the original version of the revision walker, which
+_always_ printed a list of revisions to stdout.  It is still functiona=
l,
+and needs to, since most new Git programs start out as scripts using
+`git-rev-list`.
+
+`git-rev-parse` is not as important any more; it was only used to filt=
er out
+options that were relevant for the different plumbing commands that we=
re
+called by the script.
+
+Most of what `git-rev-list` did is contained in `revision.c` and
+`revision.h`.  It wraps the options in a struct named `rev_info`, whic=
h
+controls how and what revisions are walked, and more.
+
+The original job of `git-rev-parse` is now taken by the function
+`setup_revisions()`, which parses the revisions and the common command=
 line
+options for the revision walker. This information is stored in the str=
uct
+`rev_info` for later consumption. You can do your own command line opt=
ion
+parsing after calling `setup_revisions()`. After that, you have to cal=
l
+`prepare_revision_walk()` for initialization, and then you can get the
+commits one by one with the function `get_revision()`.
+
+If you are interested in more details of the revision walking process,
+just have a look at the first implementation of `cmd_log()`; call
+`git-show v1.3.0~155^2~4` and scroll down to that function (note that =
you
+no longer need to call `setup_pager()` directly).
+
+Nowadays, `git log` is a builtin, which means that it is _contained_ i=
n the
+command `git`.  The source side of a builtin is
+
+- a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c=
`,
+  and declared in `builtin.h`,
+
+- an entry in the `commands[]` array in `git.c`, and
+
+- an entry in `BUILTIN_OBJECTS` in the `Makefile`.
+
+Sometimes, more than one builtin is contained in one source file.  For
+example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin-l=
og.c`,
+since they share quite a bit of code.  In that case, the commands whic=
h are
+_not_ named like the `.c` file in which they live have to be listed in
+`BUILT_INS` in the `Makefile`.
+
+`git log` looks more complicated in C than it does in the original scr=
ipt,
+but that allows for a much greater flexibility and performance.
+
+Here again it is a good point to take a pause.
+
+Lesson three is: study the code.  Really, it is the best way to learn =
about
+the organization of Git (after you know the basic concepts).
+
+So, think about something which you are interested in, say, "how can I
+access a blob just knowing the object name of it?".  The first step is=
 to
+find a Git command with which you can do it.  In this example, it is e=
ither
+`git show` or `git cat-file`.
+
+For the sake of clarity, let's stay with `git cat-file`, because it
+
+- is plumbing, and
+
+- was around even in the initial commit (it literally went only throug=
h
+  some 20 revisions as `cat-file.c`, was renamed to `builtin-cat-file.=
c`
+  when made a builtin, and then saw less than 10 versions).
+
+So, look into `builtin-cat-file.c`, search for `cmd_cat_file()` and lo=
ok what
+it does.
+
+------------------------------------------------------------------
+        git_config(git_default_config);
+        if (argc !=3D 3)
+                usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
+        if (get_sha1(argv[2], sha1))
+                die("Not a valid object name %s", argv[2]);
+------------------------------------------------------------------
+
+Let's skip over the obvious details; the only really interesting part
+here is the call to `get_sha1()`.  It tries to interpret `argv[2]` as =
an
+object name, and if it refers to an object which is present in the cur=
rent
+repository, it writes the resulting SHA-1 into the variable `sha1`.
+
+Two things are interesting here:
+
+- `get_sha1()` returns 0 on _success_.  This might surprise some new
+  Git hackers, but there is a long tradition in UNIX to return differe=
nt
+  negative numbers in case of different errors -- and 0 on success.
+
+- the variable `sha1` in the function signature of `get_sha1()` is `un=
signed
+  char *`, but is actually expected to be a pointer to `unsigned
+  char[20]`.  This variable will contain the 160-bit SHA-1 of the give=
n
+  commit.  Note that whenever a SHA-1 is passed as "unsigned char *", =
it
+  is the binary representation, as opposed to the ASCII representation=
 in
+  hex characters, which is passed as "char *".
+
+You will see both of these things throughout the code.
+
+Now, for the meat:
+
+----------------------------------------------------------------------=
-------
+        case 0:
+                buf =3D read_object_with_reference(sha1, argv[1], &siz=
e, NULL);
+----------------------------------------------------------------------=
-------
+
+This is how you read a blob (actually, not only a blob, but any type o=
f
+object).  To know how the function `read_object_with_reference()` actu=
ally
+works, find the source code for it (something like `git grep
+read_object_with | grep ":[a-z]"` in the git repository), and read
+the source.
+
+To find out how the result can be used, just read on in `cmd_cat_file(=
)`:
+
+-----------------------------------
+        write_or_die(1, buf, size);
+-----------------------------------
+
+Sometimes, you do not know where to look for a feature.  In many such =
cases,
+it helps to search through the output of `git log`, and then `git show=
` the
+corresponding commit.
+
+Example: If you know that there was some test case for `git bundle`, b=
ut
+do not remember where it was (yes, you _could_ `git grep bundle t/`, b=
ut that
+does not illustrate the point!):
+
+------------------------
+$ git log --no-merges t/
+------------------------
+
+In the pager (`less`), just search for "bundle", go a few lines back,
+and see that it is in commit 18449ab0...  Now just copy this object na=
me,
+and paste it into the command line
+
+-------------------
+$ git show 18449ab0
+-------------------
+
+Voila.
+
+Another example: Find out what to do in order to make some script a
+builtin:
+
+-------------------------------------------------
+$ git log --no-merges --diff-filter=3DA builtin-*.c
+-------------------------------------------------
+
+You see, Git is actually the best tool to find out about the source of=
 Git
+itself!
+
 [[glossary]]
 include::glossary.txt[]
=20
--=20
1.5.1.4.19.g69e2
