From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 20/40] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date: Mon, 13 Jun 2016 18:09:22 +0200
Message-ID: <20160613160942.1806-21-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURe-0003g0-9L
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424930AbcFMQK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35144 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so16027824wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+SJWZOieAYUy//dhW6JDdQc13eRXCoedixCKyHB+VJg=;
        b=nX7IkrTKjncUYpXOc07JVcLDLHBTqbcPPCi2BxnEUbTKQcM8L/1tm8wRSB0C1Y84sW
         HKWfNDXsVYvpSGX00/ZRocajePOBlYvtzASHKYt3V6x5FSjv7S2+bLmadznLXMeHaOja
         LIR4wV3CKQl8Eb9X2qM1Vqena42mHX4WUiyOPTnJd5Bxhkn4HtP1pcHBTfRvto+vEtHs
         Q4dvPoRipQYoSoSkv/4Sn4628kGeLUFIf6o3N8TPQw5iJKTxVEY2wafnX3OUN8qsum7v
         RA+uh4CmnmY51hYftfCc53ih2++WttIB+dCdmsll7HPGm+TDn4QLgYBnn7zl1H4xKDkn
         vSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+SJWZOieAYUy//dhW6JDdQc13eRXCoedixCKyHB+VJg=;
        b=ejlXIgIs7HC1Z+qP0PZhQz9AFu3R11ME8y8Qzpjx2vGQhVHKhhiXilVTM1Fj9zHgXq
         cn88YLrGcNkQR5VqnWRt9EV1rI4aIixygTWIh9oXrBWtSr5HH6xwUN9GXjs6Hi6bGaPn
         ZQmp9u8k6QpOF95nh8XGfcCNBoL0Fun5NaFV7rtE+OxdgLGuEHMU6OW+2SRK1p0RmIii
         cLvUVmHTGjyupLb7SYTXYpzNvOtKk0QWJ6/t7ExjhGRrXtn+3JpPwZsrtFKNNe+qP91G
         tXiGX11LM6d65FIieKoVa6pbE4x52ppQpCNgKw0oU+k3DDzMV0NyN5WrIufXqNs+l8Yi
         XhTw==
X-Gm-Message-State: ALyK8tJUVrQ4Rz8ZWz/bcbZYMSH+e9faw1uPlXENkHMrUE3Zg5OYTaB1eQ0IW2yEti+53A==
X-Received: by 10.28.0.73 with SMTP id 70mr1890742wma.64.1465834223978;
        Mon, 13 Jun 2016 09:10:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:23 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297199>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 694c65b..0997384 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4213,7 +4213,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4221,7 +4221,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4236,9 +4236,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4252,9 +4257,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(1);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.9.0.rc2.411.g3e2ca28
