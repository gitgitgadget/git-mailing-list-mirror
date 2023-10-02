Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D11E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjJBCli (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjJBClP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:41:15 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD2DD
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:41:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a25040faffso218162039f.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214459; x=1696819259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNlEB4NzHehHwb5iJrKXvrOJbxoQMMja8pt5tTtXO1Q=;
        b=YbDYTSJogYvNx1oRdDY88y98ldblduoOUXnJwtMPLKhBRucyYJeQFq4aKIUSxEjqai
         My9yMR7DLqLj2vaQr0D3PmqJ3kJl+uDe7HHV/2JJhGy6PbHp/e/oA0P7ujirX98kbPrB
         HJjWI0dtftjY3kqhbBcH0wIeT+Lm/HXILpKRoig4AWjnLyxlv/IHFsbYm9YhE2dKApFE
         FR3tC0P5Ii9auCKuZrqQBGKymG/3nU0d/p9o9l4FztYUhYVEB2NCP8leslEQtkLmwIOi
         O+8nOxBKiPFGnLsftk73KbOZLIYDHu6bDgUFeriv4Mj3gVmXgbcx9aWdrLF6iH/5/AnU
         nqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214459; x=1696819259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNlEB4NzHehHwb5iJrKXvrOJbxoQMMja8pt5tTtXO1Q=;
        b=lI0Up3w2Gawi8IGwBoSj5XSWNQWlmWfstF4yXgB9ABeIDqihdqexQ1/beN4lgLFWos
         bXMoFaf7kewU8NdCKRAqc1sZGRNa0x20vWVol+IpE9CZkPfkoJY6h0v2EHafD2Tp+Bc2
         zPI3O4Ez0Hi83HUA7je43GLKrNIWMLAt9rkVH5RCuP6Zluw7uL5UmQi/VhH6kjA23upf
         KVqU/56pI8G7rirMwK3yfG1Mmk6zl564KAg+/Y9YG+I+3BeCV5VQm6d1Ua0xAFLI0jLE
         r8EZeG5MNXMHVr6X6YSFNpQhWJK7hJCfL+H7KrWD0lefAlVhzJp2xzhbKpDZCb/Zlk7Z
         UWLw==
X-Gm-Message-State: AOJu0YxOIMfNEERrecLin6VBH7bWdy11uPhfEB8y3xGg4UcJTQFXIPDl
        VyDdfDWt2ngU40yj/PFad1M=
X-Google-Smtp-Source: AGHT+IEt6LFJRKC+RVrPfndFll2ron/E6h1d7stLk3XgZhlhpcV7qwSEH+TIG/BoKpL2sCASGT+qcw==
X-Received: by 2002:a6b:f108:0:b0:79f:d195:5384 with SMTP id e8-20020a6bf108000000b0079fd1955384mr12997043iog.17.1696214459420;
        Sun, 01 Oct 2023 19:40:59 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:59 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 23/30] builtin/cat-file: let the oid determine the output algorithm
Date:   Sun,  1 Oct 2023 21:40:27 -0500
Message-Id: <20231002024034.2611-23-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Use GET_OID_HASH_ANY when calling get_oid_with_context.  This
implements the semi-obvious behaviour that specifying a sha1 oid shows
the output for a sha1 encoded object, and specifying a sha256 oid
shows the output for a sha256 encoded object.

This is useful for testing the the conversion of an object to an
equivalent object encoded with a different hash function.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/cat-file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 694c8538df2f..e615d1f8e0da 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -107,7 +107,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
-	unsigned get_oid_flags = GET_OID_RECORD_PATH | GET_OID_ONLY_TO_DIE;
+	unsigned get_oid_flags =
+		GET_OID_RECORD_PATH |
+		GET_OID_ONLY_TO_DIE |
+		GET_OID_HASH_ANY;
 	const char *path = force_path;
 	const int opt_cw = (opt == 'c' || opt == 'w');
 	if (!path && opt_cw)
@@ -223,7 +226,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 								     &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
-				    get_oid_hex(target, &blob_oid))
+				    get_oid_hex_algop(target, &blob_oid,
+						      &hash_algos[oid.algo]))
 					die("%s not a valid tag", oid_to_hex(&oid));
 				free(buffer);
 			} else
@@ -512,7 +516,9 @@ static void batch_one_object(const char *obj_name,
 			     struct expand_data *data)
 {
 	struct object_context ctx;
-	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
+	int flags =
+		GET_OID_HASH_ANY |
+		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
 	enum get_oid_result result;
 
 	result = get_oid_with_context(the_repository, obj_name,
-- 
2.41.0

