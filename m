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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CAC43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E7A613C8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhDTNBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbhDTNBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E629C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k26so21094884wrc.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5bXgd0zNlESZG1RqrJ87r30ZpjeDb00Q3D4mTkmhKc=;
        b=WBovzlNc1Z1rhyrVvvyEgk0VMMFpnh3wAWxm1Y3+zGYsJXNk9+FTbtnf0RR2pOQyT0
         t0Geo/mrloTQcbtjdpH7sFX5aJS99e9vXsyIUOPu2wID7Q8BjxI9bn8r5RQpPbsQjBD1
         op1sifIchxKskOGc5Lb3CX07Vl2EBrFR+28cbvt0l+WQiXUza8ozTuhYRiw+L7OE/ep7
         8/+SqK2M1v14JypqTwOso9o2aKjoMRf3wULzKi9EXPDeNNRWxeN3UHNkHQVEt8a3ADux
         6nxKiOXToj6PTvcWWN5OWSKsNu7z1rtCU4lYrEJEWLI9Yyw8WpA4KgI/DDUSLHwEKJPW
         k+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5bXgd0zNlESZG1RqrJ87r30ZpjeDb00Q3D4mTkmhKc=;
        b=jvIAqAbGnzMs47CIR0ab0k/FRfcTSa6PnqEqxqsMWFZ713TVcfs+XL1jjfSiv6ZhFO
         gdAG5btM9Ssq9z/VrXgjfH9KIeXfGUSQSsjTrPVkr//hy46UijlSBDcBHKVaZHmuDmP8
         VFSScczISxEB1UVQLaG2r7Upwkz9hSIYNesrMufxXW2BjP0XUjeDI1HvjlWyjvZg0rf8
         hiCe/E4LR9cHi5LcI5MvwPqmXAX3qGFT9D1278oEGwIGftk70DOS/WBiUmhM38J0zWQM
         4AS3xARMIUiF4t3XlZv76EVDQ3ALv6J9iPJQit/7GzkVv7AQLoV5inziJarxPq4kyeU4
         qgog==
X-Gm-Message-State: AOAM531n+dfHKVukYLyAMdd4CKckf0ROP3TTNYgCIhTYuUhUoYiOE7Mr
        vTXNee4xN712ZhXmwtAzff0u5wQ9H3BuIw==
X-Google-Smtp-Source: ABdhPJyl6byqWAO3YtQHaAu5BoE3CBbwYwKUsxPz5X7kdGedt0pkSbwj3BUB834KKGNekLXQruG7BQ==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr20740114wru.166.1618923636836;
        Tue, 20 Apr 2021 06:00:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] object.c: move type_from_string() code to its last user
Date:   Tue, 20 Apr 2021 15:00:16 +0200
Message-Id: <patch-10.10-cb0ea49279-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commits leading up to this one various errors have been improved
and bugs fixed by moving various callers to
type_from_string_gently(). Now that there's no caller left of
type_from_string() except cat-file.c, let's move this function over to
it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 4 +++-
 object.c           | 9 ---------
 object.h           | 1 -
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 46fc7a32ba..20c60045f6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -154,7 +154,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 0:
-		exp_type_id = type_from_string(exp_type);
+		exp_type_id = type_from_string_gently(exp_type, strlen(exp_type));
+		if (exp_type_id < 0)
+			die(_("invalid object type \"%s\""), exp_type);
 		if (exp_type_id == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (oid_object_info(the_repository, &oid, NULL) == OBJ_TAG) {
diff --git a/object.c b/object.c
index 8f3ddfc8f4..3c962da6c9 100644
--- a/object.c
+++ b/object.c
@@ -49,15 +49,6 @@ enum object_type type_from_string_gently(const char *str, size_t len)
 	return -1;
 }
 
-enum object_type type_from_string(const char *str)
-{
-	size_t len = strlen(str);
-	enum object_type ret = type_from_string_gently(str, len);
-	if (ret < 0)
-		die(_("invalid object type \"%s\""), str);
-	return ret;
-}
-
 /*
  * Return a numerical hash value between 0 and n-1 for the object with
  * the specified sha1.  n must be a power of 2.  Please note that the
diff --git a/object.h b/object.h
index a4eca10d72..85e7491815 100644
--- a/object.h
+++ b/object.h
@@ -94,7 +94,6 @@ struct object {
 
 const char *type_name(unsigned int type);
 enum object_type type_from_string_gently(const char *str, size_t len);
-enum object_type type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.723.ga5d7868e4a

