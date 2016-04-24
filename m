From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 67/83] builtin/apply: make build_fake_ancestor() return -1 on error
Date: Sun, 24 Apr 2016 15:34:07 +0200
Message-ID: <1461504863-15946-68-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDE-0008WM-30
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbcDXNg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:27 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36725 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcDXNgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:21 -0400
Received: by mail-wm0-f53.google.com with SMTP id v188so69577409wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5xFG54lqupT6P8WYyzFVrsDretjuvY6ZpSUIUU/I6vI=;
        b=DzV+TImSqEfuLexG3XrkynHn4TvERYHLeJTvtpE3wth6Zj+yMtA7FuSkURQ0RAp/qw
         OlJf2wNzNUWZh0W3TcwwIehbXi9KMI6OAQyXO11rrZW5yrS162bAlhQsIfl76mF857ax
         /UjRAJ56CUBx/oAnL76VVxPyOW26lvi+x7XYgtgjDpltUxPfkciBV3+nNe1ThIv81Ec+
         oQPQAsASHiEklkiYFfZZz1MXdWR7qOTlOzoaiRxWxwDAJ++oi/twESLLmEc+XUSpjmbE
         +6uOqUkvNmqmGB2UZAit5xQgULjR0tSFmUeJplN+TM1i8Du6Uf+OHl4Kowq5sY9TDEzk
         XBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5xFG54lqupT6P8WYyzFVrsDretjuvY6ZpSUIUU/I6vI=;
        b=a7OjjNnKtoNBgiBVvYu0rOlHfMkDScr6hCggs5RkmM7qyQK5Ij9oNcyLQnNCSKemBF
         M2sH0aBnJ6UOxD7jldyFfkuJrBSonxvzP5B8hY0UVbrO34Kch1ouYZRqJI1OBDUnmHGD
         GjPljt7ExrAlA/zS+hHhS7VM8OmSchDH8MVrm5wgJ72LpWxzLhJyHu1KGhasNPBXkLak
         Su2T9Ako1ZRZB/MkawNcervi3OL8KsVdpdcIiGZvdOL021n0vErkvNbp5ixDjN28D77w
         uLJHpf+OnICm5MqPyGFiqpNiQb53Voxx0fxy5OIlzq8WPsfClORSET0d/T39kmNjZa4y
         22/A==
X-Gm-Message-State: AOPr4FVAI5WP4qlwwHuR3qMfDvuD8t1EmuzXuY/pdkg4f7WeExCcy/YJpF1xCFtr4jK85A==
X-Received: by 10.28.236.88 with SMTP id k85mr7197748wmh.53.1461504980090;
        Sun, 24 Apr 2016 06:36:20 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:19 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292359>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8b7a8e0..69bb94c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3891,7 +3891,7 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 }
 
 /* Build an index that contains the just the files needed for a 3way merge */
-static void build_fake_ancestor(struct patch *list, const char *filename)
+static int build_fake_ancestor(struct patch *list, const char *filename)
 {
 	struct patch *patch;
 	struct index_state result = { NULL };
@@ -3913,31 +3913,34 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
 				; /* ok, the textual part looks sane */
 			else
-				die("sha1 information is lacking or useless for submodule %s",
-				    name);
+				return error("sha1 information is lacking or "
+					     "useless for submodule %s", name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
 		} else if (!patch->lines_added && !patch->lines_deleted) {
 			/* mode-only change: update the current */
 			if (get_current_sha1(patch->old_name, sha1))
-				die("mode change for %s, which is not "
-				    "in current HEAD", name);
+				return error("mode change for %s, which is not "
+					     "in current HEAD", name);
 		} else
-			die("sha1 information is lacking or useless "
-			    "(%s).", name);
+			return error("sha1 information is lacking or useless "
+				     "(%s).", name);
 
 		ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
 		if (!ce)
-			die(_("make_cache_entry failed for path '%s'"), name);
+			return error(_("make_cache_entry failed for path '%s'"),
+				     name);
 		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
-			die ("Could not add %s to temporary index", name);
+			return error("Could not add %s to temporary index",
+				     name);
 	}
 
 	hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
 	if (write_locked_index(&result, &lock, COMMIT_LOCK))
-		die ("Could not write temporary index to %s", filename);
+		return error("Could not write temporary index to %s", filename);
 
 	discard_index(&result);
+	return 0;
 }
 
 static void stat_patch_list(struct apply_state *state, struct patch *patch)
@@ -4470,8 +4473,9 @@ static int apply_patch(struct apply_state *state,
 		return 1;
 	}
 
-	if (state->fake_ancestor)
-		build_fake_ancestor(list, state->fake_ancestor);
+	if (state->fake_ancestor &&
+	    build_fake_ancestor(list, state->fake_ancestor))
+		return -1;
 
 	if (state->diffstat)
 		stat_patch_list(state, list);
-- 
2.8.1.300.g5fed0c0
