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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784FBC43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427DB6135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhDTQwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhDTQwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:52:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4441C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:15 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so10417383wmf.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2eWJTy9Qv2KDpLJ15ROcvoWWI/eDhftMSjxZD+5B7Zo=;
        b=Zw+kj/Wo8bvvO2MP42lwBlOVQeUdS9HDTrh/kklY6aMFwv3qcXhyFjZvDwh17ql2gP
         Uo9nqGE1Bfhd4g8aVmFQOSTUesah0S8QWXPfA5vkCe/DnVEBmZ3VKTHQBp4ABAaW9JlL
         FNiahUUgZDt7nJ8HKpvrOCBvA+k90jgWenxSCjgttK+Ua1WwmJYrH/uTflRzhx8C3hdj
         Dt/L4HqnL0a7QDqDCvtu+m6vDKlSbKpoxcTS/XAZCYcK69WR+InrYroY9Ktc6ma5fXQE
         ILxFxcv1rMcXrWJPsYIzANYYIeHHF1MRcdsunQvD9WRuBzGPjX44ja2SEgMPNrHkGvnB
         /Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2eWJTy9Qv2KDpLJ15ROcvoWWI/eDhftMSjxZD+5B7Zo=;
        b=VSaqXXA+pZqrjiA1uiaQQKXM7FsWLPgqWT1H6GUOY3iUJgWED6Qqh8Qkvr6gnkvXjZ
         uR3otc2zYlR6X6fUBnUfsO9TOetwggEhxYrPNvg8WpGjcUiZndtVbn8wc9zaRnib6PvR
         MfmrD8N+fL2D6bJ9MvD4wjY48IDIxJ3jvZ1dJgXhkr6F8qCxd0intzdNhaMv7wlQyz33
         T2SM5M6G4GmzQomWhmV0ltWAcXHNFiKEcrGjvlpVbD7SNzBhUMKSOwJVUkUdIVcKtO9D
         3HLQwpTm/dlsyd2ZHdu/nEj4ffe9AYrQ3X/H92aqS1EKdoFsui53FTxwXvdN9rc1Ko9b
         VhCg==
X-Gm-Message-State: AOAM532/XU/kjAYbAGxEX6SiDsniYB3/bhaYF2Rk8wwCyxYDBlwVUYjQ
        U8hV5O3wX0qzZSQiSdjWE7xWbn83PDo=
X-Google-Smtp-Source: ABdhPJyNCHikV4PnH14eRCmz+zzKSH5+J4byiSDpIouYHbWmVRCbRgs+7TLiIwpA7eDyaefidF0DJA==
X-Received: by 2002:a05:600c:b4b:: with SMTP id k11mr5506079wmr.129.1618937534596;
        Tue, 20 Apr 2021 09:52:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20sm3781642wmi.35.2021.04.20.09.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:52:14 -0700 (PDT)
Message-Id: <a17949b9f80992a3f7ebfbf9fa602730abaf8bb1.1618937532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.935.v2.git.1618937532.gitgitgadget@gmail.com>
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
        <pull.935.v2.git.1618937532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 16:52:11 +0000
Subject: [PATCH v2 2/2] [GSOC] ref-filter: reuse output buffer
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

When we use `git for-each-ref`, every ref will allocate
its own output strbuf and error strbuf. But we can reuse
the final strbuf for each step ref's output. The error
buffer will also be reused, despite the fact that the git
will exit when `format_ref_array_item()` return a non-zero
value and output the contents of the error buffer.

The performance for `git for-each-ref` on the Git repository
itself with performance testing tool `hyperfine` changes from
23.7 ms ± 0.9 ms to 22.2 ms ± 1.0 ms. Optimization is relatively
minor.

At the same time, we apply this optimization to `git tag -l`
and `git branch -l`.

This approach is similar to the one used by 79ed0a5
(cat-file: use a single strbuf for all output, 2018-08-14)
to speed up the cat-file builtin.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       | 10 ++++++----
 builtin/for-each-ref.c | 13 +++++++------
 builtin/tag.c          | 13 +++++++------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index bcc00bcf182d..b23b1d1752af 100644
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
@@ -440,8 +442,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		struct strbuf out = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
+		strbuf_reset(&err);
+		strbuf_reset(&out);
 		if (format_ref_array_item(array.items[i], format, &out, &err))
 			die("%s", err.buf);
 		if (column_active(colopts)) {
@@ -452,10 +454,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
 		}
-		strbuf_release(&err);
-		strbuf_release(&out);
 	}
 
+	strbuf_release(&err);
+	strbuf_release(&out);
 	ref_array_clear(&array);
 	free(to_free);
 }
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8520008604e3..b529228c6239 100644
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
@@ -81,17 +83,16 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++) {
-		struct strbuf output = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
-
+		strbuf_reset(&err);
+		strbuf_reset(&output);
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
-
-		strbuf_release(&err);
-		strbuf_release(&output);
 	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index d92d8e110b4d..82fcfc098242 100644
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
 
@@ -64,17 +66,16 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		struct strbuf output = STRBUF_INIT;
-		struct strbuf err = STRBUF_INIT;
-
+		strbuf_reset(&output);
+		strbuf_reset(&err);
 		if (format_ref_array_item(array.items[i], format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
-
-		strbuf_release(&err);
-		strbuf_release(&output);
 	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
 	ref_array_clear(&array);
 	free(to_free);
 
-- 
gitgitgadget
