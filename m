From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 22/44] builtin/apply: make create_file() return -1 on error
Date: Fri, 10 Jun 2016 22:10:56 +0200
Message-ID: <20160610201118.13813-23-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSnG-0003cB-ME
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbcFJUMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35059 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcFJUML (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id k184so1049087wme.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6nwqT9nYej9htKSHVqRgQU3Q8K2OgHMCown63sXTMeY=;
        b=lQOYhTiI+5nb+xt4w4r41OZA0TWDgEX7HYcj9TkUH/kinrajylM0jBdb6+KPZdgMII
         6+ymZeE3akdzOS9qwN7D8/wFrM6xa/Gu1o+XupH8p+0QqTDQTDiuO7cwTr4LdNef2Bvz
         27a4PiKx5wMef5aSo4rgVySdmUPNlrPWE/Xmkxv+8yLiv6GW/oFFBCbWSycPhtHMh7Dg
         DRp6txmluzAMNvZPzIYSWE0mG99nRvrWmUnELhjgA0Ha+n6gkYcDp4aVU37YxzcDduiV
         W7vpwEgjdIXhJxj17lsjr0r5k0zJIktZhiYzXbusnUNUlcn1Kfe/fNeRPDlZ/yiJu62Z
         hxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6nwqT9nYej9htKSHVqRgQU3Q8K2OgHMCown63sXTMeY=;
        b=WE5FjiYYU+BHTu6mIpAaWiWU6rf/fTzr3i3GZh0iiGyGIuH4MIS0hldzq0QnlqJ4DM
         tWhB6Os8FJg5XBvYKjcfbxrSD/f1mmF3/mXkACITE7vglIKkfC3f/JEFdtSOReuDoxwN
         qCiCQuzLooQvwzTx04VRPY6SEYbAidQNIQ7FRQ9J+6LrDoK+Ez2H0HReiDXhaoWP/wPd
         b+qw7C4+VwaYDNejbxIwDoo77nk43uatoON9yizqaov7+TVwiXb1Wqs4TKdn+rqTjweU
         1UjuzEHWv7vTKvTihB+Ql8a570lhUG7c5iGfIr0R8loMin77pP7dBkKDGBfjWzs8jtXb
         yCqQ==
X-Gm-Message-State: ALyK8tKovKVdCA8t1VLlDt1kCdyJvJ7VW3p8gZMmCAmlyUnUhmLG9FKmB4RJUF4TnLC0kw==
X-Received: by 10.28.111.29 with SMTP id k29mr686161wmc.58.1465589530278;
        Fri, 10 Jun 2016 13:12:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297038>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", create_file() should just return what
add_conflicted_stages_file() and add_index_file() are returning
instead of calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 005ba78..76d473c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4258,7 +4258,7 @@ static int add_conflicted_stages_file(struct apply_state *state,
 	return 0;
 }
 
-static void create_file(struct apply_state *state, struct patch *patch)
+static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
@@ -4269,13 +4269,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway) {
-		if (add_conflicted_stages_file(state, patch))
-			exit(1);
-	} else {
-		if (add_index_file(state, path, mode, buf, size))
-			exit(1);
-	}
+	if (patch->conflicted_threeway)
+		return add_conflicted_stages_file(state, patch);
+	else
+		return add_index_file(state, path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -4291,8 +4288,10 @@ static void write_out_one_result(struct apply_state *state,
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
-		if (phase == 1)
-			create_file(state, patch);
+		if (phase == 1) {
+			if (create_file(state, patch))
+				exit(1);
+		}
 		return;
 	}
 	/*
@@ -4303,8 +4302,10 @@ static void write_out_one_result(struct apply_state *state,
 		if (remove_file(state, patch, patch->is_rename))
 			exit(1);
 	}
-	if (phase == 1)
-		create_file(state, patch);
+	if (phase == 1) {
+		if (create_file(state, patch))
+			exit(1);
+	}
 }
 
 static int write_out_one_reject(struct apply_state *state, struct patch *patch)
-- 
2.9.0.rc2.362.g3cd93d0
