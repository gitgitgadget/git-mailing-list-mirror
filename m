From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/20] t5505: use "for-each-ref" to test for the non-existence of references
Date: Thu, 25 Feb 2016 14:16:15 +0100
Message-ID: <6f79ef9e9ac452019567f150553fe8635bf22bc3.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmy-0003rh-0W
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760579AbcBYNQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:59 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62871 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760498AbcBYNQ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:58 -0500
X-AuditID: 1207440c-98bff700000008b4-8c-56cefec968e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 68.3F.02228.9CEFEC65; Thu, 25 Feb 2016 08:16:57 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPru024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:55 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHvy37kwg537BS3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxbF64yFcxlr7g4p6CBsYWti5GTQ0LARGLW2/tM
	XYxcHEICWxklmpv+QTknmCRObTnAAlLFJqArsainmQnEFhFQk5jYdogFpIhZ4BGjRNf+7Ywg
	CWGBeImHZ++DjWURUJU42PmeHcTmFYiSeHLtAyvEOjmJlh+7wWxOAQuJiyenM4PYQgLmEqtu
	7GGfwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZIiPHsYPy2TuYQ
	owAHoxIPL8PPs2FCrIllxZW5hxglOZiURHn3PD8XJsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d8VfoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYJ3E0ijYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgG4ouBUQCS4gHaG/MPZG9xQWIuUBSi9RSjLseC
	H7fXMgmx5OXnpUqJ8y4H2SEAUpRRmge3ApZQXjGKA30szLsOpIoHmIzgJr0CWsIEtGTmBrAl
	JYkIKakGRmvD565b1E3rNyqf/VSatJxjks1mUcF3H2c6acmdnLB267tt8xMOdW7ybdGKP6Db
	vFSXUYEjnOVu+OxNHjZsVS9t/7yRnDQh7LFz3GuDwE28ac31qRbG5hWfuh23nb9W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287374>

Instead of looking on the filesystem inside ".git/refs/remotes/origin",
use "git for-each-ref" to check for leftover references under the
remote's old name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5505-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1a8e3b8..d2ac346 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -687,7 +687,7 @@ test_expect_success 'rename a remote' '
 	(
 		cd four &&
 		git remote rename origin upstream &&
-		rmdir .git/refs/remotes/origin &&
+		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-- 
2.7.0
