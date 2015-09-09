From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
Date: Wed, 9 Sep 2015 09:10:07 +0000
Message-ID: <0000014fb15e897e-4f1178b9-69d9-4015-808b-e073c134281c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 11:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbgG-0003Qo-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbbIIJ2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 05:28:32 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:45966
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626AbbIIJ2b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 05:28:31 -0400
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2015 05:28:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1441789807;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=YHlOps/yimGeU57K/jEngYOdfAl4PVpfzp40JBavDY0=;
	b=YwQ/xn+TkZrMcud/Mh1A4yrzitxbyD+n+qErgWEiHxWzm1nloI+iE+0z7yySQwxI
	oA9cmPSTx6KRjqAOmyBYrSP5MrK7T8sETePrGaKjvoq4QxFJICenay1y0Kg5l5sUHua
	llii3GPkiPzTrpDYZPliVtmFd0CPWPnkfVXCN/bw=
X-SES-Outgoing: 2015.09.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277542>

This is a backport of the corresponding patch to the builtin am in 2.6:
3ecc704 (am --skip/--abort: merge HEAD/ORIG_HEAD tree into index,
2015-08-19).

Reportedly, it can make a huge difference on Windows, in one case a `git
rebase --skip` took 1m40s without, and 5s with, this patch.

Reported-and-suggested-by: Kim Gybels <kim.gybels@engilico.com>
Original report: https://github.com/git-for-windows/git/issues/365
Acked-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/examples/git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/examples/git-am.sh b/contrib/examples/git-am.sh
index 3b77028..dd539f1 100755
--- a/contrib/examples/git-am.sh
+++ b/contrib/examples/git-am.sh
@@ -512,7 +512,7 @@ then
 		git read-tree --reset -u $head_tree $head_tree &&
 		index_tree=$(git write-tree) &&
 		git read-tree -m -u $index_tree $head_tree
-		git read-tree $head_tree
+		git read-tree -m $head_tree
 		;;
 	,t)
 		if test -f "$dotest/rebasing"

--
https://github.com/git/git/pull/173
