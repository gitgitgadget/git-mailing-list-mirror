From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 24/49] builtin/apply: move 'unsafe_paths' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:01 +0200
Message-ID: <20160524081126.16973-25-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:15:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57UX-0001lL-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbcEXIO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35521 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEXIMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id f75so3655408wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w2x/AaBkU10qo83oO4qkb162M6oNfvvNDuV59jv4cp4=;
        b=pIT0/VEE9jXBSME4QmkSwBxmOGDqQudJ6IsNDWxAtkZk72zKB7Aha+gJjmqwa71WpB
         6XHfrVMP3ZCjIYAWGYut2MQrURjaeOkKh2Zc0J/gP5GLHe8mbxNX7SjommXYOp5VbYLd
         oMyh3dqsoq6J39M7nr17nUT7XmRgvKVCyaw/GK/o29WXxcnLaeerlH21FUu5fivF2/Dn
         +KQEOp6dL03ttOgVwaVayFMCqG6dIC1fo+pwZkmnyzZ3gxS1j1VpSPQv66iQHQJ8t8Oc
         NY9FXfCG9od/S4xmQfaY1+9tBzUlgAC1k/oz6zkrp38W9YBhh8wFcQjmbj2ClwZhBu8/
         7CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w2x/AaBkU10qo83oO4qkb162M6oNfvvNDuV59jv4cp4=;
        b=cHI85azX3ltuFaDyw3du/XNZoIvndcImphiccYgvRmpgY4MgQ7ub3BQmREmmrP/hx4
         nSgdiYZEjnt3ilMPguWP/N1Q4XjMysKGYYsRxxpdXwPxmvkm4/V3KT4dlGSBK1GSfwQ3
         m092SjQbNe2lmVVscWJXPhpKQyoGXbqCV8HiHGIPXtlz+wUF2FJ1st6Y2Njt2AIpe0Kp
         U4nkwhADevBzWzHLFRVwO5QSfPXZwWVvls0MwUahlKFTcRLXdMR47ibfoKZeAR0Z5my3
         SMN2JxnjJBCvmtCIQ34WStis2F9G/pEKl1Li0hpvL8qswK3Uw0/idSYptU85LfSD2mQW
         efkw==
X-Gm-Message-State: ALyK8tLGWDIhfnfgDYBzFOjl2bgHby5QxVypQATEKS3NPTKkk3j8Foag4kTKqp99xC0gSA==
X-Received: by 10.28.4.79 with SMTP id 76mr10553643wme.41.1464077538819;
        Tue, 24 May 2016 01:12:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:18 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295459>

To libify the apply functionality the 'unsafe_paths' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 604e7bf..4ef83c1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -44,6 +44,7 @@ struct apply_state {
 	int no_add;
 	int threeway;
 	int unidiff_zero;
+	int unsafe_paths;
 };
 
 /*
@@ -54,7 +55,6 @@ static int newfd = -1;
 static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
-static int unsafe_paths;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
@@ -3827,7 +3827,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!unsafe_paths)
+	if (!state->unsafe_paths)
 		die_on_unsafe_path(patch);
 
 	/*
@@ -4616,7 +4616,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOL(0, "cached", &state.cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOL(0, "unsafe-paths", &unsafe_paths,
+		OPT_BOOL(0, "unsafe-paths", &state.unsafe_paths,
 			N_("accept a patch that touches outside the working area")),
 		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
@@ -4685,7 +4685,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		state.check_index = 1;
 	}
 	if (state.check_index)
-		unsafe_paths = 0;
+		state.unsafe_paths = 0;
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-- 
2.8.3.443.gaeee61e
