From: Liu Yuan <namei.unix@gmail.com>
Subject: [PATCH] mktree: fix a memory leak in write_tree()
Date: Thu, 10 Nov 2011 17:04:31 +0800
Message-ID: <1320915871-20671-1-git-send-email-namei.unix@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 10:04:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQYw-0004sW-L0
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 10:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363Ab1KJJEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 04:04:40 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63356 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab1KJJEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 04:04:39 -0500
Received: by iage36 with SMTP id e36so2670039iag.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 01:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=7DTm+C9HXpjI3LuCEYdL2tJLdLuz3xwa9V+BF1QMqY4=;
        b=xzjtrXsNfGhIMhEB1x3Un6iBLjCnQqy3qB5+sfvt7tvQ1IwYML3GFIS9+GUoTaPKTJ
         9oGK7NiGEzoQSMh9ajI0jqPE0vqnFi1BH97xKEa7ETFV/LeJcsk/k47z72a0bJoBm3Wg
         ImEvOn43LRJNDYpGfpJyt5wQEiGZjE9d3HUzg=
Received: by 10.42.151.196 with SMTP id f4mr6469713icw.17.1320915878748;
        Thu, 10 Nov 2011 01:04:38 -0800 (PST)
Received: from localhost.localdomain ([182.92.247.2])
        by mx.google.com with ESMTPS id g16sm10651122ibs.8.2011.11.10.01.04.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 01:04:37 -0800 (PST)
X-Mailer: git-send-email 1.7.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185223>

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
