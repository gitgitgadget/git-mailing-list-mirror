Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9529CC433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617F361354
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJDO24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhJDO2z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:28:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DFBC061746
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:27:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so163724wmg.0
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgfTX8JdndOwx9UB8CihT9dHk1WDiMqiNSW8xaYOY5U=;
        b=kY7jy/SVyO5z4LtRx/TxWlqTSlIKM6q6iyRCKSgowIB/bocYjNZ7J/RINy0oiUmwSI
         97vgK9IuDdU8eZ9+sur+jpWkrnGhjS/oMGUAzZgQBXHzNfCPpzozphMapZAWEM52MEZn
         K/7TyQwzxSUXPD2uwSyCciY706KFKNurmAU6nJx7+ExNmHrhtaCi4FbybGsgiNyC5Wl/
         vzILm5OFd32d5sQKwqdwu/apTCQxRRMlr4c6UpcGJ+Cf7lI2SnQc//NFH+/PTg/FIhVB
         qb8aqIq90QqQfaqF3FHZbU/6gftOnqEp7/0DLgjJseK6Ap7p6VxhcfrY5TLEGxQHY2+9
         pzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgfTX8JdndOwx9UB8CihT9dHk1WDiMqiNSW8xaYOY5U=;
        b=sycvNfa5/MmFiza3QLgb8FjFTtjoi07AgGeVm7F/lTeTrZMW+rdjN3zsxFDCFQDPo7
         lbJ8sfsjB9zedNW587bQeB5Tj5HDgC1QOkxfxkGCGj1268vR/PyFvtiyJ/5SnzsJy6yq
         T8QPQ7bKSdGI8MKMfFHt28TU3mVp8Do1cLg+iDBW3M64c67kJwxZCCLLDpY1z3vtJieF
         ZynzZgPuHsdbalacx1D1CnheVaJ43q4FqQoapzqICcOcDnZBeXIDYM3q7l7T5vAmnHj4
         8+M2oPU/RYh8gQUPnPnryg+HOXEnmAlmLhqjSlg4QdSYza6ykTyzlfv1MwNYVzJD+cPC
         RDlQ==
X-Gm-Message-State: AOAM530AIqmNmxwd56JLe83RTpiwhjbs3JLG786JcDJde60P/PxgNL82
        n6tKIrQlUAxsTRrF7s8sVFOU503MtsQE9Q==
X-Google-Smtp-Source: ABdhPJxDhiz+aMlcXhQ3FIzJG4l9IKblLviniLzLKekLbymQiMPV5AlMJQnFBSSNi/wP6EI1QqrejQ==
X-Received: by 2002:a05:600c:4f8d:: with SMTP id n13mr4243099wmq.89.1633357625039;
        Mon, 04 Oct 2021 07:27:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm17368315wmf.3.2021.10.04.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:27:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] object.[ch]: mark object type names for translation
Date:   Mon,  4 Oct 2021 16:27:01 +0200
Message-Id: <patch-v2-1.2-55bde16aa23-20211004T142523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1409.ge73c1ecc5b4
In-Reply-To: <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the "commit", "tree", "blob" and "tag" types for translation, and
add an extern "unknown type" string for the OBJ_NONE case.

It is usually bad practice to translate individual words like this,
but for e.g. the list list output emitted by the "short object ID dead
is ambiguous" advice it makes sense.

A subsequent commit will make that output translatable, and use these
translation markings to do so. Well, we won't use "commit", but let's
mark it up anyway for consistency. It'll probably come in handy sooner
than later to have it already be translated, and it's to much of a
burden to place on translators if they're translating the other three
object types anyway.

Aside: I think it would probably make sense to change the "NULL" entry
for type_name() to be the "unknown type". I've ran into cases where
type_name() was unconditionally interpolated in e.g. an sprintf()
format, but let's leave that for #leftoverbits as that would be
changing the behavior of the type_name() function.

All of these will be new in the git.pot file, except "blob" which will
be shared with a "cat-file" command-line option, see
7bcf3414535 (cat-file --textconv/--filters: allow specifying the path
separately, 2016-09-09) for its introduction.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 27 +++++++++++++++++++++++----
 object.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 4e85955a941..47dbe0d8a2a 100644
--- a/object.c
+++ b/object.c
@@ -22,12 +22,31 @@ struct object *get_indexed_object(unsigned int idx)
 
 static const char *object_type_strings[] = {
 	NULL,		/* OBJ_NONE = 0 */
-	"commit",	/* OBJ_COMMIT = 1 */
-	"tree",		/* OBJ_TREE = 2 */
-	"blob",		/* OBJ_BLOB = 3 */
-	"tag",		/* OBJ_TAG = 4 */
+	/*
+	 * TRANSLATORS: "commit", "tree", "blob" and "tag" are the
+	 * name of Git's object types. These names are interpolated
+	 * stand-alone when doing so is unambiguous for translation
+	 * and doesn't require extra context. E.g. as part of an
+	 * already-translated string that needs to have a type name
+	 * quoted verbatim, or the short description of a command-line
+	 * option expecting a given type.
+	 */
+	N_("commit"),	/* OBJ_COMMIT = 1 */
+	N_("tree"),	/* OBJ_TREE = 2 */
+	N_("blob"),	/* OBJ_BLOB = 3 */
+	N_("tag"),	/* OBJ_TAG = 4 */
 };
 
+/*
+ * TRANSLATORS: This is the short type name of an object that's not
+ * one of Git's known object types, as opposed to "commit", "tree",
+ * "blob" and "tag" above.
+ *
+ * A user is unlikely to ever encounter these, but they can be
+ * manually created with "git hash-object --literally".
+ */
+const char *unknown_type = N_("unknown type");
+
 const char *type_name(unsigned int type)
 {
 	if (type >= ARRAY_SIZE(object_type_strings))
diff --git a/object.h b/object.h
index 549f2d256bc..0510dc4b3ea 100644
--- a/object.h
+++ b/object.h
@@ -91,6 +91,7 @@ struct object {
 	struct object_id oid;
 };
 
+extern const char *unknown_type;
 const char *type_name(unsigned int type);
 int type_from_string_gently(const char *str, ssize_t, int gentle);
 #define type_from_string(str) type_from_string_gently(str, -1, 0)
-- 
2.33.0.1409.ge73c1ecc5b4

