From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 22/83] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:22 +0200
Message-ID: <1461504863-15946-23-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFM-0001DF-Cm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbcDXNim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:38:42 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34939 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbcDXNfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id e201so60530186wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w3pB0OBhKMYaq0PYbAaUJBDayfza97CuRIdSs4OQHHU=;
        b=g67+7xqL1SLjAMn0QbOYLmZz429E19fPRkCr+eNum9qcJJhEuBn/BmrC19gE5kyoYx
         yHsa7Cwnalo6qWjO3IqDEIz1yHrfPiFJ+t22w9dCPVjATFJ23notyP1zBhiMV/4UoVPw
         XhnVY45mWTDsdOnhNxz4Wzsg2Qri5VcdW167KGtJPm9A/JSqhQDXA6O3TbD4+sJm6fNF
         LbKdYJqZbwd0PybY/h5lcCeqXV7fqUk80B7K1NapXvvtxMRS2f6LsLQt+94ekhkmkcOu
         JjfRJWN2bBvEdZOoC+lYARuS3Yji63LLgbmC+TtuZ5+MQj9wBKBYrVzpovGJqeYrtBG5
         BQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w3pB0OBhKMYaq0PYbAaUJBDayfza97CuRIdSs4OQHHU=;
        b=WXwA/YtjuBZ693KcTxwy3N6n2ovOaPl5No58PHdKN/sRxtDxaIviVgJOEZG95z883o
         HpLRKMRVRLUYQck62lJu+s2Qke6HGvWeoiwDhz/HO35+v694cJ48sZ/mJMpIUCwQ1u/9
         eFXCr2km769+7GLQKzMdNv/wKICKF/BgVNZTVsSusz72a5MrBoSOXR6D9u4leITiykuS
         wnEYxI0AU+7SVo9t1lh43EG7JvSSsjjsGyQcap59HIB1gtJycspfJCPR90VMYNnupTUb
         Kc3dXzwLwgElubcabQFPrL+jnpFMiqX4YSLFg9PV0Sy4NzqkYHlpBL+doYAc+VQV+Fyt
         hYsg==
X-Gm-Message-State: AOPr4FUdHZkMZOsS+VnWqI3LpspaoSShcvH6eG6angApNf8m+WUL/JyJd/o8fqyz0pjWmQ==
X-Received: by 10.194.59.108 with SMTP id y12mr28307329wjq.63.1461504916032;
        Sun, 24 Apr 2016 06:35:16 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292390>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 506357c..c45e481 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,6 +57,8 @@ struct apply_state {
 	int unidiff_zero;
 
 	int update_index;
+
+	int unsafe_paths;
 };
 
 /*
@@ -67,7 +69,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3842,7 +3843,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!unsafe_paths)
+	if (!state->unsafe_paths)
 		die_on_unsafe_path(patch);
 
 	/*
@@ -4612,7 +4613,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
+		OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
@@ -4689,7 +4690,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		state.check_index = 1;
 	}
 	if (state.check_index)
-		unsafe_paths = 0;
+		state.unsafe_paths = 0;
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-- 
2.8.1.300.g5fed0c0
