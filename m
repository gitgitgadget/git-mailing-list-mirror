From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] t9300: use test_cmp_bin instead of test_cmp to compare
 binary files
Date: Fri, 12 Sep 2014 21:47:34 +0200
Message-ID: <54134DD6.1040509@kdbg.org>
References: <54132E88.8050803@kdbg.org> <xmqq1trgbu0p.fsf@gitster.dls.corp.google.com> <54133812.2050002@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:47:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWor-00018p-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbaILTrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:47:41 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27814 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaILTrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:47:40 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3hvnYd2bQtz5tlG;
	Fri, 12 Sep 2014 21:47:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1688B19F364;
	Fri, 12 Sep 2014 21:47:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <54133812.2050002@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256947>

test_cmp is intended to produce diff output for human consumption. The
input in one instance in t9300-fast-import.sh are binary files, however.
Use test_cmp_bin to compare the files.

This was noticed because on Windows we have a special implementation of
test_cmp in pure bash code (to ignore differences due to intermittent CR
in actual output), and bash runs into an infinite loop due to the binary
nature of the input.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 12.09.2014 um 20:14 schrieb Thomas Braun:
> May I suggest to use test_cmp_bin instead of plain cmp?

Of course! I did remember that there was talk about it, but missed
that we actually implemented it. Sorry.

 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 99f5161..72845f6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2687,7 +2687,7 @@ test_expect_success 'R: verify created pack' '
 test_expect_success \
 	'R: verify written objects' \
 	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	 test_cmp expect actual &&
+	 test_cmp_bin expect actual &&
 	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
 	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
 	 test $a = $b'
-- 
2.0.0.12.gbcf935e
