Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7290C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E71613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhDTMva (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhDTMvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA79C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k17so5413589edr.7
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14flaGEEhHRm4a5oY6SsBCFaydNdfYD5juAMR0uDSyY=;
        b=B+Mn8RdhUezbMU9RyXDHD+dh7dv5qK5def+R/sxL7UtQZmDNYBIgNef/zEKS/SW/4N
         l4pvhbHQuKVgRFNJv49GHnnWiGAbINxAEcjQOBvXrwqgjSlms5a9+qjYk9bj7OzVq19O
         GuARVQrwJov/019T0TdInBVcExyA1ADMA5yyf4seY5yExkd7lRFGaGsSIBUEoalUabOB
         9DlcOE+e5P6tjVF6440vs3SpMTr97Ypmvv/oAuV9Ag62ch02S6S0/+Ahnc9JRKhtDX9z
         pVzMg+fUZf0JIMQez4DDEQrGnCJGA5SU2m9ghQOL/JzG1viMs8FGTaTt4dzmhUsADn0F
         Bmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14flaGEEhHRm4a5oY6SsBCFaydNdfYD5juAMR0uDSyY=;
        b=mpMAXfGj+eQtBV5ned1exDvYIMtlyPoGoD0mEbiQCo45T1S/GaKtHIfAyYHnNgcxrG
         Vxl5zPZ/f2eDeiAKoedUjV/JqmTKh/EMFZafqqx56v+JGMl4Kq+OcWLzS6gr9D/LyKNH
         XO/MwIL9sM259nruz7zgOSAXIJAxyU0LOOT+c2nezqrrxHd+k7+gk6ePm+Z/vCUEgesv
         TALt7M/JCk/eVaomXpWRk5Gh6UgVomJlJkpSOqQZoBOtW4QwUbh/0P0ZX2x7UR06mgxX
         iTQJNsZmKX00lMHfVFBbX4Qr4wf1/QDivjhwhtkI0UETKp6VjDxJdoxn++91sC1YgxBr
         Xd7A==
X-Gm-Message-State: AOAM531IvP8vFOzg2cWmGb0Pv/JiUZ9myvP5iaTrZybZOtc58PFuxJMt
        oHy3LmHemHasaCZSHs3XRE8yPuoxRBOC+Q==
X-Google-Smtp-Source: ABdhPJzwYiguIZ4LUeoS8SjXyGoWs0Jr+lUw9w2jkZpdHA5XeAEcaE9jweEZd/ylJ88LhNgujJfUEA==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr32386861edu.252.1618923051120;
        Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] object.c: simplify return semantic of parse_object_buffer()
Date:   Tue, 20 Apr 2021 14:50:40 +0200
Message-Id: <patch-07.10-ee0b572f7d-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the local "obj" variable from parse_object_buffer() and return
the object directly instead.

The reason this variable was introduced was to free() a variable
before returning in bd2c39f58f9 ([PATCH] don't load and decompress
objects twice with parse_object() 2005-05-06). But that was when
parse_object_buffer() didn't exist, there was only the parse_object()
function.

Since the split-up of the two in 9f613ddd21c (Add git-for-each-ref:
helper for language bindings, 2006-09-15) we have not needed this
variable, and as demonstrated here not having to set it to (re)set it
to NULL simplifies the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/object.c b/object.c
index f4e419e5c3..70af833ca1 100644
--- a/object.c
+++ b/object.c
@@ -188,20 +188,17 @@ struct object *lookup_unknown_object(const struct object_id *oid)
 
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
-	struct object *obj;
 	*eaten_p = 0;
 
-	obj = NULL;
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
 			blob->object.parsed = 1;
-			obj = &blob->object;
+			return &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
 		struct tree *tree = lookup_tree(r, oid);
 		if (tree) {
-			obj = &tree->object;
 			if (!tree->buffer)
 				tree->object.parsed = 0;
 			if (!tree->object.parsed) {
@@ -209,6 +206,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 					return NULL;
 				*eaten_p = 1;
 			}
+			return &tree->object;
 		}
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(r, oid);
@@ -219,20 +217,19 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 				set_commit_buffer(r, commit, buffer, size);
 				*eaten_p = 1;
 			}
-			obj = &commit->object;
+			return &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(r, oid);
 		if (tag) {
 			if (parse_tag_buffer(r, tag, buffer, size))
 			       return NULL;
-			obj = &tag->object;
+			return &tag->object;
 		}
 	} else {
 		warning(_("object %s has unknown type id %d"), oid_to_hex(oid), type);
-		obj = NULL;
 	}
-	return obj;
+	return NULL;
 }
 
 struct object *parse_object_or_die(const struct object_id *oid,
-- 
2.31.1.723.ga5d7868e4a

