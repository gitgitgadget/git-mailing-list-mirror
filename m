From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 16:45:10 +0000
Message-ID: <528CE716.8060307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Nov 20 17:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjAu9-0004EH-BY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 17:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab3KTQpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 11:45:24 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:41169 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754600Ab3KTQpV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 11:45:21 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 45449128081;
	Wed, 20 Nov 2013 16:45:19 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id DA0641280AF;
	Wed, 20 Nov 2013 16:45:16 +0000 (GMT)
Received: from [192.168.254.8] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Wed, 20 Nov 2013 16:45:15 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238082>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jens,

commit 61b6a633 ("commit -v: strip diffs and submodule shortlogs
from the commit message", 19-11-2013) in 'pu' fails the new test
it added to t7507.

I didn't spend too long looking at the problem, so take this patch
as nothing more than a quick suggestion for a possible solution! :-P
[The err file contained something like: "There was a problem with the
editor '"$FAKE_EDITOR"'"].

Having said that, this fixes it for me ...

ATB,
Ramsay Jones

 t/t7507-commit-verbose.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 09c1150..49cfb3c 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -79,7 +79,8 @@ test_expect_success 'submodule log is stripped out too with -v' '
 		echo "more" >>file &&
 		git commit -a -m "submodule commit"
 	) &&
-	GIT_EDITOR=cat test_must_fail git commit -a -v 2>err &&
+	test_set_editor cat &&
+	test_must_fail git commit -a -v 2>err &&
 	test_i18ngrep "Aborting commit due to empty commit message." err
 '
 
-- 
1.8.4
