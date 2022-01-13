Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE3BC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiAMDmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiAMDm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A2C061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so16608007pjf.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Og3NRhvCB8viY+g8beafb7FBfKqhyiS8McSgvZBORGw=;
        b=mcO06NuBWF5z+EN/5roIdawMON7nWGd8urRGPoywfp1p505pXWkA/T7bOsLNhhCf43
         HVtOALUuj3oWd/VuA1dujHXuRq6bjAqdDj3kJ0E6lmGe0flMs/pz9pWx2KyiSI1t3KIB
         7YA9xjfV1VGp+wd0jdAW0B5gX4i0KGKCIMKzTCB3U0iZUyvgFWrsxfz+JnMGp5Tpii/9
         oXejogmj0EfnGvXPLxzEllvWFCGt3ZYzjhKWfSQ+udw/1zSxsrMUiGqr7TQfKVxjk5U3
         C3qcjyrKwmzHs6niEhsZo9R4YQALTbzZ/3OaJrzEUxbb8xUK90EfaepWtERSgBW6/Gmj
         XKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Og3NRhvCB8viY+g8beafb7FBfKqhyiS8McSgvZBORGw=;
        b=OMZ2BPI9YR3DjCJy13AoMWSNrbPyk89xI+plAhov0nSlT2u9XFs/FcDGAM6pJp0XAS
         lfthqWPkZ+1sq+Lz60M/EPGrdD/SsMm3BRJ7SpqlAcoA7gYU6/2ZlOS7d4Npct3sW76Z
         aUOqqdmMxZ1ZvetaLCydfDnBgmwE4ll0ZDWKGkTzk/N2O9JbKXQVvvaUkhB5c81O6u5n
         Ky+hlW0NN2dTaX+7ISWvksER8OaTz/pAqVAVKe7Oihfs2BF/SkfqDyHylcovuXbvK4wO
         hu04k/21q8JhIbNDPzJ6hngXInxMeyuUta5rlBNB0BzCQvLZtBqlfYOYhWxsoyf8+VHm
         Mhjw==
X-Gm-Message-State: AOAM533NPUgBKlqqXQ35shd/o2DH3a/tBqB26N4RcsbRaMuP+Gl/aOHA
        d7Z+oV+OVZZ6QD3s2//C8Ow=
X-Google-Smtp-Source: ABdhPJzz10f5OjIXReYgSA0VoncXNB0gXoJECBheP4r20Wv5YLxBTAsvbAsk9vGLKk7NISp/X1oGig==
X-Received: by 2002:a17:90b:180e:: with SMTP id lw14mr3047750pjb.179.1642045349102;
        Wed, 12 Jan 2022 19:42:29 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:28 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com
Subject: [PATCH v10 4/9] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Thu, 13 Jan 2022 11:42:07 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.34.1.390.g2ae0a9cb82.dirty

