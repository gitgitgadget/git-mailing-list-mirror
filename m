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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B60C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5496501A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhCPCOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhCPCNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45347C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso551071wme.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZIeawCokkahloLMIdWp61GkJ5E26pdQFgO//MNau3E=;
        b=J+bGNkb1GeQSj8IzaVQCZ0kiCzsBBMZptVjOEMWCCzl1DPFVx/znPyI0u/qh8gIAl9
         7jMs+J9H6CDeQNg4OhC+TVBZJgG1Oy8KI+cIcVnKlUopZCYGVHpzvg6vJDKiK2X7yk2g
         tmMOUQ6sJd08rUblyaEWg3ZDmKPPTyPEzNetj64etrgmoIcAlRPUARdVDvBEkGNk4JXu
         lEnOk/wjtDi2CY+UXEhvMy1a87cUuV72RId58zWVj4we+PufXC4s2ic+Aq0uIwhCaXvM
         176stvIA/5w7H7IXKYTW3gufNsoQ8C2xBTiayGFITM7drR5YrK0IBj9dc85X9Qpts+uN
         9Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZIeawCokkahloLMIdWp61GkJ5E26pdQFgO//MNau3E=;
        b=CbSVC26ooOlnYVlyAjGoUVowVc2Dq/ULyxJQJg3ngpYvbWXbCKB15fCWcdwlfhQCLn
         ErqiTIoVEeV+MUmataHqC2uM2QksLl1sQCvsjD7T9qPyTOjo8tuoREvX07mpfIqSZQg8
         dspF0q8kPLj5syR7rjsqwDf9PE2s5jk3jgohbovRpiWrffCs1MFaikdLLN+/a7YJ/H7e
         ixic+RY5xZpFbYtMd9vBMWs7Li9WFb/Ikya5xgkFpHUnoNMqbfPVcZdVNbk6cGA+Mcgi
         3wfEwWjNYXTCjzWSooSBs+lkoHFUb5ohNTK2cUAaU4D+FRUHYWp/4QpSoRUWN6f/6RY4
         sd+w==
X-Gm-Message-State: AOAM532e8DlNvGYU16T7kFRJfb/jQF1AtmB94vdkf+0qQdz69M5W5YTa
        DLbynUNurVdn1LJDgnGVmIfYIRrJkwRyqA==
X-Google-Smtp-Source: ABdhPJz47liKjMI9Nk+Z0NA99oWwwUbFCIhGkMg087P1jAaOGf6g/kFCpDieIywihqmQ+gRZGuSwYw==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr2278681wmf.106.1615860825785;
        Mon, 15 Mar 2021 19:13:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:45 -0700 (PDT)
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
Subject: [PATCH v2 17/29] fsck.c: switch on "object_type" in fsck_walk_tree()
Date:   Tue, 16 Mar 2021 03:13:00 +0100
Message-Id: <20210316021312.13927-18-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
2.31.0.rc2.211.g1d0b8788b3

