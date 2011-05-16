From: Rafael Gieschke <rafael@gieschke.de>
Subject: [PATCH] copy_gecos: fix not adding nlen to len when processing "&"
Date: Mon, 16 May 2011 22:08:21 +0200
Message-ID: <F0632D34-AA49-48B6-B54E-208B14F3FA90@gieschke.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 16 22:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM4DH-0000fN-Ro
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 22:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247Ab1EPUQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 16:16:17 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:45434 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049Ab1EPUQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 16:16:16 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id F0B411D1D79;
	Mon, 16 May 2011 22:08:38 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.821
X-Spam-Level: 
X-Spam-Status: No, score=-2.821 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.079, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xbMaObE2bIhP; Mon, 16 May 2011 22:08:38 +0200 (CEST)
Received: from [10.165.14.131] (unknown [89.204.137.131])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 3866F1D1CD4;
	Mon, 16 May 2011 22:08:34 +0200 (CEST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173754>


nlen has to be added to len when inserting (capitalized) pw_name as
substitution for "&" in pw_gecos. Otherwise, pw_gecos will be truncated and data
might be written beyond name+sz.

Signed-off-by: Rafael Gieschke <rafael@gieschke.de>
---
 ident.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ident.c b/ident.c
index 1c4adb0..8e56b5e 100644
--- a/ident.c
+++ b/ident.c
@@ -34,6 +34,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
 			*dst++ = toupper(*w->pw_name);
 			memcpy(dst, w->pw_name + 1, nlen - 1);
 			dst += nlen - 1;
+			len += nlen;
 		}
 	}
 	if (len < sz)
-- 
1.7.4
