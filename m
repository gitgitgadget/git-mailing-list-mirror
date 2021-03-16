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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290B9C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12CBD650FF
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhCPP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbhCPP67 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69561C061762
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so1764125wmj.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwmDG2ryu0ZbzFdor8XDEGf2S52zGtGXkeHiA4hIOZY=;
        b=kfdTXbV/10adWTJ3rruao3JGfxt859jZrFK+vbzmOJeCHIBo0jbV358cIGYKXDhAd3
         OkVQX6wIZP+AxJr9quiD4J11huPT0ebat0w+uerrJDwNaHE/HdAQQqkFPHyKQr/mUFW4
         m21EnSSEC4W4vLV2RpayUm69PqWKNLOlHnCLHMJXeaV7eOLqc7HDJIG8tSVmaIq/yTsD
         OFpSDlqCJoG/TjLKmt0tXfHXQyVOpV+WMWeFk3PD7xukTUFsCqiPuEdKxqhgNpwYKlC8
         XdlAasliqNIri0jR7cWt3qovMRjzIPT18CRxLXF+xxGBe85+ffRszS44VXX5Ucm/7z7p
         93Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwmDG2ryu0ZbzFdor8XDEGf2S52zGtGXkeHiA4hIOZY=;
        b=Vo9Ht+b9i8bUTQ3n8HvOeBfQQQ3cL58XMah61IIqrcEIU0rgHJSoybPMYZHfHsxbKc
         CpZj2xEt9jgVFabptvE7GAVh0lwosnRdwAm9iqt1niR0OnkYaCNEUtCzMkKMy84x70QO
         C65pTNqPGVXKgyH7IqbjVTs9s4SBcEZZYJXVxVeDYyROS0o7Wtm6P5wxhDblJxeiVgu6
         VUq8xObzYQzt9C4QM27xYXzxdqLBIOf5VAEpHRgkoBTDS+9ieMIdpLbvXntOmz2ilw9o
         wkuN3mlPL+Cjv1FUwOwjdaR1INc8nO3IxD3LjlPCA+p05r7Pcb5zxsVSNb8ijF3b26eN
         RTyg==
X-Gm-Message-State: AOAM5302ro8wdfOfu/mihnSqWuaJElkQg+z+0jWWp23nM5vA/xqmj+MI
        o1Lhfn02KrUa7E53pm7Ys1YCXpfgMBTC+g==
X-Google-Smtp-Source: ABdhPJwE7Qrd7Y/NSHtch8+wiWkdGWX6zynybvNaDMvG1F59Fc+9FZYYv3rVbdUKGl45xA4dpze43Q==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr336837wmb.20.1615910335947;
        Tue, 16 Mar 2021 08:58:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:55 -0700 (PDT)
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
Subject: [PATCH v3 20/32] fsck.c: switch on "object_type" in fsck_walk_tree()
Date:   Tue, 16 Mar 2021 16:58:17 +0100
Message-Id: <20210316155829.31242-21-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index e3030f3b35..7c74c49d32 100644
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
2.31.0.256.gf0ddda3145

