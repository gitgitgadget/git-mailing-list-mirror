Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA8C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhL1OfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhL1OfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D513C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e5so38742598wrc.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+N8ibF8Qqra0EmOCedJOc1b0OLSrI1YjyIZ3toIsYPA=;
        b=diOTXg/6JUyU+FQX56igOI7WwEYXCU6jGF2jQktHOVdALLfdUOuQkkA97JQ+ONsDZQ
         B/nubDyxL/cJzOVnl4eq5I3nnIVBJyR6sHOeUTUx6r/SHHr9IkQrahgchEylF2kuOUIz
         EIAOBgw8PctCtqqzLIwc2r6z3Qlbn+xtsMn9J4Zv6XNYjS2o4bqtVLwl9h53K5h9iSQB
         Y598alhWg37K8fAv/OT6fM2ssNKuN+XzkPJFmxYxTkilLQl41mqrTFFGyh6cftENUr72
         CM8froFQrUevlRZf0rqdv6YW8ZF91jARaX7f4wQE8ToPzwBMtdqFS3d0FpVEbrjyb10O
         lSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+N8ibF8Qqra0EmOCedJOc1b0OLSrI1YjyIZ3toIsYPA=;
        b=jZE9CC0YmxLJ/Lf9NSND8SRStpjcB7ka8dNWtoAsa1trlji/KWTamYm8Xvnj2kc5qL
         kF63lgrgxxEGFhmX5I3q+B/1NY6r6I/p59kdIM0NMxLoRg7UxYo8KkxmGXx/0j1wTSob
         4B16jq79E0sahseTZ7FYv/dm/GNS3ZuvxlVPJdRPxULlDku6FCO2G7uaMORpO7OZLGPo
         AHmiyrYrkE+iA/osHzZInWKWSv7NQ6KBqJhkelj5UATmXOQw9FeYB5gkcB1KgeFZEm6e
         tHVKV248m5iVa8rg9KjrPve2oaXgqWyWT3j2jPpdrEoyqFQEpOQ7jeQlVMg6oO3c+JQL
         kLBQ==
X-Gm-Message-State: AOAM532NMWp6WYkV0vxwie2Ty5vqP/iNhDkH1vHxRUqDBn+4twYlPqD7
        zRxghxRsQid2SBUDXHEWBNECCNBfwOlqcqli
X-Google-Smtp-Source: ABdhPJx16pHI4RwahO3KIyWsxCUurvp4z3+2NcawKcneGurip5hkjsAP3Zn1fklRjeGNBduNy3nCtw==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr16302884wrs.233.1640702115977;
        Tue, 28 Dec 2021 06:35:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 4/6] object-name: show date for ambiguous tag objects
Date:   Tue, 28 Dec 2021 15:35:00 +0100
Message-Id: <patch-v6-4.6-b5aa6e266f6-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the ambiguous tag object output nicer in the case of tag objects
such as ebf3c04b262 (Git 2.32, 2021-06-06) by including the date in
the "tagger" header. I.e.:

    $ git rev-parse b7e68
    error: short object ID b7e68 is ambiguous
    hint: The candidates are:
    hint:   b7e68c41d92 tag 2021-06-06 - v2.32.0
    hint:   b7e68ae18e0 commit 2019-12-23 - bisect: use the standard 'if (!var)' way to check for 0
    hint:   b7e68f6b413 tree
    hint:   b7e68490b97 blob
    b7e68
    [...]

Before this we'd emit a "tag" line of:

    hint:   b7e68c41d92 tag v2.32.0

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index dcf3ab99990..990f384129e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -403,21 +403,26 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		const char *tag_tag = "";
+		timestamp_t tag_date = 0;
 
-		if (!parse_tag(tag) && tag->tag)
+		if (!parse_tag(tag) && tag->tag) {
 			tag_tag = tag->tag;
+			tag_date = tag->date;
+		}
 
 		/*
 		 * TRANSLATORS: This is a line of
 		 * ambiguous tag object output. E.g.:
 		 *
-		 *    "deadbeef tag Some Tag Message"
+		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
 		 *
 		 * The second argument is the "tag" string from
 		 * object.c, it should (hopefully) already be
 		 * translated.
 		 */
-		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
+			    show_date(tag_date, 0, DATE_MODE(SHORT)),
+			    tag_tag);
 	} else if (type == OBJ_TREE) {
 		/*
 		 * TRANSLATORS: This is a line of ambiguous <type>
-- 
2.34.1.1257.g2af47340c7b

