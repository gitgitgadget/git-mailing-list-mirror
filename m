From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: [PATCH] git-submodule: Remove duplicate entries during merge with
 conflict
Date: Thu, 17 Mar 2011 09:09:14 +0100
Message-ID: <4D81C1AA.5010008@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 09:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q08Gz-0005y4-48
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 09:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab1CQIJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 04:09:27 -0400
Received: from 3.27.mail-out.ovh.net ([46.105.56.209]:41887 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751202Ab1CQIJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 04:09:25 -0400
Received: (qmail 25548 invoked by uid 503); 17 Mar 2011 09:03:05 -0000
Received: from b9.ovh.net (HELO mail193.ha.ovh.net) (213.186.33.59)
  by 27.mail-out.ovh.net with SMTP; 17 Mar 2011 09:02:57 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 17 Mar 2011 10:09:15 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 17 Mar 2011 10:09:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
X-Ovh-Tracer-Id: 13954966397355614174
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169224>

During a merge with conflict on a submodule, the submodule appears 3 times in git ls-files (stage 1,2,3) which causes the submodule to be used 3 times in git submodule update or status command.
This patch filters the results of git ls-files and only shows submodule in stage 0 or 1 thus removing the duplicates.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..5ef0f9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -72,7 +72,7 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 ' | awk '{ if (($3 == 0) || ($3 == 1)) print $0}'
 }
 
 #
