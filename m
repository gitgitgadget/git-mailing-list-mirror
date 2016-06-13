From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 08/40] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date: Mon, 13 Jun 2016 18:09:10 +0200
Message-ID: <20160613160942.1806-9-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSp-0004h1-2d
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424904AbcFMQKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36825 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424773AbcFMQKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so15997548wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RW/ia4EE31HqHqq3QYRc3N94LOsNsFvyRvoHQ5XajkA=;
        b=bj7vx9bHGYSOEiL1hMTiW3w5ouUolpYAf4T0NVH+GcAzgxN+AKKehyAYbuZYTyJ5X2
         VqMBXxw3YZSrMvpPKhpGLBgFeKn0Uw5vtCWFkVJrqixa/DMylzHQFP6IIAOtDK3f5qjX
         bnnMDNVr+GmPcudGO1wVcrLd/HPntclh/HPMzCseskKE4Fm7OcKDxz0tEwqQuDaBq5/u
         xJWeBXzx/apJD8eK48pChao78ruJ9+bSgBBtE8uQVx66wLiPt4Vb2y0/Vgl0TAu89IWh
         i9ht6F0M4J5bynIy/yDy8UaMTCx3l3gq9PbwOWKw0enP2Vchv1acjs/J6Je7a/U/kfgK
         If1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RW/ia4EE31HqHqq3QYRc3N94LOsNsFvyRvoHQ5XajkA=;
        b=Qitur1hPejyD4qu+IwWcO5Anp676g3bAse2i95zxEfKkeDtFerY9dsop4RnPnNwQtT
         Wr0HW/OeMGLJdyVuI+0e2gbNxnR5SgQWfSlMaKfYi3dhN8kdET4wMdcQeHCaiFJh8bmV
         +pYR1mvdobnp7r1OoeFvwAscyKeSWVIPxjzY5p589fJ5sq1RUOKD8yie4RN9kie3y6W4
         TddJL0curdjSWnIVm7uyls6g8M4qdyeg294Xeps0QWDft4ZaPh8/85FabJxcHurNygua
         mZ6pjcT+LX4nul5uCnOyN1bbN8D1vEfJjRMOYu++IQlK3eZvKHBLh3vfDZMAOf0HEnnf
         FsAw==
X-Gm-Message-State: ALyK8tIa2PcujOlxymD7rJ0dzZQe1/Va3R8V0ZE5pcj5ghDpDRjsJ1l48aCjAUMvUpfv2g==
X-Received: by 10.28.126.195 with SMTP id z186mr323400wmc.95.1465834207922;
        Mon, 13 Jun 2016 09:10:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:07 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297221>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_ignorewhitespace_option() should return
-1 instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e56e754..e2f970d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,20 +57,20 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(struct apply_state *state,
-					  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
 		state->ws_ignore_action = ignore_ws_none;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "change")) {
 		state->ws_ignore_action = ignore_ws_change;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace ignore option '%s'"), option);
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
 static void set_default_whitespace_mode(struct apply_state *state)
@@ -4616,8 +4616,8 @@ static void init_apply_state(struct apply_state *state,
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
 		exit(1);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
 }
 
 static void clear_apply_state(struct apply_state *state)
-- 
2.9.0.rc2.411.g3e2ca28
