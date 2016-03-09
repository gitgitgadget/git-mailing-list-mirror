From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 18/48] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:46 +0100
Message-ID: <1457545756-20616-19-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiI5-0007uC-Np
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933714AbcCIRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:52 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33006 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933710AbcCIRwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:49 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so203673580wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLHimmVeDryRUa1zTkq6FROH2Jb3AsQitn8BB8FSqPw=;
        b=Jf5ivhjY7BHc+kFqUqmPFsi7muGYmit5AEt6J33zNmmG3FV31QWUhpQE9aqxgr1Xe0
         bllxESZ2tYJpOcWRjlu4SEAq9c45x7N+xpyeMehvoIi9/os4hlbj47ZUbb7AmSO0QXtB
         npk7QzZOpfhQcWxnXuVXEbDXbbPmSNyQdvYhhgtctbcil2ws9tlEQEoI1g/jf+QRtAdW
         X/Oix1mQ/vyzhZ+HFJXWKv5JfAnHDP+x2hUsqGjPDs24XUhts+7/yxUNyp9+GhEadLFJ
         O9ZZ8zsN9yQHZkHZu+L5kVMyIT82XgZhumtZLE7ZBnoVpTmPP/XhaYIEzT37zFuyBtQk
         kaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLHimmVeDryRUa1zTkq6FROH2Jb3AsQitn8BB8FSqPw=;
        b=RfDiEfCuK8RCTg/0AgHPSS3eFSHIhfEMF+svuR2vHcT1cCr1aD3f4O8ZVeY9f14xge
         Q9UEgcN9qNYdIkfDS5JkE88xKkO9dPvreQuC+R78gw0Va0XspM1fLTjohHvSvihV/Tw/
         I3Aj1JiXk14HEchWdXW8V/gfYNqNjy8odJnVDtVT5mhvNJEeJzlZrPEJl8H0Ifpi4L6v
         WqNCrfjpTQHvhN3PEsYnQDmWFVrEqNpePrp4hCNWpSK2TuGZ+Z73lm9oGmyLCekIbPez
         ERLntsWHh36F6jcBi330ZhUJXRlGkTaMoekYcXW+w9DKoLQdnKt/I/B0Pc3j9Qjm9TiR
         asgA==
X-Gm-Message-State: AD7BkJIHCTVNg4VrZ7Fe+PMsOHisrMESEEZp0vJDnmOR6KuUCREgnNriA9CzfC0vCyK8Rw==
X-Received: by 10.194.7.201 with SMTP id l9mr36613711wja.16.1457545967798;
        Wed, 09 Mar 2016 09:52:47 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:46 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288507>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index fd5cb7d..0378465 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -37,6 +37,9 @@ struct apply_state {
 	/* --stat does just a diffstat, and doesn't actually apply */
 	int diffstat;
 
+	/* --numstat does numeric diffstat, and doesn't actually apply */
+	int numstat;
+
 	/*
 	 *  --check turns on checking that the working tree matches the
 	 *    files that are being modified, but doesn't apply the patch
@@ -52,13 +55,11 @@ struct apply_state {
 };
 
 /*
- *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
 
 static int p_value = 1;
 static int p_value_known;
-static int numstat;
 static int summary;
 static int apply = 1;
 static int no_add;
@@ -4498,7 +4499,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->diffstat)
 		stat_patch_list(list);
 
-	if (numstat)
+	if (state->numstat)
 		numstat_patch_list(list);
 
 	if (summary)
@@ -4596,7 +4597,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOL(0, "numstat", &numstat,
+		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
@@ -4674,7 +4675,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.0.rc1.49.gca61272
