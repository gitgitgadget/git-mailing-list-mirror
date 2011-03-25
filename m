From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] HOME must be set before calling git-init when creating
	test repositories
Date: Fri, 25 Mar 2011 21:05:28 +0100
Message-ID: <20110325200528.GA7302@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 21:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3DOa-0003ue-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 21:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab1CYUOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 16:14:03 -0400
Received: from mout4.freenet.de ([195.4.92.94]:53036 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab1CYUOB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 16:14:01 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Mar 2011 16:14:01 EDT
Received: from [195.4.92.28] (helo=18.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q3DGF-0006Wj-4j; Fri, 25 Mar 2011 21:05:31 +0100
Received: from krlh-5f7279b2.pool.mediaways.net ([95.114.121.178]:52999 helo=tigra.home)
	by 18.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q3DGF-00027m-1f; Fri, 25 Mar 2011 21:05:31 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id B10269FD05;
	Fri, 25 Mar 2011 21:05:28 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 6C00D36D28; Fri, 25 Mar 2011 21:05:28 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170015>

Otherwise the created test repositories will be affected by users ~/.gitconfig.
For example, setting core.logAllrefupdates in users config will make all
calls to "git config --unset core.logAllrefupdates" fail which will break
the first test which uses the statement and expects it to succeed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

The first test which fails is t2017, btw.
I still wonder if this should be moved even further up.

 t/test-lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..4f394c3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,14 +984,14 @@ rm -fr "$test" || {
 	exit 1
 }
 
+HOME=$(pwd)
+export HOME
+
 test_create_repo "$test"
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
 
-HOME=$(pwd)
-export HOME
-
 this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
-- 
1.7.4.1.271.g4540f
