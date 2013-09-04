From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C
 option
Date: Wed, 4 Sep 2013 20:20:24 +0800
Message-ID: <20130904122020.GA25538@gmail.com>
References: <20130903115944.GA29542@gmail.com>
 <xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
 <CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 14:20:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHC42-0003kw-AQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 14:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478Ab3IDMT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 08:19:58 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46243 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543Ab3IDMT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 08:19:57 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so218508pbc.21
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JIWpqwLKMdcdnvMX7XvtqVd6LXP4nSag5uggVnsK+Rg=;
        b=x+DSfcXewM8PrapjuWlaIqowqiKxPwA9vklcVxCsBxfRClhKPe31cDCtX3KXy8o9P1
         trwuITU6FgKUgaGbnz2m+Ch/NpsnEkFby0G7Wrnhbh5Hdg8ewn1NhOFKZq1lREMHyKqq
         i6xqqxx0ZaTruT9th4MJbUn503E7fTVo3H1CpPCICfn2DAHPhBliz8wZdqmMdtLYPcke
         BkOMcr3aDZkRPV+XRADJnGOII+z/BhUKMEGiT3DcKuKrd+MhphalB4Ftq+1kMCaFBbFq
         iKHn90i8us1IWoyh5GZTEVm1b0Oil/3nFyCwluW8bDML0jPScwOWSL4PySd1WFFXYcq6
         1Vng==
X-Received: by 10.66.141.39 with SMTP id rl7mr2994530pab.46.1378297196973;
        Wed, 04 Sep 2013 05:19:56 -0700 (PDT)
Received: from gmail.com ([210.195.237.83])
        by mx.google.com with ESMTPSA id ib9sm28470352pbc.43.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 05:19:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233834>

On Wed, Sep 04, 2013 at 02:36:47PM +0800, Nazri Ramliy wrote:
> On Wed, Sep 4, 2013 at 6:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Does the above format correctly without the usual "second and
> > subsequent paragraphs are not indented, but has '+' in place of
> > a blank line"?
> 
> No it doesn't. I'll fix it in the next reroll.
> 
> >> -             if (!prefixcmp(cmd, "--exec-path")) {
> >> +             if (!strcmp(cmd, "-C")) {
> >> +                     if (*argc < 2) {
> >> +                             fprintf(stderr, "No directory given for -C.\n" );
> >> +                             usage(git_usage_string);
> >> +                     }
> >> +                     if (chdir((*argv)[1]))
> >> +                             die_errno("Cannot change to '%s'", (*argv)[1]);
> >> +                     if (envchanged)
> >> +                             *envchanged = 1;
> >> +                     (*argv)++;
> >> +                     (*argc)--;
> >> +             } else if (!prefixcmp(cmd, "--exec-path")) {
> >
> > We usually do not prepend to an existing if/else if/ chain unless
> > there is a very good reason (e.g. the new "if" condition is very
> > often triggered and we are better off checking it early) exactly
> > because doing so would make a patch that is ugly like the above.
> > You are not touching the codepath that deal with --exec-path, but
> > the resulting patch makes it appear as if you are doing something to
> > it.
> 
> I agree with you here. I'll send the reroll later.

Here it is.

Eric: Care to give your "Reviewed-by:" stamp?

nazri

-- >8 --
Subject: git: run in a directory given with -C option

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

It takes more keypresses to invoke git command in a different
directory than the current one without leaving the current
directory:

    1. (cd ~/foo && git status)
       git --git-dir=~/foo/.git --work-dir=~/foo status
       GIT_DIR=~/foo/.git GIT_WORK_TREE=~/foo git status
    2. (cd ../..; git grep foo)
    3. for d in d1 d2 d3; do (cd $d && git svn rebase); done

While doable the methods shown above are arguably more suitable for
scripting than quick command line invocations.

With this new option, the above can be done with fewer keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 16 +++++++++-
 git.c                 | 13 +++++++-
 t/t0056-git-C.sh      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 83edf30..ae049da 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-c <name>=<value>]
+'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
@@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more information,
 because `git --help ...` is converted internally into `git
 help ...`.
 
+-C <path>::
+	Run as if git was started in <path> instead of the current working
+	directory.  When multiple -C options are given, each subsequent
+	non-absolute "-C <path>" is interpreted relative to the preceding "-C
+	<path>".
++
+This option affects options that expect path name like --git-dir and
+--work-tree in that their interpretations of the path names would be
+made relative to the working directory caused by the -C option. For
+example the following invocations are equivalent:
+
+    git --git-dir=a.git --work-tree=b -C c status
+    git --git-dir=c/a.git --work-tree=c/b status
+
 -c <name>=<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 2025f77..a2d99a7 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
 
 const char git_usage_string[] =
-	"git [--version] [--help] [-c name=value]\n"
+	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -153,6 +153,17 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			set_alternate_shallow_file((*argv)[0]);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
new file mode 100755
index 0000000..c0006da
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='"-C <path>" option and its effects on other path-related options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <path>" runs git from the directory <path>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
+	echo "initial in dir1" >expected &&
+	git -C dir1 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/a.txt &&
+	git -C dir1/dir2 add a.txt &&
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1/dir2 commit -m "initial in dir1/dir2" &&
+	git -C dir1 -C dir2 log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir option: "-C c --git-dir=a.git" is equivalent to "--git-dir c/a.git"' '
+	mkdir c &&
+	mkdir c/a &&
+	mkdir c/a.git &&
+	(cd c/a.git && git init --bare) &&
+	echo 1 >c/a/a.txt &&
+	git --git-dir c/a.git --work-tree=c/a add a.txt &&
+	git --git-dir c/a.git --work-tree=c/a commit -m "initial" &&
+	git --git-dir=c/a.git log -1 --format=%s >expected &&
+	git -C c --git-dir=a.git log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivalent to "-C c --git-dir=a.git"' '
+	git -C c --git-dir=a.git log -1 --format=%s >expected &&
+	git --git-dir=a.git -C c log -1 --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
+	rm c/a/a.txt &&
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c/a.git --work-tree=../a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	git -C c/a.git --work-tree=../a status >expected &&
+	git --work-tree=../a -C c/a.git status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=c/a.git --work-tree=c/a"' '
+	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	git -C c --git-dir=a.git --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git -C c --work-tree=a"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git -C c --work-tree=a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=a.git --work-tree=a" is equivalent to "--git-dir=a.git --work-tree=a -C c"' '
+	git -C c --git-dir=a.git --work-tree=a status >expected &&
+	git --git-dir=a.git --work-tree=a -C c status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Relative followed by fullpath: "-C ./here -C /there" is equivalent to "-C /there"' '
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1 -C "$(pwd)/dir1/dir2" log --format=%s >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.8.4.22.g38647a4
