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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17575C4320E
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DA261159
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbhHEPIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhHEPH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3EDC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c16so6973802wrp.13
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Kqa23yfVnSMG7D9QgL+O13yLRuHfGHX+i/Q2aM6yXA=;
        b=O8xyGZ9xTux2ufvRWjdx+JyMCeqs+mJ+MnPn2KpJPYK5rt0jQVpdtiIbGsEAWp5mNB
         0KmkpuMM0tbgXJGIU6IntewkrHTh3VF3ztk0VBc7Y0lhhplAaZFmBlmQq9M5o2ljjXQz
         ZQTdUjJUCxdIVIqZt0w5xYBQVcdeAgBQ0sSkFMkIKIyAy5lsi6S8i+v/DC74GV6j8Rly
         wTRisU6TwAduqSKJNBranfqvkasrFJzvNxH9caDQB6M+ukcpQBmaiSL/SvT3niJ0sDW9
         hPbfISSqm7KBauXUMubmsWnV2dxOFGWfMoo8oLDBvIBgk99S0a+HoTsCp1Lu3yke/RPK
         o/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Kqa23yfVnSMG7D9QgL+O13yLRuHfGHX+i/Q2aM6yXA=;
        b=RpEDgl9VvDhT9zT9lBMvZQ4V760Vkd4sTChJ64PNusEtQ3qPHftUncmp8iUuNZqVgn
         UAkRxZH2E4Musa1yudJoONJq7F1/LxXko4yh7rCo2fu5n//l4KRSQfZp1+KeXZZpXUir
         rbqCvry+9NsMEe1g3gXsFeLIMtxgUvaEqlwOoE4qAawV9UCvmroUHzb7TZPxuTbnDkGI
         EpNUub60SO2Q0weLBatn7jKcZPLGEritgnL8GIYGFw3x4zMp4t3RXwCARwxLBLu2BJdT
         oy9eS9j0XOKlsr6XOcOF9P6lUUYhkv1LYY9Q6Gg4gBmnIMVfPCh7PcyL8wehZa5QHBRc
         3s/g==
X-Gm-Message-State: AOAM532rk5+e6uszonDMGIjlD8GkQOYLJoykDXwOiqioUhaH+bPQY/ys
        CH6Wm52YV67viJe8cufh4CO1EUZ84rslCg==
X-Google-Smtp-Source: ABdhPJxRwFfJVEpQoVpJyPqVKQFe0wR2aIZ8/TVwpDUNnYeQWDIp/i6EEX53Cq47DIHeaNudpDLQJw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr3697745wru.182.1628176063623;
        Thu, 05 Aug 2021 08:07:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 09/13] fetch-pack: add a deref_without_lazy_fetch_extended()
Date:   Thu,  5 Aug 2021 17:07:25 +0200
Message-Id: <RFC-patch-09.13-20646ee07e-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a version of the deref_without_lazy_fetch function which can be
called with custom oi_flags and to grab information about the
"object_type". This will be used for the bundle-uri client in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b0c7be717c..b0b21cc969 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -114,17 +114,18 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
-static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
+static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
+							int mark_tags_complete,
+							enum object_type *type,
+							unsigned int oi_flags)
 {
-	enum object_type type;
-	struct object_info info = { .typep = &type };
+	struct object_info info = { .typep = type };
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
+					     oi_flags))
 			return NULL;
-		if (type == OBJ_TAG) {
+		if (*type == OBJ_TAG) {
 			struct tag *tag = (struct tag *)
 				parse_object(the_repository, oid);
 
@@ -137,11 +138,21 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
 			break;
 		}
 	}
-	if (type == OBJ_COMMIT)
+	if (*type == OBJ_COMMIT)
 		return (struct commit *) parse_object(the_repository, oid);
 	return NULL;
 }
 
+
+static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
+					       int mark_tags_complete)
+{
+	enum object_type type;
+	unsigned flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
+	return deref_without_lazy_fetch_extended(oid, mark_tags_complete,
+						 &type, flags);
+}
+
 static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 			       const struct object_id *oid)
 {
-- 
2.33.0.rc0.646.g585563e77f

