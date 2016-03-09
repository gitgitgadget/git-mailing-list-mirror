From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 17/48] builtin/apply: move 'diffstat' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:45 +0100
Message-ID: <1457545756-20616-18-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiI6-0007uC-9S
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933717AbcCIRwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:54 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32965 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699AbcCIRwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so203672072wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eaDdANwf9O7ApWSrU8+QNxFbRueZcVcZdK+V5hnn3hs=;
        b=ZS2jreKhM38rcfAg93Cj/54XQ25EOIo5m63VTTn/YB69n+WtuTUqSsbSP11n3P8g7X
         G8Q5U9Og72oUgKk8/MPEoWWG7ocgqUwYcSjElrB0YEXN8TpJFsWdzwsk2sOrM8TjK+eF
         PUukQ9jAaDHmB1gHJlucTMevwY51wFAkrHI9FpiIUYN/tKJ4GFLrEgklO8qAJyd6sP+8
         6GmDqNfFaBFcNavTapBo0AKLKMEkX5ATmdTOdfrOIxxGU693HDxULagN2lzSEsPyXwpB
         wqR3hWIDshxBbnVgloQnvyAGbl3qQRsaKK3HM+kjzHSjOQClsaCKq629mh2aMSxeYTBw
         YkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eaDdANwf9O7ApWSrU8+QNxFbRueZcVcZdK+V5hnn3hs=;
        b=Hc2awqi4I8/Uha/vgA4z8//ibNBb0c2gE5ukl5RHjF6TF5pjMYjTP8xypBEBVvMvQ/
         mC9DLDfyiO/YSNUkaYZK/MRSkpo+MJatvoZZwFfsyZr10+JK551o4OKQOBJLE6++kLPF
         Yob3ztAA4P2p6Q5sssEQDX2elIP6lDTCqHMj3pJdygbaxfs3iT+U/rVBWJmVWmxw3Cwr
         nlIt0KW2K/eSR6K5Xxm0ZGrjIkUOK3baAw/2lgyOrY9Vdq2+qTcDP3WyEl643Ii1xLlj
         EEP3TVEO+6EB3Ly2OTHUZU+8NzGAgydfdJ+Y9lEmV4/etxEJGnvDL2c+j4R36uyjIg7D
         Snig==
X-Gm-Message-State: AD7BkJIGxNsk6rRyz0XuW6GXnf2Y5l77plFWQMZ4FFto6Q4U85B9uIdzj6A0ysx3CBGo1w==
X-Received: by 10.194.11.67 with SMTP id o3mr36358019wjb.74.1457545965090;
        Wed, 09 Mar 2016 09:52:45 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:44 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288506>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 85aa817..fd5cb7d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -34,6 +34,9 @@ struct apply_state {
 	/* --cached updates only the cache without ever touching the working tree. */
 	int cached;
 
+	/* --stat does just a diffstat, and doesn't actually apply */
+	int diffstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -49,14 +52,12 @@ struct apply_state {
 };
 
 /*
- *  --stat does just a diffstat, and doesn't actually apply
  *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
 
 static int p_value = 1;
 static int p_value_known;
-static int diffstat;
 static int numstat;
 static int summary;
 static int apply = 1;
@@ -4494,7 +4495,7 @@ static int apply_patch(struct apply_state *state,
 	if (fake_ancestor)
 		build_fake_ancestor(list, fake_ancestor);
 
-	if (diffstat)
+	if (state->diffstat)
 		stat_patch_list(list);
 
 	if (numstat)
@@ -4591,7 +4592,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			0, option_parse_p },
 		OPT_BOOL(0, "no-add", &no_add,
 			N_("ignore additions made by the patch")),
-		OPT_BOOL(0, "stat", &diffstat,
+		OPT_BOOL(0, "stat", &state.diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
@@ -4673,7 +4674,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.0.rc1.49.gca61272
