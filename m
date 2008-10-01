From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: obscure platform autobuilders
Date: Wed, 1 Oct 2008 11:46:43 +0100
Message-ID: <e2b179460810010346j23617764i8134c1f24b2746f0@mail.gmail.com>
References: <20080924154632.GR3669@spearce.org>
	 <e2b179460809260624n4b329345q3610069af5af75c2@mail.gmail.com>
	 <20080926225423.GA25502@coredump.intra.peff.net>
	 <e2b179460809290051q8ca76a4k7cf0af2748a5f0fc@mail.gmail.com>
	 <20081001071653.GA21174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:48:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkzFN-0005Gx-ID
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 12:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYJAKqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYJAKqr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 06:46:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:49874 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbYJAKqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 06:46:46 -0400
Received: by qw-out-2122.google.com with SMTP id 3so109969qwe.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3uOIGKhtvGOUou9leJDthbUCnO4sY0VR01p3vkH/Xks=;
        b=RNr7JioxVHx07wxQLKS5jlDAhMZxQvrkI79nddMg3LzxTTVayS0xnVe+YpFahv5URF
         P/Q0d4zxq/EHYHN103vPXH33UOAGXm7a5HDL8POQ31RHnaV56jVaZP5S1KxA/SFu+fHf
         RpG64mfaVsHmPqrfN9a1w4hDWUx0VOOdVdoxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZhCS2ZsnBq/5vTJJESZ48tIXcuOZn8zzHc32t+zXxMNOqJyRm3Q/f7Nfqr0FgeHJNa
         NC+lyqaaE9qzY9atk3BLLmtfEiwxVZ1cV8Uf1CzmCv5Qf4JaLUXHlwu30MByHiib4TcX
         4CeCpNoVatfi7Ga8rQgEzaal8AXCF9VWQwVrI=
Received: by 10.215.41.10 with SMTP id t10mr7972723qaj.62.1222858004134;
        Wed, 01 Oct 2008 03:46:44 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Wed, 1 Oct 2008 03:46:43 -0700 (PDT)
In-Reply-To: <20081001071653.GA21174@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97216>

2008/10/1 Jeff King <peff@peff.net>:
> On Mon, Sep 29, 2008 at 08:51:29AM +0100, Mike Ralphson wrote:
>> Feel free to push changes to gitbuild.sh, including getting rid of
>> anything which looks environment-specific.
>
> I actually went a step further and revamped the architecture a bit.
> Check out the "platform" branch in gitbuild.git. My goal was to try to
> include more information in the gitbuild repository about exactly what
> goes into the test setup for each platform.

Very nice!

> I'm currently building, testing, and pushing FreeBSD 6.1 and Solaris 2.8
> with it (you can see the copious tests I am skipping in
> jk/solaris/config).

My googling led me to think that INTERNAL_QSORT would be a good idea
on at least some versions of Solaris... it may depend on the fs
though.

> If you like this approach, please go ahead and add an "mr/aix" profile
> with your setup. See the README for details, and let me know if you have
> questions.  The script is a mish-mash of yours, mine, and some extra
> rewrites. I wouldn't be surprised if it needs a tweak or two. :)

How about this - let me know if ok, and I'll push it.

diff --git a/README b/README
index 184de11..e91037f 100644
--- a/README
+++ b/README
@@ -10,7 +10,8 @@ several files:
   - 'config', a shell script sourced by the build script to override any
     variables. See below for more information.

-  - 'branches', a list of branches, one per line, to build and test
+  - 'branches', a list of branches, one per line, to build and test.
+    Lines starting with # are treated as comments

   - 'gitconfig'; if this file exists, it will be used as the .git/config
     of the built and tested repository. This file should define a remote
@@ -18,7 +19,16 @@ several files:
     should be published (i.e., repo.or.cz:/srv/git/git/gitbuild.git).

   - 'config.mak'; if this file exists, it will be used as the config.mak
-    file for building git
+    file for building git. If it is not present, but there is a
+    config.mak file in your project directory, it is copied here to
+    prevent it being removed by 'git clean'
+
+  - 'catch', a shell script sourced by the build script if an error
+    occurs. It is passed the failing command-line in its arguments
+
+  - 'finally', a shell script sourced by the build script at the end
+    of the process. It is passed the exit code of build.sh as its
+    argument

 The convention for platform directory names is "$initials/$platform".  A
 build should be initiated from the platform directory. E.g., by putting
@@ -42,6 +52,9 @@ the variables are:

   - make; the command to invoke make. If not set, defaults to "gmake".

+  - project; the path to the directory to build in. If not set, defaults
+             to ./project relative to the starting directory
+
   - path_build; the PATH to use while building git. If not set, the
                 PATH is left alone.

@@ -52,8 +65,8 @@ Invoking build.sh
 =================

 Generally build.sh is invoked without any options, which means it should
-build all branches one after the other. However, it can be invoked with
-a branch name to build and test just a single branch.
+build all specified branches one after the other. However, it can be
+invoked with a branch name to build and test just a single branch.

 The 'project' directory need not be set up beforehand. If it does not
 exist, it will be created as an empty git repository automatically. As
 diff --git a/build.sh b/build.sh
index b318af2..0967ff3 100755
--- a/build.sh
+++ b/build.sh
@@ -9,6 +9,7 @@ root=$PWD
 initials=`dirname $PWD 2>/dev/null`; initials=`basename $initials 2>/dev/null`
 name=`basename $PWD 2>/dev/null`
 make=gmake
+project=project
 . ./config
 name=`echo $name | sed 's/[^A-Za-z0-9.-]/-/g'`

@@ -19,6 +20,8 @@ try() {
    0) ;;
    *) echo >&2 "build failed: $*"
       cat >&2 "$log"
+      test -f $root/catch && . $root/catch $*
+      test -f $root/finally && . $root/finally 1
       exit 1
       ;;
  esac
@@ -36,6 +39,7 @@ build_branch() {
   rm -f "$log"

   try git checkout -f -q $branch
+  test -f config.mak && test ! -f $root/config.mak && try cp config.mak $root/
   try git clean -d -f -q -x
   test -f $root/config.mak && try cp $root/config.mak config.mak

@@ -59,22 +63,23 @@ build_branch() {
 log=$root/log.build
 rm -f "$log"

-if ! test -d project; then
-  try mkdir project
-  try cd project
+if ! test -d $project; then
+  try mkdir $project
+  try cd $project
   try git init
 else
-  try cd project
+  try cd $project
 fi

 test -f $root/gitconfig && try cp $root/gitconfig .git/config
 try git remote update

 if test -z "$1"; then
-  for i in `cat "$root/branches"`; do
+  for i in `cat "$root/branches" | grep -v '^#'`; do
     build_branch $i || exit 1
   done
 else
   build_branch $1
 fi
+test -f $root/finally && . $root/finally 0
 exit 0
