From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/3] ensure that relative submodule url needs ./ or ../
Date: Tue, 13 Nov 2012 09:35:10 +0100
Message-ID: <20121113083510.GC38188@book.hvoigt.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com> <20121108185643.GN15560@sigill.intra.peff.net> <20121109184225.GA1190@book.hvoigt.net> <20121113083233.GA38188@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Issues <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYBxx-00055G-6T
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 09:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab2KMIfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 03:35:13 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:48570 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab2KMIfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 03:35:12 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TYBxf-0005pR-Gt; Tue, 13 Nov 2012 09:35:11 +0100
Content-Disposition: inline
In-Reply-To: <20121113083233.GA38188@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209588>

Even though a relative path can be without them the
documentation explicitely talks about them. Lets ensure
that behavior with a test.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 t/t7400-submodule-basic.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5397037..3c2afa6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -506,6 +506,18 @@ test_expect_success 'set up for relative path tests' '
 	)
 '
 
+test_expect_success 'subrepo is NOT considered a relative path"' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config -f .gitmodules submodule.sub.url "subrepo" &&
+		git config remote.origin.url "$submodurl" &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = subrepo
+	)
+'
+
 test_expect_success '../subrepo works with URL - ssh://hostname/repo' '
 	(
 		cd reltest &&
-- 
1.8.0.3.gaed4666
