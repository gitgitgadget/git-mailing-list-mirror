From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 1/5] git-svn: add test data for SVK merge, with script.
Date: Tue, 20 Oct 2009 15:41:59 +1300
Message-ID: <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04gY-0007qy-43
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227AbZJTCmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757650AbZJTCmo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:42:44 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42677 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511AbZJTCmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:42:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 0B2083237F;
	Tue, 20 Oct 2009 15:42:47 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYQvhD7W+GmZ; Tue, 20 Oct 2009 15:42:46 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 79F7B3225A;
	Tue, 20 Oct 2009 15:42:46 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130749>

Dump generated with SVK 2.0.2 and SVN 1.5.1 (on lenny amd64).

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 t/t9150/make-svk-dump  |   57 +++++
 t/t9150/svk-merge.dump |  616 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 673 insertions(+), 0 deletions(-)
 create mode 100644 t/t9150/make-svk-dump
 create mode 100644 t/t9150/svk-merge.dump

diff --git a/t/t9150/make-svk-dump b/t/t9150/make-svk-dump
new file mode 100644
index 0000000..2242f14
--- /dev/null
+++ b/t/t9150/make-svk-dump
@@ -0,0 +1,57 @@
+#!/bin/sh
+#
+# this script sets up a Subversion repository for Makefile in the
+# first ever git merge, as if it were done with svk.
+#
+
+set -e
+
+svk depotmap foo ~/.svk/foo
+svk co /foo/ foo
+cd foo
+mkdir trunk
+mkdir branches
+svk add trunk branches
+svk commit -m "Setup trunk and branches"
+cd trunk
+
+git cat-file blob 6683463e:Makefile > Makefile
+svk add Makefile 
+
+svk commit -m "ancestor"
+cd ..
+svk cp trunk branches/left
+
+svk commit -m "make left branch"
+cd branches/left/
+
+git cat-file blob 5873b67e:Makefile > Makefile
+svk commit -m "left update 1"
+
+cd ../../trunk
+git cat-file blob 75118b13:Makefile > Makefile
+svk commit -m "trunk update"
+
+cd ../branches/left
+git cat-file blob b5039db6:Makefile > Makefile
+svk commit -m "left update 2"
+
+cd ../../trunk
+svk sm /foo/branches/left
+# in theory we could delete the "left" branch here, but it's not
+# required so don't do it, in case people start getting ideas ;)
+svk commit -m "merge branch 'left' into 'trunk'"
+
+git cat-file blob b51ad431:Makefile > Makefile
+
+svk diff Makefile && echo "Hey!  No differences, magic"
+
+cd ../..
+
+svnadmin dump ~/.svk/foo > svk-merge.dump
+
+svk co -d foo
+rm -rf foo
+svk depotmap -d /foo/
+rm -rf ~/.svk/foo
+
diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
new file mode 100644
index 0000000..42f70db
--- /dev/null
+++ b/t/t9150/svk-merge.dump
@@ -0,0 +1,616 @@
+SVN-fs-dump-format-version: 2
+
+UUID: b48289b2-9c08-4d72-af37-0358a40b9c15
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2009-10-19T23:44:03.722969Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 123
+Content-length: 123
+
+K 7
+svn:log
+V 24
+Setup trunk and branches
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:04.927533Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Revision-number: 2
+Prop-content-length: 106
+Content-length: 106
+
+K 7
+svn:log
+V 8
+ancestor
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:05.835585Z
+PROPS-END
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 2401
+Text-content-md5: bfd8ff778d1492dc6758567373176a89
+Content-length: 2411
+
+PROPS-END
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+Revision-number: 3
+Prop-content-length: 115
+Content-length: 115
+
+K 7
+svn:log
+V 16
+make left branch
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:06.719737Z
+PROPS-END
+
+Node-path: branches/left
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 2
+Node-copyfrom-path: trunk
+
+
+Revision-number: 4
+Prop-content-length: 112
+Content-length: 112
+
+K 7
+svn:log
+V 13
+left update 1
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:07.167666Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2465
+Text-content-md5: 16e38d9753b061731650561ce01b1195
+Content-length: 2465
+
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+Revision-number: 5
+Prop-content-length: 111
+Content-length: 111
+
+K 7
+svn:log
+V 12
+trunk update
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:07.619633Z
+PROPS-END
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2521
+Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
+Content-length: 2521
+
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base merge-cache
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+Revision-number: 6
+Prop-content-length: 112
+Content-length: 112
+
+K 7
+svn:log
+V 13
+left update 2
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:08.067554Z
+PROPS-END
+
+Node-path: branches/left/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2593
+Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
+Content-length: 2593
+
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
+Revision-number: 7
+Prop-content-length: 131
+Content-length: 131
+
+K 7
+svn:log
+V 32
+merge branch 'left' into 'trunk'
+K 10
+svn:author
+V 4
+samv
+K 8
+svn:date
+V 27
+2009-10-19T23:44:08.971801Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: change
+Prop-content-length: 83
+Content-length: 83
+
+K 9
+svk:merge
+V 53
+b48289b2-9c08-4d72-af37-0358a40b9c15:/branches/left:6
+PROPS-END
+
+
+Node-path: trunk/Makefile
+Node-kind: file
+Node-action: change
+Text-content-length: 2713
+Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
+Content-length: 2713
+
+# -DCOLLISION_CHECK if you believe that SHA1's
+# 1461501637330902918203684832716283019655932542976 hashes do not give you
+# enough guarantees about no collisions between objects ever hapenning.
+#
+# -DNSEC if you want git to care about sub-second file mtimes and ctimes.
+# Note that you need some new glibc (at least >2.2.4) for this, and it will
+# BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely randomly
+# break unless your underlying filesystem supports those sub-second times
+# (my ext3 doesn't).
+CFLAGS=-g -O3 -Wall
+
+CC=gcc
+
+
+PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
+	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
+	check-files ls-tree merge-base merge-cache
+
+all: $(PROG)
+
+install: $(PROG)
+	install $(PROG) $(HOME)/bin/
+
+LIBS= -lssl -lz
+
+init-db: init-db.o
+
+update-cache: update-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o update-cache update-cache.o read-cache.o $(LIBS)
+
+show-diff: show-diff.o read-cache.o
+	$(CC) $(CFLAGS) -o show-diff show-diff.o read-cache.o $(LIBS)
+
+write-tree: write-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o write-tree write-tree.o read-cache.o $(LIBS)
+
+read-tree: read-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o read-tree read-tree.o read-cache.o $(LIBS)
+
+commit-tree: commit-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o commit-tree commit-tree.o read-cache.o $(LIBS)
+
+cat-file: cat-file.o read-cache.o
+	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
+
+fsck-cache: fsck-cache.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+checkout-cache: checkout-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
+
+diff-tree: diff-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
+
+rev-tree: rev-tree.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+show-files: show-files.o read-cache.o
+	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
+
+check-files: check-files.o read-cache.o
+	$(CC) $(CFLAGS) -o check-files check-files.o read-cache.o $(LIBS)
+
+ls-tree: ls-tree.o read-cache.o
+	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
+
+merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
+
+merge-cache: merge-cache.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-cache merge-cache.o read-cache.o $(LIBS)
+
+read-cache.o: cache.h
+show-diff.o: cache.h
+
+clean:
+	rm -f *.o $(PROG)
+
+backup: clean
+	cd .. ; tar czvf dircache.tar.gz dir-cache
+
+
-- 
1.6.3.3
