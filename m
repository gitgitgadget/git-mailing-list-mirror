From: tony.luck@intel.com
Subject: git for beginners
Date: Thu, 14 Apr 2005 16:19:00 -0700
Message-ID: <200504142319.j3ENJ0O05860@unix-os.sc.intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:16:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDZ0-0005Zh-Ir
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVDNXTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVDNXTV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:19:21 -0400
Received: from fmr22.intel.com ([143.183.121.14]:8119 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261407AbVDNXTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:19:00 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3ENJ0xt025314
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 23:19:00 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3ENKKJI028915
	for <git@vger.kernel.org>; Thu, 14 Apr 2005 23:20:20 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3ENJ0O05860;
	Thu, 14 Apr 2005 16:19:00 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If the mechanics of git still have you stumped, then here are a couple of
examples of using the really low level tools to do some basic operations.
In real life you would have higher level wrappers around these tools so
that you don't have to remember to update .git/HEAD with the new SHA1 after
you do a commit ... but knowing what the low-level tools do may help you
understand what is going on.

-Tony

$ # How to create your own project from scratch
$ mkdir tmp
$ cd tmp
$ # Create initial empty git filesystem
$ init-db 
defaulting to private storage area
$ # Look around ... lots of directories, but no files yet
$ ls -l .git
total 4
drwxr-xr-x  258 aegl aegl 4096 Apr 14 14:54 objects
$ ls .git/objects/
00  09  12  1b  24  2d  36  3f  48  51  5a  63  6c  75  7e  87  90  99  a2  ab  b4  bd  c6  cf  d8  e1  ea  f3  fc
01  0a  13  1c  25  2e  37  40  49  52  5b  64  6d  76  7f  88  91  9a  a3  ac  b5  be  c7  d0  d9  e2  eb  f4  fd
02  0b  14  1d  26  2f  38  41  4a  53  5c  65  6e  77  80  89  92  9b  a4  ad  b6  bf  c8  d1  da  e3  ec  f5  fe
03  0c  15  1e  27  30  39  42  4b  54  5d  66  6f  78  81  8a  93  9c  a5  ae  b7  c0  c9  d2  db  e4  ed  f6  ff
04  0d  16  1f  28  31  3a  43  4c  55  5e  67  70  79  82  8b  94  9d  a6  af  b8  c1  ca  d3  dc  e5  ee  f7
05  0e  17  20  29  32  3b  44  4d  56  5f  68  71  7a  83  8c  95  9e  a7  b0  b9  c2  cb  d4  dd  e6  ef  f8
06  0f  18  21  2a  33  3c  45  4e  57  60  69  72  7b  84  8d  96  9f  a8  b1  ba  c3  cc  d5  de  e7  f0  f9
07  10  19  22  2b  34  3d  46  4f  58  61  6a  73  7c  85  8e  97  a0  a9  b2  bb  c4  cd  d6  df  e8  f1  fa
08  11  1a  23  2c  35  3e  47  50  59  62  6b  74  7d  86  8f  98  a1  aa  b3  bc  c5  ce  d7  e0  e9  f2  fb
$ find . -type f
$
$ # create some files ready to check in ... use a subdirectory just to show
$ # how subdirs work
$ mkdir src
$ cat > src/hello.c
#include <stdio.h>

main()
{
	printf("Hello, world!\n");
}
$ cat > Makefile
hello: src/hello.c
	cc -o hello -O src/hello.c
$ # Now add these two files to the cache, ready for checkin (use the
$ # "--add" option because these files are new)
$ update-cache --add Makefile src/hello.c
$ # save a tree listing these files
$ write-tree
eab75ce51622aa312bb0b03572d43769f420c347
$ # commit the change. We tell it the SHA1 of the tree we just made
$ commit-tree eab75ce51622aa312bb0b03572d43769f420c347
Committing initial tree eab75ce51622aa312bb0b03572d43769f420c347
First revision of the hello system.
0107d57e748b2f01601adb6749a03aed7b3f5a84
$ # Save the SHA1 for that changeset ... we need it later
$ echo 0107d57e748b2f01601adb6749a03aed7b3f5a84 > .git/HEAD
$ 
$ # Take a look at the changeset
$ cat-file commit 0107d57e748b2f01601adb6749a03aed7b3f5a84
tree eab75ce51622aa312bb0b03572d43769f420c347
author Tony Luck <aegl@example.com> Thu Apr 14 14:57:27 2005
committer Tony Luck <aegl@example.com> Thu Apr 14 14:57:27 2005

First revision of the hello system.
$ # And dig into the tree we saved
$ ls-tree eab75ce51622aa312bb0b03572d43769f420c347
100664	blob	3a7a1c51dbc62797d6c903203de44cc6a734c05c	Makefile
40000	tree	ba103f91defa4b3885b826d6630a055f27800398	src
$ # see that git automatically made a tree for the "src" subdir, look at it
$ ls-tree ba103f91defa4b3885b826d6630a055f27800398
100664	blob	522fff361ad5c07351479ea8504b7c370d189524	hello.c
$ # This blob is our src/hello.c file
$ cat-file blob 522fff361ad5c07351479ea8504b7c370d189524
#include <stdio.h>

main()
{
	printf("Hello, world!\n");
}
$ # Look at all the files we have now, a blob for each file, a
$ # pair of tree objects for the directory and subdir, and a lone
$ # changeset.
$ find .git -type f
.git/index
.git/objects/01/07d57e748b2f01601adb6749a03aed7b3f5a84
.git/objects/ba/103f91defa4b3885b826d6630a055f27800398
.git/objects/ea/b75ce51622aa312bb0b03572d43769f420c347
.git/objects/52/2fff361ad5c07351479ea8504b7c370d189524
.git/objects/3a/7a1c51dbc62797d6c903203de44cc6a734c05c
.git/HEAD
$ # Now make a change
$ ed src/hello.c
59
$i
	return 0;
.
w
70
q
$ # We need to tell .git/index which file(s) are going to be
$ # in this changeset. Don't need "--add" option because we are
$ # changing a file that already exists
$ update-cache src/hello.c 
$ # Now we can write a new tree incorporating the change
$ write-tree
8f5ba0203e31204c5c052d995a5b4449226bcfb5
$ # and finally create a changeset ... this time we tell commit that
$ # the parent of this change is the previous change
$ commit-tree 8f5ba0203e31204c5c052d995a5b4449226bcfb5 -p `cat .git/HEAD`
Fix hello program to return successful exit code.
5403689e0c29607f57da8f751d4ba40637134e87
$ # save the new changeset in .git/HEAD
$ echo 5403689e0c29607f57da8f751d4ba40637134e87 > .git/HEAD 
$ # walk the tree from HEAD to the new version of hello.c
$ cat-file commit 5403689e0c29607f57da8f751d4ba40637134e87
tree 8f5ba0203e31204c5c052d995a5b4449226bcfb5
parent 0107d57e748b2f01601adb6749a03aed7b3f5a84
author Tony Luck <aegl@example.com> Thu Apr 14 15:00:34 2005
committer Tony Luck <aegl@example.com> Thu Apr 14 15:00:34 2005

Fix hello program to return successful exit code.
$ ls-tree 8f5ba0203e31204c5c052d995a5b4449226bcfb5
100664	blob	3a7a1c51dbc62797d6c903203de44cc6a734c05c	Makefile
40000	tree	77dc2cb94930017f62b55b9706cbadda8c90f650	src
$ ls-tree 77dc2cb94930017f62b55b9706cbadda8c90f650
100664	blob	8a6a2a7261742c6f69adaa8c876045e721ffff22	hello.c
$ cat-file blob 8a6a2a7261742c6f69adaa8c876045e721ffff22
#include <stdio.h>

main()
{
	printf("Hello, world!\n");
	return 0;
}
$ 


$ # Now an example of getting started with a pre-existing project
$ # download www.kernel.org/pub/linux/kernel/people/torvalds/sparse.git
$ # then ...
$ ls -l sparse.git
total 8
-rw-rw-r--    1 aegl aegl   41 Apr 14 14:50 HEAD
drwxr-xr-x  258 aegl aegl 4096 Apr 12 21:33 objects
$ # set up environment so that git sees these objects when we are elsewhere
$ export SHA1_FILE_DIRECTORY=`pwd`/sparse.git/objects
$ # make a directory to work in
$ mkdir sparse
$ cd sparse
$ # Still need a local .git for the cache file
$ mkdir .git
$ # Now look at the most recent commit, to find the topmost tree
$ cat-file commit `cat ../sparse.git/HEAD`
tree 67607f05a66e36b2f038c77cfb61350d2110f7e8
parent 9c59995fef9b52386e5f7242f44720a7aca287d7
author Christopher Li <sparse@chrisli.org> Sat Apr  2 09:30:09 PST 2005
committer Linus Torvalds <torvalds@ppc970.osdl.org> Thu Apr  7 20:06:31 2005

[PATCH] static declear

This patch add static declare to make sparse happy of checking itself.
$ # load up that tree into our cache (.git/index)
$ read-tree 67607f05a66e36b2f038c77cfb61350d2110f7e8
$ # and checkout all the files
$ checkout-cache -a
$ # quick as a flash, our directory is full of files
$ ls
allocate.c       compat-linux.c    example.c     inline.c     memops.c       scope.c       symbol.h          tokenize.c
allocate.h       compat-mingw.c    expand.c      lib.c        obfuscate.c    scope.h       target.c          validation
bitmap.h         compat-solaris.c  expression.c  lib.h        parse.c        show-parse.c  target.h
cgcc             compile.c         expression.h  LICENSE      parse.h        simplify.c    test-lexing.c
check.c          compile.h         FAQ           linearize.c  pre-process.c  sort.c        test-linearize.c
compat           compile-i386.c    flow.c        linearize.h  ptrlist.c      storage.c     test-parsing.c
compat-cygwin.c  cse.c             flow.h        liveness.c   ptrlist.h      storage.h     test-sort.c
compat.h         evaluate.c        ident-list.h  Makefile     README         symbol.c      token.h
$ 
