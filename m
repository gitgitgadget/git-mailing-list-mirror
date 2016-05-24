From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 48/49] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:25 +0200
Message-ID: <20160524081126.16973-49-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:13:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57TL-0001LX-A1
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbcEXINr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:13:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36790 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325AbcEXIMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id q62so3642298wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4RtKCWsSP7x9+vD7GNMB3e1SL12Kw+zBAGReeTluEc=;
        b=maZdGMDiagEUX64Fou9xFANFaJ9GXUlRMVqjDejvLr5dF78/h12rh+mnsBLdmN3YLz
         r/RbFdk01FZ5rapAIKj6X4c3crWPsJpPBLnj84ntO7bW2zOgNrmAl9i+X0czru3lfMk7
         V/9fr689mSNS4hgaCzkWkLXfgMSU4ogPLOKz2pxJYoOCKpJZu7xJPFPGYTI+8Y/heY41
         Ay2D8xwjfq+c/QusjvLWzuIJ4+9L9fXI9GpASK689jLrCOSqAvR5dpsDXRJ9to1S5135
         /cA6OQ5CpEJO94lnj7xOOEA3OM/CYxy0MV21uk+ZyIwL5VFZGc+DV+whGVU8+xZOe9O1
         upvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F4RtKCWsSP7x9+vD7GNMB3e1SL12Kw+zBAGReeTluEc=;
        b=EkNmPgKdPmcUiSdGZIDsJ5c/8Sil1Aao+M2cY1Z5zR73YSDeg4aKigvyIjWG1GtB2u
         I9xFWy9ANDRqAczlb21iDbU+yw943Fnjkl42/eOdKsc7j5pyMH7uHuqWWMcFmU3ZCD/G
         TYPerpyKUktvbS+nj2BAaE0VSjxlczSR2uq9JtFqUhsu58S7rFFN7V8q0m2qKD2mBZoD
         4sIhoFFJhUutYROn9owINLBXQWFrmKeeyK7bOPH6fFHX/RVbkJzNP/c4elbVOejkPMwV
         TgOKOgySBAUmywP6AChKvdxGudI2c2HExj7YVLRsRzovG3ZzUBVbdiBGxPI+PjS5ND4V
         X05w==
X-Gm-Message-State: ALyK8tKQRWq6Fac5zwvAgzVR3WMrZSKHwG7gIP9hUTYFpQYYWU81jkDODwCdNQKiptKKVQ==
X-Received: by 10.194.0.171 with SMTP id 11mr2809461wjf.110.1464077572653;
        Tue, 24 May 2016 01:12:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:51 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295447>

We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
keeps a linked list of all created lock_file structures. So let's make the
'lock_file' variable a pointer to a 'struct lock_file'

As the same instance of this struct can be reused, let's add an argument
to init_apply_state(), so that the caller can supply the same instance to
different calls. And let's alloc an instance in init_apply_state(), if the
caller doesn't want to supply one.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5027f1b..5d46b7c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -52,6 +52,12 @@ struct apply_state {
 	const char *prefix;
 	int prefix_length;
 
+	/*
+	 * Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock_file).
+	 */
+	struct lock_file *lock_file;
+
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
 	int cached; /* apply to the index only */
@@ -4493,8 +4499,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-static struct lock_file lock_file;
-
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
@@ -4547,7 +4551,7 @@ static int apply_patch(struct apply_state *state,
 
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && newfd < 0)
-		newfd = hold_locked_index(&lock_file, 1);
+		newfd = hold_locked_index(state->lock_file, 1);
 
 	if (state->check_index) {
 		if (read_cache() < 0)
@@ -4648,11 +4652,14 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state, const char *prefix)
+static void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->lock_file = lock_file ? lock_file : xcalloc(1, sizeof(*lock_file));
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4769,7 +4776,7 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
 			die(_("Unable to write new index file"));
 	}
 
@@ -4852,7 +4859,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix);
+	init_apply_state(&state, prefix, NULL);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.3.443.gaeee61e
