Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF713C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLOIxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLOIwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ADC3F05F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h7so2301420wrs.6
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP/fYLlkODnxDWK0FpA3HsO0Jp43PxNCSvueyf+3ybQ=;
        b=plpp0FrVTRJ2lmEk9vNTu6uHRoYQdkeHTQ6UfW/o3KWyB/73kiHSQAIIrEPY7vzq4r
         AjNmJ8eI1RFodaJItWq8U422RsqEFF+YJgnYVLAAWzTQNMGeNNJMoEW+t0cxjLy2r6zY
         dEIj3lz4JAxUe+/F4usUNzzRG6q9YKA2aWxS5DTNdMAy85uJLo78Do04O+Qoemrx5/9C
         wyJSPJTwZiyeydDIH07G9KktgzRUoYHBQ9C4I3s4qimXWoY6CZ7nKwTS2uJF5oTvq7LV
         3d+GxYfdWqN6qz7U/f52nrPc8yVNzMb8IpB8vBE+WhavAKw6WYk/Hj6Bp6flPvUooJwB
         8HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP/fYLlkODnxDWK0FpA3HsO0Jp43PxNCSvueyf+3ybQ=;
        b=MAQdgBAFEfS8D4KfU2mQO89Eleavpo8UKDIEKkYE2j9HzKDcZLLkHt31TNioiJzu9s
         uqxy945QbJFeoblporRvScwyquo/RmBvXCUHzwRbV19D8InFpg701ONIPyKJA+k7iBU8
         ymOvnA9RdeFqyQoR/+YjaNQZ+hA5VzWfCiuuLS+R9xRIiVOGEkZeGvyMv+5m/gsEyITB
         eKNefMXELvxesruKjQ/CSZDGivb7UOGqM53/WFrEcyla6rR8S77qJY8G6GLU3wz7WGDb
         6HxwsywBRI4+sJfYBjULONHwd68PrpvfsQlL3lniey87SiIJfezYiBe2MCoJZZiQ6Ilu
         RnJA==
X-Gm-Message-State: ANoB5pl9H19/66FYxj2X7NYjJCWyPLpc+rb8BVz8to75whuN9Y3mpeBR
        27ODp/l55wHq2q06lygF/V7vlO7cHl6LhQ==
X-Google-Smtp-Source: AA0mqf4y9nEXF5DaHdnGmojTM8S+0T53yhiPzG7aOuQvbgzxZBYcCdtHRY2Aaihoti2Td8gQZRqn4g==
X-Received: by 2002:a5d:50c4:0:b0:242:1dce:3fd7 with SMTP id f4-20020a5d50c4000000b002421dce3fd7mr21414107wrt.34.1671094355451;
        Thu, 15 Dec 2022 00:52:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:34 -0800 (PST)
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
Subject: [PATCH v10 11/12] merge-index: use "struct strvec" and helper to prepare args
Date:   Thu, 15 Dec 2022 09:52:15 +0100
Message-Id: <patch-v10-11.12-748fef4434f-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
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
2.39.0.rc2.1048.g0e5493b8d5b

