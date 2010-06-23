From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/4] msvc: Select the "fast" definition of the {get,put}_be32()
 macros
Date: Wed, 23 Jun 2010 20:47:02 +0100
Message-ID: <4C2264B6.5010906@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 21:51:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORVyw-000081-RF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0FWTvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 15:51:21 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:48149 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753036Ab0FWTvU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 15:51:20 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1ORVyg-0000iC-jx; Wed, 23 Jun 2010 19:51:19 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149542>


On Intel machines, the msvc compiler defines the CPU architecture
macros _M_IX86 and _M_X64 (equivalent to __i386__ and __x86_64__
respectively). Use these macros in the pre-processor expression
to select the "fast" definition of the {get,put}_be32() macros.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I did consider adding an additional guard, like so:

    (defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))) || \

However, I decided that the extra paranoia was not needed ...


 block-sha1/sha1.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index d893475..e102856 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -70,6 +70,7 @@
  */
 
 #if defined(__i386__) || defined(__x86_64__) || \
+    defined(_M_IX86) || defined(_M_X64) || \
     defined(__ppc__) || defined(__ppc64__) || \
     defined(__powerpc__) || defined(__powerpc64__) || \
     defined(__s390__) || defined(__s390x__)
-- 
1.7.1
