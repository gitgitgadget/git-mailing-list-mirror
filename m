From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pull: use $curr_branch_short more
Date: Sun, 08 Sep 2013 17:21:44 +0200
Message-ID: <522C9608.8010304@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com> <5221A510.2020206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 17:22:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgoI-0004Vp-FH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab3IHPVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 11:21:55 -0400
Received: from mout.web.de ([212.227.17.12]:59512 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab3IHPVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:21:54 -0400
Received: from [192.168.2.102] ([79.253.173.109]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MHowb-1VFfbg0An7-003i4u for <git@vger.kernel.org>;
 Sun, 08 Sep 2013 17:21:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <5221A510.2020206@web.de>
X-Provags-ID: V03:K0:/cyZFeIPRCYTu36RqKMLtqn0zY49bEu9nwM5a1dFSUgb2Vn/He7
 NRrgV+g1UyUFn+pwl0IZcLV1pta+xsKuWLYGun/rQU9vU4/rKGAoyTAOMJmVR7fIVnmTKxc
 +d3O9JNqhP1+rVlq4+pSzqSLJDouz+JNwiwz080X6t9CTWoAE03MDGF3sulW2Um61/lLiKz
 VIYUOK8JLzgBG9hsydJEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234252>

One of the first things git-pull.sh does is setting $curr_branch to
the target of HEAD and $curr_branch_short to the same but with the
leading "refs/heads/" removed.  Simplify the code by using
$curr_branch_short instead of setting $curr_branch to the same
shortened value.

The only other use of $curr_branch in that function doesn't have to
be replaced with $curr_branch_short because it just checks if the
string is empty.  That property is the same with or without the prefix
unless HEAD points to "refs/heads/" alone, which is invalid.

Noticed-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Replacement patch.  Corrected the command in the summary and
changed the first part of the description slightly.

 git-pull.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..d8b2708 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -166,9 +166,8 @@ error_on_no_merge_candidates () {
 		op_prep=with
 	fi
 
-	curr_branch=${curr_branch#refs/heads/}
-	upstream=$(git config "branch.$curr_branch.merge")
-	remote=$(git config "branch.$curr_branch.remote")
+	upstream=$(git config "branch.$curr_branch_short.merge")
+	remote=$(git config "branch.$curr_branch_short.remote")
 
 	if [ $# -gt 1 ]; then
 		if [ "$rebase" = true ]; then
-- 1.8.4 
