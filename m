Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C236109F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhJTS3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJTS3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:29:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72317C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so11880417wmz.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FHaytZHel5gVVKAT+Kci6ZP76N2n7tI4Fn75FtSz2Mk=;
        b=V/3CZumRgPv7j5ZjKWQTS1GTxRSuhvRGJRScP2HhRSfVSuVUpVyMB83UmpNz/mPPTp
         CX1Squ6134yFpkJfQGqvd6EZ96cyo+V4aVSUwibvJcAtITwI28VCXQuvgxnYSsSnNfon
         zibwAWlufXVqeSPvKUBiWucuOsoYJSRnvSNXaRj5B1i8SzmP8y0P6lSRFs4voAfOccyD
         3/5UzDDIixRgHvtY5M8bQj8UVSr4Jex1zCZbhJpYMwB6PTYLfNHPpdnUHZl4q8SDF+HV
         1El8ETKikyGOz5dnahwl26FMfsxOOH8m//FFujjNB3AozKk9HozCb0ROjcWpCvdF1qSL
         +X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHaytZHel5gVVKAT+Kci6ZP76N2n7tI4Fn75FtSz2Mk=;
        b=cf6qeialwTPDMorSVdVgboFxmo+3Rf9QdrlpLDQeRxokg34frDLbw9TQuBpaJOu4fK
         MEeJAGWr+ucTOa1nNsgt7f+f7+pCR+dNMhA7O998rM4gy8LVKsmDOY+IZ8pQRC8L6LU/
         /BuhF3i1aFliVIq25JXWZutdI92ZEX4tRJXpZDuSFPJUavE+raC1yQt5GBIqhmRQJWiZ
         f9oqc1n9rkTOCx42cCmwSYWEFtn9QBWTZxJc5VKGPUxALJ61UY7R+hVfzrAUqCfXKL5d
         3vTQ9EG2jcUfMNZ3LCHYIG6Rarcf+XNtfj7gZg+DuncW8K6fseAOHV5BCIEyabK99p9m
         LXmA==
X-Gm-Message-State: AOAM533JmvR4/wupACJqd4YuZQ/rZN3mgF3xb0xhK8a1ZhCmLFWYsKI9
        0SqUYKJ69yOIwnojfl+SjB1KFRdVv+0dnw==
X-Google-Smtp-Source: ABdhPJxK2bi+vJVD2jN9hdnvK1VMzjR0A+/ZHksQaMGffpTgOfnZTJL1QVzdjf7sUQ+MGe1Lkcs1pw==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id o13mr16127741wmq.158.1634754449782;
        Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm3091093wmq.41.2021.10.20.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:27:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] branch: use ref_sorting_release()
Date:   Wed, 20 Oct 2021 20:27:21 +0200
Message-Id: <patch-3.3-c8e8bc46ac4-20211020T182516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
References: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com> <cover-0.3-00000000000-20211020T182516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a ref_sorting_release() in branch.c to free the memory from the
ref_sorting_options(). This plugs the final in-tree memory leak of
that API.

In the preceding commit the "sorting" variable was left in the
cmd_branch() scope, even though that wasn't needed anymore. Move it to
the "else if (list)" scope instead. We can also move the "struct
string_list" only used for that branch to be declared in that block

That "struct ref_sorting" does not need to be "static" (and isn't
re-used). The "ref_sorting_options()" will return a valid one, we
don't need to make it "static" to have it zero'd out. That it was
static was another artifact of the pre-image of the preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0b7ed82654a..7a1d1eeb070 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -407,7 +407,8 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
-static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, struct ref_format *format)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
+			   struct ref_format *format, struct string_list *output)
 {
 	int i;
 	struct ref_array array;
@@ -449,7 +450,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
 			 /* format to a string_list to let print_columns() do its job */
-			string_list_append(&output, out.buf);
+			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
@@ -753,9 +754,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
-		print_ref_list(&filter, sorting, &format);
+		print_ref_list(&filter, sorting, &format, &output);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
+		ref_sorting_release(sorting);
 		return 0;
 	} else if (edit_description) {
 		const char *branch_name;
-- 
2.33.1.1338.g20da966911a

