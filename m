From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] filter-branch: only print usage information when no arguments
 supplied
Date: Wed, 30 Jan 2008 18:13:57 -0600
Message-ID: <47A112C5.8010903@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:14:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKN4x-00073D-Th
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792AbYAaAOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbYAaAOY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:14:24 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36735 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764109AbYAaAOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:14:23 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V0Dw1d012148;
	Wed, 30 Jan 2008 18:13:58 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 18:13:58 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47A109A7.1070502@nrlssc.navy.mil>
X-OriginalArrivalTime: 31 Jan 2008 00:13:58.0352 (UTC) FILETIME=[2C8D9D00:01C8639E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--9.787400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzQ1MS03MTA5?=
	=?us-ascii?B?ODktNzA1MTAyLTEyMTUzNi03MDA4MTUtNzAzNzg4LTcwMDQ3Ni03?=
	=?us-ascii?B?MDE2MTgtMTM2MDcwLTcwMDc1OS03MDUzODgtNzAyMTEzLTcwMjAz?=
	=?us-ascii?B?Ny03MDA3NTYtNzAwMTYwLTcwNDAzNC0xODgwMTktNzAyMDM4LTcw?=
	=?us-ascii?B?MDk3MC03MDkwNTAtNzAzNzEyLTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72078>

Testing for whether command line arguments were supplied was being
performed during option parsing. This had the side effect of
printing usage information when a more appropriate error message
would have been printed had the script been allowed to continue.

Now this:

	git filter-branch

will print usage information.

And these:

	git filter-branch -d /tmp/work-dir
	git filter-branch <non-existant-revision>
	git filter-branch --
	git filter-branch -- <non-existant-revision>

will print a message informing the user that filter-branch did
not know which reference to rewrite. Without this patch the
one with '-d' would also print usage information.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I prefer my original patch since I think it is consistent
with the git interface.

-brandon


 git-filter-branch.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ebf05ca..5e3fe70 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -97,6 +97,8 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 OPTIONS_SPEC=
 . git-sh-setup
 
+test $# = 0 && usage
+
 git diff-files --quiet &&
 	git diff-index --cached --quiet HEAD -- ||
 	die "Cannot rewrite branch(es) with a dirty working directory."
@@ -114,7 +116,6 @@ orig_namespace=refs/original/
 force=
 while :
 do
-	test $# = 0 && usage
 	case "$1" in
 	--)
 		shift
-- 
1.5.4.rc5.14.gaa8fc
