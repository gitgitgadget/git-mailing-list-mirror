From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 20/49] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:10:57 +0200
Message-ID: <20160524081126.16973-21-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:16:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Vf-0002ED-7b
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbcEXIPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:15:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36179 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbcEXIMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so3637465wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n1q7IrJubdKZBucrjplxe55CVeHud6O2nl91pXzOYUw=;
        b=z8xCYJI2P5o0CDYoryu0IE3d+UZDKIHQL61riG8AYzdiIQHi3rBzovOOFP4qyhj0wu
         QlyugtJcILW/tXxPmOs3no7KgMMGx7Cd6xM2QrcNecyJNcmeLC8m2q+cX3OU4c5Pv1y9
         uEFB0FaGLpHQeQMobIpUcxIvKeSWDaheCAA3sYhELOxNBJEfUruGReXG5xT8b5l8C3jX
         AwoWqBu1TWnUbJ8znh10AnM2b6qHbzrdKDU+Se8/+fJ4xR+Ze9OfwoGt+J/hZi64+QmH
         hpFhUV3jH4XC4GcHpGv72PyyV9LsZ+nBYSwCMUjiBffKKbQqdPaKkFCcEd7aLZsb//fx
         wUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n1q7IrJubdKZBucrjplxe55CVeHud6O2nl91pXzOYUw=;
        b=a5XfVhKQkqciuA/4HYPw+NFPBBqO/MKw+SORXG5ZvABuNACjDp3rPsu4YdzFQjElDg
         dUcDIaDv2V//AWirE7PoGgCqDhR4VhnHqhjKtWBh0J4GoIb2y1Kg7b45ZiFv0lHl2Mes
         H1l0U4gpnsPcjFnQnosqB6gwo9wdisQBxHB7Xkl+Y+A6Rza0whnQtg1EJRA0JvCmwcdR
         Xlkp7bD+fkc34ffkTNCerBhXmJ67md04gOG2iMJBk2rjxkoqp/vcacmszJYcvvhEArjD
         9LQr6ViTWuY02WWxul07Vbp657+rynqgyZi+QC0TebXxoJ3aQ7KDK4tciT4yDXiOwEIO
         M06A==
X-Gm-Message-State: ALyK8tJv4uX7oYF4rPfYfybnUxOwpSZV2gX8pmFu2KABo+fG4ySlHiWTWYYTxTwYQgbPVw==
X-Received: by 10.28.23.143 with SMTP id 137mr851457wmx.89.1464077533766;
        Tue, 24 May 2016 01:12:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295471>

To libify the apply functionality the 'numstat' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d940125..47a45a7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -33,6 +33,7 @@ struct apply_state {
 
 	/* These control cosmetic aspect of the output */
 	int diffstat; /* just show a diffstat, and don't actually apply */
+	int numstat; /* just show a numeric diffstat, and don't actually apply */
 
 	/* These boolean parameters control how the apply is done */
 	int allow_overlap;
@@ -43,14 +44,12 @@ struct apply_state {
 };
 
 /*
- *  --numstat does numeric diffstat, and doesn't actually apply
  *  --index-info shows the old and new index info for paths if available.
  */
 static int newfd = -1;
 
 static int state_p_value = 1;
 static int p_value_known;
-static int numstat;
 static int summary;
 static int apply = 1;
 static int no_add;
@@ -4490,7 +4489,7 @@ static int apply_patch(struct apply_state *state,
 	if (state->diffstat)
 		stat_patch_list(list);
 
-	if (numstat)
+	if (state->numstat)
 		numstat_patch_list(list);
 
 	if (summary)
@@ -4607,7 +4606,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOL(0, "numstat", &numstat,
+		OPT_BOOL(0, "numstat", &state.numstat,
 			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
@@ -4676,7 +4675,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	}
 	if (state.apply_with_reject)
 		apply = state.apply_verbosely = 1;
-	if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
+	if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))
 		apply = 0;
 	if (state.check_index && is_not_gitdir)
 		die(_("--index outside a repository"));
-- 
2.8.3.443.gaeee61e
