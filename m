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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29DEC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614CF6139F
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhDEOBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 10:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhDEOBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 10:01:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC06C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 07:01:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso1556330wmj.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LWWnAs9gItyZMI5jI3+rXEeEWJXfbneg2IfYquzOBgo=;
        b=lSqStREJPFG4yJGUVqqPgHFXmbIY5E5dATn53gjCy4XZd/Bh7He+A+lcFr8IyzjgiS
         wtxEHd7ghkNWfopEldWtswPIO/nqWXO+fDDAiC6LeySvBem4ed4LNAKebN6x/Ith8aib
         q9lNLuY6HhLAwzRJsmrWVjnDOBtIAOqJmYUB5rHK0wBB1PnKPrujE/vph9wJFMeM9028
         ZoxItzIrsNXoQq+9SF1avXMsgyeHFoGTfR5Cz24j6bwhRyQzYIqZVWfe+mWQvkt5FDJw
         9pfy2AdJF8hN84Hgbqo1yFoXvtKYEmew1EuMEG1D2QeJMQwr3hhW9bn3Q2hKMm25dqvV
         wCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LWWnAs9gItyZMI5jI3+rXEeEWJXfbneg2IfYquzOBgo=;
        b=gH/9mJQ1iNmPYtkMlHbaJa/uC48TCLHeJsK5N0rjNWxgw0NAZO2mFxsKgdrRsff7rv
         9WejAuX25GM74ODLA6sBqKvutBa3XQgM2YLQalueIGFpWBzsrADarKwSJg6n37E+/gxv
         Nb71QesgxveFDzFhcg4zxJleKkcLZRU5oBokC+SDRwCFiGnOPGMDeNzEXEofJ20RdkEy
         DXkgAaUaGBYAXX0nQx9Mtq5BNZM8JQoa4wWDXnNnoK1ERzOUJo9UhpVMs7hYfjOfuuZE
         TVnzbupH4yktUgSsO7kTe5gG53uNyKAV/Vv58V3TdXv9+c8DfUtDHU/MSdjGHt3JuL2L
         WpQg==
X-Gm-Message-State: AOAM532J5jEndfOiuUDCyAiaBpxaHv0J9fM1b4aEPErFqA64rmNw4gKN
        AMg0t1IV6s2FxU00pT4R4cRvHx3rxSo=
X-Google-Smtp-Source: ABdhPJzbTEITqNHPQ4w17jUp8Wf3JbQrN1EgPtF2jij6qh6BZTqRdtDu1dJMycdcyovKSkduuliKWw==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr25686896wmb.2.1617631281961;
        Mon, 05 Apr 2021 07:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm2043722wrj.34.2021.04.05.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 07:01:21 -0700 (PDT)
Message-Id: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 14:01:19 +0000
Subject: [PATCH] [GSOC] ref-filter: use single strbuf for all output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use `git for-each-ref`, every ref will call
`show_ref_array_item()` and allocate its own final strbuf
and error strbuf. Instead, we can provide two single strbuf:
final_buf and error_buf that get reused for each output.

When run it 100 times:

$ git for-each-ref

on git.git :

3.19s user
3.88s system
35% cpu
20.199 total

to:

2.89s user
4.00s system
34% cpu
19.741 total

The performance has been slightly improved.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC] ref-filter: use single strbuf for all output
    
    This patch learned Jeff King's optimization measures in git
    cat-file(79ed0a5): using a single strbuf for all objects output Instead
    of allocating a large number of small strbuf for every object.
    
    So ref-filter can learn same thing: use single buffer: final_buf and
    error_buf for all refs output.
    
    Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-927%2Fadlternative%2Fref-filter-single-buf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-927/adlternative/ref-filter-single-buf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/927

 builtin/for-each-ref.c |  4 +++-
 builtin/tag.c          |  4 +++-
 ref-filter.c           | 21 ++++++++++++---------
 ref-filter.h           |  5 ++++-
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a04606..9dc41f48bfa0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct strbuf error_buf = STRBUF_INIT;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -81,7 +83,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+		show_ref_array_item(array.items[i], &format, &final_buf, &error_buf);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d403417b5625..8a38b3e2de34 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
 {
 	struct ref_array array;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct strbuf error_buf = STRBUF_INIT;
 	char *to_free = NULL;
 	int i;
 
@@ -64,7 +66,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format);
+		show_ref_array_item(array.items[i], format, &final_buf, &error_buf);
 	ref_array_clear(&array);
 	free(to_free);
 
diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f71416..51ff6af64ebc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2436,16 +2436,16 @@ int format_ref_array_item(struct ref_array_item *info,
 }
 
 void show_ref_array_item(struct ref_array_item *info,
-			 const struct ref_format *format)
+			 const struct ref_format *format,
+			 struct strbuf *final_buf,
+			 struct strbuf *error_buf)
 {
-	struct strbuf final_buf = STRBUF_INIT;
-	struct strbuf error_buf = STRBUF_INIT;
 
-	if (format_ref_array_item(info, format, &final_buf, &error_buf))
-		die("%s", error_buf.buf);
-	fwrite(final_buf.buf, 1, final_buf.len, stdout);
-	strbuf_release(&error_buf);
-	strbuf_release(&final_buf);
+	if (format_ref_array_item(info, format, final_buf, error_buf))
+		die("%s", error_buf->buf);
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_reset(error_buf);
+	strbuf_reset(final_buf);
 	putchar('\n');
 }
 
@@ -2453,9 +2453,12 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
+	struct strbuf final_buf = STRBUF_INIT;
+	struct strbuf error_buf = STRBUF_INIT;
+
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
-	show_ref_array_item(ref_item, format);
+	show_ref_array_item(ref_item, format, &final_buf, &error_buf);
 	free_array_item(ref_item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 19ea4c413409..95498c9f4467 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -120,7 +120,10 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
 /*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+void show_ref_array_item(struct ref_array_item *info,
+			 const struct ref_format *format,
+			 struct strbuf *final_buf,
+			 struct strbuf *error_buf);
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */

base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
-- 
gitgitgadget
