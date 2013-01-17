From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] combine-diff: suppress a clang warning
Date: Thu, 17 Jan 2013 11:23:30 +0000
Message-ID: <20130117112330.GE4574@serenity.lan>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
 <1358376443-7404-2-git-send-email-apelisse@gmail.com>
 <CALWbr2wk+78zxGKCo-hCOwMuMOzdGspYvMu7PA6o0OYM3Y3m4A@mail.gmail.com>
 <20130117110008.GD4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, git <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvnZl-0001Ht-44
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 12:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab3AQLXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 06:23:44 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:33576 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3AQLXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 06:23:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 3FE8022CA8;
	Thu, 17 Jan 2013 11:23:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I05g3DNsBThT; Thu, 17 Jan 2013 11:23:41 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id CDE3322F12;
	Thu, 17 Jan 2013 11:23:40 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id ACBA4161E556;
	Thu, 17 Jan 2013 11:23:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zV62OXPThgoM; Thu, 17 Jan 2013 11:23:40 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DABBB161E583;
	Thu, 17 Jan 2013 11:23:32 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130117110008.GD4574@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213849>

When compiling combine-diff.c, clang 3.2 says:

    combine-diff.c:1006:19: warning: adding 'int' to a string does not
	    append to the string [-Wstring-plus-int]
		prefix = COLONS + offset;
			 ~~~~~~~^~~~~~~~
    combine-diff.c:1006:19: note: use array indexing to silence this warning
		prefix = COLONS + offset;
				^
			 &      [       ]

Suppress this by making the suggested change.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Thu, Jan 17, 2013 at 11:00:08AM +0000, John Keeping wrote:
> On Thu, Jan 17, 2013 at 11:32:39AM +0100, Antoine Pelisse wrote:
> There is one remaining warning on pu which hasn't been discussed in this
> thread as far as I can see.  I'll send a patch shortly.

... and here it is.

 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..dba4748 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1003,7 +1003,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
 			offset = 0;
-		prefix = COLONS + offset;
+		prefix = &COLONS[offset];
 
 		/* Show the modes */
 		for (i = 0; i < num_parent; i++) {
-- 
1.8.1
