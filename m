From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/7] pickaxe: plug diff filespec leak with empty needle
Date: Thu, 06 Oct 2011 18:03:35 +0200
Message-ID: <4E8DD157.3020808@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBqQH-0005qD-1d
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020Ab1JFQDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:03:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:56161 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996Ab1JFQDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:03:44 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 90F5B2F8034;
	Thu,  6 Oct 2011 18:03:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182964>

Check first for the unlikely case of an empty needle string and only
then populate the filespec, lest we leak it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c3760cf..0835a3b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -152,10 +152,10 @@ static unsigned int contains(struct diff_filespec *one,
 	unsigned int cnt;
 	unsigned long sz;
 	const char *data;
-	if (diff_populate_filespec(one, 0))
-		return 0;
 	if (!len)
 		return 0;
+	if (diff_populate_filespec(one, 0))
+		return 0;
 
 	sz = one->size;
 	data = one->data;
-- 
1.7.7
