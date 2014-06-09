From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 11/19] diffcore-order: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:30 -0700
Message-ID: <20febeddeb08ba7c811731d2f9a416716d78bf55.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wG-0000vF-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbaFIWVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:07 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36968 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:05 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so5508623pbc.28
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7VsOfzHcmCefthgEpo5B3Hb4rxIWF9w1kSaKchfqtiE=;
        b=d8zqBUGguPNjH4s8DIRXGNc2sqnjCtPIwWw0G7tu1KBMCc7Vsax0r9YPy67raclSUI
         uJWUm5hCrQrWrG8Qkcy4MW20RI3ZWf4ERvDmsUKqm75C6jpTCDBLRZIVu7vp1UIw8L1M
         uTdwFMexOKem0/eu3qFfHIbr3NU+hqrT2Zg0xWUdIgpwNTCJmYTGcJGD4UGXXqNfrzme
         nNhCJeH/4f+8fiKtB5QiNqqJnFchcCSjj/5TJZanC8bqVH+0PnF6iRVRAd3hXIaJq+Mm
         JMMke91qdMiRlVe4QhqDNLsAwo/km1L/yxIHERFc9QhIcQnPaM/tJTEDzrbOaTe5Sjmk
         aVRg==
X-Received: by 10.66.224.38 with SMTP id qz6mr1007668pac.153.1402352464620;
        Mon, 09 Jun 2014 15:21:04 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ib5sm65795821pbb.55.2014.06.09.15.21.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:03 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:00 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251119>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 diffcore-order.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diffcore-order.c b/diffcore-order.c
index 97dd3d0..5a93971 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -63,8 +63,7 @@ static int match_order(const char *path)
 	static struct strbuf p = STRBUF_INIT;
 
 	for (i = 0; i < order_cnt; i++) {
-		strbuf_reset(&p);
-		strbuf_addstr(&p, path);
+		strbuf_setstr(&p, path);
 		while (p.buf[0]) {
 			char *cp;
 			if (!wildmatch(order[i], p.buf, 0, NULL))
-- 
2.0.0.592.gf55b190
