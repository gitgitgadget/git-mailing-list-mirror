From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 10:10:56 +0200
Message-ID: <5221A510.2020206@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 10:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFgH7-0004RO-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 10:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab3HaILK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 04:11:10 -0400
Received: from mout.web.de ([212.227.15.3]:60927 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab3HaILE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 04:11:04 -0400
Received: from [192.168.2.102] ([79.253.149.114]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Le4fk-1Vnd3C0mb6-00prYX for <git@vger.kernel.org>;
 Sat, 31 Aug 2013 10:11:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:yn7e+HM481okvBC1jhoDpi7s0DZHDwPdDiPEtenwt/gMzEvs52Z
 CPGh7joBCEYqxVqsV6EnlWWaOSVb2N19aLW2y2WcN5yDBAgLHnoccvAR5A9NLrBdUJi0Eu8
 +JJGsahkwpesxSCXteok5ZKB1OxZnXDlzCGOzTGbn4s93OTH3GarKqvRM84WWCrn8LoFVxH
 N0QwUPALVxW1k1I2e1gvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233510>

One of the first things git-pull.sh does is setting $curr_branch to
the target of HEAD and $curr_branch_short to the same but with the
leading "refs/heads/" removed.  Use $curr_branch_short in the function
error_on_no_merge_candidates instead of removing the prefix from
$curr_branch directly.

The only other use of $curr_branch in that function doesn't have to
be replaced with $curr_branch_short because it just checks if the
string is empty.  That property is the same with or without the prefix
unless HEAD points to "refs/heads/" alone, which is invalid.

Noticed-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
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
-- 
1.8.4
