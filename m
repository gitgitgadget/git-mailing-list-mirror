From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 2/4] imap-send: check NULL return of SSL_CTX_new()
Date: Sat,  9 Apr 2016 01:22:14 +0900
Message-ID: <929766804585e24d7fcdc8acb7dd4835b3069d45.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 18:22:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZBB-0000dJ-18
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbcDHQWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:42462 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbcDHQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 828B761CA3;
	Fri,  8 Apr 2016 16:22:30 +0000 (UTC)
X-Mailer: git-send-email 2.8.1.104.g0d1aca6
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291040>

SSL_CTX_new() may fail with return value NULL.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 imap-send.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index 0364b326e109..c5e24a35491d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -298,6 +298,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	}
 
 	ctx = SSL_CTX_new(meth);
+	if (!ctx) {
+		ssl_socket_perror("SSL_CTX_new");
+		return -1;
+	}
 
 	if (verify)
 		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
-- 
2.8.1.104.g0d1aca6
