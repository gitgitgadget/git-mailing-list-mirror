Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD8C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6D60241
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhDINgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhDINgF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 09:36:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D2C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 06:35:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5447070wmq.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=V1PIIIBg54bmeDn8fMecZZNus6JeTs7ldJJev7bUTdg=;
        b=qe7Hf83nydataoeT/tA3awNDUqmy09bLp0fwVNdbZdUgSbo26UtkWF3OWGiSk4I1n2
         PRQBys0MUaNZmH6kdbYpoL7r0EU9SKLYl6STIDaIu95UJO0OztSFuOb+2fGUz36sXE1D
         EsRFvwSUFTpgk6zKOOSO8y4HmCmxklq7RpdxforWdWur0+/8v2JZRP5S0NzgIl8UclLQ
         k34q7e2SNWvN8Dv1LngVca7sCVl+G8DNkDGyZ3BwAiPeFOk6AHMkPT1KwtiujHiFiQ2L
         DswLSDkz/JjiCEYOZgMZLuTRKQAT6E2HfCB6nGxMENGAAvlpPgTyut0AxhgvjNV1iL6a
         UjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=V1PIIIBg54bmeDn8fMecZZNus6JeTs7ldJJev7bUTdg=;
        b=UTiTso91fN/MaizEP8DlDzZS//QGtPZIocEJACeah4SA7IPhFyXwSImVCHPMD4Bud3
         7GshqxTiEMxk178CTis8QTYGfxSQcx0IyjtE+B/B5UUcYwANm3dyy5hV3yYCfMiEekVr
         PxedITUCAwUx+zgG142zr19OLUOIAdEYhnr1tDjNddomMGb9LmlAIVAv/sCZ01gHByff
         PW+uxEm1X4MMHPDEpph4N0MYciXTGjloYINOBbjOKPEhv/nIQwdKIvQpGIhUvqWn5X00
         rYDTOgwyGWHLgs59gd6BDTSw6I++OMisG0Wg/8Kzsrxkt1Tlbx6w98vPgXP8yzjnwOFg
         fcqw==
X-Gm-Message-State: AOAM530VN+D3FvjjnWxJ+coJC9h8VC/foJbgsaH2cCAB3UqzNunvqTL2
        Tw26RG3Fvrp0Pps3miVMGXUI4Lec2tM=
X-Google-Smtp-Source: ABdhPJyDxCEFazuiqgvKurDqnLZCwMcdVx52i45BBLkC2em4WrWdYWyfGuNkLUJzaqZ9uXKMKDXj0w==
X-Received: by 2002:a1c:4686:: with SMTP id t128mr13749933wma.156.1617975350109;
        Fri, 09 Apr 2021 06:35:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm4625390wme.40.2021.04.09.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:35:49 -0700 (PDT)
Message-Id: <pull.928.git.1617975348494.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 13:35:47 +0000
Subject: [PATCH] [GSOC] ref-filter: get rid of show_ref_array_item
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use `git for-each-ref`, every ref will call
`show_ref_array_item()` and allocate its own final strbuf.
But we can reuse the final strbuf for each step ref's output.
Since `show_ref_array_item()` is not used in many places,
we can directly delete `show_ref_array_item()` and use the
same logic code to replace it. In this way, the caller can
clearly see how the loop work.

The performance for `git for-each-ref` on the Git repository
itself with performance testing tool `hyperfine` changes from
23.7 ms ± 0.9 ms to 22.2 ms ± 1.0 ms.

At the same time, we apply this optimization to `git tag -l`
and `git branch -l`, the `git branch -l` performance upgrade
from 5.8 ms ± 0.8 ms to 2.7 ms ± 0.2 ms and `git tag -l`
performance upgrade from 5.9 ms ± 0.4 ms to 5.4 ms ± 0.4 ms.
Since the number of tags in git.git is much more than branches,
so this shows that the optimization will be more obvious in
those repositories that contain a small number of objects.

This approach is similar to the one used by 79ed0a5
(cat-file: use a single strbuf for all output, 2018-08-14)
to speed up the cat-file builtin.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: get rid of show_ref_array_item
    
    Now git for-each-ref can reuse final buf for all refs output, the
    performance is slightly improved, This optimization is also applied to
    git tag -l and git branch -l.
    
    Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-928%2Fadlternative%2Fref-filter-reuse-buf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-928/adlternative/ref-filter-reuse-buf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/928

 builtin/branch.c       |  8 ++++----
 builtin/for-each-ref.c | 13 +++++++++++--
 builtin/tag.c          | 13 +++++++++++--
 ref-filter.c           | 24 +++++++++---------------
 ref-filter.h           |  2 --
 5 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bcc00bcf182d..5c797e992aa4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 {
 	int i;
 	struct ref_array array;
+	struct strbuf out = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	char *to_free = NULL;
@@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		struct strbuf out = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
+		strbuf_reset(&out);
 		if (format_ref_array_item(array.items[i], format, &out, &err))
 			die("%s", err.buf);
 		if (column_active(colopts)) {
@@ -452,10 +453,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
 		}
-		strbuf_release(&err);
-		strbuf_release(&out);
 	}
 
+	strbuf_release(&out);
 	ref_array_clear(&array);
 	free(to_free);
 }
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a04606..157cc8623949 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -80,8 +82,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+	for (i = 0; i < maxcount; i++) {
+		strbuf_reset(&output);
+		if (format_ref_array_item(array.items[i], &format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+	}
+
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d403417b5625..b172f3861413 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
 {
 	struct ref_array array;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
 	int i;
 
@@ -63,8 +65,15 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format);
+	for (i = 0; i < array.nr; i++) {
+		strbuf_reset(&output);
+		if (format_ref_array_item(array.items[i], format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+	}
+
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	free(to_free);
 
diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f71416..9e38e42fb7ae 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2435,27 +2435,21 @@ int format_ref_array_item(struct ref_array_item *info,
 	return 0;
 }
 
-void show_ref_array_item(struct ref_array_item *info,
-			 const struct ref_format *format)
-{
-	struct strbuf final_buf = STRBUF_INIT;
-	struct strbuf error_buf = STRBUF_INIT;
-
-	if (format_ref_array_item(info, format, &final_buf, &error_buf))
-		die("%s", error_buf.buf);
-	fwrite(final_buf.buf, 1, final_buf.len, stdout);
-	strbuf_release(&error_buf);
-	strbuf_release(&final_buf);
-	putchar('\n');
-}
-
 void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
+	struct strbuf output = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
-	show_ref_array_item(ref_item, format);
+	if (format_ref_array_item(ref_item, format, &output, &err))
+		die("%s", err.buf);
+	fwrite(output.buf, 1, output.len, stdout);
+	putchar('\n');
+
+	strbuf_release(&output);
 	free_array_item(ref_item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 19ea4c413409..baf72a718965 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -119,8 +119,6 @@ int format_ref_array_item(struct ref_array_item *info,
 			  const struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
-/*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */

base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
-- 
gitgitgadget
