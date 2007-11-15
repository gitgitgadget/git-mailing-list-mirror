From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH v2] Fix git-tag test breakage caused by broken sed on Leopard
Date: Thu, 15 Nov 2007 16:47:11 +0100
Message-ID: <C9DFAD77-DFEF-47AC-83D5-CFDF245D95E4@wincent.com>
References: <17E3F66C-4644-4B64-817C-88062727A2D9@wincent.com> <Pine.LNX.4.64.0711151434060.30886@racer.site> <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 16:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsgxB-0004ZM-C3
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 16:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXKOPsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbXKOPsM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 10:48:12 -0500
Received: from wincent.com ([72.3.236.74]:39837 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbXKOPsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 10:48:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFFlCqU023105
	for <git@vger.kernel.org>; Thu, 15 Nov 2007 09:48:10 -0600
In-Reply-To: <90D416F6-A3CA-43C8-B71F-38EA955A762B@wincent.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65129>

The 'message in editor has initial comment' test fails on Leopard (and
possibly on other versions of Mac OS X as well) due to the limited
sed syntax available on that platform.

Avoid the breakage by using grep instead (suggested by Johannes
Schindelin).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

The patch I previously sent had the test sense inverted (it used 'test  
-z' to test for an empty string when we should have actually been  
looking for a non-empty string), so it really only passed by mistake.  
This revised version maintains the sense of the original, sed-based  
test.

t/t7004-tag.sh |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 096fe33..b54c2e0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1007,7 +1007,7 @@ test_expect_failure \
test_expect_success \
	'message in editor has initial comment' '
	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
-	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
+	test $(grep -e "^#" -e "^\$" actual | wc -l ) -gt 0
'

get_tag_header reuse $commit commit $time >expect
-- 
1.5.3.5
