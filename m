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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0ADC433ED
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17C26199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhC1CO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhC1COM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232CBC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so6788329wml.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jaiUdQ0rqVaMig1j5NJGzYRmTLWPpZrF1UVLt9tLlRY=;
        b=VmQRLlm8tqtNvz4b2S03IBGsSK63lrx0CxeaUE0LuYT2ZR73nial00M9b5aV5rd0yp
         E8P8o90En0RxNAjVvyfcIQQ1nStXj+6WEMh3nRVk8fzEQORFWVu9yo+C+SiDLvZv/Ley
         w54dD7l63xBHDEj0Ed/Z1u9rLhMbLuHYKATS+jpRPGwV8NxayeTedQ5IZ2U1ZalIOyEE
         8TcrH7y460aQaVbu1MFe1J23O/NStfILdI0valJk1pZmAMomHax8Daf1+6wSRmoa6RtK
         bIx0EOc/B64G1g1CDXCGMfk4W0860agwwyQTSzjPN7gCd3oFqbq/B9pIBl4sfOgsp6Uc
         xp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaiUdQ0rqVaMig1j5NJGzYRmTLWPpZrF1UVLt9tLlRY=;
        b=DM/cUmh7GVBywFjnlMLqudDZCop+pesjKBk439ErPlmq1B5NqweYLzQhYWNt1s0+bI
         w5/DPlqgTnCZ+U1+ArFk3vJnoQBEMhk0bKU7Fsoq0ohb4csDF663rRAe7KwelQLF+/do
         4d1j+84mI0l4SP1B6ZqlAAS9qO1LSjnEWLpN+Y6UBm1YAtF5Ji0E/j5H7Hlr7R99glDl
         u2gNiGgNEu0Fs9PQIlKPpnUC281FYyvgP2cl553sogX4weUPhsOP5PsnMxQ8AzknEmoL
         3nZVsAHeuNasgIQZUuRSV1qnuWa3JvAZRw5qMrPkRXe2rOhiHU7NTUqSWiirbELqyFSD
         jH0A==
X-Gm-Message-State: AOAM531JJdscijQqrVnlOhNZqi0nOnM8UNDaOZEQVirw3jMatV7/4KlH
        A0ACFFJeexSM98xsBtze0jRCvwkAf9myxw==
X-Google-Smtp-Source: ABdhPJyh/VAHA4B1zll6FcNs+KZUP8us15A8xooPqoJgRlUf1tTb/wHjG6LAvnfPH3OncjTGs8YX9A==
X-Received: by 2002:a1c:2017:: with SMTP id g23mr18759922wmg.126.1616897650636;
        Sat, 27 Mar 2021 19:14:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] object.c: add and use oid_is_type_or_die_msg() function
Date:   Sun, 28 Mar 2021 04:13:38 +0200
Message-Id: <patch-08.11-351a8ec79c8-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a oid_is_type_or_die_msg() function to go with the "error" and
"die" forms for emitting "expected type X, got Y" messages. This is
useful for callers that want the message itself as a char *.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-recursive.c |  6 ++++--
 object.c          | 12 ++++++++++++
 object.h          |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index feb9bfeb8af..152e63e4436 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2971,9 +2971,11 @@ static int read_oid_strbuf(struct merge_options *opt,
 	if (!buf)
 		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
-		const char* msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
+		char *msg = oid_is_type_or_die_msg(oid, OBJ_BLOB, &type);
+		int ret = err(opt, msg);
 		free(buf);
-		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
+		free(msg);
+		return ret;
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
diff --git a/object.c b/object.c
index fa18b243280..0f60743e61f 100644
--- a/object.c
+++ b/object.c
@@ -182,6 +182,18 @@ int oid_is_type_or_error(const struct object_id *oid,
 		     type_name(want));
 }
 
+char* oid_is_type_or_die_msg(const struct object_id *oid,
+				   enum object_type want,
+				   enum object_type *type)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (want == *type)
+		BUG("call this just to get the message!");
+	strbuf_addf(&sb, _(object_type_mismatch_msg), oid_to_hex(oid),
+		    type_name(*type), type_name(want));
+	return strbuf_detach(&sb, NULL);
+}
+
 void *object_as_type(struct object *obj, enum object_type type, int quiet)
 {
 	if (obj->type == type)
diff --git a/object.h b/object.h
index d2d4a236d0e..cdc3242a128 100644
--- a/object.h
+++ b/object.h
@@ -128,6 +128,9 @@ void oid_is_type_or_die(const struct object_id *oid, enum object_type want,
 			enum object_type *type);
 int oid_is_type_or_error(const struct object_id *oid, enum object_type want,
 			 enum object_type *type);
+char* oid_is_type_or_die_msg(const struct object_id *oid,
+			     enum object_type want,
+			     enum object_type *type);
 
 /*
  * Returns the object, having parsed it to find out what it is.
-- 
2.31.1.442.g6c06c9fe35c

