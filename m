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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DBAC43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BE7613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDTNBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhDTNBG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E4C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so37489816wrw.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSsHXRcngylZXP0ifHFbgEe/71xEdr13Ak0ATSqf4Ts=;
        b=oZaFT++FMhS4VeOKPK9BdeKxCKJ8kTrEXp8tigI/K8ZrfODYzbWEeidreKhIc9W4OG
         7DmwFVmflAJe/XS2aYjJsZz4qvmwy0DYI72KS8b79JpnpBcbH2DJfG27XsSxGg8bW5i+
         5Q/8/DZeiqaXeS1Fr3jspCCv6DsQBl5kkBeDxrMRRqWxhcsbtnmRq3d8MJ4KOLVJfhem
         wJQL+VxCIhRPBrz7WmLimyVT/CZP/jEiPgu7IuxK6WeBp0vpKyzJWeMOpCMOP1EIgSDu
         x29pY46gxVM9GNqxJ05qX+oXeRUmGlUBhn7jKoXi5sQ497mYumST+LUqHqvpJF4OX2HF
         O3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSsHXRcngylZXP0ifHFbgEe/71xEdr13Ak0ATSqf4Ts=;
        b=pGgLut7i2yi39vkYeKh3myheosCjLPagZT0UuJ/Ms5BXNc6QljpP6kwhfPLc38YmAV
         Oqtw3i+dqz1kzQfQTnuM8uxtz6kxt2aOuGzVHAlwz1S7+XOCq/ci4ChzLQurDRXGD3bU
         2uYKycrOmVwOCXEU6dcRi7KQPOKxlAgkwHOqddl50LsjrquNMzoYG7aGzzrozSI22p2o
         zzA2t2NL5YQ8d6FL7J0NzUEd0q2mXpYK99JXaO8uL3GoGnhxbEIr0xRDi9uT2lFum1CF
         ivGp5SyKAa1GgGTwlszyV2Fb3rBR0FI2J1d6kn6G8hi+mQnHqkQK5uyZYL0sxTlM0Dl/
         c5vw==
X-Gm-Message-State: AOAM532v4EyUkx2YQ4BEaZvuGyAnldkK73hjpvY8/87/1a4Oz9IsLcO6
        2tUA55oRuOSqKLG5xHfng51nszWl+KZnOA==
X-Google-Smtp-Source: ABdhPJzqWHV+wxOjaNmUEXUMFqjzH+48yJ+RMGOUpBixK8W0kJyeyIQTNK/tjyjunYagT5waRerCPA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr20200872wrw.78.1618923633309;
        Tue, 20 Apr 2021 06:00:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] tag.c: use type_from_string_gently() when parsing tags
Date:   Tue, 20 Apr 2021 15:00:12 +0200
Message-Id: <patch-06.10-e6fe7ce064-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a series of strcmp() to instead use type_from_string_gently()
to get the integer type early, and then use that for comparison.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tag.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tag.c b/tag.c
index ed7037256e..1bd81bf1d1 100644
--- a/tag.c
+++ b/tag.c
@@ -140,7 +140,7 @@ void release_tag_memory(struct tag *t)
 int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
-	char type[20];
+	enum object_type type;
 	const char *bufptr = data;
 	const char *tail = bufptr + size;
 	const char *nl;
@@ -167,23 +167,24 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 		return -1;
 	bufptr += 5;
 	nl = memchr(bufptr, '\n', tail - bufptr);
-	if (!nl || sizeof(type) <= (nl - bufptr))
+	if (!nl)
+		return -1;
+	type = type_from_string_gently(bufptr, nl - bufptr);
+	if (type < 0)
 		return -1;
-	memcpy(type, bufptr, nl - bufptr);
-	type[nl - bufptr] = '\0';
 	bufptr = nl + 1;
 
-	if (!strcmp(type, blob_type)) {
+	if (type == OBJ_BLOB) {
 		item->tagged = (struct object *)lookup_blob(r, &oid);
-	} else if (!strcmp(type, tree_type)) {
+	} else if (type == OBJ_TREE) {
 		item->tagged = (struct object *)lookup_tree(r, &oid);
-	} else if (!strcmp(type, commit_type)) {
+	} else if (type == OBJ_COMMIT) {
 		item->tagged = (struct object *)lookup_commit(r, &oid);
-	} else if (!strcmp(type, tag_type)) {
+	} else if (type == OBJ_TAG) {
 		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
 		return error("unknown tag type '%s' in %s",
-			     type, oid_to_hex(&item->object.oid));
+			     type_name(type), oid_to_hex(&item->object.oid));
 	}
 
 	if (!item->tagged)
-- 
2.31.1.723.ga5d7868e4a

