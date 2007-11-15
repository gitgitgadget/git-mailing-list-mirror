From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fix git-tag test breakage caused by broken sed on Leopard
Date: Thu, 15 Nov 2007 16:16:52 +0100
Message-ID: <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 16:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsgSv-0007Lw-GW
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 16:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124AbXKOPQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 10:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757188AbXKOPQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 10:16:56 -0500
Received: from wincent.com ([72.3.236.74]:39753 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756953AbXKOPQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 10:16:56 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFFGrIh022359;
	Thu, 15 Nov 2007 09:16:53 -0600
In-Reply-To: <Pine.LNX.4.64.0711151434060.30886@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65128>

The 'message in editor has initial comment' test fails on Leopard (and
possibly on other versions of Mac OS X as well) due to the limited
sed syntax available on that platform.

Avoid the breakage by using grep instead (suggested by Johannes
Schindelin).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
  t/t7004-tag.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 096fe33..02ec9c3 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1007,7 +1007,7 @@ test_expect_failure \
  test_expect_success \
  	'message in editor has initial comment' '
  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
-	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
+	test -z "$(grep -e \"^#\" -e \"^$\" actual)"
  '

  get_tag_header reuse $commit commit $time >expect
-- 
1.5.3.5
