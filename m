From: Hans Ginzel <hans@matfyz.cz>
Subject: git rm --recursive
Date: Wed, 18 Nov 2015 16:06:38 +0100
Message-ID: <20151118150637.GA49061@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 16:15:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz4SU-0001BH-TI
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 16:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbbKRPPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 10:15:38 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:41008 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbbKRPPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 10:15:37 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2015 10:15:37 EST
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 1975)
	id CF8F0468003; Wed, 18 Nov 2015 16:06:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281450>

Hello!

I have added the --recursive alias for the -r option to the rm command.

H.
From 83f197151c04164b0dfd4d127e72439aebaf8b71 Mon Sep 17 00:00:00 2001
From: Hans Ginzel <hans@matfyz.cz>
Date: Wed, 18 Nov 2015 15:44:56 +0100
Subject: [PATCH] builtin: rm: add --recursive to be consistent with GNU rm


diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index f1efc11..0ab1cd4 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -47,6 +47,7 @@ OPTIONS
 	by the command.
 
 -r::
+--recursive::
         Allow recursive removal when a leading directory name is
         given.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index 80b972f..311b4da 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -269,7 +269,7 @@ static struct option builtin_rm_options[] = {
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
-	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
+	OPT_BOOL('r', "recursive",      &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
 	OPT_END(),
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9d90d2c..d7b73f9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -207,12 +207,25 @@ test_expect_success 'Recursive with -r but dirty' '
 	test -f frotz/nitfol
 '
 
+test_expect_success 'Recursive with --recursive but dirty' '
+	echo qfwfq >>frotz/nitfol &&
+	test_must_fail git rm --recursive frotz &&
+	test -d frotz &&
+	test -f frotz/nitfol
+'
+
 test_expect_success 'Recursive with -r -f' '
 	git rm -f -r frotz &&
 	! test -f frotz/nitfol &&
 	! test -d frotz
 '
 
+test_expect_success 'Recursive with --recursive -f' '
+	git rm -f --recursive frotz &&
+	! test -f frotz/nitfol &&
+	! test -d frotz
+'
+
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 	test_must_fail git rm nonexistent
 '
-- 
1.9.1
