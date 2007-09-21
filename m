From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] new test from the submodule chapter of the user manual
Date: Fri, 21 Sep 2007 15:09:08 +0200
Message-ID: <20070921130908.GF16235@genesis.frugalware.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site> <20070920170831.GQ16235@genesis.frugalware.org> <7vd4wdkokn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYii2-0004H8-Vl
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbXIUNhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759769AbXIUNhj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:37:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:45986 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759730AbXIUNhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 09:37:37 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IYih9-00026O-Sw
	from <vmiklos@frugalware.org>; Fri, 21 Sep 2007 15:37:27 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 17F4B1A68015; Fri, 21 Sep 2007 15:09:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4wdkokn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_05,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0361]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58852>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

second version, now checking for all output, the commit hashes shows what is
committed is what we wanted to commit.

 t/t3060-subprojects-tutorial.sh |  151 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100755 t/t3060-subprojects-tutorial.sh

diff --git a/t/t3060-subprojects-tutorial.sh b/t/t3060-subprojects-tutorial.sh
new file mode 100755
index 0000000..fc09451
--- /dev/null
+++ b/t/t3060-subprojects-tutorial.sh
@@ -0,0 +1,151 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Miklos Vajna
+#
+
+test_description='A simple subprojects tutorial in the form of a test case'
+
+. ./test-lib.sh
+
+test_tick
+
+cat > create.expect << EOF
+Initialized empty Git repository in .git/
+Created initial commit 85349d2: Initial commit, submodule a
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 a.txt
+Initialized empty Git repository in .git/
+Created initial commit 47398d6: Initial commit, submodule b
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 b.txt
+Initialized empty Git repository in .git/
+Created initial commit 3d88526: Initial commit, submodule c
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 c.txt
+Initialized empty Git repository in .git/
+Created initial commit 73af3de: Initial commit, submodule d
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 d.txt
+EOF
+
+for i in a b c d
+do
+	mkdir $i &&
+	cd $i &&
+	git init &&
+	echo "module $i" > $i.txt &&
+	git add $i.txt &&
+	git commit -m "Initial commit, submodule $i" &&
+	cd ..
+done > create.output
+test_expect_success "create the submodules" 'cmp create.expect create.output'
+
+mkdir super
+cd super
+cat > create-super.expect << EOF
+Initialized empty Git repository in .git/
+Initialized empty Git repository in `pwd`/a/.git/
+0 blocks
+Initialized empty Git repository in `pwd`/b/.git/
+0 blocks
+Initialized empty Git repository in `pwd`/c/.git/
+0 blocks
+Initialized empty Git repository in `pwd`/d/.git/
+0 blocks
+EOF
+
+(git init &&
+for i in a b c d
+do
+	git submodule add `pwd`/../$i
+done ) &> create-super.output
+test_expect_success "create the superproject" 'cmp create-super.expect create-super.output'
+
+cat > commit-superproject.expect << EOF
+Created initial commit c496be9: Add submodules a, b, c and d.
+ 5 files changed, 16 insertions(+), 0 deletions(-)
+ create mode 100644 .gitmodules
+ create mode 160000 a
+ create mode 160000 b
+ create mode 160000 c
+ create mode 160000 d
+EOF
+git commit -m "Add submodules a, b, c and d." > commit-superproject.output
+
+test_expect_success "commit in the superproject" 'cmp commit-superproject.expect commit-superproject.output'
+
+cd ..
+
+cat > clone.expect << EOF
+Initialized empty Git repository in `pwd`/cloned/.git/
+0 blocks
+EOF
+
+git clone super cloned &> clone.output
+
+test_expect_success "clone the superproject" 'cmp clone.expect clone.output'
+
+cd cloned
+
+cat > submodule-init.expect << EOF
+Submodule 'a' (${PWD%%/cloned}/a/.git) registered for path 'a'
+Submodule 'b' (${PWD%%/cloned}/b/.git) registered for path 'b'
+Submodule 'c' (${PWD%%/cloned}/c/.git) registered for path 'c'
+Submodule 'd' (${PWD%%/cloned}/d/.git) registered for path 'd'
+EOF
+
+git submodule init > submodule-init.output
+
+test_expect_success "submodule init" 'cmp submodule-init.expect submodule-init.output'
+
+cat > submodule-update.expect << EOF
+Initialized empty Git repository in `pwd`/a/.git/
+0 blocks
+Submodule path 'a': checked out '85349d24595f581f5548b321a55c8a5fbe87259f'
+Initialized empty Git repository in `pwd`/b/.git/
+0 blocks
+Submodule path 'b': checked out '47398d6286153d23bfd5780ae3bf1996eb18cf90'
+Initialized empty Git repository in `pwd`/c/.git/
+0 blocks
+Submodule path 'c': checked out '3d88526ff6973dd27a07f57a3bb2bf5fa0bada42'
+Initialized empty Git repository in `pwd`/d/.git/
+0 blocks
+Submodule path 'd': checked out '73af3de6718291404ef541f4bb152f87d35a1481'
+EOF
+
+git submodule update &> submodule-update.output
+
+test_expect_success "submodule update" 'cmp submodule-update.expect submodule-update.output'
+
+cat > submodule-push.expect << EOF
+Created commit ab78b5a: Updated the submodule from within the superproject.
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+Everything up-to-date
+Created commit 8bbfffe: Updated submodule a.
+ 1 files changed, 1 insertions(+), 1 deletions(-)
+updating 'refs/heads/master'
+  from c496be9e726d5c6ee0f96668b1b5822cf6cad027
+  to   8bbfffe1651b896e371bf7a3506452d545cf81b3
+ Also local refs/remotes/origin/master
+Generating pack...
+Done counting 2 objects.
+Deltifying 2 objects...
+  50% (1/2) done
 100% (2/2) done

+Writing 2 objects...
+  50% (1/2) done
 100% (2/2) done

+Total 2 (delta 0), reused 0 (delta 0)
+refs/heads/master: c496be9e726d5c6ee0f96668b1b5822cf6cad027 -> 8bbfffe1651b896e371bf7a3506452d545cf81b3
+EOF
+
+( cd a &&
+echo "adding a line again" >> a.txt &&
+git commit -a -m "Updated the submodule from within the superproject." &&
+git push &&
+cd .. &&
+git add a &&
+git commit -m "Updated submodule a." &&
+git push) &> submodule-push.output
+
+test_expect_success "update the submodule from within the superproject" 'cmp submodule-push.expect submodule-push.output'
+
+test_done
-- 
1.5.3.2.80.g077d6f-dirty
