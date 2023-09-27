Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF6E82CCD
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjI0T4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjI0T4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249B193
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:08 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79faba5fe12so325526139f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844567; x=1696449367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNlEB4NzHehHwb5iJrKXvrOJbxoQMMja8pt5tTtXO1Q=;
        b=aVsPheVl51TrUqCIUujV+TF+ucYsSoZnrN+anrB0PWqXWQjHnUQ7fl57t55WEnnlIU
         lrCnt0irFGwybgKfNxXRJtVBg7kIJRDJq+495/l9msbAboQpUCEHTF3lQqq4tHOy2Zgn
         8SSVY5IjFEwO+ZK0XuosqzG+Es/F72nryTMaUmjQuo6XyIn0vPol3Vz+zUYbwqm8LzXA
         5li0Q3cGJmq7/zXgZrMZN9zyIiomKmHaXT4whMmwtG7FVzTAF28yReH+0Oa75mKni/GJ
         VwDrXxfRswWF8oyMrpxyjjNpll5Gc6AAK9WPDuBfYT7SX793HtT/adVB93obMgDfmusg
         6D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844567; x=1696449367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNlEB4NzHehHwb5iJrKXvrOJbxoQMMja8pt5tTtXO1Q=;
        b=V+uOSSH1vr6Ojk4I0OsNigAJOxv3Jp/pjOc6RDhAgkFMinXsqyv5f6NaXV3e1qOFhp
         LER+pTstRfYIP2f7WIHxvSo+EkUpQ+tB2ii8qKhd5JnjHzNK6kbbFjPO/jTq8IJp3Pz5
         l4l7V/CeSBqsLMNyItOVpfYw6Mk0B3nDoWUm8oIzl8WP+cKot1KTTGEHYflsZhCcjwOk
         jF62oedRFT4wtQW+i808bYGBnlF2mCLIgpoTewEAZA/F4F9RY92XDbYSWyJ6MC6z1OR2
         gYT9ZudxKXqv4VM5jeul3Z6Pm1JbqOtD8a1CCACCFMF2lfpjPFf1UwtuHzS9/cov7AUw
         2xrA==
X-Gm-Message-State: AOJu0Ywqea0+7sCoC1Hi2ZA/aMzQAttrMaLRAMMpF0E38bKtnj/rQPGx
        USEhHRdBpA3bRJdhS/DyAls=
X-Google-Smtp-Source: AGHT+IFQOatpyhpwVGMbJebw4JPloD7iq617g1hugzw3c/U0TL59OSOFh/f8KHNC0Rs+e+cWalkw9Q==
X-Received: by 2002:a05:6602:2756:b0:792:9406:a453 with SMTP id b22-20020a056602275600b007929406a453mr3260855ioe.14.1695844567486;
        Wed, 27 Sep 2023 12:56:07 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:56:07 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 23/30] builtin/cat-file:  Let the oid determine the output algorithm
Date:   Wed, 27 Sep 2023 14:55:30 -0500
Message-Id: <20230927195537.1682-23-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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

