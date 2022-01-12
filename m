Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE7C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353231AbiALMkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353221AbiALMkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECEC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e9so4021908wra.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oj2RdNn4gsL9wns0HwT+4rw0Bsxfm1p/a9ZNRMWfAQ4=;
        b=n0CVPvuaDgn9Rnai13M5nQ6QHTiFXuqehoUsuE9EuYZFhTogOzMGcwnbSY5A+xFJJV
         oCE0c6HqzGMolKoMyUuByo5CtiGfq2wNGUq+EQKSHiX3KtqpETdmZqaOh1kx8Wusj3Sw
         4iXehJlw/vtjsYvSP6kqTAoAHDiFawc2f9zaWNVSznGuVcOP81AwQ3BdeJ9PtcbMy+B2
         VPtJjz2D9PNZXb3SptdZGr1h7/2eA+pBAJk5jTeYwGMyX8UO9ueJKMRkoSdZm5N0XVhB
         u9F/eKZMAOIMTHLSngl03m3mNCNPsNMCGwr6xCKSgMA/LfZJ88mb3HzxrZgx1/ZsKQXb
         Qa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oj2RdNn4gsL9wns0HwT+4rw0Bsxfm1p/a9ZNRMWfAQ4=;
        b=wluvhva1JiPyJHKLmMi2m+Lc/qNrMe8gbGuTwF3MGSMVbQe1FM7JYq5U6/gBdcY9Qg
         xRdov/0jKP08/nMyrlvDsWnpPcsxLftst6bwBTG7+9Xht57xO7MV/VGiRftvzzlozvwt
         VpG1iONTMdzFCuGbkJtlD7HlIE/YtbrSAXehjpdhUn3jsdSRio3pnhK3CwbucryvpBFD
         NYtxWFjFlgdDJIax4D6muZ7dcHDjaYYQSiGPsDUq8D0yXbaZ03Rw9n222FvBPqZH7jUp
         mrJtrUit3J++17LquPM9t89uXjPsAdTkleH/VtXNCXVB9bQ7I2pBtP6szGu940LBY6Ts
         x1Lw==
X-Gm-Message-State: AOAM530crlEdTEzQ6EJL+8dMcsfDQcDBApOKOgRWEqW+I6EkDJMD/o99
        nGJ8wdNVqIyi5VukNJ82/0/P8XvC/JJ/+A==
X-Google-Smtp-Source: ABdhPJzYPx17hJ0J+i3BWqgoM8leRoQNtVQxllnYxQ66ITPQR8qJHcEULYIK9YlAmCuXKRV6D6SEgA==
X-Received: by 2002:a5d:6dc9:: with SMTP id d9mr8203827wrz.42.1641991210042;
        Wed, 12 Jan 2022 04:40:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 6/6] object-name: re-use "struct strbuf" in show_ambiguous_object()
Date:   Wed, 12 Jan 2022 13:39:25 +0100
Message-Id: <patch-v7-6.6-bf226f67099-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the allocations done by show_ambiguous_object() by moving the
"desc" strbuf into the "struct ambiguous_output" introduced in the
preceding commit.

This doesn't matter for optimization purposes, but since we're
accumulating a "struct strbuf advice" anyway let's follow that pattern
and add a "struct strbuf sb", we can then strbuf_reset() it rather
than calling strbuf_release() for each call to
show_ambiguous_object().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/object-name.c b/object-name.c
index 71236ed1c16..bce3f42356a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -354,6 +354,7 @@ static int init_object_disambiguation(struct repository *r,
 struct ambiguous_output {
 	const struct disambiguate_state *ds;
 	struct strbuf advice;
+	struct strbuf sb;
 };
 
 static int show_ambiguous_object(const struct object_id *oid, void *data)
@@ -361,7 +362,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct ambiguous_output *state = data;
 	const struct disambiguate_state *ds = state->ds;
 	struct strbuf *advice = &state->advice;
-	struct strbuf desc = STRBUF_INIT;
+	struct strbuf *sb = &state->sb;
 	int type;
 	const char *hash;
 
@@ -377,7 +378,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * output shown when we cannot look up or parse the
 		 * object in question. E.g. "deadbeef [bad object]".
 		 */
-		strbuf_addf(&desc, _("%s [bad object]"), hash);
+		strbuf_addf(sb, _("%s [bad object]"), hash);
 		goto out;
 	}
 
@@ -402,8 +403,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 *
 		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
 		 */
-		strbuf_addf(&desc, _("%s commit %s - %s"),
-			    hash, date.buf, msg.buf);
+		strbuf_addf(sb, _("%s commit %s - %s"), hash, date.buf,
+			    msg.buf);
 
 		strbuf_release(&date);
 		strbuf_release(&msg);
@@ -426,7 +427,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * The second argument is the "tag" string from
 		 * object.c.
 		 */
-		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+		strbuf_addf(sb, _("%s tag %s - %s"), hash,
 			    show_date(tag_date, 0, DATE_MODE(SHORT)),
 			    tag_tag);
 	} else if (type == OBJ_TREE) {
@@ -434,13 +435,13 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		 * TRANSLATORS: This is a line of ambiguous <type>
 		 * object output. E.g. "deadbeef tree".
 		 */
-		strbuf_addf(&desc, _("%s tree"), hash);
+		strbuf_addf(sb, _("%s tree"), hash);
 	} else if (type == OBJ_BLOB) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
 		 * object output. E.g. "deadbeef blob".
 		 */
-		strbuf_addf(&desc, _("%s blob"), hash);
+		strbuf_addf(sb, _("%s blob"), hash);
 	}
 
 
@@ -451,9 +452,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * you'll probably want to swap the "%s" and leading " " space
 	 * around.
 	 */
-	strbuf_addf(advice, _("  %s\n"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), sb->buf);
 
-	strbuf_release(&desc);
+	strbuf_reset(sb);
 	return 0;
 }
 
@@ -552,6 +553,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		struct oid_array collect = OID_ARRAY_INIT;
 		struct ambiguous_output out = {
 			.ds = &ds,
+			.sb = STRBUF_INIT,
 			.advice = STRBUF_INIT,
 		};
 
@@ -581,6 +583,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 		oid_array_clear(&collect);
 		strbuf_release(&out.advice);
+		strbuf_release(&out.sb);
 	}
 
 	return status;
-- 
2.34.1.1373.g062f5534af2

