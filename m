From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] git-stash: use git-read-tree --index-output option
Date: Mon, 31 Mar 2008 06:14:38 +0900
Message-ID: <200803302115.m2ULFGLP021077@mi0.bluebottle.com>
References: <20080315014133.GB32265@neumann> <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org> <7v1w6cpox6.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803150934100.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 23:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg4sk-0008JN-G7
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 23:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbYC3VPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754584AbYC3VPT
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 17:15:19 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:49230 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbYC3VPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 17:15:17 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2ULFGLP021077
	for <git@vger.kernel.org>; Sun, 30 Mar 2008 14:15:16 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=1y1qLQs7ZJo1bu3RnAvQ2OQiZaoOpZ6TX+Q5GHTN6882LzCJx/ZaHMl4FewAhOQBi
	p3uHWTocws1D5UXHvbZEAs/cJ/zp4XZGJw8/q6ondSMigpEuEbQCHSfhqWzjCPh
Received: from nanako3.mail.bluebottle.com ([212.62.97.20])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m2ULF93K028275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Mar 2008 14:15:14 -0700
In-reply-to: <alpine.LFD.1.00.0803150934100.3557@woody.linux-foundation.org>
X-Trusted-Delivery: <d0e0165cad26831c679036b0d12c4cf9>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78515>

Instead of copying the original index with "cp -p" to preserve timestamp, use "--index-output" option of git-read-tree program.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---

 git-stash.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c2b6820..ca49c5e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -63,10 +63,9 @@ create_stash () {
 	# state of the working tree
 	w_tree=$( (
 		rm -f "$TMP-index" &&
-		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
+		git read-tree --index-output="$TMP-index" -m $i_tree &&
 		GIT_INDEX_FILE="$TMP-index" &&
 		export GIT_INDEX_FILE &&
-		git read-tree -m $i_tree &&
 		git add -u &&
 		git write-tree &&
 		rm -f "$TMP-index"

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
