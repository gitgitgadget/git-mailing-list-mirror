Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDDC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D14761260
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJTN1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhJTN1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:27:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2BDC061760
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so10235919wmz.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6BeScdJhcr25sX0/w49pGmBdQVB2zcAGqQuKdD7s6U=;
        b=b8U6QvOzBhdyqAwoMfvm8VSNvh6flYFfHujtkHx9oLKe7/ihHfRooJDsiECP61vCQg
         LUI5Jqvsb0BD44G5S2OkHbdQtUIg0g8DFfCGULBi8HM0+YZnJ/2LVTwaZQt4lte9wEcY
         TyjIobLvjj+zmnEL94/mhvwA7YhZEIFvzL7d8ucF9PRTkB8KGLk4CU9z7C0LYo8NQ/Ac
         2+ypnGkYBuAeaDrSTuR69XdNL4bfFMV1j+Q3O2kXMnPCRGShEkMD8ucKJCntVE6eHsHb
         c7f+rCy0LCci8mD146xqQeuUueZTzCzwN13ZedfOF709qw6XDjPBBZsPvvlkL+xpQSvn
         6E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6BeScdJhcr25sX0/w49pGmBdQVB2zcAGqQuKdD7s6U=;
        b=bvgHJaw6/VkDfJ2g5IQ0yJHvIjy6xCZJcGEMwkE0ru0m6Au1AvF52z9U6SnYwLqDbL
         nDXHeY+h9XsSf0fV7h6w/WpggPQ99EUAkNoDbNsdPOe2RGzBpFmCRfez1yNL+GviX8dN
         jqRE2hOUrbmO11vJCFQcY+GiCdOSLrKL2oWaRo32VY2lV7dgb+Z2XOT0Ennsfb+o0Boo
         uSJfTWXeSlZMFlu3UJyEWzpv1SQlYUB1HdT0FhYAQmGFnGfytVKPzNFQXVVcUYKQjdGL
         op10gwaYtmxXd/gO/6XYxqbsaEv0Cwj7M5Em4P25Cgkh5rNMSrhykMhTV9G+1fOgIE9O
         zusw==
X-Gm-Message-State: AOAM530yO6vypzjHMc+L3hE1ft17l5iAAQqnOAYiCxWYo406qx9c3al2
        twz81mYOzsMyuI8U5X/SqxFg45mizpTRZQ==
X-Google-Smtp-Source: ABdhPJy2MMnrNFy6GBMptME/r0JALFwH3XjyM6kY/3QXWa6ukdLW4ERmGJOu60v8qS64HjgaaBHY7w==
X-Received: by 2002:adf:f190:: with SMTP id h16mr40492248wro.250.1634736285380;
        Wed, 20 Oct 2021 06:24:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm5933351wmj.0.2021.10.20.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 4/4] branch: use ref_sorting_release()
Date:   Wed, 20 Oct 2021 15:24:36 +0200
Message-Id: <RFC-patch-v2-4.4-f7d87aea384-20211020T131627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com> <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
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
 builtin/branch.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 69211f8dd1c..3963c592f56 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -69,7 +69,6 @@ static const char *color_branch_slots[] = {
 	[BRANCH_COLOR_WORKTREE] = "worktree",
 };
 
-static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
 define_list_config_array(color_branch_slots);
@@ -406,7 +405,8 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
-static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, struct ref_format *format)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
+			   struct ref_format *format, struct string_list *output)
 {
 	int i;
 	struct ref_array array;
@@ -448,7 +448,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
 			 /* format to a string_list to let print_columns() do its job */
-			string_list_append(&output, out.buf);
+			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
@@ -623,7 +623,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	int icase = 0;
-	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 
@@ -737,6 +736,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_current_branch_name();
 		return 0;
 	} else if (list) {
+		struct ref_sorting *sorting;
+		static struct string_list output = STRING_LIST_INIT_DUP;
+
 		/*  git branch --list also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
@@ -752,9 +754,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

