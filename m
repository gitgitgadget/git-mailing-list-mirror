Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67AC433E5
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A3C619A1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhC1COz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhC1COI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E85EC0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so9313400wrw.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jarA8mn8C5ZF66NNUoR+kAbMHmCwkjeLNBzH2X+7FR0=;
        b=MDCPrD9OAZlAauzpTG7At4cmrpyzIgjS58V/dXpTX3vpk5aJC5/Bc5zUrW8T3NLSCu
         5NY3nXnT9lgTbvsRslKPUq/jixgjMyp6OnUWuZqENgQz/bLeXkotpPEu+cWtktzoqx/O
         ADjoM6gPl5bIWJqBNg89v2nx2GmM1bht3WGImq3BFEbzsYyQa1Ql7FxGcR+RaL6qKA5Y
         RHsdb/jAtkWCLs9m0mY7dhqyCdRpckixvWOdI/8WqPqamVVK9huMyY5+/T5+GS+ERgT3
         ivyEg5VVXIaFoIGmrturfr6jIzN09ex5h8GLE5BRjwX8cD5zeKoaJ9lNa+lWuvXDhz0W
         /jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jarA8mn8C5ZF66NNUoR+kAbMHmCwkjeLNBzH2X+7FR0=;
        b=NkujYgBcD/GgcfdFBe9dn9icaj2iaDO1q4mt8Q8ER7R/ADPoZQJulweRSKBbp7WgE0
         3wVov5WDzMSxgubJRrVjPpOSR2RcNJR1a2nsmJUlrHheZqBi/nxXqhm3aNVOGK+1VPFW
         ZPEc8BkFLlAkEPYfyGUUkRdFXrEklPkOyLWq2vS03rK/Fo+0AHIIDXnHiUWXhXqu2sGY
         i6SCOPXHJdHV4cTgMOKKTopiKCdi5KBNqHfzIhC23BsMkL9P5ViU7QsA94ijAuD7mHuU
         9vp7kytEkIdXuYRAn5tbznt9nGcPMGKDr8gKAM0LxOmlTdxRenHDS7sJyOv3tE4UkJOt
         aWXg==
X-Gm-Message-State: AOAM530NN7e30la9ubx9Pd1nh6Jr3PnBcZLnL4x2VRKhIcYtRuETk5ox
        IJEaWQWsU4iCsM6KeJrWV84lzlrGG+J6hQ==
X-Google-Smtp-Source: ABdhPJxztNgtAa474yL1RLcJLctgMVp2ucVyX4DHvHsQrxWcs1xm1mC9mnxaf2JFhxV1rgQIDzb0sg==
X-Received: by 2002:adf:f150:: with SMTP id y16mr21786459wro.414.1616897645977;
        Sat, 27 Mar 2021 19:14:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] object.c: refactor type_from_string_gently()
Date:   Sun, 28 Mar 2021 04:13:32 +0200
Message-Id: <patch-02.11-3e3979b6b35-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of the "gently" argument to type_from_string_gently() to make
it consistent with most other *_gently() functions.

This refactoring of adding a third parameter was done in
fe8e3b71805 (Refactor type_from_string() to allow continuing after
detecting an error, 2014-09-10) in preparation for its use in
fsck.c.

Simplifying this means we can move the die() into the simpler
type_from_string() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c        |  2 +-
 object-file.c |  2 +-
 object.c      | 12 +++++-------
 object.h      |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..6cc4f9ea892 100644
--- a/fsck.c
+++ b/fsck.c
@@ -957,7 +957,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
-	*tagged_type = type_from_string_gently(buffer, eol - buffer, 1);
+	*tagged_type = type_from_string_gently(buffer, eol - buffer);
 	if (*tagged_type < 0)
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
diff --git a/object-file.c b/object-file.c
index 624af408cdc..b7c26b67355 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1314,7 +1314,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 		type_len++;
 	}
 
-	type = type_from_string_gently(type_buf, type_len, 1);
+	type = type_from_string_gently(type_buf, type_len);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
 	/*
diff --git a/object.c b/object.c
index 65446172172..1c36ea606f2 100644
--- a/object.c
+++ b/object.c
@@ -35,7 +35,7 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len, int gentle)
+int type_from_string_gently(const char *str, ssize_t len)
 {
 	int i;
 
@@ -43,17 +43,15 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
 			return i;
-
-	if (gentle)
-		return -1;
-
-	die(_("invalid object type \"%s\""), str);
+	return -1;
 }
 
 int type_from_string(const char *str)
 {
 	size_t len = strlen(str);
-	int ret = type_from_string_gently(str, len, 0);
+	int ret = type_from_string_gently(str, len);
+	if (ret < 0)
+		die(_("invalid object type \"%s\""), str);
 	return ret;
 }
 
diff --git a/object.h b/object.h
index 3ab3eb193d3..ffdc1298300 100644
--- a/object.h
+++ b/object.h
@@ -93,7 +93,7 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t, int gentle);
+int type_from_string_gently(const char *str, ssize_t len);
 int type_from_string(const char *str);
 
 /*
-- 
2.31.1.442.g6c06c9fe35c

