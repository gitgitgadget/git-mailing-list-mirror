From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 69/83] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date: Sun, 24 Apr 2016 15:34:09 +0200
Message-ID: <1461504863-15946-70-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDQ-0000Cp-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbcDXNgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:33 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38667 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbcDXNg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:28 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so89953056wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvsA6P/M25FOS6uXm/oa+1uDQOojhkjPgGbS3V22rDg=;
        b=Fge22b/bmsIAoqavJmk0zS9YpOdy+Rtk1l7BjUBsqnHk7dmO1TTdxeYsCuVqAW2k9/
         TWomjMdwK47zbqVbDwRLvwMLBt7aLR/YC8u8zjZALpCqPqiEJn8IJjJTzuv39eZjcEl0
         T7+IppYA30hD2xO1sRd5KuMCMNjdrhZaLA9AYrM6g/r22ikWXBAqqovqBmcu6WhWw/EP
         8Hv2lVRYm/TDEJWzDWBk96DQo6X/0WlUwSH05x0J5zvwp7VI9F+kJXs+x4JvfZ/9kyXI
         Q5bMreSosSyF/HoV0Ju9m6B41lB2sx3oH97Y/ih/cwMwEgM9HPMWrWKNImjxt8jR9jss
         EHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvsA6P/M25FOS6uXm/oa+1uDQOojhkjPgGbS3V22rDg=;
        b=O8l+pG6obbE8ExFznU8x+UWZAwCfGNAjMkKN/rnxPOAh/yukfUnc8tdt9Q1iRM4yTb
         95VR5fRekqGruA5ChOb1P1tg3O6mYAASycX+IcsJySzBIpC4Y1Wp4HR3stu6sCMITv+b
         EDXTGJ8hd5ImUQWjl3FYtmG5V4uzma18e4qMRq6+zoNWzpCNGWZC9qZW1F6rewUf2Wqd
         NSOKtGtVklEqJWCSPr2gWppXGlcsnIIbQIA944p9/wZ/r+D2coLG4Ksm76sKuO1jFvQx
         mVz4QqaAqTs0yzcZaWG6SxtNu4/x+zqbFLRyxvKYqWy08/GTImR5IxbmfyL7kXDbM1WZ
         hQTg==
X-Gm-Message-State: AOPr4FX6ZEI81B6lGMwfzv0Fcp8gw3WF67voFs2D5O6ZBU0rafjdIqiZUID2QEbyfu399g==
X-Received: by 10.28.29.147 with SMTP id d141mr2487830wmd.91.1461504982686;
        Sun, 24 Apr 2016 06:36:22 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:21 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292364>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 89118c1..5a5be49 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4210,7 +4210,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4218,7 +4218,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4234,8 +4234,11 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
 		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4249,9 +4252,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
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
2.8.1.300.g5fed0c0
