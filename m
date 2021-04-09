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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEAC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E23861185
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhDIIuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhDIIu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA156C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f8so5616711edd.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hIrXibzbQzsqIhnEtOW2QwhgJT0nyQUQRIZzgSz6Og=;
        b=qEmCqGXMWcLndqAbOeOYCcr0tKvCLAsAj33zrLSYmgJ27Khet2lafswMEKEUnPWGy+
         pRmA1nlzBasvAaED3lLgkYSq6QUOmEuNnDL5pGv1ueQBH5TZzL9F00Bm5/cw3Uq0EL8/
         UhRY7/dxJjmpLxjCJlt7/UnSpdCtzDDK+AtVcu0/T/ycI4IGHYloaWdBu37ep3zd47iN
         JXjoYFQkALok3jd28VAxg3GsZgEmAw4pOuRmgtORxYyw9XWYhDh+XrNghQpvKyJ70qZY
         rnjuOaxAE8v/lbjwsch68xDMg+Jqwg+dJ8aMROW5ouyEXNcB5Pjtbp5tW54CLJ8WnX87
         ROGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hIrXibzbQzsqIhnEtOW2QwhgJT0nyQUQRIZzgSz6Og=;
        b=MrwqRVEt21PnhAvMv7sC6BkovJhlqkOKmKFSxzanVCqyQdJAN3AkYFuMcYJ8TvZYMm
         L1wZgukzobtaZ5+hZh8IeREGHrof97KSHFoJ3yxvbXn9cxBSBaMtjU8u7NaknuMOTX0G
         Lrek2XjRmq9Q3sRhMf6/9KobDH0RzHaiLb5yu82VEUvP/dGVllQHPDdOctjfeFy23NzU
         x+/zmq1ptCiZN45v3e4lnj9WT/LE6kqWun5gmx2lU26okhpZc5s9QPT8HpZ8mJ+EA3jj
         HnrtsAHQDnrBLn7GrvpiHhT8ZQxrSiKMYDOTGXampZqXuC8DMwJKl0wzH1k03HuXiA4d
         Zcng==
X-Gm-Message-State: AOAM530nvG+6iT75FCvVT7rs+SS0kbyc0P4QcRAPaoR/cbe2xaASE9iY
        Xv/W3ToqfC2eOxYMysOueDCE/TwdCnCUgg==
X-Google-Smtp-Source: ABdhPJxpbDfaQWdE31ao0Rj8THYCSQ7T6TYPhrd+mxf77Vf3s5PRpo0V4HAmWpWKx0NS2VzeZGD4/A==
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr16402029edu.67.1617958214428;
        Fri, 09 Apr 2021 01:50:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] object.c: add and use oid_is_type_or_die_msg() function
Date:   Fri,  9 Apr 2021 10:49:58 +0200
Message-Id: <patch-3.7-fb2e4feb3d-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
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
index be7f727b5a..2429d2cb89 100644
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
index 8b2df3a94c..1573e571de 100644
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
index d2d4a236d0..cdc3242a12 100644
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
2.31.1.592.gdf54ba9003

