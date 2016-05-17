From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] pack-redundant: free all memory
Date: Mon, 16 May 2016 20:22:46 -0700
Message-ID: <20160517032247.25092-3-sbeller@google.com>
References: <20160517032247.25092-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 05:23:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Vb7-0002G1-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcEQDW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:22:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36088 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbcEQDWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:22:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id bt5so1654746pac.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7NMYK0gxAJSba01StA7ybtZ/XN32XWXSaAKScio30tY=;
        b=YGrWEMk3NLhlqpRdQO+Jn2Kpl8F9ofUzOPRP/GcPe+CzAJGxNi1HWcxgC9Ozv6nUrv
         rm3sGsvv3iw3UiCwSf7DZ4UvGEqkeFuzy8k7ynFIyXE7oAti5XIRoKvRHLidHjqPSb+7
         aFMAafbJS3uuVxh2FH/frUnRbgcS7jO1eonLJsbHwp//ePx1ubNz+cau4L5/bIUksKP4
         3123BDAKNnu2XPNAc85yIs/Ky4TS0K/OLk/d8wjezq6YoFTSbJ51as/kf9oy2f127d9/
         0AsU10aJ4NGinHRkkr8gg+A2BZadi8acYGqYP06AP/2HDlTGcVddNltw/uzxW04hZYr5
         bwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7NMYK0gxAJSba01StA7ybtZ/XN32XWXSaAKScio30tY=;
        b=gJTCvMCrVkO4gq5w9xFTIPcgmMtXAgifn4c9I6VKqiDA9Wjg7rwm7LzNeXDyjO0fe9
         DMESSbzkB1TPKH3BokdPXxzJH5msFB4xKf+hFnZZi9/mxluOCQRmEpmapQKrkJx2nUXF
         +OeQ8SgAADsDg5XZa7lGrDFFGvgynAEAdaies8CIn6zF6GwtRSJirWFp22hrjkP92jJJ
         czUVgrFxeHnze0FlqYmB2Ja4fStjWtpWt4fS/bIMSJPoEFZG1sJbV0RFu3oIAwbMtyvH
         GVpseMikrf5bJisYwZ+JKlM9mtN18AX84RPnhjiHbi/xkFL2cqdNdin5qGvaOx7Z6i5N
         q7JQ==
X-Gm-Message-State: AOPr4FX5lF+yZwbyNFB0TGuEt028Tt0bGKur950VLLI3EpE9ZsHrt6/6TWUI2j6mW4/EktR5
X-Received: by 10.66.197.200 with SMTP id iw8mr20023589pac.69.1463455374937;
        Mon, 16 May 2016 20:22:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id n66sm544345pfb.17.2016.05.16.20.22.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 20:22:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g9c0faef
In-Reply-To: <20160517032247.25092-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294841>

From: Stefan Beller <stefanbeller@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-redundant.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 72c8158..c75c5c9 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -223,6 +223,18 @@ static inline size_t pack_list_size(struct pack_list *pl)
 	return ret;
 }
 
+static inline void pack_list_free(struct pack_list *pl)
+{
+	struct pack_list *cur_pl;
+	while (pl) {
+		llist_free(pl->unique_objects);
+		llist_free(pl->all_objects);
+		cur_pl = pl;
+		pl = pl->next;
+		free(cur_pl);
+	}
+}
+
 static struct pack_list * pack_list_difference(const struct pack_list *A,
 					       const struct pack_list *B)
 {
@@ -691,5 +703,10 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 		fprintf(stderr, "%luMB of redundant packs in total.\n",
 			(unsigned long)pack_set_bytecount(red)/(1024*1024));
 
+#ifdef FREE_ALL_MEMORY
+	pack_list_free(red);
+	llist_free(ignore);
+#endif
+
 	return 0;
 }
-- 
2.8.2.401.g9c0faef
