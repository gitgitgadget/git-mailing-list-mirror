Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09994C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbiKRLTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbiKRLSz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5F1A05F
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n21so12206813ejb.9
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1jc3g6FVR4JsZ8MKj9R2CKrUWqJw9rMcQoh/2RRAX8=;
        b=UB8bEGfGJTYqNofOxcKGGvz9bPvlTCk7F1lnM7pdMI6Emd1yuff9MhufYGI7HG0DpT
         dYd2PSH9Im8utUURPoCf6TZq9ImB/th2Dn7tp4Y/Q479oylxZcH78YanB5wbkPiv0yi6
         7h2Beg/wql2ZvYY6iksiJJa/4+542klrHpGMKyKWFPkOa41tcX/qNCV3KHG1XR1ZQTmV
         i7cpXaDFsex4nnf+WeNNcfUS36KIc2/0UTFTwZdow9RZz9qPJWoyG9UzKLNfnR57vYRJ
         QZOXLXTAjlmpqU2pLbfq1OVItT93bbl+ZIeQwbv36IhDPAOvpKcah7SCcSKUm6h+2Qv4
         EyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1jc3g6FVR4JsZ8MKj9R2CKrUWqJw9rMcQoh/2RRAX8=;
        b=dqGP6B+/2kMtkxd/kXL73arpBZnEoFlj1gEZ6ZfltLzi4/Z3g68qrXEovlzfxZxP+I
         rEobKZ+WFX2pUs6DJ6RZAgjL8nZd7w6RWAetrHzHCFd72C2I1w0l83anLwTCM5uStkL2
         dCQuc4ER9ZZJ4YZzEFQ5lhsfC7987HikUHKd3bltbtb4RL3fZm7V/vQ3SPV5pTv/ueGF
         LhnqA3NaZMD6/V+s6JqkXYsP0s58JiIfANYieMJD7iduoFwly41ACDxWBmE25jcGibkb
         j8D0OupX+HdVPjq7JlrvIyGsfWKrr56Dv5b5L2yOjCIdhk+Fe8La5SQ4sJRkqwCIIvwJ
         27ug==
X-Gm-Message-State: ANoB5plASOvgcoPKmfw6B04GMkfH7GlEDEd2thAKi9kxJIQtqBWc+Dfy
        ygT2gxSaX3vGsPOapHsISqkIVoyWk7a1nw==
X-Google-Smtp-Source: AA0mqf4XXDKfPA7DYsu6sC0wc9OC5hCiKIBja1F1Pgcf/zYI6/0PtU7HeGBuqtLLoWfPSNnF+RJJFQ==
X-Received: by 2002:a17:907:c787:b0:7ad:8035:ae3d with SMTP id tz7-20020a170907c78700b007ad8035ae3dmr5525585ejc.46.1668770323427;
        Fri, 18 Nov 2022 03:18:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 11/12] merge-index: use "struct strvec" and helper to prepare args
Date:   Fri, 18 Nov 2022 12:18:28 +0100
Message-Id: <patch-v9-11.12-adb712ca7a5-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the code that was libified in the preceding commit to use
strvec_pushf() with a helper function, instead of in-place xsnprintf()
code that we generate with a macro.

This is less efficient in term of the number of allocations we do, but
it's now much clearer what's going on. The logic is simply that we
have an argument list like:

	<merge-program> <oids> <path> <modes>

Where we always need either an OID/mode pair, or "". Now we'll add
both to their own strvec, which we then combine at the end.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 21598a52383..d679272391b 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -7,6 +7,18 @@ struct mofs_data {
 	const char *program;
 };
 
+static void push_arg(struct strvec *oids, struct strvec *modes,
+		     const struct object_id *oid, const unsigned int mode)
+{
+	if (oid) {
+		strvec_push(oids, oid_to_hex(oid));
+		strvec_pushf(modes, "%06o", mode);
+	} else {
+		strvec_push(oids, "");
+		strvec_push(modes, "");
+	}
+}
+
 static int merge_one_file(struct index_state *istate,
 			  const struct object_id *orig_blob,
 			  const struct object_id *our_blob,
@@ -15,27 +27,25 @@ static int merge_one_file(struct index_state *istate,
 			  unsigned int their_mode, void *data)
 {
 	struct mofs_data *d = data;
-	const char *pgm = d->program;
-	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][GIT_MAX_HEXSZ + 1];
-	char ownbuf[4][60];
-	int stage = 0;
+	const char *program = d->program;
+	struct strvec oids = STRVEC_INIT;
+	struct strvec modes = STRVEC_INIT;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-#define ADD_MOF_ARG(oid, mode) \
-	if ((oid)) { \
-		stage++; \
-		oid_to_hex_r(hexbuf[stage], (oid)); \
-		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%06o", (mode)); \
-		arguments[stage] = hexbuf[stage]; \
-		arguments[stage + 4] = ownbuf[stage]; \
-	}
+	strvec_push(&cmd.args, program);
+
+	push_arg(&oids, &modes, orig_blob, orig_mode);
+	push_arg(&oids, &modes, our_blob, our_mode);
+	push_arg(&oids, &modes, their_blob, their_mode);
+
+	strvec_pushv(&cmd.args, oids.v);
+	strvec_clear(&oids);
+
+	strvec_push(&cmd.args, path);
 
-	ADD_MOF_ARG(orig_blob, orig_mode);
-	ADD_MOF_ARG(our_blob, our_mode);
-	ADD_MOF_ARG(their_blob, their_mode);
+	strvec_pushv(&cmd.args, modes.v);
+	strvec_clear(&modes);
 
-	strvec_pushv(&cmd.args, arguments);
 	return run_command(&cmd);
 }
 
-- 
2.38.0.1511.gcdcff1f1dc2

