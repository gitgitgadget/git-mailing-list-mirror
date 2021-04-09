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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96433C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F05611BE
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDIIdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIIdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAAC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r22so5546060edq.9
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXB1irjxtKShVKEOY4pEqvxwGalhOa2Qa+KafN0mxHs=;
        b=jnXzRzMFLQrbGrqDjY36wbNqapi3mi5qrdZkdWvob/X6ty6SKIEGC7GhV46mXSO2c2
         IGU9xtEAfOqwcVcu17z+qZsMxkZNiyYuB7tX88qci0VKId97DVhu4NOhz/IyKijUrjr4
         XHLg7o6qYF4kZDUcbfxNcdH9iGKkROAkudkAdiahvfXk8qmWFP1100J3nASRjEIKJRqi
         xID/BZ467w+Ik0oX/I1aU2MjJfpf+qVzwo9XbEF6uAjdDffwX//fEXDbxWvRYqtD2XKW
         P8YhQJF4nOEj5iv7hBsI8tZtpCF7SjmkdU5eDA5Z7bVm1G3dIOqHN9gTdIlVwZgJOLR9
         ljlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXB1irjxtKShVKEOY4pEqvxwGalhOa2Qa+KafN0mxHs=;
        b=MyieWRHiNqQc+KzzwR+Rp11K41Mvmvvioiw0UeUZA4dvYEUlRXJj5johafoCo+F1Pd
         cV9USTu0eSM1DC9Ls5Eghg2XJc63/mxrv/OHRFnXYZID0EKXO0eY+EVw6v+WjD1y2DXg
         EwvOJHxdwdLspEKoe8vIWll5V7q/W09oaaafbVCbD2sTYtUhfaHmrJcjYYyxULWIzxDg
         CfVEpcQ8JuVTjyO67VPAC73Rx3kbQl/nxV6Q0o0SbJet2xMvFaJ1WGc1E4ClpBHlH5eq
         1DQ1jJRnB0hgam+1Zb5mnOM3tkN8++znktkHfHRZbNH+8KEjVBTAAAeHMNZSyJHGwEh1
         +u7g==
X-Gm-Message-State: AOAM5302XZXI1zfOqoAXRhPaD4V3S9Ky6CSl+RjHvfVAcEHWl2EBhsOv
        YDDURExap9S+Aqj2gt+6XVsv3xq9SDvkfA==
X-Google-Smtp-Source: ABdhPJzzFfP2ouc0OWMWgUlyIgpK4xqGCX0rvdBb/HvJ4Q4+gN4SM1plFXwYD/Q545Y+BpnfeP/J3A==
X-Received: by 2002:a50:f19d:: with SMTP id x29mr7256615edl.102.1617957188209;
        Fri, 09 Apr 2021 01:33:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] tag.c: use type_from_string_gently() when parsing tags
Date:   Fri,  9 Apr 2021 10:32:54 +0200
Message-Id: <patch-6.6-3279d67d2b-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
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
index 3e18a41841..871c4c9a14 100644
--- a/tag.c
+++ b/tag.c
@@ -135,7 +135,7 @@ void release_tag_memory(struct tag *t)
 int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
-	char type[20];
+	enum object_type type;
 	const char *bufptr = data;
 	const char *tail = bufptr + size;
 	const char *nl;
@@ -162,23 +162,24 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
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
2.31.1.592.gdf54ba9003

