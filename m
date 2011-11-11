From: Liu Yuan <namei.unix@gmail.com>
Subject: [PATCH] mktree: fix a memory leak in write_tree()
Date: Fri, 11 Nov 2011 11:51:11 +0800
Message-ID: <1320983471-3165-1-git-send-email-namei.unix@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 04:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROi9H-0005GZ-UQ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 04:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab1KKDvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 22:51:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53808 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab1KKDvT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 22:51:19 -0500
Received: by iage36 with SMTP id e36so3701137iag.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 19:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7DTm+C9HXpjI3LuCEYdL2tJLdLuz3xwa9V+BF1QMqY4=;
        b=fWGhKpt5MH4M/K9G9WvUMzzu1Efbw7OxHl6ZVE6ydsixYP3CZYYrSEMyb4Cileu+Yl
         +c4LOjxwfBxtzEVnRyznCFyUejmyg8INdJYVLGogi6+uJ21Yzz00NbUKUX1g2VKQiNzB
         R2cb4tYabU3LMYiQLzwJgdxETS3SlgiDCezBQ=
Received: by 10.50.169.33 with SMTP id ab1mr11131313igc.0.1320983478798;
        Thu, 10 Nov 2011 19:51:18 -0800 (PST)
Received: from localhost.localdomain ([182.92.247.2])
        by mx.google.com with ESMTPS id ew6sm7783026igc.4.2011.11.10.19.51.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 19:51:17 -0800 (PST)
X-Mailer: git-send-email 1.7.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185250>

From: Liu Yuan <tailai.ly@taobao.com>

We forget to call strbuf_release to release the buf memory.

Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
---
 builtin/mktree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 098395f..4ae1c41 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -60,6 +60,7 @@ static void write_tree(unsigned char *sha1)
 	}
 
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
+	strbuf_release(&buf);
 }
 
 static const char *mktree_usage[] = {
-- 
1.7.6.1
