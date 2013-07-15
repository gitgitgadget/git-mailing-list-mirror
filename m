From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/9] mailmap: debug: eliminate -Wformat field precision type warning
Date: Mon, 15 Jul 2013 02:54:11 -0400
Message-ID: <1373871253-96480-8-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgU-00043H-Si
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab3GOGyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:54 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53187 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab3GOGyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:52 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so25815314ied.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YStTXJa1jrZtigps1obCsIoUiU+KItL36r526D/NHtg=;
        b=TNEYnfXE1Y83CurYIaaX/w9k5s0SqfBET4E5uf+DqilTfp3HZ+VD5i7DJGuaatflWg
         HNEn5pd8HxodbJiIZbztV5T9bn05vH2GBfczT/zgJI8IwnC7khCJjXGJ7ORTTOz/enbW
         coynhA4c7+XAz4GqG5z4lX9mDIdhlL1+6eJeQTH5GJr74TpK6L/SidALEQOOsna26x2N
         H/TsA8SuL7qkofQcfGawnIsPN433Z8CSf8tbb1JWszP0L684/TnW4igXK/orfMpMUeZT
         nOB96NMGrRlU/loVYY2WjTc7B4KV1LJa8/VraQUooy1HGEbR/nPEo0x14PpAcDrx+jwH
         zb1Q==
X-Received: by 10.50.129.38 with SMTP id nt6mr6269694igb.16.1373871291455;
        Sun, 14 Jul 2013 23:54:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230430>

The compiler complains that '*' in fprintf() format directive "%.*s"
should have type int, but we pass size_t. Fix this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 62d998a..4cc6e81 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -309,7 +309,7 @@ int map_user(struct string_list *map,
 	struct mailmap_entry *me;
 
 	debug_mm("map_user: map '%.*s' <%.*s>\n",
-		 *namelen, *name, *emaillen, *email);
+		 (int)*namelen, *name, (int)*emaillen, *email);
 
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item != NULL) {
@@ -337,8 +337,8 @@ int map_user(struct string_list *map,
 				*name = mi->name;
 				*namelen = strlen(*name);
 		}
-		debug_mm("map_user:  to '%.*s' <%.*s>\n", *namelen, *name,
-				 *emaillen, *email);
+		debug_mm("map_user:  to '%.*s' <%.*s>\n", (int)*namelen, *name,
+				 (int)*emaillen, *email);
 		return 1;
 	}
 	debug_mm("map_user:  --\n");
-- 
1.8.3.2.804.g0da7a53
