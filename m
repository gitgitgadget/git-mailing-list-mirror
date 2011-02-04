From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git pull: Remove option handling done by fetch
Date: Fri, 04 Feb 2011 21:17:00 +0100
Message-ID: <4D4C5EBC.2090100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 21:17:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlS5j-0007aF-0Y
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 21:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1BDURH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 15:17:07 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:60880 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1BDURG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 15:17:06 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id C8F311875AAED;
	Fri,  4 Feb 2011 21:17:04 +0100 (CET)
Received: from [93.240.99.67] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PlS5Y-0002EX-00; Fri, 04 Feb 2011 21:17:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/tkiHSAr+LTmxmAkslrn/IgqhbhExHL6Hg3nqR
	+UHg3oQeTwER4OK9Wr6xGzCLHOR3L4NZwc7znrn/m2OyDWtPZl
	385IF3R7mg0dniRU5yOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166057>

In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
"--[no-]recurse-submodules" had been added to git-pull.sh. This was not
necessary because all options to "git fetch" are passed to it and handled
there, so lets remove them.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I noticed this while implementing the on-demand recursive fetch.

 git-pull.sh |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index eb87f49..20a3bbe 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge

 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress= recurse_submodules=
+log_arg= verbosity= progress=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
@@ -105,12 +105,6 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
-	--recurse-submodules)
-		recurse_submodules=--recurse-submodules
-		;;
-	--no-recurse-submodules)
-		recurse_submodules=--no-recurse-submodules
-		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
@@ -223,7 +217,7 @@ test true = "$rebase" && {
 	done
 }
 orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0

 curr_head=$(git rev-parse -q --verify HEAD)
-- 
1.7.4.31.g5ae186
