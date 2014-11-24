From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] mailmap: use higher level string list functions
Date: Mon, 24 Nov 2014 13:22:03 -0800
Message-ID: <1416864124-15231-2-git-send-email-sbeller@google.com>
References: <1416864124-15231-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, marius@trolltech.com, julian@quantumfyre.co.uk,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 22:22:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt15P-0006ej-QX
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbaKXVWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 16:22:16 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53054 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaKXVWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:22:14 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so2073449ieb.17
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 13:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S2YTMf+uiZv/PrbOSfsz4/XJIMxruVY5RJ0Heyb+SUU=;
        b=eF4P+8CXDAMma/AwOVI5p+guRP9W7xaS/1CaqrmGSY5WlpesR9mwGLihGS92gVbqPs
         1dOxEJ+PZcdFv+h34CdLPirnpzrZs1id+hikKOHNP7nI6TygXvjck2s4O8jsXpJyjpN5
         y3IU0mJ9tXTfEP+f5rpQry9YEU26vu5bdrIfnJeF21lr7gwXmJPX3RemqtS2daqJ1YzB
         p2gCE6hsKbawWse9OV1XKGR5Er0exwVdYGnW6J77F5ovRxywB9ecrMaKFP115nzjQzSM
         PnYQSwKxjiJnY6KaNGjcM0a1ijpVFj2k6heqoreFayVtFNdV1qARbmAXKVosURutMAiJ
         nz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S2YTMf+uiZv/PrbOSfsz4/XJIMxruVY5RJ0Heyb+SUU=;
        b=QMp3JUBflGkV6j/pm6tnJdZ3NCsOS8Ek7HDa0Fn8pm+rs9Sxkdy9tBkKKwA/LyWtav
         1BllMAXYOi3YFoFUHSAVGrCC7jTQqGExouc8PU5eJ0IKcByTi5kj44OivOUH1IKwu1ln
         0P/VRTLcLaA5cgXz+PofjHDkG37BQzGOrEwx1aFbwAdilujwDqAG8VDsxxdYloefQkZG
         syCqWsipiY/KUUE6ami0YeqYRLPN/g0jbdV5GdWeX/ivwn/L4UwdL32JzuXbg9OkYC9f
         6VTIItA8mJJmC0GOOeiuUJU9hueOuXYTSuNDkWyD8TzzG445UR7qaMAE3AK1SCrd32p6
         gLpw==
X-Gm-Message-State: ALoCoQmG9xftAcHcUnT97Phk3MgAp6mQkpvfuAlTHo/vOEmLT3vO+4i6TLsXIk8JnsoPkhCzltAZ
X-Received: by 10.107.36.136 with SMTP id k130mr20551568iok.4.1416864134067;
        Mon, 24 Nov 2014 13:22:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:413f:9e9a:731:9749])
        by mx.google.com with ESMTPSA id v91sm8120076iov.15.2014.11.24.13.22.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 13:22:13 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1416864124-15231-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260148>

No functional changes intended. This commit makes user of higher level
and better documented functions of the string list API, so the code is
more understandable.

Note that also the required computational amount should not change
in principal as we need to look up the item no matter if it is already
part of the list or not. Once looked up, insertion comes for free.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 mailmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 81890a6..f0df350 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -78,15 +78,10 @@ static void add_mapping(struct string_list *map,
 		new_email = NULL;
 	}
 
-	if ((index = string_list_find_insert_index(map, old_email, 1)) < 0) {
-		/* mailmap entry exists, invert index value */
-		index = -1 - index;
-		me = (struct mailmap_entry *)map->items[index].util;
+	struct string_list_item *item = string_list_insert(map, old_email);
+	if (item->util) {
+		me = (struct mailmap_entry *)item->util;
 	} else {
-		/* create mailmap entry */
-		struct string_list_item *item;
-
-		item = string_list_insert_at_index(map, index, old_email);
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
 		me->namemap.cmp = namemap_cmp;
-- 
2.2.0.rc3
