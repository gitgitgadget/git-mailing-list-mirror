From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 19:08:31 +0200
Message-ID: <20070920170831.GQ16235@genesis.frugalware.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYPzZ-0006tt-O8
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 19:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759605AbXITRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759583AbXITRi6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 13:38:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34931 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759350AbXITRi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 13:38:56 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IYPyi-0006WU-Ne
	from <vmiklos@frugalware.org>; Thu, 20 Sep 2007 19:38:33 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E68171A68019; Thu, 20 Sep 2007 19:08:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201133590.28395@racer.site>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4571]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58791>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Sep 20, 2007 at 11:34:25AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 19 Sep 2007, Junio C Hamano wrote:
> > Looks Ok to me, although I didn't verify the examples by
> > actually running them myself this time (last round I did).
>
> So maybe we should do the same as with the tutorial: stick the examples
> into a test script?

what about this?

 t/t3060-subprojects-tutorial.sh |   62 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 t/t3060-subprojects-tutorial.sh

diff --git a/t/t3060-subprojects-tutorial.sh b/t/t3060-subprojects-tutorial.sh
new file mode 100755
index 0000000..2fcf4ab
--- /dev/null
+++ b/t/t3060-subprojects-tutorial.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Miklos Vajna
+#
+
+test_description='A simple subprojects tutorial in the form of a test case'
+
+. ./test-lib.sh
+
+test_expect_success "create the submodules" '
+	for i in a b c d
+	do
+		mkdir $i &&
+		cd $i &&
+		git init &&
+		echo "module $i" > $i.txt &&
+		git add $i.txt &&
+		git commit -m "Initial commit, submodule $i" &&
+		cd ..
+	done
+'
+
+test_expect_success "create the superproject" '
+	mkdir super &&
+	cd super &&
+	git init &&
+	for i in a b c d
+	do
+		git submodule add '`pwd`'/$i
+	done
+'
+
+test_expect_success "commit in the superproject" '
+	git commit -m "Add submodules a, b, c and d." &&
+	cd ..
+'
+
+test_expect_success "clone the superproject" '
+	git clone super cloned &&
+	cd cloned
+'
+
+test_expect_success "submodule init" '
+	git submodule init
+'
+
+test_expect_success "submodule update" '
+	git submodule update
+'
+
+test_expect_success "update the submodule from within the superproject" '
+	cd a &&
+	echo "adding a line again" >> a.txt &&
+	git commit -a -m "Updated the submodule from within the superproject." &&
+	git push &&
+	cd .. &&
+	git add a &&
+	git commit -m "Updated submodule a." &&
+	git push
+'
+
+test_done
-- 
1.5.3.2.80.g077d6f-dirty
