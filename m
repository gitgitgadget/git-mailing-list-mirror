From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] bisect: avoid signed integer overflow
Date: Wed, 3 Apr 2013 20:17:55 +0100
Message-ID: <20130403191755.GI2222@serenity.lan>
References: <0cb4456948b0874a1cedc5679a7b23b82e755e94.1364931627.git.john@keeping.me.uk>
 <7vzjxgabd6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 21:18:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTCk-0001tb-D1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763219Ab3DCTSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:18:12 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:49115 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763205Ab3DCTSK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:18:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5556D161E291;
	Wed,  3 Apr 2013 20:18:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZ88z28jJBD5; Wed,  3 Apr 2013 20:18:00 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D4109161E0F0;
	Wed,  3 Apr 2013 20:17:57 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vzjxgabd6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219960>


Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v1:
- Change the function signature instead of casting a value in the
  function.
- This lets us remove an existing cast.

 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index bd1b7b5..374d9e2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -525,9 +525,9 @@ struct commit_list *filter_skipped(struct commit_list *list,
  * is increased by one between each call, but that should not matter
  * for this application.
  */
-static int get_prn(int count) {
+static unsigned get_prn(unsigned count) {
 	count = count * 1103515245 + 12345;
-	return ((unsigned)(count/65536) % PRN_MODULO);
+	return (count/65536) % PRN_MODULO;
 }
 
 /*
-- 
1.8.2.540.gf023cfe
