From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH, fixed] HOME must be set before calling git-init when
	creating test repositories
Date: Fri, 25 Mar 2011 21:44:54 +0100
Message-ID: <20110325204454.GA14031@blimp.localdomain>
References: <20110325200528.GA7302@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 21:45:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Dt0-0004lp-3y
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 21:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab1CYUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 16:45:08 -0400
Received: from mout8.freenet.de ([195.4.92.98]:46117 "EHLO mout8.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067Ab1CYUpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 16:45:07 -0400
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout8.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.72 #3)
	id 1Q3DsU-0005Sh-RA; Fri, 25 Mar 2011 21:45:02 +0100
Received: from krlh-5f7279b2.pool.mediaways.net ([95.114.121.178]:32953 helo=tigra.home)
	by 1.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.72 #3)
	id 1Q3DsU-0001SE-Ky; Fri, 25 Mar 2011 21:45:02 +0100
Received: from blimp.localdomain (unknown [192.168.0.94])
	by tigra.home (Postfix) with ESMTP id 2247C9FC7E;
	Fri, 25 Mar 2011 21:44:55 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id DF87736D28; Fri, 25 Mar 2011 21:44:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110325200528.GA7302@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170016>

Otherwise the created test repositories will be affected by users ~/.gitconfig.
For example, setting core.logAllrefupdates in users config will make all
calls to "git config --unset core.logAllrefupdates" fail which will break
the first test which uses the statement and expects it to succeed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Aah... Sorry. Missed the test's part of the new HOME.

 t/test-lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..8792e4a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -984,14 +984,14 @@ rm -fr "$test" || {
 	exit 1
 }
 
+HOME=$(pwd)/"$test"
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
