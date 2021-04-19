Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A194C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6381D6108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhDSL3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhDSL3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:29:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A96C061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s7so33534477wru.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=unhnUxWwf6QK6cp4rrR6TrbktMm/8rXyUTIBHzAEXfg=;
        b=BXOUlxpLd56aIkzUp+iaABGXqjdNmYdtYHtkfeGiejkmg9qs8FHNQqQTNmd+UQ3M4h
         kzb6m9AJGdZicS7Cwk3Q7dPN76UxIbREvlmrwlj/2THgU267xxjTUh8SuQEfOX2I36Ur
         P/K4rZgYE/cIjJ6NoQWqYF81mV7YHGo7sh0VQBzifKwCiW5Mvag28s4kKltHD6z/mh0x
         elym4+AflX3qAxJIwqVmvOVzz7DJ7RnieDx74sIOA9lwt4xsUzcN0Kwy8YGHTg4nUSj5
         4mUrtUASZHOQp2DJmetiTZS4wy/0sPjndJ+VnIeRhwQdxGbkPT2FwCNrhcPfFPb4j7vA
         /HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=unhnUxWwf6QK6cp4rrR6TrbktMm/8rXyUTIBHzAEXfg=;
        b=rlNt17OlEZWMBnbwQmVMnmfKPW3YyUi7LTcmEOHB82/8fDtR2w3r0ox/rhSm9FvQtG
         wuzS0XWrb33JQvY/4YB4znq2Cy18zdk39FG8frNoKmNqmn0pywH5owWIV52iofgz+MJU
         U72pp5/q7CL6rx0lRMAiOuZ36Olq4N5+gU6oWtl4G0AVAO4GByLz3IwkQuMkOW/ZauIG
         fcaQhAjzIFOtoLdY6H9XuLJ8tmMH4ClT2orvdSzP29w11wqbPjFFG+NPifbGbsT0PAEP
         rADX4emqcyrlBWqe+PbYbqUp34doDpm9815Zf5Ry8qJEk6JThb6T2t1C5aX7j2KkmYaG
         ZnWg==
X-Gm-Message-State: AOAM532ujSSLHCBPRocQEtzbJTP9RF61kc9wvCXrcnUFOo8lTgrFUTSQ
        q2rt47Q9eXf8Vmfo5Uj1LeVTsjtEFr0=
X-Google-Smtp-Source: ABdhPJyy1FzYrn8BoB5fTnpa6gV25rUKPI5ELCFyYqsMlH1/L/R9d7MdLXqwZJ31lZUdJzv50+jEHg==
X-Received: by 2002:a5d:58f3:: with SMTP id f19mr13906928wrd.133.1618831727807;
        Mon, 19 Apr 2021 04:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4sm24450106wrf.36.2021.04.19.04.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:28:47 -0700 (PDT)
Message-Id: <ec98f2177d905cc9b3c61e15ddb756243536c125.1618831726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.935.git.1618831726.gitgitgadget@gmail.com>
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:28:44 +0000
Subject: [PATCH 1/2] [GSOC] ref-filter: get rid of show_ref_array_item
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

Inlining the exported function `show_ref_array_item()`
which is not providing the right level of abstraction,
simplifies the API and can unlock improvements at the
former call sites.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/for-each-ref.c | 14 ++++++++++++--
 builtin/tag.c          | 14 ++++++++++++--
 ref-filter.c           | 25 ++++++++++---------------
 ref-filter.h           |  2 --
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index cb9c81a04606..8520008604e3 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -80,8 +80,18 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], &format);
+	for (i = 0; i < maxcount; i++) {
+		struct strbuf output = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (format_ref_array_item(array.items[i], &format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+
+		strbuf_release(&err);
+		strbuf_release(&output);
+	}
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d403417b5625..d92d8e110b4d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -63,8 +63,18 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format);
+	for (i = 0; i < array.nr; i++) {
+		struct strbuf output = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (format_ref_array_item(array.items[i], format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+
+		strbuf_release(&err);
+		strbuf_release(&output);
+	}
 	ref_array_clear(&array);
 	free(to_free);
 
diff --git a/ref-filter.c b/ref-filter.c
index f0bd32f71416..df67047fd615 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2435,27 +2435,22 @@ int format_ref_array_item(struct ref_array_item *info,
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
+	strbuf_release(&err);
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
-- 
gitgitgadget

