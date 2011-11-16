From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH] mailmap: xcalloc mailmap_info
Date: Thu, 17 Nov 2011 00:51:13 +0100
Message-ID: <1321487473-29194-1-git-send-email-marcandre.lureau@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQpGG-0004Ie-LH
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 00:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab1KPXvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 18:51:20 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46804 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab1KPXvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 18:51:19 -0500
Received: by bke11 with SMTP id 11so1257838bke.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 15:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CEpwEBzCaJ0qBHNirIZH3hZyAsaPwe7hXeA64IcMDDk=;
        b=p848CUXRQFep4NQy4OM+D3yHdOqgGtr9C2FaKVOzyTmwgMBgjpd/wnC3wYep9Ozzc4
         FYTcMM1j5v9RO1wbhMmqLX4b4hw3UbuZRog7xQtCZ6ghX+dqxnghqi58EPKQKhh9Pos9
         obsUHCj0LXOaxYmocVIbEXDwzs+NAvVN9SgKs=
Received: by 10.205.127.134 with SMTP id ha6mr30826780bkc.23.1321487478471;
        Wed, 16 Nov 2011 15:51:18 -0800 (PST)
Received: from localhost (102.Red-83-43-162.dynamicIP.rima-tde.net. [83.43.162.102])
        by mx.google.com with ESMTPS id g25sm237814fae.16.2011.11.16.15.51.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 15:51:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185562>

This is to avoid reaching free of uninitialized members.

With an invalid .mailmap (and perhaps in other cases), it can reach
free(mi->name) with garbage for example.
---
 mailmap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 02fcfde..fbf7764 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -88,7 +88,7 @@ static void add_mapping(struct string_list *map,
 			me->email = xstrdup(new_email);
 		}
 	} else {
-		struct mailmap_info *mi = xmalloc(sizeof(struct mailmap_info));
+		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
 		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", old_email, index);
 		if (new_name)
 			mi->name = xstrdup(new_name);
-- 
1.7.7
