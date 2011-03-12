From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/2] git-p4: test clone @all
Date: Sat, 12 Mar 2011 11:24:49 -0500
Message-ID: <20110312162449.GC8509@arf.padd.com>
References: <20110312162246.GA8509@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 17:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyRcg-0006iu-Kx
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 17:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab1CLQYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 11:24:53 -0500
Received: from honk.padd.com ([74.3.171.149]:44218 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031Ab1CLQYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 11:24:53 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 1BDDE20B3;
	Sat, 12 Mar 2011 08:24:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B3DE43207D; Sat, 12 Mar 2011 11:24:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110312162246.GA8509@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168948>

Cloning a p4 depot by default generates a single commit.  The use
of the "@all" revision specifier instead tells git-p4 to import
all commits.  Check to make sure both these invocations work as
expected.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 1969e6b..abe7c64 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -37,11 +37,27 @@ test_expect_success 'add p4 files' '
 	echo file1 >file1 &&
 	p4 add file1 &&
 	p4 submit -d "file1" &&
+	echo file2 >file2 &&
+	p4 add file2 &&
+	p4 submit -d "file2" &&
 	cd "$TRASH_DIRECTORY"
 '
 
 test_expect_success 'basic git-p4 clone' '
 	"$GITP4" clone --dest="$git" //depot &&
+	cd "$git" &&
+	git log --oneline >lines &&
+	test_line_count = 1 lines &&
+	cd .. &&
+	rm -rf "$git" && mkdir "$git"
+'
+
+test_expect_success 'git-p4 clone @all' '
+	"$GITP4" clone --dest="$git" //depot@all &&
+	cd "$git" &&
+	git log --oneline >lines &&
+	test_line_count = 2 lines &&
+	cd .. &&
 	rm -rf "$git" && mkdir "$git"
 '
 
-- 
1.7.4.1
