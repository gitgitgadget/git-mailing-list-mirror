From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 25/49] builtin/apply: move 'line_termination' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:02 +0200
Message-ID: <20160524081126.16973-26-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SC-0000un-5S
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbcEXIM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33397 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbcEXIMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id 67so3641222wmg.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oG1204YO4nHFLvejvBX2px7tzVI1R9nymwkCA3lhLgg=;
        b=DqmnFR42YiuTiST5WTu0Wif5OXQibw/dW4eJMhIklBAPpE3iuuiAdbTGlSHsJUjZU3
         BArDmXv5LwW4Pkp3xBerF/4mOUYGrCdfnA92xU3xLF5I7+zMacGTKVmuE8Ua7z/WGoSV
         Icw7lbnpV0YjumCymqH3o0TozQ+ApH8US+AON9Ze386RlcnWajhpJI6ZrJho7DOeGZSK
         wbX2AgLxvyI+Ao4I8L0wf7s5mnDfyLBTu4BC+CJCrYIQH3WGoH9+ZiE0UvPTIUrL26mZ
         qi3CPY39H4q1aM/xzYc/EmPashe22Ol5mc7iN2QdiB5gRPD0t+PKb/OOSYEmGzCS0A7N
         k1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oG1204YO4nHFLvejvBX2px7tzVI1R9nymwkCA3lhLgg=;
        b=bExp4v9fiEgyhi46QOiXvCBfvMhjnnFO6xl7xvUJbsIMY6MP2Ip7tseYMv5j+q9ypn
         3yHM+iUDDk0dLsnHHyalj8BMxKic1kBaokgVXgW4G0zCGAtgLqhfIMZLJ0K5YjtEBJsk
         WX1HgQF/S2NC5Jtjc45vggvYvsEpkXvTB0HOgo+Xim14Wbxmf5WvHbMQ4O+i6XN566wP
         4fy0LR9LrcAMw7aDw7EQXMotppUJrdgwmwJCUp56OcV6uLjsBiE57RRPKGlViH0fUiBV
         s0tb9oSLVUVKJlSHrosnEiY5gbMc1qEUbeV1PwRnetXyPU4Jsw/zOU9QHS1Pkt1rGVAS
         9TEA==
X-Gm-Message-State: AOPr4FXVvnnFGkcRizT2CpwnwTZviX7Z0X6qNscDSvMjBTuKl22CrhIJECOMz3btdOSrKA==
X-Received: by 10.28.128.138 with SMTP id b132mr22216091wmd.53.1464077540307;
        Tue, 24 May 2016 01:12:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:19 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295437>

To libify the apply functionality the 'line_termination' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4ef83c1..95cd60a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -45,6 +45,9 @@ struct apply_state {
 	int threeway;
 	int unidiff_zero;
 	int unsafe_paths;
+
+	/* Other non boolean parameters */
+	int line_termination;
 };
 
 /*
@@ -56,7 +59,6 @@ static int state_p_value = 1;
 static int p_value_known;
 static int apply = 1;
 static const char *fake_ancestor;
-static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
@@ -3977,7 +3979,8 @@ static void stat_patch_list(struct patch *patch)
 	print_stat_summary(stdout, files, adds, dels);
 }
 
-static void numstat_patch_list(struct patch *patch)
+static void numstat_patch_list(struct apply_state *state,
+			       struct patch *patch)
 {
 	for ( ; patch; patch = patch->next) {
 		const char *name;
@@ -3986,7 +3989,7 @@ static void numstat_patch_list(struct patch *patch)
 			printf("-\t-\t");
 		else
 			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		write_name_quoted(name, stdout, line_termination);
+		write_name_quoted(name, stdout, state->line_termination);
 	}
 }
 
@@ -4490,7 +4493,7 @@ static int apply_patch(struct apply_state *state,
 		stat_patch_list(list);
 
 	if (state->numstat)
-		numstat_patch_list(list);
+		numstat_patch_list(state, list);
 
 	if (state->summary)
 		summary_patch_list(list);
@@ -4565,6 +4568,7 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->line_termination = '\n';
 
 	git_apply_config();
 	if (apply_default_whitespace)
@@ -4625,7 +4629,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
 		/* Think twice before adding "--nul" synonym to this */
-		OPT_SET_INT('z', NULL, &line_termination,
+		OPT_SET_INT('z', NULL, &state.line_termination,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
 				N_("ensure at least <n> lines of context match")),
-- 
2.8.3.443.gaeee61e
