From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] t3503: test cherry picking and reverting root commits
Date: Thu, 12 May 2011 14:20:23 +0200
Message-ID: <4DCBD087.90302@viscovery.net>
References: <20110512110855.GA5240@sigill.intra.peff.net> <20110512111007.GC5292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 14:21:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKUt5-0003kr-VT
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 14:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756995Ab1ELMU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 08:20:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35201 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756944Ab1ELMU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 08:20:58 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QKUsR-00050b-Ol; Thu, 12 May 2011 14:20:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 77B311660F;
	Thu, 12 May 2011 14:20:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110512111007.GC5292@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173466>

Am 5/12/2011 13:10, schrieb Jeff King:
> +test_expect_success 'cherry-pick a root commit with an external strategy' '
> +
> +	git cherry-pick --strategy=resolve master &&
> +	test first = $(cat file1)

What if file1 does not exist? Then cat fails loudly. But this does not
fail the entire command immediately; rather, the test command fails, but
not because of a non-equality, but because of an invalid usage ("syntax
error"). IOW, the test does the right thing, but for the wrong reason.

Yes, an earlier test gave a bad precedent, and the following fixup (to
be squashed in) fixes it, too.

-- Hannes


diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 1f9ed67..3006452 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git cherry-pick master &&
-	test first = $(cat file1)
+	test first = "$(cat file1)"
 
 '
 
@@ -37,7 +37,7 @@ test_expect_success 'revert a root commit' '
 test_expect_success 'cherry-pick a root commit with an external strategy' '
 
 	git cherry-pick --strategy=resolve master &&
-	test first = $(cat file1)
+	test first = "$(cat file1)"
 
 '
 
