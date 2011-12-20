From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t0090: be prepared that 'wc -l' writes leading blanks
Date: Tue, 20 Dec 2011 09:24:21 +0100
Message-ID: <4EF04635.6020406@viscovery.net>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com> <4EE8C3AD.9050605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 09:24:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcv0K-000228-MC
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 09:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1LTIYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 03:24:39 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53238 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752438Ab1LTIY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 03:24:27 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Rcuzm-0000PX-JL; Tue, 20 Dec 2011 09:24:23 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3DBF11660F;
	Tue, 20 Dec 2011 09:24:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EE8C3AD.9050605@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187501>

From: Johannes Sixt <j6t@kdbg.org>

Use 'printf %d $(whatever|wc -l)' so that the shell removes the blanks
for us.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 12/14/2011 16:41, schrieb Johannes Sixt:
> I'd solve it by moving the command substitution outside the quoted string:
> 
>  	printf "SHA (%d entries, 0 subtrees)\n" \
> 		$(git ls-files | wc -l) >expect &&
> 
> Other proposed solutions add another process. I don't like that on Windows ;)

And here is a proper patch to that effect.

-- Hannes

 t/t0090-cache-tree.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index f972562..6c33e28 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -17,15 +17,13 @@ cmp_cache_tree () {
 # test-dump-cache-tree already verifies that all existing data is
 # correct.
 test_shallow_cache_tree () {
-	echo "SHA " \
-	    "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
+	printf "SHA  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >expect &&
 	cmp_cache_tree expect
 }
 
 test_invalid_cache_tree () {
 	echo "invalid                                   (0 subtrees)" >expect &&
-	echo "SHA #(ref) " \
-	    "($(git ls-files|wc -l) entries, 0 subtrees)" >>expect &&
+	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
 	cmp_cache_tree expect
 }
 
-- 
1.7.8.1499.g39f909
