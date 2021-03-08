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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F31C43142
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6144F65239
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhCHPHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCHPHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B4C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e23so6250540wmh.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9klyRnnzVvknYOXub4tFfZ+7goWz26qrhIOQPJFtzA=;
        b=TdvKN8MMMzL9gGkFuILPJ5AuYILrg12J2wfX51TrOm2i6Yko5+ZUdB9mD2U7L+2aSb
         rWoXwl2cIJCwPB+jN7ZY3aYyYBLHugZIZZryYcthKFRifyJI6aeic3eg0lKWPBB3UnSR
         klC8BIM8MoxQAoHQFqJjKveErpHgJ77CeF7bfaHETgqLwNjLBmN58iLjddvWeWqn9jrv
         5Je/FIOjTIlUPg+55opXmw0VsVdwUve9HCzKlDA8l2DWzebdwMmsrAaUTeRGFG+R/+s/
         dG8EX2d6z1WEuRyKOQQ9YnGepkanyaaGTsNHx3hF/MI3ZCj14B5RHRijcKVWloCtFEWR
         MPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9klyRnnzVvknYOXub4tFfZ+7goWz26qrhIOQPJFtzA=;
        b=CdkMz5MUfXOwParrlIRw16DM7x6D0RjDCi9UusWWHXwGR4A7FJr2dDeJwq0gpzkslt
         VBWo1R+f8vX7kdbTPBDpqzgfs46rfJMVnzBD1nQoW4nxyK4RGzyIwx676DxeLbSIVjVJ
         ZsL8cu+b8ILUgSx8PWEmmr9qjfd4yEkx6SCJbPr+AltH5IZRk/vJNp5rsTg6cQNK3kWM
         Y7IJUW7moxPy/XbvfeDf1f1IJmYRo18zprlkPTfRF6xGD4bhrxDqzNBZBC2wcKhpyA6X
         XKddODG28ER0RS5b7A93o4YEkzDoKgzW7mqIuvjU4qOg+2IMWoNpC0mnDMEX1IXdMHWA
         tTVQ==
X-Gm-Message-State: AOAM531kZv0gfk1tnw1TLwZNayIA9140Nbhbx0Th5Ke9PAxfj27dy24f
        xSk4H3yn8IVdluPQ6ltGmyJh5vMSsrOLbw==
X-Google-Smtp-Source: ABdhPJxa+w44++vHXEzvjMbqaVuI1tEKVXPH9OYPi93htS8Du5OqziVVBJ5VsRN1eIcip+7X77YNGg==
X-Received: by 2002:a1c:1d82:: with SMTP id d124mr23079226wmd.1.1615216042080;
        Mon, 08 Mar 2021 07:07:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/30] fsck.c: switch on "object_type" in fsck_walk_tree()
Date:   Mon,  8 Mar 2021 16:06:37 +0100
Message-Id: <20210308150650.18626-18-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7146e66f086 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06) the "mode" is validated such
that we'll never reach the "else" clause here.

Good for us that fsck_tree() has its own FSCK_MSG_BAD_FILEMODE check
which we can use, added way back in 64071805eda (git-fsck-cache: be
stricter about "tree" objects, 2005-07-27).

Except it really doesn't due to a regression in 7146e66f086. A
follow-up commit will address that, but for now we can simply rewrite
this code like the rest of the s/entry.mode/entry.object_type/g
changes I'm making.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index e3030f3b358..7c74c49d329 100644
--- a/fsck.c
+++ b/fsck.c
@@ -396,28 +396,25 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		struct object *obj;
 		int result;
 
-		if (S_ISGITLINK(entry.mode))
+		switch (entry.object_type) {
+		case OBJ_COMMIT:
 			continue;
-
-		if (S_ISDIR(entry.mode)) {
+		case OBJ_TREE:
 			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_TREE, data, options);
-		}
-		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
+			break;
+		case OBJ_BLOB:
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
-			result = options->walk(obj, OBJ_BLOB, data, options);
-		}
-		else {
-			result = error("in tree %s: entry %s has bad mode %.6o",
-				       fsck_describe_object(options, &tree->object.oid),
-				       entry.path, entry.mode);
+			break;
+		default:
+			BUG("unreachable");
 		}
+		result = options->walk(obj, entry.object_type, data, options);
 		if (result < 0)
 			return result;
 		if (!res)
-- 
2.31.0.rc0.126.g04f22c5b82

