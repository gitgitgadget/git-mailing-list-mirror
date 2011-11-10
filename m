From: Liu Yuan <namei.unix@gmail.com>
Subject: [PATCH] mktree: fix a memory leak in write_tree()
Date: Thu, 10 Nov 2011 16:39:22 +0800
Message-ID: <1320914362-20417-1-git-send-email-namei.unix@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQAh-00011u-Ey
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab1KJIjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 03:39:37 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52717 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab1KJIje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 03:39:34 -0500
Received: by ywf7 with SMTP id 7so2694799ywf.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 00:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7DTm+C9HXpjI3LuCEYdL2tJLdLuz3xwa9V+BF1QMqY4=;
        b=U8Ga/9CkF9a0EUa+cQt5lYCqzUBNAHpoKte7oFgwvNv8vk0gkXHrv8gvMkJOmPCMfL
         sSJP5CF69klLYxCDk0w88EeWXy5Vdt9UaZShefmr2CM0ZMFylnCUL8NOKa4doB3nN0VG
         PVIQauR5QogZk7Hjic5g9+I5+0kmE2gSkzOGw=
Received: by 10.100.226.2 with SMTP id y2mr3054671ang.80.1320914373916;
        Thu, 10 Nov 2011 00:39:33 -0800 (PST)
Received: from localhost.localdomain ([182.92.247.2])
        by mx.google.com with ESMTPS id i50sm11486897yhk.11.2011.11.10.00.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 00:39:33 -0800 (PST)
X-Mailer: git-send-email 1.7.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185220>

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
