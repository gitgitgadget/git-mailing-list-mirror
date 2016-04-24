From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 19/83] builtin/apply: move 'summary' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:19 +0200
Message-ID: <1461504863-15946-20-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKC4-0007sT-2W
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbcDXNfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:15 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37576 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcDXNfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:13 -0400
Received: by mail-wm0-f54.google.com with SMTP id n3so90202033wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o+7YcjiW+ta87cdKddv6F9cE7Gz8h3nviDfw8W7S6S8=;
        b=ekVZK5aWAXQeMIGbwOzGYlTFevuczHXkHbrpGObgQ1AXY8OVEodRp00OZl2rULYCQo
         GGsxerHCDNLIUoe+YJanqZKoJWIIFEWUkGnH2aOew9LKFsxS3kPx0EHfupJfnOv1ao5m
         UNrrHEWoCJbpp2px/VXmQ/VqHczUKAdlaVJAm0WUd0IRFtz1Y4lpxCETULw+weS4sEIG
         TcJSNdNM5m83BDhUyEsfhmvbgEntAkNphT2qrY/2EtW4V8X2DWbXjvIbtfPhK47ZJgb4
         ZBT2AAIhgrzrG2YkLaiyH0M51R98Sc7/xJz1WJEMEdnOtXzG4YEZG9t+uiDhSaWNGBA5
         4Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o+7YcjiW+ta87cdKddv6F9cE7Gz8h3nviDfw8W7S6S8=;
        b=PvFYmkYppH7+3jSfrvvhZUTNd0qa/liL5LKprrP59OgV3sxlGTavlnuGCB1T3yftgX
         PYj09PYJutkzDpvxe0cvArPCspX68WM2z7huRaXz2NWX9VXRMYEAfY+jfEcuFEOx2/iX
         edjFI5CQe2SwiORWagQEhkrWFEAFuHLs6XtjALBMkQEIdwIldfr5LVoU26mT66MMRbEg
         UO04pBpz92FEqxRTpC7wqzxT7sIJtsgQ+9Sn+/AnOptOub36YOAAapU0e9kSbFkvD4Pl
         twlWCf8JjOqeBnsKANsYHCM7GDH8czJQdBz+VGINRZeR8ZwMPre7kD2W5MEGhn5i4Dg1
         l/3Q==
X-Gm-Message-State: AOPr4FU8AkzWhTMoJiaIqr0vOgWuNLkj2aL1oVEW+vUWMgAD/JdS3vG74SOOmVLDhcGd0w==
X-Received: by 10.28.92.69 with SMTP id q66mr7345227wmb.102.1461504911880;
        Sun, 24 Apr 2016 06:35:11 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:11 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292332>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 16d78f9..e488879 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -39,6 +39,8 @@ struct apply_state {
 	/* --numstat does numeric diffstat, and doesn't actually apply */
 	int numstat;
 
+	int summary;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -60,7 +62,6 @@ static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int summary;
 static int apply = 1;
 static int no_add;
 static int threeway;
@@ -4504,7 +4505,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->numstat)
 		numstat_patch_list(list);
 
-	if (summary)
+	if (state->summary)
 		summary_patch_list(list);
 
 	free_patch_list(list);
@@ -4601,7 +4602,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOL(0, "summary", &summary,
+		OPT_BOOL(0, "summary", &state.summary,
 			N_("instead of applying the patch, output a summary for the input")),
 		OPT_BOOL(0, "check", &state.check,
 			N_("instead of applying the patch, see if the patch is applicable")),
@@ -4676,7 +4677,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || state.summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.1.300.g5fed0c0
