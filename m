Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC3BC43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69625613AB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhDTQwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhDTQwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:52:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76DC06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g9so22341945wrx.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fOig0rtmFbMsuO7Glz/4J6tAr2Wc+LDu9zupBOBwnXQ=;
        b=DC+vv5ND1v+BJycu+VYokrbfRMbaBQspuEe2Tu/YAF+cztqFeCr4gRDBdUKcKnXNtV
         0ibiU2W+AO5/XncG64/PAPGW4jhFMQWYPzdjTJIKY2FMtf9RPjrWaPcDWT0+rcMOmrKM
         5sg/Yp53Zfe9so3Q2iN2KkZAN6lo9QEQzUwkWPbtkd2GBkd0VfDwgIM8r8eQ639WJ9sH
         V+8Pn8+/2OXdPYcxpWb02EzYVUyIek7MISBBVFIWdPchr3XQL52D7VzZ0y/4rGYIBJZp
         vmf/cuek2noW4DMiWGG8ARsywDpjCcU7vrn3u3VxXGpvxMPtPDPpfXFAOq+dls5cfTJy
         CDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fOig0rtmFbMsuO7Glz/4J6tAr2Wc+LDu9zupBOBwnXQ=;
        b=DSQhBQqEedcz2tC6N63JUeMHrjAK+QHeSk85ipA9DsJi8n15BpBghJ3x52T/SWwiHs
         8RgrgsW+hIswExOW1u3uRMActnM6rEzU2K8FVohVQt3HamaVJmwaYgh+fjzF8nEyGjrM
         yy2cyNIV8dkw4cKTe5l/Z4hCJOOw53ghjgdN+TjFlhAaPGYCQkXdS/s60+ORjlTZqqr5
         j993WIuF/Ey9dDXyc3ljgpIUB1tHFPXKXO+Fs41UW3Z2m7ENMoWgeMCwZL3aCVtpL6nk
         Ups37CwsL2luxEuvZfbg0huGa7zupUIUYN9bpopLAOWqCD11NzpEe0ixxkwQJ3fxj0HF
         +5ZQ==
X-Gm-Message-State: AOAM530RZLiO4A81vmEq1yVN+2/tpex9979SzIqFJEvBwODNirHpjy0x
        gcy3Pcf81itrjX/LxhZxUBUbAnsTUKw=
X-Google-Smtp-Source: ABdhPJxRHP8Mt1snxfru1AjLSRlvw9DfeWHdIbHUI/6bb9NS5yrHMHzjHF2XwBuMdiVviDSSt4pkbA==
X-Received: by 2002:a5d:4a8b:: with SMTP id o11mr21427870wrq.233.1618937533974;
        Tue, 20 Apr 2021 09:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm29047079wrf.75.2021.04.20.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:52:13 -0700 (PDT)
Message-Id: <7e378eef4b3405777eef9c0e9fe4e9e4ec6a1df9.1618937532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.935.v2.git.1618937532.gitgitgadget@gmail.com>
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
        <pull.935.v2.git.1618937532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 16:52:10 +0000
Subject: [PATCH v2 1/2] [GSOC] ref-filter: get rid of show_ref_array_item
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

Inlining the exported function `show_ref_array_item()`,
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

